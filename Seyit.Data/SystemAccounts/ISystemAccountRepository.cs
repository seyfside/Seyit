using System.Threading.Tasks;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.SystemAccounts
{
    public interface ISystemAccountRepository:IGenericRepository<SystemAccount>
    {
        Task<SystemAccount> GetByAccountCodeAsync(string accountCode);
    }
}