using System;
using MediatR;

namespace Seyit.Business.Airways.Command
{
    public class CreateAirwayCommand:IRequest<Guid>
    {
        public Guid AirWayId { get; set; }
        public string AirWayName { get; set; }
        public bool Status { get; set; }
    }
}