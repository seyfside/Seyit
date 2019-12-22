using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Seyit.Data.Suppliers
{
    public class SupplierConfiguration:IEntityTypeConfiguration<Supplier>
    {
        public void Configure(EntityTypeBuilder<Supplier> builder)
        {
            builder.HasKey(x => x.Id);
            builder.Property(x => x.SupplierName);
            builder.Property(x => x.ProcessOrder);
        }
    }
}