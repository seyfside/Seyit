using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Seyit.Data;
using Seyit.Data.Airways;
using Seyit.Data.Infrastructure;

namespace Seyit.Business.Airways.Query
{
    public class GetAllAirwaysQueryHandler : IRequestHandler<GetAllAirwaysQuery, PagedResult<AirwayDto>>
    {
        private readonly IAirwayRepository _airwayRepository;

        public GetAllAirwaysQueryHandler(IAirwayRepository airwayRepository)
        {
            _airwayRepository = airwayRepository;
        }

        public Task<PagedResult<AirwayDto>> Handle(GetAllAirwaysQuery request, CancellationToken cancellationToken)
        {
            var searchModel=new SearchModel<Airway>
            {
                CurrentPage = request.CurrentPage,
                PageSize = request.PageSize
            };
            var result = _airwayRepository.Search(searchModel);

            return Task.FromResult(result);
        }
    }
}