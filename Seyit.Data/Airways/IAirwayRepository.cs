using Seyit.Data.Infrastructure;

namespace Seyit.Data.Airways
{
    public interface IAirwayRepository : IGenericRepository<Airway>
    {
        PagedResult<AirwayDto> Search(SearchModel<Airway> searchModel);
    }
}
