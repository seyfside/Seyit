using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.Currencies
{
    public class CurrencyRepository :GenericRepository<Currency>, ICurrencyRepository
    {
        protected CurrencyRepository(SeyitDbContext context) : base(context)
        {
        }

        public async Task<CurrencyComboDto[]> GetCombosAsync()
        {
            return await Table.Select(CurrencyComboDto.Projection).ToArrayAsync();
        }
    }
}