using System;
using MediatR;

namespace Seyit.Business.Suppliers.Command
{
    public class CreateSupplierCommand:IRequest<Guid>
    {
        public Guid Id => Guid.NewGuid();
        public string Name { get; set; }
        public int Order { get; set; }
    }
}