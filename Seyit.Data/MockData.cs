using Seyit.Data.Currencies;
using Seyit.Data.Suppliers;
using Seyit.Data.SystemAccounts;

namespace Seyit.Data
{
    public class MockData
    {
        public void Generate()
        {
            var context = new SeyitDbContext();
            context.Database.EnsureDeleted();
            context.Database.EnsureCreated();
            var supplier = new Supplier {ProcessOrder = 1, SupplierName = "supplier 1"};
            context.Add(supplier);
            var systemAccount=new SystemAccount
            {
                AccountCode = "OtherSupplier",
                AccountPath = "1",
                AccountName = "",
                CurrencyId = 0,ParentAccountId = 0,RegionLetter = "tr-TR"
            };

            context.Add(systemAccount);
            
            var currency1=new Currency
            {
                CurrencyCode = "TL",
                CurrencyName = "Türk Lirası",
                OrderProcess = 1
            };
            var currency2=new Currency
            {
                CurrencyCode = "USD",
                CurrencyName = "Dolar",
                OrderProcess = 2
            };
            context.Add(currency1);
            context.Add(currency2);
            context.SaveChanges();
        }
    }
}