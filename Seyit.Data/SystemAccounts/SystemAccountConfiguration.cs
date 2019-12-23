using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Seyit.Data.SystemAccounts
{
    public class SystemAccountConfiguration:IEntityTypeConfiguration<SystemAccount>
    {
        public void Configure(EntityTypeBuilder<SystemAccount> builder)
        {
            builder.HasKey(x => x.AccountId);
            builder.Property(x => x.AccountCode);
            builder.Property(x => x.AccountName);
            builder.Property(x => x.AccountPath);
            builder.Property(x => x.CurrencyId);
            builder.Property(x => x.CreationDate);
            builder.Property(x => x.ParentAccountId);
            builder.Property(x => x.RegionLetter);
        }
    }
}