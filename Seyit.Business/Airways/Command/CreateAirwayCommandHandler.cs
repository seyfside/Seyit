using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Seyit.Business.Infrastructure;
using Seyit.Data;
using Seyit.Data.Airways;
using Seyit.Data.Suppliers;
using Seyit.Data.SystemAccounts;

namespace Seyit.Business.Airways.Command
{
    public class CreateAirwayCommandHandler:IRequestHandler<CreateAirwayCommand,Guid>
    {
        private readonly IAirwayRepository _airwayRepository;
        private readonly ISystemAccountRepository _systemAccountRepository;
        private readonly ISupplierRepository _supplierRepository;
        private readonly SeyitDbContext _dbContext;
        private readonly IDateTimeProvider _dateTimeProvider;
        
        public CreateAirwayCommandHandler(IAirwayRepository airwayRepository, SeyitDbContext dbContext, ISystemAccountRepository systemAccountRepository, IDateTimeProvider dateTimeProvider, ISupplierRepository supplierRepository)
        {
            _airwayRepository = airwayRepository;
            _dbContext = dbContext;
            _systemAccountRepository = systemAccountRepository;
            _dateTimeProvider = dateTimeProvider;
            _supplierRepository = supplierRepository;
        }

        public async Task<Guid> Handle(CreateAirwayCommand request, CancellationToken cancellationToken)
        {
            //todo : update sorguları asnotracking halde üretiliyor.
            var supplier = await _supplierRepository.GetByIdAsync(request.SupplierId).ConfigureAwait(false);
           
            _dbContext.Database.BeginTransaction();

            var accountId= await _systemAccountRepository.CreateAirwaySystemAccountsAsync(request.AirWayName,request.RegionLetter,_dateTimeProvider.Now);

            var entity=new Airway
            {
                AirWayName = request.AirWayName,
                Status = request.Status,
                AccountId = accountId,
                CarrierCode = request.CarrierCode,
                ServicesPrice = request.ServicesPrice,
                CanCreateRezervation = request.CanCreateRezervation,
                WebServicesUrl = request.WebServicesUrl,
                WebServisPassword = request.WebServisPassword,
                DefaultAgencyCommissionsPrice = request.DefaultAgencyCommissionsPrice,
                WebServicesParamOne = request.WebServicesParamOne,
                WebServicesParamTwo = request.WebServicesParamTwo,
                WebServicesUserName = request.WebServicesUserName,
                SearchServiceTimeOutSecond = request.SearchServiceTimeOutSecond,
                Supplier = supplier
            };
            _airwayRepository.Insert(entity);

            await _dbContext.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
            
            _dbContext.Database.CommitTransaction();
            
            return await Task.FromResult(entity.AirWayId);
        }
    }
}
