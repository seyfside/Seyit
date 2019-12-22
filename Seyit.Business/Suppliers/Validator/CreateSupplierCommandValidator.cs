using FluentValidation;
using Seyit.Business.Suppliers.Command;

namespace Seyit.Business.Suppliers.Validator
{
    public class CreateSupplierCommandValidator:AbstractValidator<CreateSupplierCommand>
    {
        public CreateSupplierCommandValidator()
        {
            RuleFor(x => x.Name).NotEmpty();
            RuleFor(x => x.Order).NotEmpty();
        }
    }
}