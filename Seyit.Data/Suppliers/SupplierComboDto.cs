using System;
using System.Linq.Expressions;

namespace Seyit.Data.Suppliers
{
    public class SupplierComboDto
    {
        public int SupplierId { get; set; }
        public string SupplierName { get; set; }

        public static Expression<Func<Supplier,SupplierComboDto>> Projection
            {
                get
                {
                    return x => new SupplierComboDto
                    {
                        SupplierName = x.SupplierName,
                        SupplierId = x.SupplierId
                    };
                }
            }
    }
}