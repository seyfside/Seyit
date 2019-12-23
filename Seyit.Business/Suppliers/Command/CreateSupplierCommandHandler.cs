using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Seyit.Data;
using Seyit.Data.Suppliers;

namespace Seyit.Business.Suppliers.Command
{
    public class CreateSupplierCommandHandler:IRequestHandler<CreateSupplierCommand,int>
    {
        private readonly ISupplierRepository _supplierRepository;
        private readonly SeyitDbContext _dbContext;

        public CreateSupplierCommandHandler(ISupplierRepository supplierRepository, SeyitDbContext dbContext)
        {
            _supplierRepository = supplierRepository;
            _dbContext = dbContext;
        }

        public async Task<int> Handle(CreateSupplierCommand request, CancellationToken cancellationToken)
        {
            var entity=new Supplier
            {
                SupplierId = request.SupplierId,
                SupplierName = request.SupplierName,
                ProcessOrder = request.ProcessOrder
            };
            _supplierRepository.Insert(entity);
            await _dbContext.SaveChangesAsync(cancellationToken);
            
            return await Task.FromResult(entity.SupplierId);
        }
    }
}