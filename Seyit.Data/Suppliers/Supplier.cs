using System.ComponentModel.DataAnnotations.Schema;

namespace Seyit.Data.Suppliers
{
    public class Supplier
    {
        public int SupplierId { get; set; }
        public string SupplierName { get; set; }
        public int ProcessOrder { get; set; }
    }
}