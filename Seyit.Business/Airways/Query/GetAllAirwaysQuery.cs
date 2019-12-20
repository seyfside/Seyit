using System;
using MediatR;

namespace Seyit.Business.Airways.Query
{
    public class GetAllAirwaysQuery:IRequest<Guid>
    {
        public Guid Id { get; set; }
    }
}