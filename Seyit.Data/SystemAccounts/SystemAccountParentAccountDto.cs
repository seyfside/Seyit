using System;
using System.Linq.Expressions;

namespace Seyit.Data.SystemAccounts
{
    public class SystemAccountParentAccountDto
    {
        public string AccountPath { get; set; }
        public long AccountId { get; set; }
        
        public static Expression<Func<SystemAccount,SystemAccountParentAccountDto>> Projection
        {
            get
            {
                return x => new SystemAccountParentAccountDto
                {
                    AccountPath = x.AccountPath,
                    AccountId = x.AccountId
                };
            }
        }
    }
}