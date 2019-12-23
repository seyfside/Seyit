using System.Threading.Tasks;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.Currencies
{
    public interface ICurrencyRepository:IGenericRepository<Currency>
    {
        Task<CurrencyComboDto[]> GetCombosAsync();
    }
}