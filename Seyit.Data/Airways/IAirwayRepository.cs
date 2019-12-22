using System.Threading.Tasks;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.Airways
{
    public interface IAirwayRepository : IGenericRepository<Airway>
    {
        Task<AirwayComboDto[]> GetCombosAsync();
    }
}
