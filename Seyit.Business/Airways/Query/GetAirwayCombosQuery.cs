using MediatR;
using Seyit.Data.Airways;

namespace Seyit.Business.Airways.Query
{
    public class GetAirwayCombosQuery:IRequest<AirwayComboDto[]>
    {
    }
}