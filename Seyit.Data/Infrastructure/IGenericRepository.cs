using System;

namespace Seyit.Data.Infrastructure
{
    public interface IGenericRepository<T> where T :class, IEntity
    {
        T GetById(Guid id);
        void Insert(T obj);
        void Update(T obj);
        void Delete(Guid id);
    }
}