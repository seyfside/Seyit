using System;
using System.Linq.Expressions;

namespace Seyit.Data.Airways
{
    public class AirwayDto
    {
        public string Name { get; set; }
        public bool Status { get; set; }
        
        public static Expression<Func<Airway,AirwayDto>> Projection
        {
            get
            {
                return x => new AirwayDto
                {
                    Name = x.AirWayName,
                    Status = x.Status
                };
            }
        }
    }
}