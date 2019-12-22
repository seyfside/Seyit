using System.Threading.Tasks;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.Suppliers
{
    public interface ISupplierRepository:IGenericRepository<Supplier>
    {
        Task<SupplierComboDto[]> GetCombosAsync();
    }
}