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
            builder.Property(x => x.AccountId);
            builder.Property(x => x.CarrierCode);
            builder.Property(x => x.ServicesPrice);
            builder.Property(x => x.CanCreateRezervation);
            builder.Property(x => x.WebServicesUrl);
            builder.Property(x => x.WebServisPassword);
            builder.Property(x => x.DefaultAgencyCommissionsPrice);
            builder.Property(x => x.WebServicesParamOne);
            builder.Property(x => x.WebServicesParamTwo);
            builder.Property(x => x.WebServicesUserName);
            builder.Property(x => x.SearchServiceTimeOutSecond);
            builder.HasOne(x => x.Supplier);
        }
    }
}