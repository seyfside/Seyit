using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace Seyit.Data.Infrastructure
{
    public class GenericRepository<T> : IGenericRepository<T> where T : class, IEntity
    {
        private readonly DbSet<T> _table;

        protected GenericRepository(SeyitDbContext context)
        {
            _table = context.Set<T>();
        }

        protected IQueryable<T> Table => _table.AsNoTracking();

        public T GetById(Guid id)
        {
            return _table.AsNoTracking().FirstOrDefault(x=>x.Id==id);
        }

        public void Insert(T obj)
        {
            _table.Add(obj);
        }

        public void Update(T obj)
        {
            _table.Update(obj);
        }

        public void Delete(Guid id)
        {
            T existing = _table.Find(id);
            _table.Remove(existing);
        }
    }
}