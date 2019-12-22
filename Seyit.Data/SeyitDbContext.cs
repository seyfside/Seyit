using Microsoft.EntityFrameworkCore;
using Seyit.Data.Airways;
using Seyit.Data.Suppliers;

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
            
            base.OnModelCreating(modelBuilder);
        }
    }
}