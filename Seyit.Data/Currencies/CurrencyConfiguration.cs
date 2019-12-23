using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Seyit.Data.Currencies
{
    public class CurrencyConfiguration:IEntityTypeConfiguration<Currency>
    {
        public void Configure(EntityTypeBuilder<Currency> builder)
        {
            builder.HasKey(x => x.CurrencyId);
            builder.Property(x => x.CurrencyCode);
            builder.Property(x => x.CurrencyName);
            builder.Property(x => x.OrderProcess);
        }
    }
}