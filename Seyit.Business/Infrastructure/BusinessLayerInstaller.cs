using System.Reflection;
using FluentValidation;
using MediatR;
using Microsoft.Extensions.DependencyInjection;
using Seyit.Core;
using Seyit.Data.Infrastructure;

namespace Seyit.Business.Infrastructure
{
    public class BusinessLayerInstaller:IContainerInstaller
    {
        public void Install(IServiceCollection services)
        {
            new DataLayerInstaller().Install(services);

            services.AddScoped<IDateTimeProvider, DateTimeProvider>();
            services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));
            services.AddMediatR(Assembly.GetExecutingAssembly());

            services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());
        }
    }
}