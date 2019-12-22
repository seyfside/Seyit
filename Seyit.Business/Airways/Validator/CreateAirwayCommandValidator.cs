using FluentValidation;
using Seyit.Business.Airways.Command;

namespace Seyit.Business.Airways.Validator
{
    public class CreateAirwayCommandValidator:AbstractValidator<CreateAirwayCommand>
    {
        public CreateAirwayCommandValidator()
        {
            RuleFor(x => x.Name).NotEmpty();
        }
    }
}