using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Seyit.Core;
using Seyit.Data;
using Seyit.Data.Airways;

namespace Seyit.Business.Airways.Query
{
    public class GetAirwayCombosQueryHandler : IRequestHandler<GetAirwayCombosQuery, AirwayComboDto[]>
    {
        private readonly IAirwayRepository _airwayRepository;

        public GetAirwayCombosQueryHandler(IAirwayRepository airwayRepository)
        {
            _airwayRepository = airwayRepository;
        }

        public Task<AirwayComboDto[]> Handle(GetAirwayCombosQuery request, CancellationToken cancellationToken)
        {
            return _airwayRepository.GetCombosAsync();
        }
    }
}