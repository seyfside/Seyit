using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Seyit.Data;
using Seyit.Data.Suppliers;

namespace Seyit.Business.Suppliers.Command
{
    public class CreateSupplierCommandHandler:IRequestHandler<CreateSupplierCommand,Guid>
    {
        private readonly ISupplierRepository _supplierRepository;
        private readonly SeyitDbContext _dbContext;

        public CreateSupplierCommandHandler(ISupplierRepository supplierRepository, SeyitDbContext dbContext)
        {
            _supplierRepository = supplierRepository;
            _dbContext = dbContext;
        }

        public async Task<Guid> Handle(CreateSupplierCommand request, CancellationToken cancellationToken)
        {
            var entity=new Supplier
            {
                Id = request.Id,
                SupplierName = request.Name,
                ProcessOrder = request.Order
            };
            _supplierRepository.Insert(entity);
            await _dbContext.SaveChangesAsync(cancellationToken);
            
            return await Task.FromResult(request.Id);
        }
    }
}