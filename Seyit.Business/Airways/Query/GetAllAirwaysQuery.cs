using System;
using MediatR;
using Seyit.Data.Airways;
using Seyit.Data.Infrastructure;

namespace Seyit.Business.Airways.Query
{
    public class GetAllAirwaysQuery:IRequest<PagedResult<AirwayDto>>
    {
        public int CurrentPage { get; set; }
        public int PageSize { get; set; }
    }
}