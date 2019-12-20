using System.Reflection;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using Seyit.Core;
using Seyit.Data.Infrastructure;

namespace Seyit.Business.Infrastructure
{
    public class BusinesslayerInstaller:IContainerInstaller
    {
        public void Install(IServiceCollection services)
        {
            new DatalayerInstaller().Install(services);

            services.AddMediatR(Assembly.GetExecutingAssembly());
        }
    }
}