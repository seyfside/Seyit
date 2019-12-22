using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Seyit.Data.Suppliers
{
    public class Supplier : IEntity
    {
        [Column("SupplierId")] public Guid Id { get; set; }//todo: change key type from int to guid

        public string SupplierName { get; set; }
        public int ProcessOrder { get; set; }
    }
}