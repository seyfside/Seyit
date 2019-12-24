using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Seyit.Data.Infrastructure
{
    public class GenericRepository<T> : IGenericRepository<T> where T : class
    {
        private readonly DbSet<T> _table;

        public GenericRepository(SeyitDbContext dbContext)
        {
            _table = dbContext.Set<T>();
        }

        protected IQueryable<T> Table => _table;

        public ValueTask<T> GetByIdAsync(object id)
        {
            return _table.FindAsync(id);
        }

        public void Insert(T obj)
        {
            _table.Add(obj);
        }

        public void Update(T entity)
        {
            _table.Update(entity);
        }

        public void Delete(object id)
        {
            var existing = _table.Find(id);
            _table.Remove(existing);
        }
    }
}