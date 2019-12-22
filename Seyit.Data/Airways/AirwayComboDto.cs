using System;
using System.Linq.Expressions;

namespace Seyit.Data.Airways
{
    public class AirwayComboDto
    {
        public string Name { get; set; }
        public Guid Id { get; set; }
        
        public static Expression<Func<Airway,AirwayComboDto>> Projection
        {
            get
            {
                return x => new AirwayComboDto
                {
                    Name = x.AirWayName,
                    Id = x.Id
                };
            }
        }
    }
}