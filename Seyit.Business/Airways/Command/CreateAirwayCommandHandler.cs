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

        public async Task<Guid> Handle(CreateAirwayCommand request, CancellationToken cancellationToken)
        {
            var entity=new Airway
            {
                AirWayId = request.AirWayId,
                AirWayName = request.AirWayName,
                Status = request.Status
            };

            // _dbContext.Database.BeginTransaction();
            _airwayRepository.Insert(entity);
            await _dbContext.SaveChangesAsync(cancellationToken);
            
            //_dbContext.Database.CommitTransaction();
            
            return await Task.FromResult(entity.AirWayId);
        }
    }
}