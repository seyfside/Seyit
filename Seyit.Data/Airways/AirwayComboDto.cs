using System;
using System.Linq.Expressions;

namespace Seyit.Data.Airways
{
    public class AirwayComboDto
    {
        public string AirWayName { get; set; }
        public Guid AirWayId { get; set; }
        
        public static Expression<Func<Airway,AirwayComboDto>> Projection
        {
            get
            {
                return x => new AirwayComboDto
                {
                    AirWayName = x.AirWayName,
                    AirWayId = x.AirWayId
                };
            }
        }
    }
}