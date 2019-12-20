using System;
using MediatR;

namespace Seyit.Business.Airways.Command
{
    public class CreateAirwayCommand:IRequest<Guid>
    {
        public Guid Id => Guid.NewGuid();
        public string Name { get; set; }
        public bool Status { get; set; }
    }
}