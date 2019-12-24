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
            
            new MockData().Generate();
        }

    }
}