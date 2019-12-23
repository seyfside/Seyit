using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.SystemAccounts
{
    public class SystemAccountRepository:GenericRepository<SystemAccount>,ISystemAccountRepository
    {
        public SystemAccountRepository(SeyitDbContext context) : base(context)
        {
        }


        public async Task<SystemAccount> GetParentAccountInfoAsync(string accountCode)
        {
            return await Table.AsNoTracking().Where(x => x.AccountCode == accountCode).FirstOrDefaultAsync();
        }
    }
}