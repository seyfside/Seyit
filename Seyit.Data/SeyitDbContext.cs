using Microsoft.EntityFrameworkCore;
using Seyit.Data.Airways;

namespace Seyit.Data
{
    public class SeyitDbContext:DbContext
    {
        public DbSet<Airway> Airways { get; set; }
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlite("Filename=Flight.sqlite");
            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new AirwayConfiguration());
            
            base.OnModelCreating(modelBuilder);
        }
    }
}