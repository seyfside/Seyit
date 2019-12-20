using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;

namespace Seyit.Business.Airways.Query
{
    public class GetAllAirwaysQueryHandler : IRequestHandler<GetAllAirwaysQuery, Guid>
    {
        public Task<Guid> Handle(GetAllAirwaysQuery request, CancellationToken cancellationToken)
        {
            return Task.FromResult(request.Id);
        }
    }
}