using Microsoft.EntityFrameworkCore;
using Seyit.Data.Airways;
using Seyit.Data.Currencies;
using Seyit.Data.Suppliers;
using Seyit.Data.SystemAccounts;

namespace Seyit.Data
{
    public class SeyitDbContext:DbContext
    {
        public DbSet<Airway> Airways { get; set; }
        public DbSet<Supplier> Suppliers { get; set; }
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseInMemoryDatabase(databaseName:"flight");
            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new AirwayConfiguration());
            modelBuilder.ApplyConfiguration(new SupplierConfiguration());
            modelBuilder.ApplyConfiguration(new CurrencyConfiguration());
            modelBuilder.ApplyConfiguration(new SystemAccountConfiguration());
            
            base.OnModelCreating(modelBuilder);
        }
    }
}