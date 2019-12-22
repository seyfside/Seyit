using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.Suppliers
{
    public class SupplierRepository : GenericRepository<Supplier>, ISupplierRepository
    {
        public SupplierRepository(SeyitDbContext context) : base(context)
        {
        }

        public async Task<SupplierComboDto[]> GetCombosAsync()
        {
            return await Table.Select(SupplierComboDto.Projection).ToArrayAsync();
        }
    }
}