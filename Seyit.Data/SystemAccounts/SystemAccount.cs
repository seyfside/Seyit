using System;

namespace Seyit.Data.SystemAccounts
{
    public class SystemAccount
    {
        public long AccountId { get; set; }
        public long ParentAccountId { get; set; }
        public int CurrencyId { get; set; }
        public string AccountPath { get; set; }
        public string AccountName { get; set; }
        public string AccountCode { get; set; }
        public string RegionLetter { get; set; }
        public DateTime CreationDate { get; set; }
    }
}