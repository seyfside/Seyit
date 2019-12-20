using Microsoft.EntityFrameworkCore;

namespace Seyit.Data
{
    public class SeyitDbContext:DbContext
    {
        public DbSet<Airway> Airways { get; set; }
    }
}