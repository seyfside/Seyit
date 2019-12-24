using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.Airways
{
    public class AirwayRepository : GenericRepository<Airway>, IAirwayRepository
    {
        public AirwayRepository(SeyitDbContext dbContext) : base(dbContext)
        {
        }

        public async Task<AirwayComboDto[]> GetCombosAsync()
        {
            return await Table.Where(x => x.Status).Select(AirwayComboDto.Projection).ToArrayAsync();
        }
    }
}