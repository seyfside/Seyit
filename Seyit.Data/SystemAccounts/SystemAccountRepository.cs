using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Seyit.Data.Currencies;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.SystemAccounts
{
    public class SystemAccountRepository:GenericRepository<SystemAccount>,ISystemAccountRepository
    {
        private const string AirwayParentAccountCode = "OtherSupplier";

        private readonly SeyitDbContext _dbContext;
        private readonly ICurrencyRepository _currencyRepository;

        public SystemAccountRepository(SeyitDbContext dbContext, ICurrencyRepository currencyRepository) : base(dbContext)
        {
            _dbContext = dbContext;
            _currencyRepository = currencyRepository;
        }


        private async Task<SystemAccount> GetParentAccountInfoAsync(string accountCode)
        {
            return await Table.AsNoTracking().Where(x => x.AccountCode == accountCode).FirstOrDefaultAsync();
        }

        public async Task<long> CreateAirwaySystemAccountsAsync(string airwayName,string regionLetter,DateTime creationDate)
        {
            var currencies = await _currencyRepository.GetCombosAsync().ConfigureAwait(false);
            var parentAccount =await GetParentAccountInfoAsync(AirwayParentAccountCode).ConfigureAwait(false);

            var airwaySystemAccount=new SystemAccount
            {
                ParentAccountId = parentAccount.AccountId,
                AccountName = airwayName,
                CurrencyId = default,
                RegionLetter = regionLetter,
                AccountCode = String.Empty,
                CreationDate = creationDate
            };
            
            Insert(airwaySystemAccount);

            await _dbContext.SaveChangesAsync();

            airwaySystemAccount.AccountPath = $"{parentAccount.AccountPath}/{airwaySystemAccount.AccountId}";

            Update(airwaySystemAccount);

            foreach (var currency in currencies)
            {
                var account=new SystemAccount
                {
                    ParentAccountId = airwaySystemAccount.AccountId,
                    AccountName = $"{airwayName} {currency.CurrencyName}",
                    CurrencyId = currency.CurrencyId,
                    RegionLetter = airwaySystemAccount.RegionLetter,
                    AccountCode = String.Empty,
                    CreationDate = creationDate
                };
                Insert(account);
                await _dbContext.SaveChangesAsync().ConfigureAwait(false);

                account.AccountPath = $"{airwaySystemAccount.AccountPath}/{account.AccountId}";
                Update(account);
            }
            
            return airwaySystemAccount.AccountId;
        }
    }
}