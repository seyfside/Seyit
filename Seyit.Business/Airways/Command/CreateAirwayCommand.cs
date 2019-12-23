using System;
using MediatR;

namespace Seyit.Business.Airways.Command
{
    public class CreateAirwayCommand:IRequest<Guid>
    {
        public Guid AirWayId => Guid.NewGuid();
        public string AirWayName { get; set; }
        public bool Status { get; set; }
    }
}