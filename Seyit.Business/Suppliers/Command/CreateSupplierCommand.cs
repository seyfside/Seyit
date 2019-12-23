using System;
using MediatR;

namespace Seyit.Business.Suppliers.Command
{
    public class CreateSupplierCommand:IRequest<int>
    {
        public int SupplierId { get; set; }
        public string SupplierName { get; set; }
        public int ProcessOrder { get; set; }
    }
}