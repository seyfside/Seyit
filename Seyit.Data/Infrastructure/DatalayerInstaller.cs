using Microsoft.Extensions.DependencyInjection;
using Seyit.Core;

namespace Seyit.Data.Infrastructure
{
    public class DatalayerInstaller:IContainerInstaller
    {
        public void Install(IServiceCollection services)
        {
            services.AddDbContext<SeyitDbContext>(ServiceLifetime.Scoped);
        }
    }
}