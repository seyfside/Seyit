using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.Currencies
{
    public class CurrencyRepository :GenericRepository<Currency>, ICurrencyRepository
    {
        public CurrencyRepository(SeyitDbContext dbContext) : base(dbContext)
        {
        }

        public async Task<CurrencyComboDto[]> GetCombosAsync()
        {
            return await Table.AsNoTracking().Select(CurrencyComboDto.Projection).ToArrayAsync();
        }
    }
}