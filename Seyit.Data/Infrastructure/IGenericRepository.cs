using System.Threading.Tasks;

namespace Seyit.Data.Infrastructure
{
    public interface IGenericRepository<T> where T :class
    {
        ValueTask<T> GetByIdAsync(object id);
        void Insert(T obj);
        void Update(T obj);
        void Delete(object id);
    }
}