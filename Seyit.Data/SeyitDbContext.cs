using System.Reflection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Seyit.Data.Currencies;
using Seyit.Data.Suppliers;
using Seyit.Data.SystemAccounts;

namespace Seyit.Data
{
    public class SeyitDbContext:DbContext
    {
        public DbSet<Airway> Airways { get; set; }
        public DbSet<Supplier> Suppliers { get; set; }
        public DbSet<Currency> Currencies { get; set; }
        public DbSet<SystemAccount> SystemAccounts { get; set; }
        
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Server=localhost\\SQLEXPRESS;Database=flight;Trusted_Connection=True;");
            #if DEBUG
            optionsBuilder.UseLoggerFactory(MyLoggerFactory);
            #endif
            base.OnConfiguring(optionsBuilder);
        }
        
        public static readonly ILoggerFactory MyLoggerFactory
            = LoggerFactory.Create(builder =>
            {
                builder
                    .AddFilter((category, level) =>
                    category == DbLoggerCategory.Database.Command.Name
                    && level == LogLevel.Information)
                    .AddConsole();
            });


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
            
            base.OnModelCreating(modelBuilder);
        }
    }
}