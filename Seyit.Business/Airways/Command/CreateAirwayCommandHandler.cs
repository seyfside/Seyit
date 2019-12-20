using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Seyit.Data;
using Seyit.Data.Airways;

namespace Seyit.Business.Airways.Command
{
    public class CreateAirwayCommandHandler:IRequestHandler<CreateAirwayCommand,Guid>
    {
        private readonly IAirwayRepository _airwayRepository;
        private readonly SeyitDbContext _dbContext;

        public CreateAirwayCommandHandler(IAirwayRepository airwayRepository, SeyitDbContext dbContext)
        {
            _airwayRepository = airwayRepository;
            _dbContext = dbContext;
        }

        public Task<Guid> Handle(CreateAirwayCommand request, CancellationToken cancellationToken)
        {
            var entity=new Airway
            {
                Id = request.Id,
                AirWayName = request.Name,
                Status = request.Status
            };
            _airwayRepository.Insert(entity);
            _dbContext.SaveChanges();
            
            return Task.FromResult<Guid>(request.Id);
        }
    }
}