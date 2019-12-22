using System;
using System.Linq.Expressions;

namespace Seyit.Data.Suppliers
{
    public class SupplierComboDto
    {
        public Guid Id { get; set; }
        public string Name { get; set; }

        public static Expression<Func<Supplier,SupplierComboDto>> Projection
            {
                get
                {
                    return x => new SupplierComboDto
                    {
                        Name = x.SupplierName,
                        Id = x.Id
                    };
                }
            }
    }
}