using System.Linq;
using System.Reflection;
using Microsoft.Extensions.DependencyInjection;

namespace Seyit.Core
{
    public static class ServiceCollectionExtensions
    {

        public static void AddByNameConvention(this IServiceCollection services,Assembly assembly ,string nameEndsWith, string[] exceptNames)
        {
            foreach (var type in assembly.GetTypes()
                .Where(x=>x.IsClass && x.Name.EndsWith(nameEndsWith) && !exceptNames.Contains(x.Name)))
            {
                var singleInterface = type.GetInterfaces().First(x => x.Name.EndsWith(nameEndsWith));

                services.AddScoped(singleInterface, type);
            }
        }
        
        
    }
}