using System;
using System.Linq.Expressions;

namespace Seyit.Data.Currencies
{
    public class CurrencyComboDto
    {
        public int CurrencyId { get; set; }
        public string CurrencyName { get; set; }
        
        
        public static Expression<Func<Currency,CurrencyComboDto>> Projection
        {
            get
            {
                return x => new CurrencyComboDto
                {
                    CurrencyId = x.CurrencyId,
                    CurrencyName = x.CurrencyName
                };
            }
        }
    }
}