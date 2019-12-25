using System.Reflection;
using Microsoft.Extensions.DependencyInjection;
using Seyit.Core;

namespace Seyit.Data.Infrastructure
{
    public class DataLayerInstaller:IContainerInstaller
    {
        public void Install(IServiceCollection services)
        {
            services.AddDbContext<SeyitDbContext>(ServiceLifetime.Scoped);

            services.AddByNameConvention(Assembly.GetExecutingAssembly(), "Repository",new []{"GenericRepository"});

            new MockData().Generate();
        }

    }
}