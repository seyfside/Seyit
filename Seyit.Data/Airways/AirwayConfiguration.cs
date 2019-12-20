using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Seyit.Data.Airways
{
    public class AirwayConfiguration:IEntityTypeConfiguration<Airway>
    {
        public void Configure(EntityTypeBuilder<Airway> builder)
        {
            builder.HasKey(x => x.Id);
            builder.Property(x => x.AirWayName);
            builder.Property(x => x.Status);
        }
    }
}