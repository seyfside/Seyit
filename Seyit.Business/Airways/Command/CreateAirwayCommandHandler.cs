using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Seyit.Business.Infrastructure;
using Seyit.Data;
using Seyit.Data.Airways;
using Seyit.Data.Currencies;
using Seyit.Data.Suppliers;
using Seyit.Data.SystemAccounts;

namespace Seyit.Business.Airways.Command
{
    public class CreateAirwayCommandHandler:IRequestHandler<CreateAirwayCommand,Guid>
    {
        private readonly IAirwayRepository _airwayRepository;
        private readonly ICurrencyRepository _currencyRepository;
        private readonly ISystemAccountRepository _systemAccountRepository;
        private readonly ISupplierRepository _supplierRepository;
        private readonly SeyitDbContext _dbContext;
        private readonly IDateTimeProvider _dateTimeProvider;

        private const string ParentAccountCode = "OtherSupplier";

        public CreateAirwayCommandHandler(IAirwayRepository airwayRepository, SeyitDbContext dbContext, ICurrencyRepository currencyRepository, ISystemAccountRepository systemAccountRepository, IDateTimeProvider dateTimeProvider, ISupplierRepository supplierRepository)
        {
            _airwayRepository = airwayRepository;
            _dbContext = dbContext;
            _currencyRepository = currencyRepository;
            _systemAccountRepository = systemAccountRepository;
            _dateTimeProvider = dateTimeProvider;
            _supplierRepository = supplierRepository;
        }

        public async Task<Guid> Handle(CreateAirwayCommand request, CancellationToken cancellationToken)
        {
            //todo refactor: move create system account codes
            var currencies = await _currencyRepository.GetCombosAsync().ConfigureAwait(false);
            var parentAccount = await _systemAccountRepository.GetParentAccountInfoAsync(ParentAccountCode).ConfigureAwait(false);
            var supplier = await _supplierRepository.GetByIdAsync(request.SupplierId).ConfigureAwait(false);
            
           var airwaySystemAccount=new SystemAccount
            {
                ParentAccountId = parentAccount.AccountId,
                AccountName = request.AirWayName,
                CurrencyId = default,
                RegionLetter = request.RegionLetter,
                AccountCode = String.Empty,
                CreationDate = _dateTimeProvider.Now
            };
            
            _dbContext.Database.BeginTransaction();//todo : tran içinde tran mı yoksa tek tran mı
            
            _systemAccountRepository.Insert(airwaySystemAccount);
            await _dbContext.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
            airwaySystemAccount.AccountPath = $"{parentAccount.AccountPath}/{airwaySystemAccount.AccountId}";
            _systemAccountRepository.Update(airwaySystemAccount);
            
            var entity=new Airway
            {
                AirWayName = request.AirWayName,
                Status = request.Status,
                AccountId = airwaySystemAccount.AccountId,
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

            foreach (var currency in currencies)
            {
                var account=new SystemAccount
                {
                    ParentAccountId = airwaySystemAccount.AccountId,
                    AccountName = $"{airwaySystemAccount.AccountName} {currency.CurrencyName}",
                    CurrencyId = currency.CurrencyId,
                    RegionLetter = airwaySystemAccount.RegionLetter,
                    AccountCode = String.Empty,
                    CreationDate = _dateTimeProvider.Now
                };
                _systemAccountRepository.Insert(account);
                await _dbContext.SaveChangesAsync(cancellationToken).ConfigureAwait(false);

                account.AccountPath = $"{airwaySystemAccount.AccountPath}/{account.AccountId}";
                _systemAccountRepository.Update(account);
            }

            await _dbContext.SaveChangesAsync(cancellationToken).ConfigureAwait(false);
            
            _dbContext.Database.CommitTransaction();
            
            return await Task.FromResult(entity.AirWayId);
        }
    }
}