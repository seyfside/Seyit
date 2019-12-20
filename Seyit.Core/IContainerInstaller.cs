using Microsoft.Extensions.DependencyInjection;

namespace Seyit.Core
{
    public interface IContainerInstaller
    {
        void Install(IServiceCollection services);
    }
}