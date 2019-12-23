using Microsoft.Extensions.DependencyInjection;
using Seyit.Core;
using Seyit.Data.Airways;
using Seyit.Data.Currencies;
using Seyit.Data.Suppliers;
using Seyit.Data.SystemAccounts;

namespace Seyit.Data.Infrastructure
{
    public class DataLayerInstaller:IContainerInstaller
    {
        public void Install(IServiceCollection services)
        {
            services.AddDbContext<SeyitDbContext>(ServiceLifetime.Scoped);
            services.AddScoped<IAirwayRepository, AirwayRepository>();
            services.AddScoped<ISupplierRepository, SupplierRepository>();
            services.AddScoped<ICurrencyRepository, CurrencyRepository>();
            services.AddScoped<ISystemAccountRepository, SystemAccountRepository>();

            var context = new SeyitDbContext();
            context.Database.EnsureDeleted();
            context.Database.EnsureCreated();
            var supplier = new Supplier {ProcessOrder = 1, SupplierName = "supplier 1"};
            context.Add(supplier);
            var airway = new Airway {Supplier = supplier, AirWayName ="AirWay 1" };
            context.Add(airway);
            var systemAccount=new SystemAccount
            {
                AccountCode = "OtherSupplier",
                AccountPath = "1/2",
                AccountName = "account name 1",
                CurrencyId = 0,ParentAccountId = 0,RegionLetter = "tr-TR"
            };

            context.Add(systemAccount);
            
            var currency=new Currency
            {
                CurrencyCode = "TL",
                CurrencyName = "Türk Lirası",
                OrderProcess = 1
            };
            context.Add(currency);
            context.SaveChanges();
        }
    }
}