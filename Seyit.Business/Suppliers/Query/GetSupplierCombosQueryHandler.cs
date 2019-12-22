using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Seyit.Data.Suppliers;

namespace Seyit.Business.Suppliers.Query
{
    public class GetSupplierCombosQueryHandler : IRequestHandler<GetSupplierCombosQuery, SupplierComboDto[]>
    {
        private readonly ISupplierRepository _supplierRepository;

        public GetSupplierCombosQueryHandler(ISupplierRepository supplierRepository)
        {
            _supplierRepository = supplierRepository;
        }

        public async Task<SupplierComboDto[]> Handle(GetSupplierCombosQuery request, CancellationToken cancellationToken)
        {
           return await _supplierRepository.GetCombosAsync();
        }
    }
}