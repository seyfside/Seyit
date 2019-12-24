using System;
using System.Threading.Tasks;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.SystemAccounts
{
    public interface ISystemAccountRepository:IGenericRepository<SystemAccount>
    {
        Task<long> CreateAirwaySystemAccountsAsync(string airwayName,string regionLetter,DateTime creationDate);
    }
}