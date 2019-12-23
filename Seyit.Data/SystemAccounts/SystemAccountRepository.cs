using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.SystemAccounts
{
    public class SystemAccountRepository:GenericRepository<SystemAccount>,ISystemAccountRepository
    {
        protected SystemAccountRepository(SeyitDbContext context) : base(context)
        {
        }


        public async Task<SystemAccount> GetByAccountCodeAsync(string accountCode)
        {
            return await Table.Where(x => x.AccountCode == accountCode).FirstOrDefaultAsync();
        }
    }
}