create database BiletDukkaniTestMainDbSql01 collate Turkish_CI_AI_KS_WS
go

create table AgencyAllowedSuppliers
(
	AgencyTypeId uniqueidentifier,
	SupplierId int
)
go

create table AgencyCommissionTables
(
	AgencyCommissionTableId uniqueidentifier constraint DF_AgencyCommissionTables_AgencyCommissionTableId default newid() not null
		constraint PK_AgencyCommissionTables
			primary key,
	AgencyId uniqueidentifier,
	AirWayId uniqueidentifier,
	DomesticBussinessPrice decimal(18,2),
	DomesticEconomyPrice decimal(18,2),
	DomesticEconomyHighPrice decimal(18,2),
	DomesticPromotionPrice decimal(18,2),
	InterFirstPrice decimal(18,2),
	InterBussinessPrice decimal(18,2),
	InterEconomyPrice decimal(18,2),
	InterEconomyHighPrice decimal(18,2),
	InterPromotionPrice decimal(18,2)
)
go

create table AgencyCorporateCode
(
	AgencyCorporateCodeId uniqueidentifier constraint DF_AgencyCorporateCode_Id default newid() not null
		constraint PK_AgencyCorporateCode
			primary key,
	AgencyId uniqueidentifier not null,
	CarrierCode nvarchar(5) not null,
	CorporateCode nvarchar(50) not null
)
go

create table AgencyIpLogs
(
	AgencyIpLogId uniqueidentifier constraint DF_AgencyIpLogsa_AgencyIpLogId default newid() not null
		constraint PK_AgencyIpLogsa_1
			primary key,
	AgencyId uniqueidentifier,
	UserId uniqueidentifier,
	IpAddress nvarchar(50),
	IpType nvarchar(50),
	ContinentName nvarchar(50),
	CountryName nvarchar(50),
	RegionName nvarchar(50),
	CityName nvarchar(250),
	Lat float,
	Long float,
	CreationDate datetime,
	IpProcessTypeName nvarchar(50)
)
go

create table AgencyProfile
(
	AgencyId uniqueidentifier,
	ParentAgencyId uniqueidentifier,
	AgencyDefaultCurrencyId int,
	AgencyOwnerUserId uniqueidentifier,
	AgencyCode int identity,
	AgencyName nvarchar(250),
	CommercialTitle nvarchar(500),
	AgencyLogo nvarchar(500),
	PhoneNumber nvarchar(50),
	FaxNumber nvarchar(50),
	ManagerName nvarchar(50),
	ManagerSurName nvarchar(50),
	CountryId int not null,
	CityId int,
	DistrictName nvarchar(50),
	Adress nvarchar(500),
	TaxOffice nvarchar(50),
	TaxNumber nvarchar(50),
	WebSite nvarchar(500),
	IsBya bit,
	PayTicketingInstallmetCommission bit,
	PayNoInstallmentTicketingCommission bit,
	IsIata bit,
	CanManuelPosPayment bit,
	PayManuelPosCommission bit,
	ForceManuelPosTreeDPayment bit,
	ForceTreeDPaymentTicketing bit,
	CreationDate datetime,
	CreatedBy uniqueidentifier,
	AgencyTypeId uniqueidentifier,
	HasContract bit,
	AllowXMLServices bit,
	XMLPaymentType nvarchar(50),
	XMLAuthPassword nvarchar(250),
	XMLAllowedIPAdress nvarchar(250),
	Status bit,
	AccountId int,
	SmsOriginator nvarchar(11),
	ParentAgencyCommissionPrice decimal(18,2),
	DefaultInvoicePreference int constraint DF_AgencyProfile_DefaultInvoicePreference default 0,
	IsCreateCorporateAgency bit constraint DF_AgencyProfile_IsCreateCorporateAgency default 0,
	CreditLimit decimal(18,2) constraint DF_AgencyProfile_CreditLimit default 0,
	IsAgencyCompany bit constraint DF_AgencyProfile_IsAgencyCompany default 0 not null
)
go

create table AgencyRequests
(
	AgencyId uniqueidentifier,
	CreationDate datetime,
	RequestFrom nvarchar(3),
	RequestTo nvarchar(3),
	ProcessId uniqueidentifier,
	SearchId uniqueidentifier,
	DepartureDate date,
	ArrivalDate date
)
go

create table AgencyTypes
(
	AgencyTypeId uniqueidentifier constraint DF_AgencyTypes_AgencyTypeId default newid() not null
		constraint PK_AgencyTypes
			primary key,
	AgencyTypeName nvarchar(250),
	Status bit,
	ShortenChar nvarchar(1)
)
go

create table AgencyUsers
(
	AgencyUserId uniqueidentifier constraint DF_AgencyUsers_AgencyUserId default newid() not null
		constraint PK_AgencyUsers
			primary key,
	AgencyId uniqueidentifier,
	UserId uniqueidentifier,
	Name nvarchar(50),
	SurName nvarchar(50),
	Phone nvarchar(50),
	CreationDate datetime
)
go

create table AirLineList
(
	AirLineId uniqueidentifier constraint DF_AirLineList_AirLineId default newid() not null
		constraint PK_AirLineList
			primary key,
	IataCode nvarchar(2) not null,
	IcaoCode nvarchar(3) not null,
	AirLineName nvarchar(500) not null,
	Country nvarchar(150) not null
)
go

create table AirPorts
(
	AirportId uniqueidentifier constraint DF_Airports_AirportId default newid() not null
		constraint PK_Airports
			primary key,
	AirportCode nvarchar(255),
	AirportName nvarchar(255),
	CountryCode nvarchar(255),
	CountryName nvarchar(255),
	LocalizedCountryName nvarchar(255),
	CityCode nvarchar(255),
	CityName nvarchar(255),
	LocalizedCityName nvarchar(255),
	StateCode nvarchar(255),
	StateName nvarchar(255),
	Rating float,
	AirPortTimezone int,
	WindowsTimeZone nvarchar(50),
	UnixTimeZone nvarchar(50),
	IsCity bit
)
go

create table AirWayCommissions
(
	AirWayCommissionId uniqueidentifier constraint DF_AgencyCommissions_AgencyCommissionId default newid() not null
		constraint PK_AirWayCommissions
			primary key,
	AirWayId uniqueidentifier,
	DomesticBussinessPrice decimal(18,2),
	DomesticEconomyPrice decimal(18,2),
	DomesticEconomyHighPrice decimal(18,2),
	DomesticPromotionPrice decimal(18,2),
	InterFirstPrice decimal(18,2),
	InterBussinessPrice decimal(18,2),
	InterEconomyPrice decimal(18,2),
	InterEconomyHighPrice decimal(18,2),
	InterPromotionPrice decimal(18,2)
)
go

create TRIGGER [dbo].[trg_AirwayCommissionChange]
   ON  [dbo].[AirWayCommissions]
   AFTER UPDATE
AS 
BEGIN

declare @DomesticBussinesPrice decimal(18,2)
set @DomesticBussinesPrice=(select DomesticBussinessPrice from deleted)
declare @DomesticEconomyPrice decimal(18,2)
set @DomesticEconomyPrice=(select DomesticEconomyPrice from deleted)
declare @DomesticPromoPrice  decimal(18,2)
set @DomesticPromoPrice=(select DomesticPromotionPrice from deleted)
declare @InterFirstPrice decimal(18,2)
set @InterFirstPrice=(select InterFirstPrice from deleted)
declare @InterBussinesPrice decimal(18,2)
set @InterBussinesPrice=(select InterBussinessPrice from deleted)
declare @InterEconomyPrice decimal(18,2)
set @InterEconomyPrice=(select InterEconomyPrice from deleted)
declare @InterPromoPrice decimal(18,2)
set @InterPromoPrice=(select InterPromotionPrice from deleted)



declare @DomesticBussinesPriceNew decimal(18,2)
set @DomesticBussinesPriceNew=(select DomesticBussinessPrice from inserted)
declare @DomesticEconomyPriceNew decimal(18,2)
set @DomesticEconomyPriceNew=(select DomesticEconomyPrice from inserted)
declare @DomesticPromoPriceNew  decimal(18,2)
set @DomesticPromoPriceNew=(select DomesticPromotionPrice from inserted)
declare @InterFirstPriceNew decimal(18,2)
set @InterFirstPriceNew=(select InterFirstPrice from inserted)
declare @InterBussinesPriceNew decimal(18,2)
set @InterBussinesPriceNew=(select InterBussinessPrice from inserted)
declare @InterEconomyPriceNew decimal(18,2)
set @InterEconomyPriceNew=(select InterEconomyPrice from inserted)
declare @InterPromoPriceNew decimal(18,2)
set @InterPromoPriceNew=(select InterPromotionPrice from inserted)
				declare  cur  cursor local fast_forward for select AirwayId From Deleted  
                open cur    
                declare @AirwayId uniqueidentifier
                fetch next from cur into @AirwayId
                while @@fetch_status =0  
                begin                 
				 update AgencyCommissionTables set
				  DomesticBussinessPrice=((@DomesticBussinesPriceNew-@DomesticBussinesPrice)+DomesticBussinessPrice),
				 DomesticEconomyPrice=((@DomesticEconomyPriceNew-@DomesticEconomyPrice)+DomesticEconomyPrice),
				 DomesticPromotionPrice=((@DomesticPromoPriceNew -@DomesticPromoPrice)+DomesticPromotionPrice),
				 InterFirstPrice=((@InterFirstPriceNew-@InterFirstPrice)+InterFirstPrice),
				 InterBussinessPrice=((@InterBussinesPriceNew-@InterBussinesPrice)+InterBussinessPrice),
				 InterEconomyPrice=((@InterEconomyPriceNew-@InterEconomyPrice)+InterEconomyPrice),
				 InterPromotionPrice=((@InterPromoPriceNew-@InterPromoPrice)+InterPromotionPrice)
				 where AirwayId=@AirwayId
                fetch next from cur into @AirwayId   
                end
                close cur  
                deallocate cur   

END
go

create table AirWayRules
(
	AirWayRuleId uniqueidentifier constraint DF_AirWayRules_AirWayRuleId default newid() not null
		constraint PK_AirWayRules
			primary key,
	CarrierCode nvarchar(5),
	SupplierId int,
	RuleTitle nvarchar(500),
	RuleContent nvarchar(max),
	Lang nvarchar(2)
)
go

create table AirWayServicesCharges
(
	SupplierId int,
	InternalPrice decimal(18,2),
	DomestictPrice decimal(18,2),
	DomesticCurrencyId int,
	InternalCurrencyId int
)
go

create table AirWaySpecialClassPrice
(
	CarrierCode nvarchar(5),
	ClassCode nvarchar(5),
	Price decimal(18,2),
	ColumnName nvarchar(50),
	Status bit,
	RoundTrip bit
)
go

create table AirWaySuppliers
(
	SupplierId int,
	SupplierName nvarchar(50),
	ProcessOrder int
)
go

create table AirWays
(
	AirWayId uniqueidentifier constraint DF_AirWays_AirWayId default newid() not null,
	AirWayName nvarchar(max),
	CarrierCode nvarchar(max),
	WebServicesUserName nvarchar(max),
	WebServisPassword nvarchar(max),
	WebServicesParamOne nvarchar(max),
	WebServicesParamTwo nvarchar(max),
	ServicesPrice decimal(18,2),
	DefaultAgencyCommissionsPrice decimal(18,2),
	Status bit,
	WebServicesUrl nvarchar(max),
	CanCreateRezervation bit,
	SupplierId int,
	AccountId int,
	SearchServiceTimeOutSecond int
)
go

create table AirWaysClassTypes
(
	AirWayClassTypeId int identity
		constraint PK_AirWayClassTypeName
			primary key,
	CarrierCode nvarchar(5),
	ClassCode nvarchar(15),
	ClassTypeName nvarchar(15),
	Status bit
)
go

create table AirWaysPriceColumns
(
	AirWayPriceColumnId int identity
		constraint PK_AirWayPriceColumns
			primary key,
	CarrierCode nvarchar(3) not null,
	ClassCode nvarchar(10) not null,
	ColumnName nvarchar(50) not null,
	Status bit not null
)
go

create table AnnouncementDetails
(
	AnnouncementDetailId uniqueidentifier constraint DF_AnnouncementDetails_AnnouncementDetailId default newid() not null
		constraint PK_AnnouncementDetails
			primary key,
	UserId uniqueidentifier not null,
	AnnouncementId uniqueidentifier not null,
	Readed bit not null,
	ReadDate datetime not null
)
go

create table Announcements
(
	AnnouncementId uniqueidentifier not null
		constraint PK_Announcements
			primary key,
	Title nvarchar(max) not null,
	LongText nvarchar(max) not null,
	CreationDate datetime not null,
	Status bit not null,
	Lang nvarchar(5) not null
)
go

create table AspNetRoles
(
	Id nvarchar(128) not null
		constraint [PK_dbo.AspNetRoles]
			primary key,
	Name nvarchar(256) not null
)
go

create table AspNetUsers
(
	Id nvarchar(128) not null
		constraint [PK_dbo.AspNetUsers]
			primary key,
	Email nvarchar(256),
	EmailConfirmed bit not null,
	PasswordHash nvarchar(max),
	SecurityStamp nvarchar(max),
	PhoneNumber nvarchar(max),
	PhoneNumberConfirmed bit not null,
	TwoFactorEnabled bit not null,
	LockoutEndDateUtc datetime,
	LockoutEnabled bit not null,
	AccessFailedCount int not null,
	UserName nvarchar(256) not null
)
go

create table AspNetUserClaims
(
	Id int identity
		constraint [PK_dbo.AspNetUserClaims]
			primary key,
	UserId nvarchar(128) not null
		constraint [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
			references AspNetUsers
				on delete cascade,
	ClaimType nvarchar(max),
	ClaimValue nvarchar(max)
)
go

create table AspNetUserLogins
(
	LoginProvider nvarchar(128) not null,
	ProviderKey nvarchar(128) not null,
	UserId nvarchar(128) not null
		constraint [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
			references AspNetUsers
				on delete cascade,
	constraint [PK_dbo.AspNetUserLogins]
		primary key (LoginProvider, ProviderKey, UserId)
)
go

create table AspNetUserRoles
(
	UserId nvarchar(128) not null
		constraint [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
			references AspNetUsers
				on delete cascade,
	RoleId nvarchar(128) not null
		constraint [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
			references AspNetRoles
				on delete cascade,
	constraint [PK_dbo.AspNetUserRoles]
		primary key (UserId, RoleId)
)
go

create table BaggageInfo
(
	AirWayBagId int identity
		constraint PK_BaggageInfo
			primary key,
	Carrier nvarchar(50),
	ColumnName nvarchar(50),
	BagValue nvarchar(50),
	PassegerType nvarchar(10),
	Unit nvarchar(50),
	IsDomestic bit,
	ETicketInfo nvarchar(max),
	Lang nvarchar(5)
)
go

create table BankInstallments
(
	BankInstallmetId uniqueidentifier constraint DF_Table_1_BankInstalmetId default newid() not null
		constraint PK_BankInstallments
			primary key,
	BankId uniqueidentifier,
	InstallmentCount int,
	CommissionRate decimal(18,2),
	Status bit,
	ExpenseInstallmentRate decimal(18,2),
	OtherBankInstallmentRate decimal(18,2)
)
go

create table BankPosInformations
(
	BankPosInformationId uniqueidentifier constraint DF_BankPosInformation_BankPosInformationId default newid() not null
		constraint PK_BankPosInformation
			primary key,
	BankId uniqueidentifier,
	PosInfoName nvarchar(50),
	ServicesUrl nvarchar(500),
	ClientId nvarchar(50),
	ClientUserName nvarchar(50),
	ClientPassword nvarchar(50),
	MerchantId nvarchar(50),
	TreeDStoreKey nvarchar(500),
	TreeDServicesUrl nvarchar(500),
	AuthType nvarchar(10),
	SupplierName nvarchar(50),
	TreeDPaymentLocalUrl nvarchar(500),
	TreeDPaymentLocalSuccsessUrl nvarchar(500),
	TreeDPaymentLocalFailUrl nvarchar(500),
	ProcessOrder int,
	Status bit
)
go

create table BankPosLogPaymentStatus
(
	BankPosLogStatuId int identity
		constraint PK_BankPosLogPaymentStatus
			primary key,
	EnumEqual nvarchar(50),
	Description nvarchar(50),
	ReceiptReferance bit,
	Lang nvarchar(5)
)
go

create table BankPosLogs
(
	BankPosLogId uniqueidentifier constraint DF_BankPosLogs_BankPosLogId default newid() not null
		constraint PK_BankPosLogs
			primary key,
	BankPosId uniqueidentifier,
	ProcessType int,
	PaymentStatus int,
	InstallmentCount int,
	InstallmentCommisionAmount decimal(18,2),
	Amount decimal(18,2),
	TotalAmount decimal(18,2),
	CurrencyId int,
	AuthType nvarchar(50),
	XId nvarchar(50),
	BankProcessId nvarchar(50),
	HostRefNum nvarchar(50),
	TransId nvarchar(50),
	CardOwner nvarchar(50),
	CardMasked nvarchar(20),
	ClientIpAdress nvarchar(50),
	Notes nvarchar(1500),
	BankResponse nvarchar(500),
	ProcessId uniqueidentifier,
	SupplierName nvarchar(25),
	CreationDate datetime,
	CanceledTran bit,
	IsSuccess bit,
	UserId uniqueidentifier,
	AgencyId uniqueidentifier,
	IsTPayment as [dbo].[IsTPayment]([ProcessType],[PaymentStatus])
)
go

create table BankRefundOrCancelErrors
(
	BankRefundOrCancelErrorId uniqueidentifier constraint DF_BankRefundOrCancelErrors_BankRefundOrCancelErrorId default newid() not null
		constraint PK_BankRefundOrCancelErrors
			primary key,
	BankId uniqueidentifier,
	Amont decimal(18,2),
	ReservationId uniqueidentifier,
	UserId uniqueidentifier,
	CreationDate datetime
)
go

create table Banks
(
	BankId uniqueidentifier constraint DF_Banks_BankId default newid() not null
		constraint PK_Banks
			primary key,
	BankName nvarchar(50),
	BankLogo nvarchar(max),
	Status bit,
	OrderProcess int,
	AccountId int,
	BankCode nvarchar(50),
	DefaultBank bit,
	TRYAccountNumber nvarchar(50),
	USDAccountNumber nvarchar(50),
	EURAccountNumber nvarchar(50)
)
go

create table CanceledPnrs
(
	PnrNumber nvarchar(50),
	Supplier nvarchar(50),
	CreationDate datetime,
	AgencyId uniqueidentifier
)
go

create table CharterFlights
(
	CharterFlightId uniqueidentifier,
	Departure nvarchar(3),
	Arrival nvarchar(3),
	StartTerminal nvarchar(50),
	EndTerminal nvarchar(50),
	DepartureDate date,
	DepartureTime time,
	ArrivalDate date,
	ArrivalTime time,
	CarrierCode nvarchar(3),
	FlightNumber nvarchar(50),
	Baggage nvarchar(50),
	CreationDate datetime,
	IsRoundTrip bit,
	IsApproved bit,
	NotValidAfter datetime,
	ProviderId uniqueidentifier,
	CharterGroupId uniqueidentifier,
	IsReturnFlight bit,
	LogoFileName nvarchar(50)
)
go

create table CharterFlightsCached
(
	DeparturePort nvarchar(3),
	ArrivalPort nvarchar(3),
	DepartureCity nvarchar(500),
	ArrivalCity nvarchar(500),
	DepartureDate date,
	DepartureTime time,
	ArrivalDate date,
	ArrivalTime time,
	RtDepartureDate date,
	RtDepartureTime time,
	RtArrivalDate date,
	RtArrivalTime time,
	Price decimal(18,2),
	CurrencyName nvarchar(3),
	SeatCount int,
	DepartureCountry nvarchar(50),
	ArrivalCountry nvarchar(50),
	IsRoundTrip bit,
	CharterGroupId uniqueidentifier,
	CarrierCode nvarchar(5),
	FlightNumber nvarchar(10),
	RtCarrierCode nvarchar(5),
	RtFlightNumber nvarchar(10),
	StartTerminal nvarchar(20),
	EndTerminal nvarchar(20),
	RtStartTerminal nvarchar(20),
	RtEndTerminal nvarchar(20),
	IsApproveded bit
)
go

create table CharterPrices
(
	CharterPriceId uniqueidentifier,
	ClassCode nvarchar(3),
	TaxPrice decimal(18,2),
	BasePrice decimal(18,2),
	ServicesPrice decimal(18,2),
	SeatCount int,
	CurrencyId int,
	CurrencyCode as [dbo].[CurrencyName]([CurrencyId]),
	CharterGroupId uniqueidentifier
)
go

create table Cities
(
	CityId int not null,
	CountryId int,
	CityName nvarchar(255)
)
go

create table CollectiveManuelTicket
(
	Id uniqueidentifier not null
		constraint PK_CollectiveManuelTicket
			primary key,
	AirwayId uniqueidentifier not null,
	UserId uniqueidentifier not null,
	FileExtension nvarchar(10),
	CreationDate datetime not null
)
go

create table CollectiveManuelTicketDetail
(
	Id uniqueidentifier not null
		constraint PK_CollectiveManuelTicketDetail
			primary key,
	CollectiveManuelTicketId uniqueidentifier not null,
	AgencyId uniqueidentifier,
	AirWayId uniqueidentifier,
	CurrencyId int,
	CreationDate datetime,
	PnrNumber nvarchar(10),
	IsDomestic bit,
	CarrierCode nvarchar(5),
	PassengerType int,
	GenderType int,
	Name nvarchar(50),
	Surname nvarchar(50),
	PassportNumber nvarchar(50),
	CitizenNumber nvarchar(50),
	DateOfBirth datetime,
	TicketNumber nvarchar(50),
	PhoneNumber nvarchar(50),
	Email nvarchar(254),
	BasePrice decimal(18,2),
	TaxPrice decimal(18,2),
	VqPrice decimal(18,2),
	SecretServicePrice decimal(18,2),
	ServicePrice decimal(18,2),
	AgencyCommissionPrice decimal(18,2),
	ExtraCommissionPrice decimal(18,2),
	TaxIdentifier nvarchar(100),
	TaxOffice nvarchar(100),
	InvoiceAddress nvarchar(500),
	Status int,
	Reason nvarchar(500),
	Type int,
	TransactionPrice decimal(19,5),
	TransactionOwnerUserId uniqueidentifier,
	FlightData nvarchar(max),
	Notes nvarchar(1000),
	IsManuelPaid bit
)
go

create table CommissionInvoice
(
	CommissionInvoiceId uniqueidentifier constraint DF_CommissionInvoice_CommissionInvoiceId default newid() not null
		constraint PK_CommissionInvoice
			primary key,
	AgencyId uniqueidentifier not null,
	ProductType nvarchar(10),
	IsDomestic bit not null,
	Description nvarchar(1000),
	Name nvarchar(100),
	TotalAmount decimal(18,2) not null,
	Currency nvarchar(10) not null,
	InvoiceDate datetime,
	LastTicketDate datetime not null,
	InvoiceNumber nvarchar(50),
	IsGeneratedInvoice bit not null,
	GeneratedInvoiceDate datetime,
	CreatedBy nvarchar(128),
	CreationDate datetime not null,
	CommissionInvoiceType int constraint DF_CommissionInvoice_CommissionInvoiceType default 0,
	ParentAgencyId uniqueidentifier
)
go

create table CommissionInvoiceDetails
(
	CommissionInvoiceId uniqueidentifier not null
		constraint FK_CommissionInvoiceDetails_CommissionInvoice
			references CommissionInvoice,
	ReservationId uniqueidentifier not null
)
go

create table Countries
(
	CountryId int not null,
	CountryName nvarchar(255),
	CountryNameEnglish nvarchar(255),
	Status bit,
	ProcessOrder int,
	TwoLetterCode nchar(2)
)
go

create table CreditCardInfo
(
	AgencyId uniqueidentifier,
	BankId uniqueidentifier,
	CardNumber varchar(16),
	SecretCreditCard varchar(16),
	LongName varchar(150)
)
go

create table Currencies
(
	CurrencyId int,
	CurrencyName nvarchar(50),
	OrderProcess int,
	CurrencyCode nvarchar(3)
)
go

create table CustomersInfo
(
	CustomerId uniqueidentifier constraint DF_CustomersInfo_CustomerId default newid() not null,
	AgencyId uniqueidentifier constraint DF_CustomersInfo_AgencyId default newid(),
	Name nvarchar(50),
	SurName nvarchar(50),
	PassengerType int,
	Gender int,
	GsmArea nvarchar(5),
	GsmNumber nvarchar(25),
	BirthDate date,
	EmailAdress nvarchar(50),
	NeedWheelChair int,
	PhoneArea nvarchar(5),
	PhoneNumber nvarchar(50),
	CitizenNumber nvarchar(11),
	PassportSerialNumber nvarchar(10),
	PassportNumber nvarchar(50),
	PassportEndDate date,
	PassportCountry nvarchar(5),
	CompanyName nvarchar(250),
	TaxOffice nvarchar(50),
	TaxNumber nvarchar(50),
	ZipCode nvarchar(50),
	Adress nvarchar(500),
	City nvarchar(500),
	Country nvarchar(50),
	CreationDate datetime
)
go

create table DisabledFlightClasses
(
	DisabledFlightClassId int identity
		constraint PK_DisabledFlightClasses
			primary key,
	CarrierCode nvarchar(3),
	ClassCode nvarchar(3),
	StartDate date,
	EndDate date,
	Departure nvarchar(3),
	Arrival nvarchar(3)
)
go

create table ErrorLogs
(
	ErrorId int identity
		constraint PK_ErrorLogs
			primary key,
	ErrorMessage nvarchar(max),
	ErrorStackTrace nvarchar(max),
	CreationDate datetime,
	UserId uniqueidentifier constraint DF_ErrorLogs_UserId default newid()
)
go

create table FareStatuList
(
	FareStatuId int,
	EnumEqual nvarchar(50),
	Description nvarchar(50),
	Lang nvarchar(5)
)
go

create table FlightPriceInfo
(
	FlightPriceId uniqueidentifier constraint DF_FlightPriceInfo_FlightPriceId default newid() not null
		constraint PK_FlightPriceInfo
			primary key,
	ReservationId uniqueidentifier,
	PassengerType int,
	BasePrice decimal(18,2),
	Tax decimal(18,2),
	Vq decimal(18,2),
	FuelOther decimal(18,2),
	SecretServicesPrice decimal(18,2),
	ServicesPrice decimal(18,2),
	AgencyCommission decimal(18,2),
	ExtraCommisson decimal(18,4),
	TotalPrice decimal(18,2),
	CurrencyId int,
	OriginalCurrencyId int,
	CurrencyConvertionRate decimal(18,4),
	SystemServicesPrice decimal(18,2),
	ParentAgencyServicesPrice decimal(18,2),
	IsRefundable bit,
	ProviderId int,
	PassengerId uniqueidentifier,
	PriceIndex int,
	FareStatus int,
	TicketStatus int,
	SupplierName nvarchar(50),
	FareReferanceId uniqueidentifier,
	CreationDate datetime,
	RefundPrice decimal(18,2),
	PenaltyPrice decimal(18,2)
)
go

CREATE TRIGGER  [dbo].[trg_InsertFlightPriceInfoWithCurriencies] 
   ON  [dbo].[FlightPriceInfo]
   AFTER INSERT
AS 
BEGIN
	

declare @FlightPriceId  uniqueidentifier =(Select FlightPriceId from inserted)

declare @PassengerId uniqueidentifier =(select PassengerId from inserted)

declare @CurrencyCode nvarchar(4)

declare @ForexSelling decimal(18,4)
	
declare CurrencyCursor cursor for 
select CurrencyCode,ForexSelling from SystemCurrencies 

open CurrencyCursor

FETCH  NEXT FROM CurrencyCursor INTO @CurrencyCode,@ForexSelling
 WHILE @@FETCH_STATUS = 0  
 BEGIN 

insert into   FlightPriceInfoWithCurriencies
(FlightPriceId,PassengerId,CurrencyCode,CurrencyUnitPrice,CreationDate)
values(@FlightPriceId,@PassengerId,@CurrencyCode,@ForexSelling,GETDATE())


FETCH  NEXT FROM CurrencyCursor INTO @CurrencyCode,@ForexSelling
END
CLOSE CurrencyCursor   
DEALLOCATE CurrencyCursor




END
go

create table FlightPriceInfoWithCurriencies
(
	FlightPriceId uniqueidentifier,
	PassengerId uniqueidentifier,
	CurrencyCode nvarchar(3),
	CurrencyUnitPrice decimal(18,4),
	CreationDate datetime
)
go

create table FlightsInfo
(
	FlightInfoId uniqueidentifier constraint DF_FlightsInfo_FlightInfoId default newid() not null
		constraint PK_FlightsInfo
			primary key,
	ReservationId uniqueidentifier,
	NParamValue nvarchar(50),
	StartTerminal nvarchar(50),
	EndTerminal nvarchar(50),
	FlightNumber nvarchar(50),
	CarrierCode nvarchar(5),
	CooperatedCode nvarchar(10),
	Departure nvarchar(50),
	Arrival nvarchar(50),
	DepartureDate date,
	ArrivalDate date,
	DepartureTime time not null,
	ArrivalTime time,
	FlightClass nvarchar(5),
	SeatCount int,
	IsConnected bit,
	FlightIndex int,
	BaggageInfo nvarchar(50),
	IsReturnFlight bit,
	ProviderId int,
	SupplierName nvarchar(50),
	CharterGroupId uniqueidentifier,
	CreationDate datetime,
	FareBasisCode nvarchar(50)
)
go

create table GalileoDisabledCarries
(
	CarrierCode nvarchar(3),
	Status bit
)
go

create table GenderTypes
(
	PassengerGenderTypeId int identity
		constraint PK_GenderTypes
			primary key,
	GenderTypeName nvarchar(50),
	GenderTypeValue int,
	Description nvarchar(50),
	Lang nvarchar(5)
)
go

create table GroupReservationOffers
(
	OfferId uniqueidentifier not null
		constraint PK_GroupReservationOffers
			primary key,
	Title nvarchar(500),
	PaymentType int not null,
	OfferrerId uniqueidentifier not null,
	OfferSelectorId uniqueidentifier,
	IsSelected bit,
	SelectionDate datetime,
	CreationDate datetime not null,
	GroupReservationId uniqueidentifier not null,
	FileExtension nvarchar(50)
)
go

create table GroupReservations
(
	GroupReservationId uniqueidentifier not null
		constraint PK_GroupReservations
			primary key,
	GroupReservationName nvarchar(100) not null,
	GroupReservationType int not null,
	Departure nvarchar(3) not null,
	Arrival nvarchar(3) not null,
	DepartureDate datetime not null,
	DepartureFlightNumber nvarchar(7) not null,
	IsRoundTrip bit,
	ArrivalDate datetime,
	ArrivalFlightNumber nvarchar(7),
	PaxAdult int,
	PaxChild int,
	PaxInfant int,
	ContactMail nvarchar(320) not null,
	AgencyNotes nvarchar(max),
	Status int not null,
	AgencyId uniqueidentifier not null,
	UserId uniqueidentifier not null,
	PnrOrBookingId nvarchar(100),
	IsDomestic bit,
	ReservationId uniqueidentifier,
	CreationDate datetime not null
)
go

create table IataClassTypes
(
	IataClassTypeId int identity
		constraint PK_IataClassTypes
			primary key,
	ClassType nvarchar(5),
	Carrier nvarchar(5),
	ClassTypeName nvarchar(50),
	SupplierId int
)
go

create table InternalOptionPrice
(
	InternalOptionPriceId int identity
		constraint PK_InternalOptionPrice
			primary key,
	AgencyId uniqueidentifier,
	OptionalPrice decimal(18,2),
	SupplierId int,
	CreationDate datetime,
	Status bit
)
go

create table LogDisabledAgencies
(
	AgencyId uniqueidentifier,
	Status bit,
	MethodName nvarchar(50)
)
go

create table NotificationUserSettings
(
	Id uniqueidentifier not null
		constraint PK_NotificationUserSettings
			primary key,
	SettingType int not null,
	UserId nvarchar(128) not null
)
go

create table NotificationUsers
(
	Id uniqueidentifier not null
		constraint PK_NotificationUsers
			primary key,
	NotificationId uniqueidentifier not null,
	UserId nvarchar(128) not null,
	IsViewed bit not null,
	ViewDate datetime
)
go

create table Notifications
(
	Id uniqueidentifier not null
		constraint PK_Notifications
			primary key,
	SourceUserId nvarchar(128),
	NotificationType int,
	GroupType int,
	MessageCode nvarchar(50) not null,
	RelatedLink nvarchar(max),
	CreationDate datetime not null
)
go

create table OptionDateHistory
(
	Id int identity
		constraint PK_OptionDateHistory
			primary key,
	ReservationId uniqueidentifier not null,
	OptionDate datetime not null,
	CreationDate datetime not null
)
go

create table OrderTransaction
(
	OrderId bigint identity
		constraint PK_OrderTransaction
			primary key,
	OrderTransactionTypeId int,
	Credit decimal(18,4),
	Debt decimal(18,4),
	CurrencyId int,
	OriginalCurrencyId int,
	ConvertionRate decimal(18,4),
	UserId uniqueidentifier,
	ProcessId uniqueidentifier,
	ReservationId uniqueidentifier,
	PassengerId uniqueidentifier,
	Notes nvarchar(500),
	CreationDate date,
	CreationTime time,
	AccountId bigint,
	SalesType int constraint DF_OrderTransaction_SalesType default 0
)
go

create table OrderTransactionBackup42
(
	OrderId bigint not null,
	OrderTransactionTypeId int,
	Credit decimal(18,4),
	Debt decimal(18,4),
	CurrencyId int,
	OriginalCurrencyId int,
	ConvertionRate decimal(18,4),
	UserId uniqueidentifier,
	ProcessId uniqueidentifier,
	ReservationId uniqueidentifier,
	PassengerId uniqueidentifier,
	Notes nvarchar(500),
	CreationDate date,
	CreationTime time,
	AccountId bigint,
	SalesType int
)
go

create table OrderTransactionTypes
(
	OrderTransactionTypeId int identity
		constraint PK_OrderTransactionTypes
			primary key,
	TransactionName nvarchar(50),
	TransactionDescription nvarchar(50),
	Information nvarchar(max),
	SpecialCodes nvarchar(50),
	Lang nvarchar(5)
)
go

create table PassengerTypes
(
	PassengerTypeId int identity
		constraint PK_PassengerTypes
			primary key,
	PassengerTypeName nvarchar(50),
	PassengerTypeValue int,
	Description nvarchar(50),
	Lang nvarchar(5)
)
go

create table PassengersInfo
(
	PassengerId uniqueidentifier constraint DF_PassengersInfo_PassengerId default newid() not null,
	ReservationId uniqueidentifier constraint DF_PassengersInfo_ReservationId default newid(),
	Name nvarchar(50),
	SurName nvarchar(50),
	PassengerType int,
	Gender int,
	GsmArea nvarchar(5),
	GsmNumber nvarchar(25),
	BirthDate date,
	EmailAdress nvarchar(50),
	PassengerIndex int,
	TicketNumber nvarchar(50),
	NeedWheelChair int,
	PhoneArea nvarchar(5),
	PhoneNumber nvarchar(50),
	CitizenNumber nvarchar(11),
	PassportSerialNumber nvarchar(10),
	PassportNumber nvarchar(50),
	PassportEndDate date,
	PassportCountry nvarchar(5),
	SupplierCardNumber nvarchar(50),
	ForcePassportInfo bit,
	ProviderId int,
	SupplierName nvarchar(50),
	CompanyName nvarchar(250),
	TaxOffice nvarchar(50),
	TaxNumber nvarchar(50),
	ZipCode nvarchar(50),
	Adress nvarchar(500),
	City nvarchar(500),
	Country nvarchar(50),
	CreationDate datetime,
	SendSMS tinyint constraint DF_PassengersInfo_SendSMS default 0,
	FakeNameApprove bit constraint DF_PassengersInfo_FakeNameApprove default 0
)
go

create table PassportRequieredCountries
(
	CountryName nvarchar(500) not null,
	IsRequiered bit not null
)
go

create table PnrHistory
(
	PnrHistoryId int identity
		constraint PK_PnrHistory
			primary key,
	ReservationId uniqueidentifier,
	TicketProcessType int,
	UserId uniqueidentifier,
	Notes nvarchar(max),
	CreationDate datetime
)
go

create table PnrVendorRemaks
(
	VendorRemarksId uniqueidentifier constraint DF_PnrVendorRemaks_VendorRemarksId default newid() not null
		constraint PK_PnrVendorRemaks
			primary key,
	PnrNumber nvarchar(50) not null,
	AirWayName nvarchar(225) not null,
	VendorMessage nvarchar(max) not null,
	CreationDate datetime not null
)
go

create table PnrVendorRemarkPatterns
(
	PnrVendorRemarkPatternId uniqueidentifier constraint DF_PnrVendorRemakPatterns_PnrVendorRemarkPatternId default newid() not null
		constraint PK_PnrVendorRemakPatterns
			primary key,
	PatternType nvarchar(500),
	PatternFormat nvarchar(50),
	Description nvarchar(250)
)
go

create table ProcessTransactionTypes
(
	ProcessTransactionTypeId int,
	Description nvarchar(max)
)
go

create table ProcessTransactions
(
	ProcessId uniqueidentifier,
	ExceptionText nvarchar(max),
	CreationDate datetime,
	ProcessTransactionTypeId int
)
go

create table ProviderRouteList
(
	ProviderRouteListId uniqueidentifier constraint DF_Table_1_RoutListId default newid() not null
		constraint PK_ProviderRouteList
			primary key,
	Departure nvarchar(5),
	Arrival nvarchar(5),
	ProviderDesc nvarchar(50),
	Status bit
)
go

create table ReceiptInfo
(
	ReceiptId int identity
		constraint PK_ReceiptInfo
			primary key,
	ProcessId uniqueidentifier,
	Name nvarchar(50),
	Surname nvarchar(50),
	TcNo nvarchar(50),
	Adress nvarchar(50),
	City nvarchar(50),
	Country nvarchar(50),
	IsCompany bit,
	CompanyName nvarchar(500),
	TaxOffice nvarchar(50),
	TaxNumber nvarchar(50),
	ZipCode nvarchar(50),
	PassengerIndex int
)
go

create table ReservationHistory
(
	Id uniqueidentifier not null
		constraint PK_ReservationHistory
			primary key,
	ReservationId uniqueidentifier not null,
	ParentReservationId uniqueidentifier,
	UserId uniqueidentifier not null,
	ProcessId uniqueidentifier,
	CreationDate datetime not null
)
go

create table ReservationInvoiceCustomer
(
	CustomerId uniqueidentifier not null,
	ReservationId uniqueidentifier not null
)
go

create table ReservationNotes
(
	ReservationNoteId uniqueidentifier constraint DF_ReservationNotes_ReservationNoteId default newid() not null
		constraint PK_ReservationNotes
			primary key,
	ReservationNote nvarchar(4000),
	CreationDate datetime,
	ProcessId uniqueidentifier
)
go

create table ReservationProviderInfo
(
	ReservationProviderInfoId uniqueidentifier constraint DF_ReservationProviderInfo_Id default newid() not null
		constraint PK_ReservationProviderInfo
			primary key,
	ReservationId uniqueidentifier not null,
	ReferenceNumber nvarchar(50) not null
)
go

create table ReservationStatusList
(
	ReservationStatuId int,
	EnumEqual nvarchar(50),
	Description nvarchar(50),
	Lang nvarchar(5)
)
go

create table Reservations
(
	ReservationId uniqueidentifier constraint DF_Reservations_ReservationId default newid() not null
		constraint PK_Reservations
			primary key,
	ProcessId uniqueidentifier,
	PnrNumber nvarchar(10),
	PnrStatus int,
	AgencyId uniqueidentifier,
	UserId uniqueidentifier,
	IsDomestic bit,
	IsCIP bit,
	Notes nvarchar(max),
	PaymentType int,
	ProcessType int,
	LastDateToTicket datetime,
	ProviderId int,
	SubProviderId int,
	CreationDate datetime,
	SupplierName nvarchar(50),
	InvoiceType int constraint DF_Reservations_InvoiceType default 0
)
go

create table SiteMapMenu
(
	SiteMapId int identity
		constraint PK_SiteMapMenu
			primary key,
	ParentSiteMapId int,
	SiteMapTitle nvarchar(500),
	SiteMapControl nvarchar(50),
	SiteMapAction nvarchar(50),
	AlowedRoles nvarchar(max),
	OrderProcess int,
	Status bit,
	Lang nvarchar(5)
)
go

create table SmsCounter
(
	ProcessId uniqueidentifier,
	SmsCount int
)
go

create table SupplierCallCenterManager
(
	CallCenterId uniqueidentifier,
	SupplierId nvarchar(50),
	UserName nvarchar(250),
	Password nvarchar(50),
	PortalUrl text,
	UserCode nvarchar(150)
)
go

create table SupplierPnrLogs
(
	SupplierPnrLogId int identity
		constraint PK_SupplierPnrLogs
			primary key,
	SupplierName nvarchar(50),
	PnrNumber nvarchar(50),
	CreationDate datetime,
	AgencyId uniqueidentifier
)
go

create table Support
(
	SupportId bigint identity
		constraint PK_Support
			primary key,
	AgencyId uniqueidentifier,
	SupporterId uniqueidentifier,
	IsReaded bit,
	ProcessId uniqueidentifier,
	Topic int not null,
	SupportType int,
	RelatedId nvarchar(128),
	Description nvarchar(1000),
	CreationDate datetime,
	ResolvedDate datetime,
	TakeOver bit,
	UserName nvarchar(150)
)
go

create table SupportDetails
(
	SupportDetailId bigint identity
		constraint PK_SupportDetails
			primary key,
	SupportMessage nvarchar(max),
	UserId uniqueidentifier,
	CreationDate datetime,
	SupportId bigint
)
go

create table SysSystemInformationList
(
	SystemInformationId int identity
		constraint PK_SysSystemInformationList
			primary key,
	InformationType nvarchar(500),
	ExceptionText nvarchar(max),
	Lang nvarchar(2)
)
go

create table SystemAccounts
(
	AccountId bigint identity
		constraint PK_SystemAccounts
			primary key,
	ParentAccountId bigint,
	AccountName nvarchar(max),
	CurrencyId int,
	AccountPath nvarchar(max),
	AccountCode nvarchar(50),
	RegionLetter nvarchar(50),
	CreationDate datetime
)
go

create table SystemAccountsBackup
(
	AccountId bigint identity
		constraint PK_SystemAccountsBackup
			primary key,
	ParentAccountId bigint,
	AccountName nvarchar(max),
	CurrencyId int,
	AccountPath nvarchar(max),
	AccountCode nvarchar(50),
	RegionLetter nvarchar(50),
	CreationDate datetime
)
go

create table SystemAccountsBackup42
(
	AccountId bigint not null,
	ParentAccountId bigint,
	AccountName nvarchar(max),
	CurrencyId int,
	AccountPath nvarchar(max),
	AccountCode nvarchar(50),
	RegionLetter nvarchar(50),
	CreationDate datetime
)
go

create table SystemCurrencies
(
	SystemCurrencyId uniqueidentifier constraint DF_SystemCurrencies_SystemCurrencyId default newid() not null
		constraint PK_SystemCurrencies
			primary key,
	CurrencyCode nvarchar(50) not null,
	CurrencyName nvarchar(50) not null,
	ForexBuying decimal(18,4) not null,
	ForexSelling decimal(18,4) not null,
	BanknoteBuying decimal(18,4) not null,
	BanknoteSelling decimal(18,4) not null,
	CreationDate datetime not null,
	OrderProcess int
)
go

create table SystemLocalProcessSettings
(
	ServicesName nvarchar(50) not null
		constraint PK_SystemLocalProcessSettings
			primary key,
	ServicesInvokerAgencyId uniqueidentifier,
	SecurityId uniqueidentifier,
	Interval int
)
go

create table TempTransferAccountId
(
	OldAccountId int,
	AccountId int,
	AccountPath nvarchar(150),
	AccountName varchar(250)
)
go

create table TempTransferAccountType
(
	Id uniqueidentifier,
	TableName varchar(250),
	AccountId int
)
go

create table TicketInvoice
(
	TicketInvoiceId uniqueidentifier constraint DF_TicketInvoice_TicketInvoiceId default newid() not null
		constraint PK_TicketInvoice
			primary key,
	AgencyId uniqueidentifier not null,
	ProductType nvarchar(10),
	ReservationId nvarchar(50),
	Description nvarchar(1000),
	Name nvarchar(100),
	InvoiceNumber nvarchar(16),
	InvoiceGuid uniqueidentifier,
	TotalAmount decimal(12,2) not null,
	Currency nvarchar(10) not null,
	PaymentMethod nvarchar(100),
	CreationDate datetime not null,
	InvoiceDate datetime,
	CancellationDate datetime,
	TicketInvoiceType int,
	PassengerId uniqueidentifier,
	TicketInvoiceProcessType int constraint DF_TicketInvoice_TicketInvoiceProcessType default 0
)
go

create table TicketInvoiceCounter
(
	TicketInvoiceCounterId uniqueidentifier not null
		constraint PK_TicketInvoiceCounter
			primary key,
	Prefix nvarchar(3) not null,
	Year nvarchar(4) not null,
	Counter int not null
)
go

create table TicketInvoiceCustomer
(
	CustomerId uniqueidentifier constraint DF_TicketInvoiceCustomer_CustomerId default newid() not null
		constraint PK_TicketInvoiceCustomer
			primary key,
	AgencyId uniqueidentifier not null,
	Identifier nvarchar(20),
	Name nvarchar(250),
	SurName nvarchar(250),
	CitySubdivisionName nvarchar(200),
	CityName nvarchar(100),
	Country nvarchar(250),
	EMail nvarchar(300) not null,
	TaxOffice nvarchar(200) not null,
	Address nvarchar(1000),
	EInvoicePkAlias nvarchar(300),
	CreationDate datetime not null
)
go

create table VersionInfo
(
	Version bigint not null,
	AppliedOn datetime,
	Description nvarchar(1024)
)
go

create unique clustered index UC_Version
	on VersionInfo (Version)
go

create table XmlAuthSessions
(
	SessionId nvarchar(255) not null,
	AgencyId uniqueidentifier not null,
	ExpirationDate datetime not null
)
go

create table __MigrationHistory
(
	MigrationId nvarchar(150) not null,
	ContextKey nvarchar(300) not null,
	Model varbinary(max) not null,
	ProductVersion nvarchar(32) not null,
	constraint [PK_dbo.__MigrationHistory]
		primary key (MigrationId, ContextKey)
)
go

create table sys.filestream_tombstone_2073058421
(
	column_guid uniqueidentifier,
	file_id int not null,
	filestream_value_name nvarchar(260),
	oplsn_bOffset int not null,
	oplsn_fseqno int not null,
	oplsn_slotid int not null,
	rowset_guid uniqueidentifier not null,
	size bigint,
	status bigint not null,
	transaction_sequence_num bigint not null
)
go

create unique clustered index FSTSClusIdx
	on sys.filestream_tombstone_2073058421 (oplsn_fseqno, oplsn_bOffset, oplsn_slotid)
go

create index FSTSNCIdx
	on sys.filestream_tombstone_2073058421 (file_id, rowset_guid, column_guid, oplsn_fseqno, oplsn_bOffset, oplsn_slotid)
go

create table sys.filetable_updates_2105058535
(
	item_guid uniqueidentifier not null,
	oplsn_bOffset int not null,
	oplsn_fseqno int not null,
	oplsn_slotid int not null,
	table_id bigint not null
)
go

create unique clustered index FFtUpdateIdx
	on sys.filetable_updates_2105058535 (table_id, oplsn_fseqno, oplsn_bOffset, oplsn_slotid, item_guid)
go

create table sys.queue_messages_1977058079
(
	binary_message_body varbinary(max),
	conversation_group_id uniqueidentifier not null,
	conversation_handle uniqueidentifier not null,
	fragment_bitmap bigint not null,
	fragment_size int not null,
	message_enqueue_time datetime,
	message_id uniqueidentifier not null,
	message_sequence_number bigint not null,
	message_type_id int not null,
	next_fragment int not null,
	priority tinyint not null,
	queuing_order bigint identity(0, 1),
	service_contract_id int not null,
	service_id int not null,
	status tinyint not null,
	validation nchar(1) not null
)
go

create unique clustered index queue_clustered_index
	on sys.queue_messages_1977058079 (status, priority, queuing_order, conversation_group_id, conversation_handle)
go

create unique index queue_secondary_index
	on sys.queue_messages_1977058079 (status, priority, queuing_order, conversation_group_id, conversation_handle, service_id)
go

create table sys.queue_messages_2009058193
(
	binary_message_body varbinary(max),
	conversation_group_id uniqueidentifier not null,
	conversation_handle uniqueidentifier not null,
	fragment_bitmap bigint not null,
	fragment_size int not null,
	message_enqueue_time datetime,
	message_id uniqueidentifier not null,
	message_sequence_number bigint not null,
	message_type_id int not null,
	next_fragment int not null,
	priority tinyint not null,
	queuing_order bigint identity(0, 1),
	service_contract_id int not null,
	service_id int not null,
	status tinyint not null,
	validation nchar(1) not null
)
go

create unique clustered index queue_clustered_index
	on sys.queue_messages_2009058193 (status, priority, queuing_order, conversation_group_id, conversation_handle)
go

create unique index queue_secondary_index
	on sys.queue_messages_2009058193 (status, priority, queuing_order, conversation_group_id, conversation_handle, service_id)
go

create table sys.queue_messages_2041058307
(
	binary_message_body varbinary(max),
	conversation_group_id uniqueidentifier not null,
	conversation_handle uniqueidentifier not null,
	fragment_bitmap bigint not null,
	fragment_size int not null,
	message_enqueue_time datetime,
	message_id uniqueidentifier not null,
	message_sequence_number bigint not null,
	message_type_id int not null,
	next_fragment int not null,
	priority tinyint not null,
	queuing_order bigint identity(0, 1),
	service_contract_id int not null,
	service_id int not null,
	status tinyint not null,
	validation nchar(1) not null
)
go

create unique clustered index queue_clustered_index
	on sys.queue_messages_2041058307 (status, priority, queuing_order, conversation_group_id, conversation_handle)
go

create unique index queue_secondary_index
	on sys.queue_messages_2041058307 (status, priority, queuing_order, conversation_group_id, conversation_handle, service_id)
go

create table sys.sysallocunits
(
	auid bigint not null,
	fgid smallint not null,
	ownerid bigint not null,
	pcdata bigint not null,
	pcreserved bigint not null,
	pcused bigint not null,
	pgfirst binary(6) not null,
	pgfirstiam binary(6) not null,
	pgroot binary(6) not null,
	status int not null,
	type tinyint not null
)
go

create unique clustered index clust
	on sys.sysallocunits (auid)
go

create unique index nc
	on sys.sysallocunits (ownerid, type, auid)
go

create table sys.sysasymkeys
(
	algorithm char(2) not null,
	bitlength int not null,
	encrtype char(2) not null,
	id int not null,
	modified datetime not null,
	name sysname not null,
	pkey varbinary(2000),
	pukey varbinary(max) not null,
	thumbprint varbinary(32) not null
)
go

create unique clustered index cl
	on sys.sysasymkeys (id)
go

create unique index nc1
	on sys.sysasymkeys (name)
go

create unique index nc3
	on sys.sysasymkeys (thumbprint)
go

create table sys.sysaudacts
(
	audit_spec_id int not null,
	class tinyint not null,
	grantee int not null,
	id int not null,
	state char not null,
	subid int not null,
	type char(4) not null
)
go

create unique clustered index clust
	on sys.sysaudacts (class, id, subid, grantee, audit_spec_id, type)
go

create table sys.sysbinobjs
(
	class tinyint not null,
	created datetime not null,
	id int not null,
	intprop int not null,
	modified datetime not null,
	name sysname not null,
	nsid int not null,
	status int not null,
	type char(2) not null
)
go

create unique clustered index clst
	on sys.sysbinobjs (class, id)
go

create unique index nc1
	on sys.sysbinobjs (class, nsid, name)
go

create table sys.sysbinsubobjs
(
	class tinyint not null,
	idmajor int not null,
	intprop int not null,
	name sysname not null,
	status int not null,
	subid int not null
)
go

create unique clustered index clst
	on sys.sysbinsubobjs (class, idmajor, subid)
go

create unique index nc1
	on sys.sysbinsubobjs (name, idmajor, class)
go

create table sys.sysbrickfiles
(
	backuplsn binary(10),
	brickid int not null,
	createlsn binary(10),
	dbid int not null,
	diffbaseguid uniqueidentifier,
	diffbaselsn binary(10),
	diffbaseseclsn binary(10),
	diffbasetime datetime not null,
	droplsn binary(10),
	fileguid uniqueidentifier,
	fileid int not null,
	filestate tinyint not null,
	filetype tinyint not null,
	firstupdatelsn binary(10),
	forkguid uniqueidentifier,
	forklsn binary(10),
	forkvc bigint not null,
	growth int not null,
	grpid int not null,
	internalstatus int not null,
	lastupdatelsn binary(10),
	lname sysname not null,
	maxsize int not null,
	pname nvarchar(260) not null,
	pruid int not null,
	readonlybaselsn binary(10),
	readonlylsn binary(10),
	readwritelsn binary(10),
	redostartforkguid uniqueidentifier,
	redostartlsn binary(10),
	redotargetlsn binary(10),
	size int not null,
	status int not null
)
go

create unique clustered index clst
	on sys.sysbrickfiles (dbid, pruid, fileid)
go

create table sys.syscerts
(
	cert varbinary(max) not null,
	encrtype char(2) not null,
	id int not null,
	issuer varbinary(884) not null,
	lastpkeybackup datetime,
	name sysname not null,
	pkey varbinary(2500),
	snum varbinary(16) not null,
	status int not null,
	thumbprint varbinary(32) not null
)
go

create unique clustered index cl
	on sys.syscerts (id)
go

create unique index nc1
	on sys.syscerts (name)
go

create unique index nc2
	on sys.syscerts (issuer, snum)
go

create unique index nc3
	on sys.syscerts (thumbprint)
go

create table sys.syschildinsts
(
	crdate datetime not null,
	iname sysname not null,
	ipipename nvarchar(260) not null,
	lsid varbinary(85) not null,
	modate datetime not null,
	pid int not null,
	status int not null,
	sysdbpath nvarchar(260) not null
)
go

create unique clustered index cl
	on sys.syschildinsts (lsid)
go

create table sys.sysclones
(
	cloneid int not null,
	dbfragid int not null,
	id int not null,
	partid int not null,
	rowsetid bigint not null,
	segid int not null,
	status int not null,
	subid int not null,
	version int not null
)
go

create unique clustered index clst
	on sys.sysclones (id, subid, partid, version, segid, cloneid)
go

create table sys.sysclsobjs
(
	class tinyint not null,
	created datetime not null,
	id int not null,
	intprop int not null,
	modified datetime not null,
	name sysname not null,
	status int not null,
	type char(2) not null
)
go

create unique clustered index clst
	on sys.sysclsobjs (class, id)
go

create unique index nc
	on sys.sysclsobjs (name, class)
go

create table sys.syscolpars
(
	chk int not null,
	colid int not null,
	collationid int not null,
	dflt int not null,
	id int not null,
	idtval varbinary(64),
	length smallint not null,
	maxinrow smallint not null,
	name sysname,
	number smallint not null,
	prec tinyint not null,
	scale tinyint not null,
	status int not null,
	utype int not null,
	xmlns int not null,
	xtype tinyint not null
)
go

create unique clustered index clst
	on sys.syscolpars (id, number, colid)
go

create unique index nc
	on sys.syscolpars (id, name, number)
go

create table sys.syscommittab
(
	commit_csn bigint not null,
	commit_lbn bigint not null,
	commit_time datetime not null,
	commit_ts bigint not null,
	dbfragid int not null,
	xdes_id bigint not null
)
go

create unique clustered index ci_commit_ts
	on sys.syscommittab (commit_ts, xdes_id)
go

create unique index si_xdes_id
	on sys.syscommittab (xdes_id) include (dbfragid)
go

create table sys.syscompfragments
(
	cprelid int not null,
	datasize bigint not null,
	fragid int not null,
	fragobjid int not null,
	itemcnt bigint not null,
	rowcnt bigint not null,
	status int not null,
	ts binary(8) not null
)
go

create unique clustered index clst
	on sys.syscompfragments (cprelid, fragid)
go

create table sys.sysconvgroup
(
	id uniqueidentifier not null,
	refcount int not null,
	service_id int not null,
	status int not null
)
go

create unique clustered index clst
	on sys.sysconvgroup (id)
go

create table sys.syscscolsegments
(
	base_id bigint not null,
	column_id int not null,
	data_ptr binary(16) not null,
	encoding_type int not null,
	hobt_id bigint not null,
	magnitude float not null,
	max_data_id bigint not null,
	min_data_id bigint not null,
	null_value bigint not null,
	on_disk_size bigint not null,
	primary_dictionary_id int not null,
	row_count int not null,
	secondary_dictionary_id int not null,
	segment_id int not null,
	status int not null,
	version int not null
)
go

create unique clustered index clust
	on sys.syscscolsegments (hobt_id, column_id, segment_id)
go

create table sys.syscsdictionaries
(
	column_id int not null,
	data_ptr binary(16) not null,
	dictionary_id int not null,
	entry_count bigint not null,
	flags bigint not null,
	hobt_id bigint not null,
	last_id int not null,
	on_disk_size bigint not null,
	type int not null,
	version int not null
)
go

create unique clustered index clust
	on sys.syscsdictionaries (hobt_id, column_id, dictionary_id)
go

create table sys.sysdbfiles
(
	dbfragid int not null,
	fileguid uniqueidentifier not null,
	fileid int not null,
	pname nvarchar(260)
)
go

create unique clustered index clst
	on sys.sysdbfiles (dbfragid, fileid)
go

create table sys.sysdbfrag
(
	brickid int not null,
	dbid int not null,
	fragid int not null,
	name sysname not null,
	pruid int not null,
	status int not null
)
go

create unique clustered index cl
	on sys.sysdbfrag (dbid, fragid)
go

create unique index nc1
	on sys.sysdbfrag (dbid, brickid, pruid)
go

create table sys.sysdbreg
(
	category int not null,
	cmptlevel tinyint not null,
	crdate datetime not null,
	id int not null,
	modified datetime not null,
	name sysname not null,
	scope int not null,
	sid varbinary(85),
	status int not null,
	status2 int not null,
	svcbrkrguid uniqueidentifier not null
)
go

create unique clustered index clst
	on sys.sysdbreg (id)
go

create unique index nc1
	on sys.sysdbreg (name)
go

create unique index nc2
	on sys.sysdbreg (svcbrkrguid, scope)
go

create table sys.sysdercv
(
	contract int not null,
	convgroup uniqueidentifier not null,
	diagid uniqueidentifier not null,
	dlgopened datetime not null,
	dlgtimer datetime not null,
	enddlgseq bigint not null,
	farbrkrinst nvarchar(128),
	farprincid int not null,
	farsvc nvarchar(256) not null,
	firstoorder bigint not null,
	handle uniqueidentifier not null,
	initiator tinyint not null,
	inseskey varbinary(4096) not null,
	inseskeyid uniqueidentifier not null,
	lastoorder bigint not null,
	lastoorderfr int not null,
	lifetime datetime not null,
	outseskey varbinary(4096) not null,
	outseskeyid uniqueidentifier not null,
	princid int not null,
	priority tinyint not null,
	rcvfrag int not null,
	rcvseq bigint not null,
	state char(2) not null,
	status int not null,
	svcid int not null,
	sysseq bigint not null
)
go

create unique clustered index cl
	on sys.sysdercv (diagid, initiator)
go

create table sys.sysdesend
(
	diagid uniqueidentifier not null,
	handle uniqueidentifier not null,
	initiator tinyint not null,
	sendseq bigint not null,
	sendxact binary(6) not null
)
go

create unique clustered index cl
	on sys.sysdesend (handle)
go

create table sys.sysendpts
(
	affinity bigint not null,
	authrealm nvarchar(128),
	authtype tinyint not null,
	bstat smallint not null,
	dfltdb sysname,
	dfltdm nvarchar(128),
	dfltns nvarchar(384),
	encalg tinyint not null,
	id int not null,
	maxconn int not null,
	name sysname not null,
	port1 int not null,
	port2 int not null,
	protocol tinyint not null,
	pstat smallint not null,
	site nvarchar(128),
	tstat smallint not null,
	type tinyint not null,
	typeint int not null,
	wsdlproc nvarchar(776)
)
go

create unique clustered index clst
	on sys.sysendpts (id)
go

create unique index nc1
	on sys.sysendpts (name)
go

create table sys.sysfgfrag
(
	dbfragid int not null,
	fgfragid int not null,
	fgid int not null,
	phfgid int not null,
	status int not null
)
go

create unique clustered index cl
	on sys.sysfgfrag (fgid, fgfragid, dbfragid, phfgid)
go

create table sys.sysfiles1
(
	fileid smallint not null,
	filename nchar(260) not null,
	name nchar(128) not null,
	status int not null
)
go

create table sys.sysfoqueues
(
	created datetime not null,
	csn bigint,
	epoch int,
	id int not null,
	lsn binary(10) not null
)
go

create unique clustered index clst
	on sys.sysfoqueues (id, lsn)
go

create table sys.sysfos
(
	created datetime not null,
	csn bigint,
	epoch int,
	high varbinary(512),
	history varbinary(6000),
	id int not null,
	low varbinary(512) not null,
	modified datetime not null,
	rowcnt bigint,
	size bigint,
	status char not null,
	tgid int not null
)
go

create unique clustered index clst
	on sys.sysfos (id)
go

create unique index nc1
	on sys.sysfos (tgid, low, high)
go

create table sys.sysftinds
(
	bXVTDocidUseBaseT tinyint not null,
	batchsize int not null,
	crend datetime,
	crerrors int not null,
	crrows bigint not null,
	crschver binary(8) not null,
	crstart datetime,
	crtsnext binary(8),
	crtype char not null,
	fgid int not null,
	id int not null,
	indid int not null,
	nextdocid bigint not null,
	sensitivity tinyint not null,
	status int not null
)
go

create unique clustered index clst
	on sys.sysftinds (id)
go

create table sys.sysftproperties
(
	guid_identifier uniqueidentifier not null,
	int_identifier int not null,
	property_id int not null,
	property_list_id int not null,
	property_name nvarchar(256) not null,
	string_description nvarchar(512)
)
go

create unique clustered index clst
	on sys.sysftproperties (property_list_id, property_id)
go

create unique index nonclst
	on sys.sysftproperties (property_list_id, property_name)
go

create unique index nonclstgi
	on sys.sysftproperties (property_list_id, guid_identifier, int_identifier)
go

create table sys.sysftsemanticsdb
(
	database_id int not null,
	fileguid uniqueidentifier not null,
	register_date datetime not null,
	registered_by int not null,
	version nvarchar(128) not null
)
go

create unique clustered index cl
	on sys.sysftsemanticsdb (database_id)
go

create table sys.sysftstops
(
	lcid int not null,
	status tinyint not null,
	stoplistid int not null,
	stopword nvarchar(64) not null
)
go

create unique clustered index clst
	on sys.sysftstops (stoplistid, stopword, lcid)
go

create table sys.sysguidrefs
(
	class tinyint not null,
	guid uniqueidentifier not null,
	id int not null,
	status int not null,
	subid int not null
)
go

create unique clustered index cl
	on sys.sysguidrefs (class, id, subid)
go

create unique index nc
	on sys.sysguidrefs (guid, class)
go

create table sys.sysidxstats
(
	dataspace int not null,
	fillfact tinyint not null,
	id int not null,
	indid int not null,
	intprop int not null,
	lobds int not null,
	name sysname,
	rowset bigint not null,
	status int not null,
	tinyprop tinyint not null,
	type tinyint not null
)
go

create unique clustered index clst
	on sys.sysidxstats (id, indid)
go

create unique index nc
	on sys.sysidxstats (name, id)
go

create table sys.sysiscols
(
	idmajor int not null,
	idminor int not null,
	intprop int not null,
	status int not null,
	subid int not null,
	tinyprop1 tinyint not null,
	tinyprop2 tinyint not null,
	tinyprop3 tinyint not null
)
go

create unique clustered index clst
	on sys.sysiscols (idmajor, idminor, subid)
go

create unique index nc1
	on sys.sysiscols (idmajor, intprop, subid, idminor)
go

create table sys.syslnklgns
(
	lgnid int,
	modate datetime not null,
	name sysname,
	pwdhash varbinary(320),
	srvid int not null,
	status int not null
)
go

create unique clustered index cl
	on sys.syslnklgns (srvid, lgnid)
go

create table sys.sysmultiobjrefs
(
	class tinyint not null,
	depid int not null,
	depsubid int not null,
	indepid int not null,
	indepsubid int not null,
	status int not null
)
go

create unique clustered index clst
	on sys.sysmultiobjrefs (class, depid, depsubid, indepid, indepsubid)
go

create unique index nc1
	on sys.sysmultiobjrefs (indepid, class, indepsubid, depid, depsubid)
go

create table sys.sysnsobjs
(
	class tinyint not null,
	created datetime not null,
	id int not null,
	intprop int not null,
	modified datetime not null,
	name sysname not null,
	nsid int not null,
	status int not null
)
go

create unique clustered index clst
	on sys.sysnsobjs (class, id)
go

create unique index nc
	on sys.sysnsobjs (name, nsid, class)
go

create table sys.sysobjkeycrypts
(
	class tinyint not null,
	crypto varbinary(max) not null,
	id int not null,
	status int not null,
	thumbprint varbinary(32) not null,
	type char(4) not null
)
go

create unique clustered index cl
	on sys.sysobjkeycrypts (class, id, thumbprint)
go

create table sys.sysobjvalues
(
	imageval varbinary(max),
	objid int not null,
	subobjid int not null,
	valclass tinyint not null,
	valnum int not null,
	value sql_variant
)
go

create unique clustered index clst
	on sys.sysobjvalues (valclass, objid, subobjid, valnum)
go

create table sys.sysowners
(
	created datetime not null,
	deflanguage sysname,
	dfltsch sysname,
	id int not null,
	modified datetime not null,
	name sysname not null,
	password varbinary(256),
	sid varbinary(85),
	status int not null,
	type char not null
)
go

create unique clustered index clst
	on sys.sysowners (id)
go

create unique index nc1
	on sys.sysowners (name)
go

create unique index nc2
	on sys.sysowners (sid, id)
go

create table sys.sysphfg
(
	dbfragid int not null,
	fgguid uniqueidentifier,
	fgid int not null,
	lgfgid int,
	name sysname not null,
	phfgid int not null,
	status int not null,
	type char(2) not null
)
go

create unique clustered index cl
	on sys.sysphfg (phfgid)
go

create table sys.syspriorities
(
	local_service_id int,
	name sysname not null,
	priority tinyint not null,
	priority_id int not null,
	remote_service_name nvarchar(256),
	service_contract_id int
)
go

create unique clustered index cl
	on sys.syspriorities (priority_id)
go

create unique index nc
	on sys.syspriorities (service_contract_id, local_service_id, remote_service_name) include (priority)
go

create unique index nc2
	on sys.syspriorities (name)
go

create table sys.sysprivs
(
	class tinyint not null,
	grantee int not null,
	grantor int not null,
	id int not null,
	state char not null,
	subid int not null,
	type char(4) not null
)
go

create unique clustered index clust
	on sys.sysprivs (class, id, subid, grantee, grantor, type)
go

create table sys.syspru
(
	brickid int not null,
	dbid int not null,
	fragid int not null,
	pruid int not null,
	status int not null
)
go

create unique clustered index cl
	on sys.syspru (dbid, pruid)
go

create table sys.sysprufiles
(
	backuplsn binary(10),
	createlsn binary(10),
	dbfragid int not null,
	diffbaseguid uniqueidentifier,
	diffbaselsn binary(10),
	diffbaseseclsn binary(10),
	diffbasetime datetime not null,
	droplsn binary(10),
	fileguid uniqueidentifier,
	fileid int not null,
	filestate tinyint not null,
	filetype tinyint not null,
	firstupdatelsn binary(10),
	forkguid uniqueidentifier,
	forklsn binary(10),
	forkvc bigint not null,
	growth int not null,
	grpid int not null,
	internalstatus int not null,
	lastupdatelsn binary(10),
	lname sysname not null,
	maxsize int not null,
	pname nvarchar(260) not null,
	readonlybaselsn binary(10),
	readonlylsn binary(10),
	readwritelsn binary(10),
	redostartforkguid uniqueidentifier,
	redostartlsn binary(10),
	redotargetlsn binary(10),
	size int not null,
	status int not null
)
go

create unique clustered index clst
	on sys.sysprufiles (fileid)
go

create table sys.sysqnames
(
	hash int not null,
	name nvarchar(4000) not null,
	nid int not null,
	qid int not null
)
go

create unique clustered index clst
	on sys.sysqnames (qid, hash, nid)
go

create unique index nc1
	on sys.sysqnames (nid)
go

create table sys.sysremsvcbinds
(
	id int not null,
	name sysname not null,
	remsvc nvarchar(256),
	scid int not null,
	status int not null
)
go

create unique clustered index clst
	on sys.sysremsvcbinds (id)
go

create unique index nc1
	on sys.sysremsvcbinds (name)
go

create unique index nc2
	on sys.sysremsvcbinds (scid, remsvc)
go

create table sys.sysrmtlgns
(
	lgnid int,
	modate datetime not null,
	name sysname,
	srvid int not null,
	status int not null
)
go

create unique clustered index cl
	on sys.sysrmtlgns (srvid, name)
go

create table sys.sysrowsetrefs
(
	class tinyint not null,
	indexid int not null,
	objid int not null,
	rowsetid bigint not null,
	rowsetnum int not null,
	status int not null
)
go

create unique clustered index clust
	on sys.sysrowsetrefs (class, objid, indexid, rowsetnum)
go

create table sys.sysrowsets
(
	cmprlevel tinyint not null,
	fgidfs smallint not null,
	fillfact tinyint not null,
	idmajor int not null,
	idminor int not null,
	lockres varbinary(8),
	maxint smallint not null,
	maxleaf int not null,
	maxnullbit smallint not null,
	minint smallint not null,
	minleaf smallint not null,
	numpart int not null,
	ownertype tinyint not null,
	rcrows bigint not null,
	rowsetid bigint not null,
	rsguid varbinary(16),
	scope_id int,
	status int not null
)
go

create unique clustered index clust
	on sys.sysrowsets (rowsetid)
go

create table sys.sysrscols
(
	bitpos smallint not null,
	cid int not null,
	colguid varbinary(16),
	hbcolid int not null,
	maxinrowlen smallint not null,
	nullbit int not null,
	offset int not null,
	ordkey smallint not null,
	rcmodified bigint not null,
	rscolid int not null,
	rsid bigint not null,
	status int not null,
	ti int not null
)
go

create unique clustered index clst
	on sys.sysrscols (rsid, hbcolid)
go

create table sys.sysrts
(
	addr nvarchar(256),
	brkrinst nvarchar(128),
	id int not null,
	lifetime datetime,
	miraddr nvarchar(256),
	name sysname not null,
	remsvc nvarchar(256)
)
go

create unique clustered index clst
	on sys.sysrts (id)
go

create unique index nc1
	on sys.sysrts (remsvc, brkrinst, id)
go

create unique index nc2
	on sys.sysrts (name)
go

create table sys.sysscalartypes
(
	chk int not null,
	collationid int not null,
	created datetime not null,
	dflt int not null,
	id int not null,
	length smallint not null,
	modified datetime not null,
	name sysname not null,
	prec tinyint not null,
	scale tinyint not null,
	schid int not null,
	status int not null,
	xtype tinyint not null
)
go

create unique clustered index clst
	on sys.sysscalartypes (id)
go

create unique index nc1
	on sys.sysscalartypes (schid, name)
go

create unique index nc2
	on sys.sysscalartypes (name, schid)
go

create table sys.sysschobjs
(
	created datetime not null,
	id int not null,
	intprop int not null,
	modified datetime not null,
	name sysname not null,
	nsclass tinyint not null,
	nsid int not null,
	pclass tinyint not null,
	pid int not null,
	status int not null,
	status2 int not null,
	type char(2) not null
)
go

create unique clustered index clst
	on sys.sysschobjs (id)
go

create unique index nc1
	on sys.sysschobjs (nsclass, nsid, name)
go

create unique index nc2
	on sys.sysschobjs (name, nsid, nsclass)
go

create index nc3
	on sys.sysschobjs (pid, pclass)
go

create table sys.sysseobjvalues
(
	id bigint not null,
	imageval varbinary(max),
	subid bigint not null,
	valclass tinyint not null,
	valnum int not null,
	value sql_variant
)
go

create unique clustered index clst
	on sys.sysseobjvalues (valclass, id, subid, valnum)
go

create table sys.syssingleobjrefs
(
	class tinyint not null,
	depid int not null,
	depsubid int not null,
	indepid int not null,
	indepsubid int not null,
	status int not null
)
go

create unique clustered index clst
	on sys.syssingleobjrefs (class, depid, depsubid)
go

create unique index nc1
	on sys.syssingleobjrefs (indepid, class, indepsubid, depid, depsubid)
go

create table sys.syssoftobjrefs
(
	depclass tinyint not null,
	depid int not null,
	indepclass tinyint not null,
	indepdb sysname,
	indepname sysname not null,
	indepschema sysname,
	indepserver sysname,
	number int not null,
	status int not null
)
go

create unique clustered index clst
	on sys.syssoftobjrefs (depclass, depid, indepclass, indepname, indepschema, number)
go

create unique index nc1
	on sys.syssoftobjrefs (indepname, indepschema, indepclass, depid, depclass, number)
go

create table sys.syssqlguides
(
	batchtext nvarchar(max),
	created datetime not null,
	hash varbinary(20),
	id int not null,
	modified datetime not null,
	name sysname not null,
	paramorhinttext nvarchar(max),
	scopeid int not null,
	scopetype tinyint not null,
	status int not null
)
go

create unique clustered index clst
	on sys.syssqlguides (id)
go

create unique index nc1
	on sys.syssqlguides (name)
go

create unique index nc2
	on sys.syssqlguides (scopetype, scopeid, hash, id)
go

create table sys.systypedsubobjs
(
	class tinyint not null,
	collationid int not null,
	idmajor int not null,
	intprop int not null,
	length smallint not null,
	name sysname,
	prec tinyint not null,
	scale tinyint not null,
	status int not null,
	subid int not null,
	utype int not null,
	xtype tinyint not null
)
go

create unique clustered index clst
	on sys.systypedsubobjs (class, idmajor, subid)
go

create unique index nc
	on sys.systypedsubobjs (name, idmajor, class)
go

create table sys.sysusermsgs
(
	id int not null,
	msglangid smallint not null,
	severity smallint not null,
	status smallint not null,
	text nvarchar(1024) not null
)
go

create unique clustered index clst
	on sys.sysusermsgs (id, msglangid)
go

create table sys.syswebmethods
(
	alias nvarchar(64) not null,
	id int not null,
	nmspace nvarchar(384),
	objname nvarchar(776),
	status int not null
)
go

create unique clustered index clst
	on sys.syswebmethods (id, nmspace, alias)
go

create table sys.sysxlgns
(
	crdate datetime not null,
	dbname sysname,
	id int not null,
	lang sysname,
	modate datetime not null,
	name sysname not null,
	pwdhash varbinary(256),
	sid varbinary(85),
	status int not null,
	type char not null
)
go

create unique clustered index cl
	on sys.sysxlgns (id)
go

create unique index nc1
	on sys.sysxlgns (name)
go

create unique index nc2
	on sys.sysxlgns (sid)
go

create table sys.sysxmitbody
(
	count int not null,
	msgbody varbinary(max),
	msgref bigint not null
)
go

create unique clustered index clst
	on sys.sysxmitbody (msgref)
go

create table sys.sysxmitqueue
(
	dlgerr int not null,
	dlgid uniqueidentifier not null,
	enqtime datetime not null,
	finitiator bit not null,
	frombrkrinst nvarchar(128),
	fromsvc nvarchar(256),
	hdrpartlen smallint not null,
	hdrseclen smallint not null,
	msgbody varbinary(max),
	msgbodylen int not null,
	msgenc tinyint not null,
	msgid uniqueidentifier not null,
	msgref bigint,
	msgseqnum bigint not null,
	msgtype nvarchar(256),
	rsndtime datetime,
	status int not null,
	svccontr nvarchar(256),
	tobrkrinst nvarchar(128),
	tosvc nvarchar(256),
	unackmfn int not null
)
go

create unique clustered index clst
	on sys.sysxmitqueue (dlgid, finitiator, msgseqnum)
go

create table sys.sysxmlcomponent
(
	defval nvarchar(4000),
	deriv char not null,
	enum char not null,
	id int not null,
	kind char not null,
	nameid int not null,
	nmscope int not null,
	qual tinyint not null,
	status int not null,
	symspace char not null,
	uriord int not null,
	xsdid int not null
)
go

create unique clustered index cl
	on sys.sysxmlcomponent (id)
go

create unique index nc1
	on sys.sysxmlcomponent (xsdid, uriord, qual, nameid, symspace, nmscope)
go

create table sys.sysxmlfacet
(
	compid int not null,
	dflt nvarchar(4000),
	kind char(2) not null,
	ord int not null,
	status smallint not null
)
go

create unique clustered index cl
	on sys.sysxmlfacet (compid, ord)
go

create table sys.sysxmlplacement
(
	defval nvarchar(4000),
	maxoccur int not null,
	minoccur int not null,
	ordinal int not null,
	placedid int not null,
	placingid int not null,
	status int not null
)
go

create unique clustered index cl
	on sys.sysxmlplacement (placingid, ordinal)
go

create unique index nc1
	on sys.sysxmlplacement (placedid, placingid, ordinal)
go

create table sys.sysxprops
(
	class tinyint not null,
	id int not null,
	name sysname not null,
	subid int not null,
	value sql_variant
)
go

create unique clustered index clust
	on sys.sysxprops (class, id, subid, name)
go

create table sys.sysxsrvs
(
	catalog sysname,
	cid int,
	connecttimeout int,
	id int not null,
	modate datetime not null,
	name sysname not null,
	product sysname not null,
	provider sysname not null,
	querytimeout int,
	status int not null
)
go

create unique clustered index cl
	on sys.sysxsrvs (id)
go

create unique index nc1
	on sys.sysxsrvs (name)
go

create table sys.trace_xe_action_map
(
	package_name nvarchar(60) not null,
	trace_column_id smallint not null,
	xe_action_name nvarchar(60) not null
)
go

create table sys.trace_xe_event_map
(
	package_name nvarchar(60) not null,
	trace_event_id smallint not null,
	xe_event_name nvarchar(60) not null
)
go

create view INFORMATION_SCHEMA.CHECK_CONSTRAINTS as -- missing source code
go

create view INFORMATION_SCHEMA.COLUMNS as -- missing source code
go

create view INFORMATION_SCHEMA.COLUMN_DOMAIN_USAGE as -- missing source code
go

create view INFORMATION_SCHEMA.COLUMN_PRIVILEGES as -- missing source code
go

create view INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE as -- missing source code
go

create view INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE as -- missing source code
go

create view INFORMATION_SCHEMA.DOMAINS as -- missing source code
go

create view INFORMATION_SCHEMA.DOMAIN_CONSTRAINTS as -- missing source code
go

CREATE VIEW [dbo].[FinancialDashboardView]
AS
SELECT tr.AgencyId, CONVERT(DATE, tr.CreationDate) AS CreationDate, ts.EnumEqual AS ReservationType, tr.SupplierName, tf.TotalPrice, tf.AgencyCommission, tf.ServicesPrice
FROM     dbo.Reservations AS tr INNER JOIN
                  dbo.ReservationStatusList AS ts ON tr.PnrStatus = ts.ReservationStatuId INNER JOIN
                  dbo.FlightPriceInfo AS tf ON tr.ReservationId = tf.ReservationId
go

create view INFORMATION_SCHEMA.KEY_COLUMN_USAGE as -- missing source code
go

create view INFORMATION_SCHEMA.PARAMETERS as -- missing source code
go

create view INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS as -- missing source code
go

create view INFORMATION_SCHEMA.ROUTINES as -- missing source code
go

create view INFORMATION_SCHEMA.ROUTINE_COLUMNS as -- missing source code
go

CREATE VIEW [dbo].[ReservationDashboardView]
as
select r.AgencyId,CONVERT(date,p.CreationDate) as CreationDate,
      (IIF((r.PnrStatus = 4 and s.EnumEqual = 'Void'), 'Cancel', s.EnumEqual)) as
       ReservationType,s.FareStatuId as PnrStatus,r.SupplierName
from dbo.PassengersInfo AS p INNER JOIN
     dbo.FlightPriceInfo AS pr ON pr.PassengerId = p.PassengerId LEFT OUTER JOIN
     dbo.FlightsInfo AS f ON f.ReservationId = p.ReservationId LEFT OUTER JOIN
     dbo.Reservations AS r ON r.ReservationId = p.ReservationId LEFT OUTER JOIN
     dbo.FareStatuList AS s ON s.FareStatuId = pr.FareStatus LEFT OUTER JOIN
     dbo.AgencyProfile AS pf ON pf.AgencyId = r.AgencyId
where  f.FlightIndex=0
go

create view INFORMATION_SCHEMA.SCHEMATA as -- missing source code
go

create view INFORMATION_SCHEMA.SEQUENCES as -- missing source code
go

CREATE VIEW [dbo].[SupportDashboardView]
AS
SELECT        AgencyId, CONVERT(DATE, CreationDate) AS CreationDate, CASE WHEN ResolvedDate IS NULL THEN 'Open' ELSE 'Closed' END AS SupportType
FROM            dbo.Support
go

create view INFORMATION_SCHEMA.TABLES as -- missing source code
go

create view INFORMATION_SCHEMA.TABLE_CONSTRAINTS as -- missing source code
go

create view INFORMATION_SCHEMA.TABLE_PRIVILEGES as -- missing source code
go

create view INFORMATION_SCHEMA.VIEWS as -- missing source code
go

create view INFORMATION_SCHEMA.VIEW_COLUMN_USAGE as -- missing source code
go

create view INFORMATION_SCHEMA.VIEW_TABLE_USAGE as -- missing source code
go

create view sys.all_columns as -- missing source code
go

create view sys.all_objects as -- missing source code
go

create view sys.all_parameters as -- missing source code
go

create view sys.all_sql_modules as -- missing source code
go

create view sys.all_views as -- missing source code
go

create view sys.allocation_units as -- missing source code
go

create view sys.assemblies as -- missing source code
go

create view sys.assembly_files as -- missing source code
go

create view sys.assembly_modules as -- missing source code
go

create view sys.assembly_references as -- missing source code
go

create view sys.assembly_types as -- missing source code
go

create view sys.asymmetric_keys as -- missing source code
go

create view sys.availability_databases_cluster as -- missing source code
go

create view sys.availability_group_listener_ip_addresses as -- missing source code
go

create view sys.availability_group_listeners as -- missing source code
go

create view sys.availability_groups as -- missing source code
go

create view sys.availability_groups_cluster as -- missing source code
go

create view sys.availability_read_only_routing_lists as -- missing source code
go

create view sys.availability_replicas as -- missing source code
go

create view sys.backup_devices as -- missing source code
go

create view sys.certificates as -- missing source code
go

create view sys.change_tracking_databases as -- missing source code
go

create view sys.change_tracking_tables as -- missing source code
go

create view sys.check_constraints as -- missing source code
go

create view sys.column_store_dictionaries as -- missing source code
go

create view sys.column_store_segments as -- missing source code
go

create view sys.column_type_usages as -- missing source code
go

create view sys.column_xml_schema_collection_usages as -- missing source code
go

create view sys.columns as -- missing source code
go

create view sys.computed_columns as -- missing source code
go

create view sys.configurations as -- missing source code
go

create view sys.conversation_endpoints as -- missing source code
go

create view sys.conversation_groups as -- missing source code
go

create view sys.conversation_priorities as -- missing source code
go

create view sys.credentials as -- missing source code
go

create view sys.crypt_properties as -- missing source code
go

create view sys.cryptographic_providers as -- missing source code
go

create view sys.data_spaces as -- missing source code
go

create view sys.database_audit_specification_details as -- missing source code
go

create view sys.database_audit_specifications as -- missing source code
go

create view sys.database_files as -- missing source code
go

create view sys.database_filestream_options as -- missing source code
go

create view sys.database_mirroring as -- missing source code
go

create view sys.database_mirroring_endpoints as -- missing source code
go

create view sys.database_mirroring_witnesses as -- missing source code
go

create view sys.database_permissions as -- missing source code
go

create view sys.database_principals as -- missing source code
go

create view sys.database_recovery_status as -- missing source code
go

create view sys.database_role_members as -- missing source code
go

create view sys.databases as -- missing source code
go

create view sys.default_constraints as -- missing source code
go

create view sys.destination_data_spaces as -- missing source code
go

create view sys.dm_audit_actions as -- missing source code
go

create view sys.dm_audit_class_type_map as -- missing source code
go

create view sys.dm_broker_activated_tasks as -- missing source code
go

create view sys.dm_broker_connections as -- missing source code
go

create view sys.dm_broker_forwarded_messages as -- missing source code
go

create view sys.dm_broker_queue_monitors as -- missing source code
go

create view sys.dm_cdc_errors as -- missing source code
go

create view sys.dm_cdc_log_scan_sessions as -- missing source code
go

create view sys.dm_clr_appdomains as -- missing source code
go

create view sys.dm_clr_loaded_assemblies as -- missing source code
go

create view sys.dm_clr_properties as -- missing source code
go

create view sys.dm_clr_tasks as -- missing source code
go

create view sys.dm_cryptographic_provider_properties as -- missing source code
go

create view sys.dm_database_encryption_keys as -- missing source code
go

create view sys.dm_db_file_space_usage as -- missing source code
go

create view sys.dm_db_fts_index_physical_stats as -- missing source code
go

create view sys.dm_db_index_usage_stats as -- missing source code
go

create view sys.dm_db_log_space_usage as -- missing source code
go

create view sys.dm_db_mirroring_auto_page_repair as -- missing source code
go

create view sys.dm_db_mirroring_connections as -- missing source code
go

create view sys.dm_db_mirroring_past_actions as -- missing source code
go

create view sys.dm_db_missing_index_details as -- missing source code
go

create view sys.dm_db_missing_index_group_stats as -- missing source code
go

create view sys.dm_db_missing_index_groups as -- missing source code
go

create view sys.dm_db_partition_stats as -- missing source code
go

create view sys.dm_db_persisted_sku_features as -- missing source code
go

create view sys.dm_db_script_level as -- missing source code
go

create view sys.dm_db_session_space_usage as -- missing source code
go

create view sys.dm_db_task_space_usage as -- missing source code
go

create view sys.dm_db_uncontained_entities as -- missing source code
go

create view sys.dm_exec_background_job_queue as -- missing source code
go

create view sys.dm_exec_background_job_queue_stats as -- missing source code
go

create view sys.dm_exec_cached_plans as -- missing source code
go

create view sys.dm_exec_connections as -- missing source code
go

create view sys.dm_exec_procedure_stats as -- missing source code
go

create view sys.dm_exec_query_memory_grants as -- missing source code
go

create view sys.dm_exec_query_optimizer_info as -- missing source code
go

create view sys.dm_exec_query_resource_semaphores as -- missing source code
go

create view sys.dm_exec_query_stats as -- missing source code
go

create view sys.dm_exec_query_transformation_stats as -- missing source code
go

create view sys.dm_exec_requests as -- missing source code
go

create view sys.dm_exec_sessions as -- missing source code
go

create view sys.dm_exec_trigger_stats as -- missing source code
go

create view sys.dm_filestream_file_io_handles as -- missing source code
go

create view sys.dm_filestream_file_io_requests as -- missing source code
go

create view sys.dm_filestream_non_transacted_handles as -- missing source code
go

create view sys.dm_fts_active_catalogs as -- missing source code
go

create view sys.dm_fts_fdhosts as -- missing source code
go

create view sys.dm_fts_index_population as -- missing source code
go

create view sys.dm_fts_memory_buffers as -- missing source code
go

create view sys.dm_fts_memory_pools as -- missing source code
go

create view sys.dm_fts_outstanding_batches as -- missing source code
go

create view sys.dm_fts_population_ranges as -- missing source code
go

create view sys.dm_fts_semantic_similarity_population as -- missing source code
go

create view sys.dm_hadr_auto_page_repair as -- missing source code
go

create view sys.dm_hadr_availability_group_states as -- missing source code
go

create view sys.dm_hadr_availability_replica_cluster_nodes as -- missing source code
go

create view sys.dm_hadr_availability_replica_cluster_states as -- missing source code
go

create view sys.dm_hadr_availability_replica_states as -- missing source code
go

create view sys.dm_hadr_cluster as -- missing source code
go

create view sys.dm_hadr_cluster_members as -- missing source code
go

create view sys.dm_hadr_cluster_networks as -- missing source code
go

create view sys.dm_hadr_database_replica_cluster_states as -- missing source code
go

create view sys.dm_hadr_database_replica_states as -- missing source code
go

create view sys.dm_hadr_instance_node_map as -- missing source code
go

create view sys.dm_hadr_name_id_map as -- missing source code
go

create view sys.dm_io_backup_tapes as -- missing source code
go

create view sys.dm_io_cluster_shared_drives as -- missing source code
go

create view sys.dm_io_pending_io_requests as -- missing source code
go

create view sys.dm_logpool_hashentries as -- missing source code
go

create view sys.dm_logpool_stats as -- missing source code
go

create view sys.dm_os_buffer_descriptors as -- missing source code
go

create view sys.dm_os_child_instances as -- missing source code
go

create view sys.dm_os_cluster_nodes as -- missing source code
go

create view sys.dm_os_cluster_properties as -- missing source code
go

create view sys.dm_os_dispatcher_pools as -- missing source code
go

create view sys.dm_os_dispatchers as -- missing source code
go

create view sys.dm_os_hosts as -- missing source code
go

create view sys.dm_os_latch_stats as -- missing source code
go

create view sys.dm_os_loaded_modules as -- missing source code
go

create view sys.dm_os_memory_allocations as -- missing source code
go

create view sys.dm_os_memory_broker_clerks as -- missing source code
go

create view sys.dm_os_memory_brokers as -- missing source code
go

create view sys.dm_os_memory_cache_clock_hands as -- missing source code
go

create view sys.dm_os_memory_cache_counters as -- missing source code
go

create view sys.dm_os_memory_cache_entries as -- missing source code
go

create view sys.dm_os_memory_cache_hash_tables as -- missing source code
go

create view sys.dm_os_memory_clerks as -- missing source code
go

create view sys.dm_os_memory_node_access_stats as -- missing source code
go

create view sys.dm_os_memory_nodes as -- missing source code
go

create view sys.dm_os_memory_objects as -- missing source code
go

create view sys.dm_os_memory_pools as -- missing source code
go

create view sys.dm_os_nodes as -- missing source code
go

create view sys.dm_os_performance_counters as -- missing source code
go

create view sys.dm_os_process_memory as -- missing source code
go

create view sys.dm_os_ring_buffers as -- missing source code
go

create view sys.dm_os_schedulers as -- missing source code
go

create view sys.dm_os_server_diagnostics_log_configurations as -- missing source code
go

create view sys.dm_os_spinlock_stats as -- missing source code
go

create view sys.dm_os_stacks as -- missing source code
go

create view sys.dm_os_sublatches as -- missing source code
go

create view sys.dm_os_sys_info as -- missing source code
go

create view sys.dm_os_sys_memory as -- missing source code
go

create view sys.dm_os_tasks as -- missing source code
go

create view sys.dm_os_threads as -- missing source code
go

create view sys.dm_os_virtual_address_dump as -- missing source code
go

create view sys.dm_os_wait_stats as -- missing source code
go

create view sys.dm_os_waiting_tasks as -- missing source code
go

create view sys.dm_os_windows_info as -- missing source code
go

create view sys.dm_os_worker_local_storage as -- missing source code
go

create view sys.dm_os_workers as -- missing source code
go

create view sys.dm_qn_subscriptions as -- missing source code
go

create view sys.dm_repl_articles as -- missing source code
go

create view sys.dm_repl_schemas as -- missing source code
go

create view sys.dm_repl_tranhash as -- missing source code
go

create view sys.dm_repl_traninfo as -- missing source code
go

create view sys.dm_resource_governor_configuration as -- missing source code
go

create view sys.dm_resource_governor_resource_pool_affinity as -- missing source code
go

create view sys.dm_resource_governor_resource_pools as -- missing source code
go

create view sys.dm_resource_governor_workload_groups as -- missing source code
go

create view sys.dm_server_audit_status as -- missing source code
go

create view sys.dm_server_memory_dumps as -- missing source code
go

create view sys.dm_server_registry as -- missing source code
go

create view sys.dm_server_services as -- missing source code
go

create view sys.dm_tcp_listener_states as -- missing source code
go

create view sys.dm_tran_active_snapshot_database_transactions as -- missing source code
go

create view sys.dm_tran_active_transactions as -- missing source code
go

create view sys.dm_tran_commit_table as -- missing source code
go

create view sys.dm_tran_current_snapshot as -- missing source code
go

create view sys.dm_tran_current_transaction as -- missing source code
go

create view sys.dm_tran_database_transactions as -- missing source code
go

create view sys.dm_tran_locks as -- missing source code
go

create view sys.dm_tran_session_transactions as -- missing source code
go

create view sys.dm_tran_top_version_generators as -- missing source code
go

create view sys.dm_tran_transactions_snapshot as -- missing source code
go

create view sys.dm_tran_version_store as -- missing source code
go

create view sys.dm_xe_map_values as -- missing source code
go

create view sys.dm_xe_object_columns as -- missing source code
go

create view sys.dm_xe_objects as -- missing source code
go

create view sys.dm_xe_packages as -- missing source code
go

create view sys.dm_xe_session_event_actions as -- missing source code
go

create view sys.dm_xe_session_events as -- missing source code
go

create view sys.dm_xe_session_object_columns as -- missing source code
go

create view sys.dm_xe_session_targets as -- missing source code
go

create view sys.dm_xe_sessions as -- missing source code
go

create view sys.endpoint_webmethods as -- missing source code
go

create view sys.endpoints as -- missing source code
go

create view sys.event_notification_event_types as -- missing source code
go

create view sys.event_notifications as -- missing source code
go

create view sys.events as -- missing source code
go

create view sys.extended_procedures as -- missing source code
go

create view sys.extended_properties as -- missing source code
go

create view sys.filegroups as -- missing source code
go

create view sys.filetable_system_defined_objects as -- missing source code
go

create view sys.filetables as -- missing source code
go

create view sys.foreign_key_columns as -- missing source code
go

create view sys.foreign_keys as -- missing source code
go

create view sys.fulltext_catalogs as -- missing source code
go

create view sys.fulltext_document_types as -- missing source code
go

create view sys.fulltext_index_catalog_usages as -- missing source code
go

create view sys.fulltext_index_columns as -- missing source code
go

create view sys.fulltext_index_fragments as -- missing source code
go

create view sys.fulltext_indexes as -- missing source code
go

create view sys.fulltext_languages as -- missing source code
go

create view sys.fulltext_semantic_language_statistics_database as -- missing source code
go

create view sys.fulltext_semantic_languages as -- missing source code
go

create view sys.fulltext_stoplists as -- missing source code
go

create view sys.fulltext_stopwords as -- missing source code
go

create view sys.fulltext_system_stopwords as -- missing source code
go

create view sys.function_order_columns as -- missing source code
go

create view sys.http_endpoints as -- missing source code
go

create view sys.identity_columns as -- missing source code
go

create view sys.index_columns as -- missing source code
go

create view sys.indexes as -- missing source code
go

create view sys.internal_tables as -- missing source code
go

create view sys.key_constraints as -- missing source code
go

create view sys.key_encryptions as -- missing source code
go

create view sys.linked_logins as -- missing source code
go

create view sys.login_token as -- missing source code
go

create view sys.master_files as -- missing source code
go

create view sys.master_key_passwords as -- missing source code
go

create view sys.message_type_xml_schema_collection_usages as -- missing source code
go

create view sys.messages as -- missing source code
go

create view sys.module_assembly_usages as -- missing source code
go

create view sys.numbered_procedure_parameters as -- missing source code
go

create view sys.numbered_procedures as -- missing source code
go

create view sys.objects as -- missing source code
go

create view sys.openkeys as -- missing source code
go

create view sys.parameter_type_usages as -- missing source code
go

create view sys.parameter_xml_schema_collection_usages as -- missing source code
go

create view sys.parameters as -- missing source code
go

create view sys.partition_functions as -- missing source code
go

create view sys.partition_parameters as -- missing source code
go

create view sys.partition_range_values as -- missing source code
go

create view sys.partition_schemes as -- missing source code
go

create view sys.partitions as -- missing source code
go

create view sys.plan_guides as -- missing source code
go

create view sys.procedures as -- missing source code
go

create view sys.registered_search_properties as -- missing source code
go

create view sys.registered_search_property_lists as -- missing source code
go

create view sys.remote_logins as -- missing source code
go

create view sys.remote_service_bindings as -- missing source code
go

create view sys.resource_governor_configuration as -- missing source code
go

create view sys.resource_governor_resource_pool_affinity as -- missing source code
go

create view sys.resource_governor_resource_pools as -- missing source code
go

create view sys.resource_governor_workload_groups as -- missing source code
go

create view sys.routes as -- missing source code
go

create view sys.schemas as -- missing source code
go

create view sys.securable_classes as -- missing source code
go

create view sys.selective_xml_index_namespaces as -- missing source code
go

create view sys.selective_xml_index_paths as -- missing source code
go

create view sys.sequences as -- missing source code
go

create view sys.server_assembly_modules as -- missing source code
go

create view sys.server_audit_specification_details as -- missing source code
go

create view sys.server_audit_specifications as -- missing source code
go

create view sys.server_audits as -- missing source code
go

create view sys.server_event_notifications as -- missing source code
go

create view sys.server_event_session_actions as -- missing source code
go

create view sys.server_event_session_events as -- missing source code
go

create view sys.server_event_session_fields as -- missing source code
go

create view sys.server_event_session_targets as -- missing source code
go

create view sys.server_event_sessions as -- missing source code
go

create view sys.server_events as -- missing source code
go

create view sys.server_file_audits as -- missing source code
go

create view sys.server_permissions as -- missing source code
go

create view sys.server_principal_credentials as -- missing source code
go

create view sys.server_principals as -- missing source code
go

create view sys.server_role_members as -- missing source code
go

create view sys.server_sql_modules as -- missing source code
go

create view sys.server_trigger_events as -- missing source code
go

create view sys.server_triggers as -- missing source code
go

create view sys.servers as -- missing source code
go

create view sys.service_broker_endpoints as -- missing source code
go

create view sys.service_contract_message_usages as -- missing source code
go

create view sys.service_contract_usages as -- missing source code
go

create view sys.service_contracts as -- missing source code
go

create view sys.service_message_types as -- missing source code
go

create view sys.service_queue_usages as -- missing source code
go

create view sys.service_queues as -- missing source code
go

create view sys.services as -- missing source code
go

create view sys.soap_endpoints as -- missing source code
go

create view sys.spatial_index_tessellations as -- missing source code
go

create view sys.spatial_indexes as -- missing source code
go

create view sys.spatial_reference_systems as -- missing source code
go

create view sys.sql_dependencies as -- missing source code
go

create view sys.sql_expression_dependencies as -- missing source code
go

create view sys.sql_logins as -- missing source code
go

create view sys.sql_modules as -- missing source code
go

create view sys.stats as -- missing source code
go

create view sys.stats_columns as -- missing source code
go

create view sys.symmetric_keys as -- missing source code
go

create view sys.synonyms as -- missing source code
go

create view sys.sysaltfiles as -- missing source code
go

create view sys.syscacheobjects as -- missing source code
go

create view sys.syscharsets as -- missing source code
go

create view sys.syscolumns as -- missing source code
go

create view sys.syscomments as -- missing source code
go

create view sys.sysconfigures as -- missing source code
go

create view sys.sysconstraints as -- missing source code
go

create view sys.syscurconfigs as -- missing source code
go

create view sys.syscursorcolumns as -- missing source code
go

create view sys.syscursorrefs as -- missing source code
go

create view sys.syscursors as -- missing source code
go

create view sys.syscursortables as -- missing source code
go

create view sys.sysdatabases as -- missing source code
go

create view sys.sysdepends as -- missing source code
go

create view sys.sysdevices as -- missing source code
go

create view sys.sysfilegroups as -- missing source code
go

create view sys.sysfiles as -- missing source code
go

create view sys.sysforeignkeys as -- missing source code
go

create view sys.sysfulltextcatalogs as -- missing source code
go

create view sys.sysindexes as -- missing source code
go

create view sys.sysindexkeys as -- missing source code
go

create view sys.syslanguages as -- missing source code
go

create view sys.syslockinfo as -- missing source code
go

create view sys.syslogins as -- missing source code
go

create view sys.sysmembers as -- missing source code
go

create view sys.sysmessages as -- missing source code
go

create view sys.sysobjects as -- missing source code
go

create view sys.sysoledbusers as -- missing source code
go

create view sys.sysopentapes as -- missing source code
go

create view sys.sysperfinfo as -- missing source code
go

create view sys.syspermissions as -- missing source code
go

create view sys.sysprocesses as -- missing source code
go

create view sys.sysprotects as -- missing source code
go

create view sys.sysreferences as -- missing source code
go

create view sys.sysremotelogins as -- missing source code
go

create view sys.sysservers as -- missing source code
go

create view sys.system_columns as -- missing source code
go

create view sys.system_components_surface_area_configuration as -- missing source code
go

create view sys.system_internals_allocation_units as -- missing source code
go

create view sys.system_internals_partition_columns as -- missing source code
go

create view sys.system_internals_partitions as -- missing source code
go

create view sys.system_objects as -- missing source code
go

create view sys.system_parameters as -- missing source code
go

create view sys.system_sql_modules as -- missing source code
go

create view sys.system_views as -- missing source code
go

create view sys.systypes as -- missing source code
go

create view sys.sysusers as -- missing source code
go

create view sys.table_types as -- missing source code
go

create view sys.tables as -- missing source code
go

create view sys.tcp_endpoints as -- missing source code
go

create view sys.trace_categories as -- missing source code
go

create view sys.trace_columns as -- missing source code
go

create view sys.trace_event_bindings as -- missing source code
go

create view sys.trace_events as -- missing source code
go

create view sys.trace_subclass_values as -- missing source code
go

create view sys.traces as -- missing source code
go

create view sys.transmission_queue as -- missing source code
go

create view sys.trigger_event_types as -- missing source code
go

create view sys.trigger_events as -- missing source code
go

create view sys.triggers as -- missing source code
go

create view sys.type_assembly_usages as -- missing source code
go

create view sys.types as -- missing source code
go

create view sys.user_token as -- missing source code
go

create view sys.via_endpoints as -- missing source code
go

create view sys.views as -- missing source code
go

CREATE VIEW [dbo].[vw_AgencyRequest]
AS
SELECT        rq.ProcessId, rq.AgencyId, p.AgencyName, rq.RequestFrom, rq.RequestTo, ISNULL(r.PnrNumber, '-') AS PnrNumber, dbo.RequestEqualSearchIdToProcessId(rq.ProcessId, rq.SearchId) AS IsRedirected, rq.CreationDate, 
                         CAST(ISNULL(rq.DepartureDate, '1900-01-01') AS Date) AS DepartureDate, CAST(ISNULL(rq.ArrivalDate, '1900-01-01') AS Date) AS ArrivalDate
FROM            dbo.AgencyRequests AS rq LEFT OUTER JOIN
                         dbo.Reservations AS r ON rq.ProcessId = r.ProcessId INNER JOIN
                         dbo.AgencyProfile AS p ON p.AgencyId = rq.AgencyId
go

CREATE VIEW [dbo].[vw_BankPosLogs]
AS
	SELECT bl.BankPosLogId, bl.BankPosId, bl.ProcessType, bl.PaymentStatus, bl.InstallmentCount, bl.InstallmentCommisionAmount, bl.Amount, bl.TotalAmount, bl.CurrencyId, bl.AuthType, bl.XId, bl.BankProcessId,
		bl.HostRefNum, bl.TransId, bl.CardOwner, bl.CardMasked, bl.ClientIpAdress, bl.Notes, bl.BankResponse, bl.ProcessId, bl.SupplierName, bl.CreationDate, bl.CanceledTran, bl.IsSuccess, bl.UserId, bl.AgencyId,
		bl.IsTPayment,
		(case when p.IsAgencyCompany = 1 and p.ParentAgencyId != dbo.EmptyGuid() then (select top 1
			sagp.AgencyName
		from AgencyProfile sagp
		where sagp.AgencyId = p.ParentAgencyId) else  p.AgencyName end) as AgencyName,
		b.BankId, b.BankName, b.BankLogo, b.Status, b.OrderProcess, b.AccountId, b.BankCode, au.Name + ' ' + au.SurName AS UserInfo, ps.Description, cr.CurrencyName,
		ps.ReceiptReferance
	FROM dbo.BankPosLogs AS bl INNER JOIN
		dbo.BankPosInformations AS bi ON bi.BankPosInformationId = bl.BankPosId INNER JOIN
		dbo.Banks AS b ON b.BankId = bi.BankId INNER JOIN
		dbo.AgencyProfile AS p ON p.AgencyId = bl.AgencyId LEFT OUTER JOIN
		dbo.AgencyUsers AS au ON au.UserId = bl.UserId INNER JOIN
		dbo.BankPosLogPaymentStatus AS ps ON ps.EnumEqual = bl.PaymentStatus INNER JOIN
		dbo.Currencies AS cr ON cr.CurrencyId = bl.CurrencyId
go

CREATE VIEW [dbo].[vw_CommissionDetails]
AS
SELECT 
	substring( 
		( 
			 select ' ' + p.TicketNumber AS 'data()' 
			 FROM dbo.PassengersInfo p  
			 where p.ReservationId = cd.ReservationId FOR XML PATH('')
		), 2 , 10) As TicketNumberList

	
FROM dbo.CommissionInvoiceDetails cd
INNER JOIN dbo.Reservations r ON r.ReservationId = cd.ReservationId
go

CREATE VIEW [dbo].[vw_ReservationSummary]
AS
SELECT        p.TicketNumber, p.Name, p.SurName, p.CreationDate, f.CarrierCode, pr.FareStatus, s.Description, r.PnrNumber, r.ProcessId, r.AgencyId, r.LastDateToTicket, pf.AgencyName
FROM            dbo.PassengersInfo AS p INNER JOIN
                         dbo.FlightPriceInfo AS pr ON pr.PassengerId = p.PassengerId LEFT OUTER JOIN
                         dbo.FlightsInfo AS f ON f.ReservationId = p.ReservationId LEFT OUTER JOIN
                         dbo.Reservations AS r ON r.ReservationId = p.ReservationId LEFT OUTER JOIN
                         dbo.FareStatuList AS s ON s.FareStatuId = pr.FareStatus LEFT OUTER JOIN
                         dbo.AgencyProfile AS pf ON pf.AgencyId = r.AgencyId
WHERE        (f.FlightIndex = 0)
go

CREATE VIEW [dbo].[vw_ReservationSummaryDetail]
AS
	SELECT p.TicketNumber, p.Name, p.SurName, p.CreationDate, f.CarrierCode, pr.FareStatus, s.Description, pr.TicketStatus, r.PnrNumber, r.ProcessId, r.AgencyId, r.LastDateToTicket, pf.AgencyName
			, f.Departure, f.Arrival, f.DepartureDate, f.DepartureTime, r.UserId, r.SupplierName,
		(select top 1
			ap.AirportId
		from dbo.AirPorts ap
		where ap.AirportCode = f.Departure) as DepartureCode,
		(select top 1
			ap.AirportId
		from dbo.AirPorts ap
		where ap.AirportCode = f.Arrival) as ArrivalCode,
		(select top 1
			ap.CityName
		from dbo.AirPorts ap
		where ap.AirportCode = f.Departure) as DepartureCity,
		(select top 1
			ap.CityName
		from dbo.AirPorts ap
		where ap.AirportCode = f.Arrival) as ArrivalCity,
		r.ReservationId,
		pf.ParentAgencyId,
		case when  (ParentAgencyId is null or ParentAgencyId ='00000000-0000-0000-0000-000000000000') then '' else (select top 1
			AgencyName
		from AgencyProfile pag
		where pag.AgencyId = pf.ParentAgencyId) end as ParentAgencyName
	FROM dbo.PassengersInfo AS p INNER JOIN
		dbo.FlightPriceInfo AS pr ON pr.PassengerId = p.PassengerId LEFT OUTER JOIN
		dbo.FlightsInfo AS f ON f.ReservationId = p.ReservationId LEFT OUTER JOIN
		dbo.Reservations AS r ON r.ReservationId = p.ReservationId LEFT OUTER JOIN
		dbo.FareStatuList AS s ON s.FareStatuId = pr.FareStatus LEFT OUTER JOIN
		dbo.AgencyProfile AS pf ON pf.AgencyId = r.AgencyId

	WHERE        (f.FlightIndex = 0)
go

CREATE VIEW [dbo].[vw_TicketBaseReporting]
AS
	SELECT (CASE WHEN r.PaymentType = 1 THEN 'CR' WHEN r.PaymentType = 2 THEN 'CC' WHEN r.PaymentType = 3 THEN 'CC' WHEN r.PaymentType = 0 THEN '-' END) AS PaymentType, p.TicketNumber, p.Name,
		p.SurName, f.CarrierCode, s.Description, aw.SupplierId, r.PnrNumber, r.ProviderId, r.SubProviderId, r.ProcessId, r.AgencyId, r.LastDateToTicket,
		(case when pf.IsAgencyCompany = 1 and pf.ParentAgencyId != dbo.EmptyGuid() then (select top 1
			sagp.AgencyName
		from AgencyProfile sagp
		where sagp.AgencyId = pf.ParentAgencyId) else  pf.AgencyName end) as AgencyName,

		pr.FlightPriceId, pr.ReservationId,
		pr.PassengerType, pr.BasePrice, pr.Tax, pr.BasePrice + pr.Tax AS Price, pr.Vq, pr.FuelOther, pr.SecretServicesPrice, pr.ServicesPrice, pr.AgencyCommission, pr.ExtraCommisson, pr.TotalPrice, pr.CurrencyId,
		pr.OriginalCurrencyId, pr.CurrencyConvertionRate, pr.SystemServicesPrice, pr.ParentAgencyServicesPrice, pr.IsRefundable, pr.ProviderId AS Expr1, pr.PassengerId, pr.PriceIndex, pr.FareStatus, pr.TicketStatus,
		pr.SupplierName, pr.FareReferanceId, pr.CreationDate, c.CurrencyName, r.SupplierName AS Expr2, dbo.FlightInfoDestionation(r.ReservationId) AS FlightDest, CAST(CAST(f.DepartureDate AS datetime) 
                         + CAST(f.DepartureTime AS datetime) AS datetime) AS FlightDate, dbo.FlightInfoFlightNumbers(r.ReservationId) AS FlightNumbers, (CASE WHEN r.SubProviderId <> 0 THEN
                             (SELECT AgencyName
		FROM AgencyProfile
		WHERE        AccountId = r.SubProviderId) ELSE '-' END) AS SubProviderName

	FROM dbo.PassengersInfo AS p INNER JOIN
		dbo.FlightPriceInfo AS pr ON pr.PassengerId = p.PassengerId INNER JOIN
		dbo.FlightsInfo AS f ON f.ReservationId = p.ReservationId INNER JOIN
		dbo.Reservations AS r ON r.ReservationId = p.ReservationId INNER JOIN
		dbo.ReservationStatusList AS s ON s.ReservationStatuId = pr.TicketStatus INNER JOIN
		dbo.AgencyProfile AS pf ON pf.AgencyId = r.AgencyId INNER JOIN
		dbo.Currencies AS c ON c.CurrencyId = pr.CurrencyId INNER JOIN
		dbo.AirWays AS aw ON aw.AccountId = r.ProviderId
	WHERE (f.FlightIndex = 0)
go

create view sys.xml_indexes as -- missing source code
go

create view sys.xml_schema_attributes as -- missing source code
go

create view sys.xml_schema_collections as -- missing source code
go

create view sys.xml_schema_component_placements as -- missing source code
go

create view sys.xml_schema_components as -- missing source code
go

create view sys.xml_schema_elements as -- missing source code
go

create view sys.xml_schema_facets as -- missing source code
go

create view sys.xml_schema_model_groups as -- missing source code
go

create view sys.xml_schema_namespaces as -- missing source code
go

create view sys.xml_schema_types as -- missing source code
go

create view sys.xml_schema_wildcard_namespaces as -- missing source code
go

create view sys.xml_schema_wildcards as -- missing source code
go

CREATE proc [dbo].[AgencyAllowedSuppliersAdd]
@AgencyTypeId uniqueidentifier,@SupplierId int
as
insert into AgencyAllowedSuppliers(AgencyTypeId,SupplierId) values(@AgencyTypeId,@SupplierId)
go

create proc [dbo].[AgencyAllowedSuppliersDelete]
@AgencyTypeId uniqueidentifier
as
delete from AgencyAllowedSuppliers
where AgencyTypeId=@AgencyTypeId
go

CREATE proc [dbo].[AgencyAllowedSuppliersIsAgencyAllowed] 
@AgencyTypeId uniqueidentifier,
@SupplierName nvarchar(50)
as
select * from AgencyAllowedSuppliers s
inner join AirWaySuppliers a on a.SupplierId=s.SupplierId
where s.AgencyTypeId=@AgencyTypeId and a.SupplierName=@SupplierName
go

create proc [dbo].[AgencyAllowedSuppliersList]
as
select * from AgencyAllowedSuppliers
go

create proc [dbo].[AgencyAllowedSuppliersListById]
@AgencyTypeId uniqueidentifier
as
select * from AgencyAllowedSuppliers
where AgencyTypeId=@AgencyTypeId
go

create proc [dbo].[AgencyAllowedSuppliersUpdate]
@AgencyTypeId uniqueidentifier, @SupplierId int
as
update AgencyAllowedSuppliers set SupplierId=@SupplierId
where AgencyTypeId=@AgencyTypeId
go

CREATE proc [dbo].[AgencyCommissionTableListByAgencyId]    
@AgencyId uniqueidentifier 
as

if exists(select * from AgencyCommissionTables where AgencyId=@AgencyId)
begin
select 
aw.AirWayName,
a.AirWayCommissionId as AirAirWayCommissionId,
a.AirWayId as AirAirWayId,
a.DomesticBussinessPrice as AirDomesticBussinessPrice,
a.DomesticEconomyPrice as AirDomesticEconomyPrice,
a.DomesticEconomyHighPrice as AirDomesticEconomyHighPrice,
a.DomesticPromotionPrice as AirDomesticPromotionPrice,
a.InterBussinessPrice as AirInterBussinessPrice,
a.InterEconomyPrice as AirInterEconomyPrice,
a.InterEconomyHighPrice as AirInterEconomyHighPrice,
a.InterFirstPrice as AirInterFirstPrice,
a.InterPromotionPrice as AirInterPromotionPrice,
t.AgencyCommissionTableId as AgAgencyCommissionTableId,
t.AirWayId as AgAirWayId,
t.DomesticBussinessPrice as AgDomesticBussinessPrice,
t.DomesticEconomyPrice as AgDomesticEconomyPrice,
t.DomesticEconomyHighPrice as AgDomesticEconomyHighPrice,
t.DomesticPromotionPrice as AgDomesticPromotionPrice,
t.InterBussinessPrice as AgInterBussinessPrice,
t.InterEconomyPrice as AgInterEconomyPrice,
t.InterEconomyHighPrice as AgInterEconomyHighPrice,
t.InterFirstPrice as AgInterFirstPrice,
t.InterPromotionPrice as AgInterPromotionPrice,
t.AgencyId as AgAgencyId
 from AirWayCommissions a
inner join AgencyCommissionTables t on t.AirwayId=a.AirWayId
inner join AirWays aw on aw.AirWayId=t.AirWayId
where t.AgencyId=@AgencyId and aw.Status = 1
end
else
begin
select 
aw.AirWayName,
a.AirWayCommissionId as AirAirWayCommissionId,
a.AirWayId as AirAirWayId,
a.DomesticBussinessPrice as AirDomesticBussinessPrice,
a.DomesticEconomyPrice as AirDomesticEconomyPrice,
a.DomesticEconomyHighPrice as AirDomesticEconomyHighPrice,
a.DomesticPromotionPrice as AirDomesticPromotionPrice,
a.InterBussinessPrice as AirInterBussinessPrice,
a.InterEconomyPrice as AirInterEconomyPrice,
a.InterEconomyHighPrice as AirInterEconomyHighPrice,
a.InterFirstPrice as AirInterFirstPrice,
a.InterPromotionPrice as AirInterPromotionPrice ,
null as AgAgencyCommissionTableId,
null as AgAirWayId,
null as AgDomasticBussinessPrice,
null as AgDomesticEconomyPrice,
null as AgDomesticEconomyHighPrice,
null as AgDomesticPromotionPrice,
null as AgInterBussinessPrice,
null as AgInterEconomyPrice,
null as AgInterEconomyHighPrice,
null as AgInterFirstPrice,
null as AgInterPromotionPrice
from AirWayCommissions a 
inner join AirWays aw on aw.AirWayId=a.AirWayId
where aw.Status = 1
end
go

CREATE proc [dbo].[AgencyCommissionTableListByParentAgencyId]    
@AgencyId uniqueidentifier ,
@ParentAgencyId uniqueidentifier
as

if exists(select * from AgencyCommissionTables where AgencyId=@AgencyId)
begin
	if @ParentAgencyId = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER)
	begin
		select 
			aw.AirWayName,
			a.AirWayCommissionId as AirAirWayCommissionId,
			a.AirWayId as AirAirWayId,
			a.DomesticBussinessPrice as AirDomesticBussinessPrice,
			a.DomesticEconomyPrice as AirDomesticEconomyPrice,
			a.DomesticEconomyHighPrice as AirDomesticEconomyHighPrice,
			a.DomesticPromotionPrice as AirDomesticPromotionPrice,
			a.InterBussinessPrice as AirInterBussinessPrice,
			a.InterEconomyPrice as AirInterEconomyPrice,
			a.InterEconomyHighPrice as AirInterEconomyHighPrice,
			a.InterFirstPrice as AirInterFirstPrice,
			a.InterPromotionPrice as AirInterPromotionPrice,
			t.AgencyCommissionTableId as AgAgencyCommissionTableId,
			t.AirWayId as AgAirWayId,
			t.DomesticBussinessPrice as AgDomesticBussinessPrice,
			t.DomesticEconomyPrice as AgDomesticEconomyPrice,
			t.DomesticEconomyHighPrice as AgDomesticEconomyHighPrice,
			t.DomesticPromotionPrice as AgDomesticPromotionPrice,
			t.InterBussinessPrice as AgInterBussinessPrice,
			t.InterEconomyPrice as AgInterEconomyPrice,
			t.InterEconomyHighPrice as AgInterEconomyHighPrice,
			t.InterFirstPrice as AgInterFirstPrice,
			t.InterPromotionPrice as AgInterPromotionPrice,
			t.AgencyId as AgAgencyId
		from AirWayCommissions a
		inner join AgencyCommissionTables t on t.AirwayId=a.AirWayId
		inner join AirWays aw on aw.AirWayId=t.AirWayId
		where t.AgencyId=@AgencyId and aw.Status = 1
	end
	else
	begin
		select 
			aw.AirWayName,
			a.AirWayCommissionId as AirAirWayCommissionId,
			a.AirWayId as AirAirWayId,
			parentComm.DomesticBussinessPrice as AirDomesticBussinessPrice,
			parentComm.DomesticEconomyPrice as AirDomesticEconomyPrice,
			parentComm.DomesticEconomyHighPrice as AirDomesticEconomyHighPrice,
			parentComm.DomesticPromotionPrice as AirDomesticPromotionPrice,
			parentComm.InterBussinessPrice as AirInterBussinessPrice,
			parentComm.InterEconomyPrice as AirInterEconomyPrice,
			parentComm.InterEconomyHighPrice as AirInterEconomyHighPrice,
			parentComm.InterFirstPrice as AirInterFirstPrice,
			parentComm.InterPromotionPrice as AirInterPromotionPrice,
			t.AgencyCommissionTableId as AgAgencyCommissionTableId,
			t.AirWayId as AgAirWayId,
			t.DomesticBussinessPrice as AgDomesticBussinessPrice,
			t.DomesticEconomyPrice as AgDomesticEconomyPrice,
			t.DomesticEconomyHighPrice as AgDomesticEconomyHighPrice,
			t.DomesticPromotionPrice as AgDomesticPromotionPrice,
			t.InterBussinessPrice as AgInterBussinessPrice,
			t.InterEconomyPrice as AgInterEconomyPrice,
			t.InterEconomyHighPrice as AgInterEconomyHighPrice,
			t.InterFirstPrice as AgInterFirstPrice,
			t.InterPromotionPrice as AgInterPromotionPrice,
			t.AgencyId as AgAgencyId
		from AirWayCommissions a
		inner join AgencyCommissionTables t on t.AirwayId=a.AirWayId
		inner join AirWays aw on aw.AirWayId=t.AirWayId
		inner join AgencyCommissionTables parentComm on parentComm.AgencyId = @ParentAgencyId and parentComm.AirWayId = a.AirWayId
		where t.AgencyId=@AgencyId and aw.Status = 1
	end

end
else
begin
	if @ParentAgencyId = CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER)
	begin
		select 
			aw.AirWayName,
			a.AirWayCommissionId as AirAirWayCommissionId,
			a.AirWayId as AirAirWayId,
			a.DomesticBussinessPrice as AirDomesticBussinessPrice,
			a.DomesticEconomyPrice as AirDomesticEconomyPrice,
			a.DomesticEconomyHighPrice as AirDomesticEconomyHighPrice,
			a.DomesticPromotionPrice as AirDomesticPromotionPrice,
			a.InterBussinessPrice as AirInterBussinessPrice,
			a.InterEconomyPrice as AirInterEconomyPrice,
			a.InterEconomyHighPrice as AirInterEconomyHighPrice,
			a.InterFirstPrice as AirInterFirstPrice,
			a.InterPromotionPrice as AirInterPromotionPrice ,
			null as AgAgencyCommissionTableId,
			null as AgAirWayId,
			null as AgDomasticBussinessPrice,
			null as AgDomesticEconomyPrice,
			null as AgDomesticEconomyHighPrice,
			null as AgDomesticPromotionPrice,
			null as AgInterBussinessPrice,
			null as AgInterEconomyPrice,
			null as AgInterEconomyHighPrice,
			null as AgInterFirstPrice,
			null as AgInterPromotionPrice
		from AirWayCommissions a 
		inner join AirWays aw on aw.AirWayId=a.AirWayId
		where aw.Status = 1
	end
	else
	begin
		select 
			aw.AirWayName,
			a.AirWayCommissionId as AirAirWayCommissionId,
			a.AirWayId as AirAirWayId,
			parentComm.DomesticBussinessPrice as AirDomesticBussinessPrice,
			parentComm.DomesticEconomyPrice as AirDomesticEconomyPrice,
			parentComm.DomesticEconomyHighPrice as AirDomesticEconomyHighPrice,
			parentComm.DomesticPromotionPrice as AirDomesticPromotionPrice,
			parentComm.InterBussinessPrice as AirInterBussinessPrice,
			parentComm.InterEconomyPrice as AirInterEconomyPrice,
			parentComm.InterEconomyHighPrice as AirInterEconomyHighPrice,
			parentComm.InterFirstPrice as AirInterFirstPrice,
			parentComm.InterPromotionPrice as AirInterPromotionPrice ,
			null as AgAgencyCommissionTableId,
			null as AgAirWayId,
			null as AgDomasticBussinessPrice,
			null as AgDomesticEconomyPrice,
			null as AgDomesticEconomyHighPrice,
			null as AgDomesticPromotionPrice,
			null as AgInterBussinessPrice,
			null as AgInterEconomyPrice,
			null as AgInterEconomyHighPrice,
			null as AgInterFirstPrice,
			null as AgInterPromotionPrice
		from AirWayCommissions a 
		inner join AirWays aw on aw.AirWayId=a.AirWayId
		inner join AgencyCommissionTables parentComm on parentComm.AgencyId = @ParentAgencyId and parentComm.AirWayId = a.AirWayId
		where aw.Status = 1

	end

end
go

CREATE proc [dbo].[AgencyCommissionTablesAdd]
@AgencyId uniqueidentifier, 
@AirWayId uniqueidentifier, 
@DomesticBussinessPrice decimal(18,2), 
@DomesticEconomyPrice decimal(18,2), 
@DomesticEconomyHighPrice decimal(18,2), 
@DomesticPromotionPrice decimal(18,2), 
@InterFirstPrice decimal(18,2), 
@InterBussinessPrice decimal(18,2), 
@InterEconomyPrice decimal(18,2), 
@InterEconomyHighPrice decimal(18,2), 
@InterPromotionPrice decimal(18,2)
as
insert into 
AgencyCommissionTables(
AgencyId, 
AirWayId, 
DomesticBussinessPrice, 
DomesticEconomyPrice, 
DomesticEconomyHighPrice, 
DomesticPromotionPrice, 
InterFirstPrice, 
InterBussinessPrice, 
InterEconomyPrice, 
InterEconomyHighPrice,
InterPromotionPrice) 
values(
@AgencyId, 
@AirWayId, 
@DomesticBussinessPrice, 
@DomesticEconomyPrice, 
@DomesticEconomyHighPrice,
@DomesticPromotionPrice, 
@InterFirstPrice, 
@InterBussinessPrice, 
@InterEconomyPrice, 
@InterEconomyHighPrice,
@InterPromotionPrice)
go

create proc [dbo].[AgencyCommissionTablesDelete]
@AgencyCommissionTableId uniqueidentifier
as
delete from AgencyCommissionTables
where AgencyCommissionTableId=@AgencyCommissionTableId
go

create proc [dbo].[AgencyCommissionTablesDeleteByAgencyId]
@AgencyId uniqueidentifier
as
delete from AgencyCommissionTables where AgencyId=@AgencyId
go

create proc [dbo].[AgencyCommissionTablesList]
as
select * from AgencyCommissionTables
go

create proc [dbo].[AgencyCommissionTablesListById]
@AgencyCommissionTableId uniqueidentifier
as
select * from AgencyCommissionTables
where AgencyCommissionTableId=@AgencyCommissionTableId
go

CREATE proc [dbo].[AgencyCommissionTablesUpdate]
@AgencyCommissionTableId uniqueidentifier, 
@AgencyId uniqueidentifier, 
@AirWayId uniqueidentifier, 
@DomesticBussinessPrice decimal(18,2),
@DomesticEconomyPrice decimal(18,2), 
@DomesticEconomyHighPrice decimal(18,2), 
@DomesticPromotionPrice decimal(18,2), 
@InterFirstPrice decimal(18,2), 
@InterBussinessPrice decimal(18,2), 
@InterEconomyPrice decimal(18,2), 
@InterEconomyHighPrice decimal(18,2), 
@InterPromotionPrice decimal(18,2)
as
update AgencyCommissionTables set 
AgencyId=@AgencyId, AirWayId=@AirWayId, 
DomesticBussinessPrice=@DomesticBussinessPrice, 
DomesticEconomyPrice=@DomesticEconomyPrice, 
DomesticEconomyHighPrice=@DomesticEconomyHighPrice, 
DomesticPromotionPrice=@DomesticPromotionPrice, 
InterFirstPrice=@InterFirstPrice, 
InterBussinessPrice=@InterBussinessPrice, 
InterEconomyPrice=@InterEconomyPrice, 
InterEconomyHighPrice=@InterEconomyHighPrice, 
InterPromotionPrice=@InterPromotionPrice
where AgencyCommissionTableId=@AgencyCommissionTableId
go

CREATE proc [dbo].[AgencyCorporateCodeAdd]
@AgencyId uniqueidentifier, @CarrierCode nvarchar(5), @CorporateCode nvarchar(50)
as
insert into AgencyCorporateCode(AgencyId, CarrierCode, CorporateCode) values(@AgencyId, @CarrierCode, @CorporateCode)
go

CREATE proc [dbo].[AgencyCorporateCodeByAgencyId]
@AgencyId uniqueidentifier
as
select * from AgencyCorporateCode
where AgencyId = @AgencyId
go

CREATE proc [dbo].[AgencyCorporateCodeDelete]
@AgencyCorporateCodeId uniqueidentifier
as
delete from AgencyCorporateCode
where AgencyCorporateCodeId = @AgencyCorporateCodeId
go

CREATE proc [dbo].[AgencyCorporateCodeList]
as
select * from AgencyCorporateCode
go

CREATE proc [dbo].[AgencyCorporateCodeUpdate]
@AgencyCorporateCodeId uniqueidentifier, @AgencyId uniqueidentifier, @CarrierCode nvarchar(5), @CorporateCode nvarchar(50)
as
update AgencyCorporateCode set AgencyId = @AgencyId, CarrierCode = @CarrierCode, CorporateCode = @CorporateCode where AgencyCorporateCodeId = @AgencyCorporateCodeId
go

Create Proc [dbo].[AgencyIpLogsAdd]
@AgencyId uniqueidentifier,
@UserId uniqueidentifier,
@IpAddress nvarchar(50),
@IpType nvarchar(50),
@ContinentName nvarchar(50),
@CountryName nvarchar(50),
@RegionName nvarchar(50),
@CityName nvarchar(250),
@Lat float,
@Long float,
@CreationDate datetime,
@IpProcessTypeName nvarchar(50)
as
INSERT INTO AgencyIpLogs(
AgencyId,
UserId,
IpAddress,
IpType,
ContinentName,
CountryName,
RegionName,
CityName,
Lat,
Long,
CreationDate,
IpProcessTypeName
)
VALUES
(
@AgencyId,
@UserId,
@IpAddress,
@IpType,
@ContinentName,
@CountryName,
@RegionName,
@CityName,
@Lat,
@Long,
@CreationDate,
@IpProcessTypeName
)
go

CREATE proc [dbo].[AgencyIpLogsCheckIfIpExists]
@IpAddress nvarchar(50),
@AgencyId uniqueidentifier,
@UserId uniqueidentifier
as
select * from AgencyIpLogs 
where IpAddress=@IpAddress and 
AgencyId=@AgencyId and UserId=@UserId
and   CreationDate>DATEADD(day,-1,getdate())
go

Create Proc [dbo].[AgencyIpLogsDelete]
@AgencyIpLogId uniqueidentifier
AS
DELETE  FROM AgencyIpLogs
WHERE AgencyIpLogId=@AgencyIpLogId
go

CREATE proc  [dbo].[AgencyIpLogsFilter]
@AgencyId uniqueidentifier,
@StartDate date,
@EndDate date
as
select l.*,Isnull(p.AgencyName,'-') as [AgencyName],Isnull((u.Name+' '+u.SurName),'-') as [UserName] from AgencyIpLogs  l
inner  join AgencyProfile p on p.AgencyId=l.AgencyId
left join AgencyUsers u on u.UserId=l.UserId
where CAST(l.CreationDate  as date) between ISNULL(@StartDate,Cast(l.CreationDate as date)) and  ISNULL(@EndDate,Cast(l.CreationDate as date))
and l.AgencyId=ISNULL(@AgencyId,l.AgencyId) 
order by l.CreationDate desc
go

create proc [dbo].[AgencyIpLogsGetLastIp]
@AgencyId uniqueidentifier,
@UserId uniqueidentifier
as
select Top 1 * from AgencyIpLogs 
where AgencyId=@AgencyId and UserId=@UserId
and   CreationDate>DATEADD(day,-1,getdate())
order by CreationDate desc
go

Create Proc [dbo].[AgencyIpLogsList]
as
SELECT * FROM AgencyIpLogs
go

Create Proc [dbo].[AgencyIpLogsListById]
@AgencyIpLogId uniqueidentifier
AS
SELECT * FROM AgencyIpLogs
WHERE AgencyIpLogId=@AgencyIpLogId
go

Create Proc [dbo].[AgencyIpLogsUpdate]
@AgencyIpLogId uniqueidentifier,
@AgencyId uniqueidentifier,
@UserId uniqueidentifier,
@IpAddress nvarchar(50),
@IpType nvarchar(50),
@ContinentName nvarchar(50),
@CountryName nvarchar(50),
@RegionName nvarchar(50),
@CityName nvarchar(250),
@Lat float,
@Long float,
@CreationDate datetime,
@IpProcessTypeName nvarchar(50)
AS
UPDATE AgencyIpLogs
SET
AgencyId=@AgencyId,
UserId=@UserId,
IpAddress=@IpAddress,
IpType=@IpType,
ContinentName=@ContinentName,
CountryName=@CountryName,
RegionName=@RegionName,
CityName=@CityName,
Lat=@Lat,
Long=@Long,
CreationDate=@CreationDate,
IpProcessTypeName=@IpProcessTypeName
WHERE AgencyIpLogId=@AgencyIpLogId
go

CREATE proc [dbo].[AgencyProfileAdd]
@AgencyId uniqueidentifier,
@ParentAgencyId uniqueidentifier,
@AgencyDefaultCurrencyId int,
 @AgencyOwnerUserId uniqueidentifier, @AgencyName nvarchar(250), @CommercialTitle nvarchar(500), @AgencyLogo nvarchar(500), @PhoneNumber nvarchar(50), @FaxNumber nvarchar(50), @ManagerName nvarchar(50), @ManagerSurName nvarchar(50), @CountryId int, @CityId int, @DistrictName nvarchar(50), @Adress nvarchar(500), @TaxOffice nvarchar(50), @TaxNumber nvarchar(50), @WebSite nvarchar(500), @IsBya bit,  @PayTicketingInstallmetCommission bit, @PayNoInstallmentTicketingCommission bit, @IsIata bit, @CanManuelPosPayment bit, @PayManuelPosCommission bit, @ForceManuelPosTreeDPayment bit, @ForceTreeDPaymentTicketing bit, @CreationDate datetime, @CreatedBy uniqueidentifier, @AgencyTypeId uniqueidentifier, @HasContract bit,  @AllowXMLServices bit, @XMLPaymentType nvarchar(50), @XMLAuthPassword nvarchar(250), @XMLAllowedIPAdress nvarchar(250), @Status bit, @AccountId int,@SmsOriginator nvarchar(11),@ParentAgencyCommissionPrice decimal(18,2)
 ,@DefaultInvoicePreference int, @IsCreateCorporateAgency bit, @CreditLimit decimal(18,2),
 @IsAgencyCompany bit
as
insert into AgencyProfile(AgencyId,ParentAgencyId,AgencyDefaultCurrencyId, AgencyOwnerUserId, AgencyName, CommercialTitle, AgencyLogo, PhoneNumber, FaxNumber, ManagerName, ManagerSurName, CountryId, CityId, DistrictName, Adress, TaxOffice, TaxNumber, WebSite, IsBya,  PayTicketingInstallmetCommission, PayNoInstallmentTicketingCommission, IsIata, CanManuelPosPayment, PayManuelPosCommission, ForceManuelPosTreeDPayment, ForceTreeDPaymentTicketing, CreationDate, CreatedBy, AgencyTypeId, HasContract,  AllowXMLServices, XMLPaymentType, XMLAuthPassword, XMLAllowedIPAdress, Status, AccountId,SmsOriginator,ParentAgencyCommissionPrice, DefaultInvoicePreference, IsCreateCorporateAgency, CreditLimit, IsAgencyCompany) 
values(@AgencyId,@ParentAgencyId,@AgencyDefaultCurrencyId, @AgencyOwnerUserId,  @AgencyName, @CommercialTitle, @AgencyLogo, @PhoneNumber, @FaxNumber, @ManagerName, @ManagerSurName, @CountryId, @CityId, @DistrictName, @Adress, @TaxOffice, @TaxNumber, @WebSite, @IsBya,  @PayTicketingInstallmetCommission, @PayNoInstallmentTicketingCommission, @IsIata, @CanManuelPosPayment, @PayManuelPosCommission, @ForceManuelPosTreeDPayment, @ForceTreeDPaymentTicketing, @CreationDate, @CreatedBy, @AgencyTypeId, @HasContract,  @AllowXMLServices, @XMLPaymentType, @XMLAuthPassword, @XMLAllowedIPAdress, @Status, @AccountId,@SmsOriginator,@ParentAgencyCommissionPrice, @DefaultInvoicePreference, @IsCreateCorporateAgency, @CreditLimit, @IsAgencyCompany)
go

create Proc [dbo].[AgencyProfileCharterSupplierList]
as
select Distinct p.* from CharterFlights c 
inner Join AgencyProfile p on c.ProviderId=p.AgencyId
order by p.AgencyName
go

create proc [dbo].[AgencyProfileDelete]
@AgencyId uniqueidentifier
as
delete from AgencyProfile
where AgencyId=@AgencyId
go

create proc [dbo].[AgencyProfileList]
as
select * from AgencyProfile
go

create proc [dbo].[AgencyProfileListByAccountId]
@AccountId int
as
select * from AgencyProfile where AccountId=@AccountId
go

create proc [dbo].[AgencyProfileListByFilter]
	@IsAgencyCompany bit = null
as
select *
from AgencyProfile
where (@IsAgencyCompany is null or IsAgencyCompany = @IsAgencyCompany)
go

create proc [dbo].[AgencyProfileListById]
@AgencyId uniqueidentifier
as
select * from AgencyProfile
where AgencyId=@AgencyId
go

CREATE proc [dbo].[AgencyProfileListByParentAgecyId]
@ParentAgencyId uniqueidentifier
as
select * from AgencyProfile
where ParentAgencyId = @ParentAgencyId
go

create proc [dbo].[AgencyProfileOneItemByProcessId]
@ProcessId uniqueidentifier
as
select Top 1 * from AgencyProfile ag
inner join Reservations r on r.AgencyId=ag.AgencyId 
where r.ProcessId=@ProcessId
go

create proc [dbo].[AgencyProfileOneItemByUserId]
@UserId uniqueidentifier
as
select * from AgencyUsers u 
 inner join AgencyProfile   p on p.AgencyId=u.AgencyId
 where u.UserId=@UserId
go

CREATE proc [dbo].[AgencyProfileUpdate]
@AgencyId uniqueidentifier,
 @ParentAgencyId uniqueidentifier,
 @AgencyDefaultCurrencyId int,
  @AgencyOwnerUserId uniqueidentifier,  @AgencyName nvarchar(250), @CommercialTitle nvarchar(500), @AgencyLogo nvarchar(500), @PhoneNumber nvarchar(50), @FaxNumber nvarchar(50), @ManagerName nvarchar(50), @ManagerSurName nvarchar(50), @CountryId int, @CityId int, @DistrictName nvarchar(50), @Adress nvarchar(500), @TaxOffice nvarchar(50), @TaxNumber nvarchar(50), @WebSite nvarchar(500), @IsBya bit,  @PayTicketingInstallmetCommission bit, @PayNoInstallmentTicketingCommission bit, @IsIata bit, @CanManuelPosPayment bit, @PayManuelPosCommission bit, @ForceManuelPosTreeDPayment bit, @ForceTreeDPaymentTicketing bit, @CreationDate datetime, @CreatedBy uniqueidentifier, @AgencyTypeId uniqueidentifier, @HasContract bit,  @AllowXMLServices bit, @XMLPaymentType nvarchar(50), @XMLAuthPassword nvarchar(250), @XMLAllowedIPAdress nvarchar(250), @Status bit, @AccountId int,@SmsOriginator nvarchar(11),@ParentAgencyCommissionPrice decimal(18,2)
  ,@DefaultInvoicePreference int, @IsCreateCorporateAgency bit, @CreditLimit decimal(18,2),
   @IsAgencyCompany bit
as
update AgencyProfile set ParentAgencyId=@ParentAgencyId,
AgencyDefaultCurrencyId=@AgencyDefaultCurrencyId,
 AgencyOwnerUserId=@AgencyOwnerUserId,  AgencyName=@AgencyName, CommercialTitle=@CommercialTitle, AgencyLogo=@AgencyLogo, PhoneNumber=@PhoneNumber, FaxNumber=@FaxNumber, ManagerName=@ManagerName, ManagerSurName=@ManagerSurName, CountryId=@CountryId, CityId=@CityId, DistrictName=@DistrictName, Adress=@Adress, TaxOffice=@TaxOffice, TaxNumber=@TaxNumber, WebSite=@WebSite, IsBya=@IsBya,  PayTicketingInstallmetCommission=@PayTicketingInstallmetCommission, PayNoInstallmentTicketingCommission=@PayNoInstallmentTicketingCommission, IsIata=@IsIata, CanManuelPosPayment=@CanManuelPosPayment, PayManuelPosCommission=@PayManuelPosCommission, ForceManuelPosTreeDPayment=@ForceManuelPosTreeDPayment, ForceTreeDPaymentTicketing=@ForceTreeDPaymentTicketing, CreationDate=@CreationDate, CreatedBy=@CreatedBy, AgencyTypeId=@AgencyTypeId, HasContract=@HasContract,  AllowXMLServices=@AllowXMLServices, XMLPaymentType=@XMLPaymentType, XMLAuthPassword=@XMLAuthPassword, XMLAllowedIPAdress=@XMLAllowedIPAdress, Status=@Status, AccountId=@AccountId,SmsOriginator=@SmsOriginator,
 ParentAgencyCommissionPrice=@ParentAgencyCommissionPrice, DefaultInvoicePreference = @DefaultInvoicePreference, IsCreateCorporateAgency = @IsCreateCorporateAgency, CreditLimit = @CreditLimit, IsAgencyCompany = @IsAgencyCompany
where AgencyId=@AgencyId
go

CREATE proc [dbo].[AgencyRequestList]
@StartDate date,
@EndDate date,
@AgencyId uniqueidentifier,
@IsRedirected bit
as

if(@AgencyId=dbo.EmptyGuid())
BEGIN
select * from vw_AgencyRequest where cast(CreationDate as date) between @StartDate and @EndDate and IsRedirected=@IsRedirected
order by CreationDate desc
END
ELSE
BEGIN
select * from vw_AgencyRequest where cast(CreationDate as date) between @StartDate and @EndDate And AgencyId=@AgencyId and IsRedirected=@IsRedirected
order by CreationDate desc
END
go

CREATE proc [dbo].[AgencyRequestsAdd]
@AgencyId uniqueidentifier,
 @CreationDate datetime, 
 @RequestFrom nvarchar(3),
 @RequestTo nvarchar(3),
 @ProcessId uniqueidentifier,
 @SearchId uniqueidentifier,
 @DepartureDate date,
 @ArrivalDate date
as
insert into AgencyRequests
(AgencyId,
 CreationDate,
 RequestFrom,
 RequestTo, 
 ProcessId,
 SearchId,
 DepartureDate,
 ArrivalDate
 )
 values(
 @AgencyId,
 @CreationDate,
 @RequestFrom,
 @RequestTo,
 @ProcessId,
 @SearchId,
 @DepartureDate,
 @ArrivalDate)
go

create proc [dbo].[AgencyRequestsDelete]
@AgencyId uniqueidentifier
as
delete from AgencyRequests
where AgencyId=@AgencyId
go

create proc [dbo].[AgencyRequestsList]
as
select * from AgencyRequests
go

create proc [dbo].[AgencyRequestsListById]
@AgencyId uniqueidentifier
as
select * from AgencyRequests
where AgencyId=@AgencyId
go

CREATE proc [dbo].[AgencyRequestsUpdate]
@AgencyId uniqueidentifier,
@CreationDate datetime, 
@RequestFrom nvarchar(3),
@RequestTo nvarchar(3), 
@ProcessId uniqueidentifier,
@SearchId uniqueidentifier,
@DepartureDate date,
@ArrivalDate date
as
update AgencyRequests set 
CreationDate=@CreationDate,
RequestFrom=@RequestFrom, 
RequestTo=@RequestTo,
ProcessId=@ProcessId,
SearchId=@SearchId,
DepartureDate=@DepartureDate,
ArrivalDate=@ArrivalDate
where AgencyId=@AgencyId
go

create proc [dbo].[AgencyRequestsUpdateProcessIdBySessionId]
@ProcessId uniqueidentifier,
@SearchId uniqueidentifier
as
update AgencyRequests set ProcessId=@ProcessId where SearchId=@SearchId
go

create proc [dbo].[AgencyTypesAdd]
@AgencyTypeName nvarchar(250), @Status bit, @ShortenChar nvarchar(1)
as
insert into AgencyTypes(AgencyTypeName, Status, ShortenChar) values(@AgencyTypeName, @Status, @ShortenChar)
go

create proc [dbo].[AgencyTypesDelete]
@AgencyTypeId uniqueidentifier
as
delete from AgencyTypes
where AgencyTypeId=@AgencyTypeId
go

create proc [dbo].[AgencyTypesList]
as
select * from AgencyTypes
go

create proc [dbo].[AgencyTypesListById]
@AgencyTypeId uniqueidentifier
as
select * from AgencyTypes
where AgencyTypeId=@AgencyTypeId
go

create proc [dbo].[AgencyTypesUpdate]
@AgencyTypeId uniqueidentifier, @AgencyTypeName nvarchar(250), @Status bit, @ShortenChar nvarchar(1)
as
update AgencyTypes set AgencyTypeName=@AgencyTypeName, Status=@Status, ShortenChar=@ShortenChar
where AgencyTypeId=@AgencyTypeId
go

create proc [dbo].[AgencyUsersAdd]
@AgencyId uniqueidentifier, @UserId uniqueidentifier, @Name nvarchar(50), @SurName nvarchar(50), @Phone nvarchar(50), @CreationDate datetime
as
insert into AgencyUsers(AgencyId, UserId, Name, SurName, Phone, CreationDate) values(@AgencyId, @UserId, @Name, @SurName, @Phone, @CreationDate)
go

create proc [dbo].[AgencyUsersDelete]
@AgencyUserId uniqueidentifier
as
delete from AgencyUsers
where AgencyUserId=@AgencyUserId
go

create proc [dbo].[AgencyUsersList]
as
select * from AgencyUsers
go

create proc [dbo].[AgencyUsersListByAgencyId]
@AgencyId uniqueidentifier
as
select * from AgencyUsers where AgencyId=@AgencyId
order by Name
go

create proc [dbo].[AgencyUsersListById]
@AgencyUserId uniqueidentifier
as
select * from AgencyUsers
where AgencyUserId=@AgencyUserId
go

create proc [dbo].[AgencyUsersOneItemByUserId]
@UserId uniqueidentifier
as
select * from AgencyUsers where UserId=@UserId
go

create proc [dbo].[AgencyUsersUpdate]
@AgencyUserId uniqueidentifier, @AgencyId uniqueidentifier, @UserId uniqueidentifier, @Name nvarchar(50), @SurName nvarchar(50), @Phone nvarchar(50), @CreationDate datetime
as
update AgencyUsers set AgencyId=@AgencyId, UserId=@UserId, Name=@Name, SurName=@SurName, Phone=@Phone, CreationDate=@CreationDate
where AgencyUserId=@AgencyUserId
go

create proc [dbo].[AirLineListAdd]
@IataCode nvarchar(2), @IcaoCode nvarchar(3), @AirLineName nvarchar(500), @Country nvarchar(150)
as
insert into AirLineList(IataCode, IcaoCode, AirLineName, Country) values(@IataCode, @IcaoCode, @AirLineName, @Country)
go

create proc [dbo].[AirLineListDelete]
@AirLineId uniqueidentifier
as
delete from AirLineList
where AirLineId=@AirLineId
go

create proc [dbo].[AirLineListList]
as
select * from AirLineList
go

create proc [dbo].[AirLineListListById]
@AirLineId uniqueidentifier
as
select * from AirLineList
where AirLineId=@AirLineId
go

create proc [dbo].[AirLineListOneItemByCarrierCode]
@CarrierCode nvarchar(5)
as
select * from AirLineList where IataCode=@CarrierCode
go

create proc [dbo].[AirLineListUpdate]
@AirLineId uniqueidentifier, @IataCode nvarchar(2), @IcaoCode nvarchar(3), @AirLineName nvarchar(500), @Country nvarchar(150)
as
update AirLineList set IataCode=@IataCode, IcaoCode=@IcaoCode, AirLineName=@AirLineName, Country=@Country
where AirLineId=@AirLineId
go

CREATE Proc [dbo].[AirPortExistsInTurkey]    
@AirPortCode nvarchar(3)
as
Select AirportCode From AirPorts where CountryCode='TR'  and (AirportCode =@AirportCode  or CityCode=@AirPortCode)
go

create proc [dbo].[AirPortsAdd]
@AirportCode nvarchar(255), @AirportName nvarchar(255), @CountryCode nvarchar(255), @CountryName nvarchar(255), @LocalizedCountryName nvarchar(255), @CityCode nvarchar(255), @CityName nvarchar(255), @LocalizedCityName nvarchar(255), @StateCode nvarchar(255), @StateName nvarchar(255), @Rating float, @AirPortTimezone int, @WindowsTimeZone nvarchar(50), @UnixTimeZone nvarchar(50), @IsCity bit
as
insert into AirPorts(AirportCode, AirportName, CountryCode, CountryName, LocalizedCountryName, CityCode, CityName, LocalizedCityName, StateCode, StateName, Rating, AirPortTimezone, WindowsTimeZone, UnixTimeZone, IsCity) values(@AirportCode, @AirportName, @CountryCode, @CountryName, @LocalizedCountryName, @CityCode, @CityName, @LocalizedCityName, @StateCode, @StateName, @Rating, @AirPortTimezone, @WindowsTimeZone, @UnixTimeZone, @IsCity)
go

create proc [dbo].[AirPortsCountryList]
as
select distinct CountryCode,LocalizedCountryName from AirPorts 
order by LocalizedCountryName
go

create proc [dbo].[AirPortsCountryListByCountryCode]
@CountryCode nvarchar(5)
as
select * from AirPorts  where CountryCode=@CountryCode
Order by AirportName asc,
 Rating desc
go

create proc [dbo].[AirPortsDelete]
@AirportId uniqueidentifier
as
delete from AirPorts
where AirportId=@AirportId
go

create proc [dbo].[AirPortsList]
as
select * from AirPorts
go

create proc [dbo].[AirPortsListById]
@AirportId uniqueidentifier
as
select * from AirPorts
where AirportId=@AirportId
go

CREATE proc  [dbo].[AirPortsListForAutoComplate]
as
select  AirportCode,CityCode,
CityName,
AirportName,
CountryCode,CountryName,
AirportId,LocalizedCountryName,LocalizedCityName from AirPorts

order by Rating desc
go

create proc [dbo].[AirPortsOneItemByAirportCode]
@AirportCode nvarchar(3)
as
select * from AirPorts where AirportCode=@AirportCode
go

create proc [dbo].[AirPortsUpdate]
@AirportId uniqueidentifier, @AirportCode nvarchar(255), @AirportName nvarchar(255), @CountryCode nvarchar(255), @CountryName nvarchar(255), @LocalizedCountryName nvarchar(255), @CityCode nvarchar(255), @CityName nvarchar(255), @LocalizedCityName nvarchar(255), @StateCode nvarchar(255), @StateName nvarchar(255), @Rating float, @AirPortTimezone int, @WindowsTimeZone nvarchar(50), @UnixTimeZone nvarchar(50), @IsCity bit
as
update AirPorts set AirportCode=@AirportCode, AirportName=@AirportName, CountryCode=@CountryCode, CountryName=@CountryName, LocalizedCountryName=@LocalizedCountryName, CityCode=@CityCode, CityName=@CityName, LocalizedCityName=@LocalizedCityName, StateCode=@StateCode, StateName=@StateName, Rating=@Rating, AirPortTimezone=@AirPortTimezone, WindowsTimeZone=@WindowsTimeZone, UnixTimeZone=@UnixTimeZone, IsCity=@IsCity
where AirportId=@AirportId
go

CREATE proc [dbo].[AirWayCommissionListForCreation]
as
Select 
aw.AirWayName,
b.AirWayId,
isnull(a.AirWayCommissionId,newid()) as [AirWayCommissionId],
isnull(a.DomesticBussinessPrice,0) as [DomesticBussinessPrice],
isnull(a.DomesticEconomyPrice,0) as [DomesticEconomyPrice],
isnull(a.DomesticEconomyHighPrice,0) as [DomesticEconomyHighPrice],
isnull(a.DomesticPromotionPrice,0) as [DomesticPromoPrice],
isnull(a.InterFirstPrice,0) as [InterFirstPrice],
isnull(a.InterBussinessPrice,0) as [InterBussinessPrice],
isnull(a.InterEconomyPrice,0) as [InterEconomyPrice],
isnull(a.InterEconomyHighPrice,0) as [InterEconomyHighPrice],
isnull(a.InterPromotionPrice,0) as [InterPromoPrice] From AirWays b
left join   AirWayCommissions a on a.AirWayId=b.AirWayId
left join AirWays aw on aw.AirWayId=b.AirWayId
where aw.Status = 1
go

CREATE proc [dbo].[AirWayCommissionsAdd]
@AirWayCommissionId uniqueidentifier, 
@AirWayId uniqueidentifier, 
@DomesticBussinessPrice decimal(18,2), 
@DomesticEconomyPrice decimal(18,2), 
@DomesticEconomyHighPrice decimal(18,2), 
@DomesticPromotionPrice decimal(18,2), 
@InterFirstPrice decimal(18,2), 
@InterBussinessPrice decimal(18,2), 
@InterEconomyPrice decimal(18,2), 
@InterEconomyHighPrice decimal(18,2), 
@InterPromotionPrice decimal(18,2)
as
insert into AirWayCommissions(
AirWayCommissionId, 
AirWayId, 
DomesticBussinessPrice, 
DomesticEconomyPrice, 
DomesticEconomyHighPrice, 
DomesticPromotionPrice, 
InterFirstPrice, 
InterBussinessPrice, 
InterEconomyPrice, 
InterEconomyHighPrice, 
InterPromotionPrice) 
values(
@AirWayCommissionId, 
@AirWayId, 
@DomesticBussinessPrice, 
@DomesticEconomyPrice, 
@DomesticEconomyHighPrice, 
@DomesticPromotionPrice, 
@InterFirstPrice, 
@InterBussinessPrice, 
@InterEconomyPrice, 
@InterEconomyHighPrice, 
@InterPromotionPrice)
go

create proc [dbo].[AirWayCommissionsDelete]
@AirWayCommissionId uniqueidentifier
as
delete from AirWayCommissions
where AirWayCommissionId=@AirWayCommissionId
go

create proc [dbo].[AirWayCommissionsList]
as
select * from AirWayCommissions
go

create proc [dbo].[AirWayCommissionsListById]
@AirWayCommissionId uniqueidentifier
as
select * from AirWayCommissions
where AirWayCommissionId=@AirWayCommissionId
go

CREATE proc [dbo].[AirWayCommissionsUpdate]
@AirWayCommissionId uniqueidentifier, 
@AirWayId uniqueidentifier, 
@DomesticBussinessPrice decimal(18,2),
@DomesticEconomyPrice decimal(18,2), 
@DomesticEconomyHighPrice decimal(18,2), 
@DomesticPromotionPrice decimal(18,2), 
@InterFirstPrice decimal(18,2), 
@InterBussinessPrice decimal(18,2), 
@InterEconomyPrice decimal(18,2), 
@InterEconomyHighPrice decimal(18,2), 
@InterPromotionPrice decimal(18,2)
as
update AirWayCommissions set 
AirWayId=@AirWayId, 
DomesticBussinessPrice=@DomesticBussinessPrice, 
DomesticEconomyPrice=@DomesticEconomyPrice, 
DomesticEconomyHighPrice=@DomesticEconomyHighPrice, 
DomesticPromotionPrice=@DomesticPromotionPrice, 
InterFirstPrice=@InterFirstPrice, 
InterBussinessPrice=@InterBussinessPrice, 
InterEconomyPrice=@InterEconomyPrice, 
InterEconomyHighPrice=@InterEconomyHighPrice, 
InterPromotionPrice=@InterPromotionPrice
where AirWayCommissionId=@AirWayCommissionId
go

create proc [dbo].[AirWayRulesAdd]
@CarrierCode nvarchar(5), @SupplierId int, @RuleTitle nvarchar(500), @RuleContent nvarchar(max), @Lang nvarchar(2)
as
insert into AirWayRules(CarrierCode, SupplierId, RuleTitle, RuleContent, Lang) values(@CarrierCode, @SupplierId, @RuleTitle, @RuleContent, @Lang)
go

create proc [dbo].[AirWayRulesDelete]
@AirWayRuleId uniqueidentifier
as
delete from AirWayRules
where AirWayRuleId=@AirWayRuleId
go

create proc [dbo].[AirWayRulesList]
as
select * from AirWayRules
go

create proc [dbo].[AirWayRulesListById]
@AirWayRuleId uniqueidentifier
as
select * from AirWayRules
where AirWayRuleId=@AirWayRuleId
go

create proc [dbo].[AirWayRulesUpdate]
@AirWayRuleId uniqueidentifier, @CarrierCode nvarchar(5), @SupplierId int, @RuleTitle nvarchar(500), @RuleContent nvarchar(max), @Lang nvarchar(2)
as
update AirWayRules set CarrierCode=@CarrierCode, SupplierId=@SupplierId, RuleTitle=@RuleTitle, RuleContent=@RuleContent, Lang=@Lang
where AirWayRuleId=@AirWayRuleId
go

create proc [dbo].[AirWayServicesChargesAdd]
@InternalPrice decimal(18,2), @DomestictPrice decimal(18,2), @DomesticCurrencyId int, @InternalCurrencyId int
as
insert into AirWayServicesCharges(InternalPrice, DomestictPrice, DomesticCurrencyId, InternalCurrencyId) values(@InternalPrice, @DomestictPrice, @DomesticCurrencyId, @InternalCurrencyId)
go

create proc [dbo].[AirWayServicesChargesDelete]
@SupplierId int
as
delete from AirWayServicesCharges
where SupplierId=@SupplierId
go

create proc [dbo].[AirWayServicesChargesList]
as
select * from AirWayServicesCharges
go

create proc [dbo].[AirWayServicesChargesListById]
@SupplierId int
as
select * from AirWayServicesCharges
where SupplierId=@SupplierId
go

create proc [dbo].[AirWayServicesChargesUpdate]
@SupplierId int, @InternalPrice decimal(18,2), @DomestictPrice decimal(18,2), @DomesticCurrencyId int, @InternalCurrencyId int
as
update AirWayServicesCharges set InternalPrice=@InternalPrice, DomestictPrice=@DomestictPrice, DomesticCurrencyId=@DomesticCurrencyId, InternalCurrencyId=@InternalCurrencyId
where SupplierId=@SupplierId
go

create proc [dbo].[AirWaySpecialClassPriceAdd]
@ClassCode nvarchar(5), @Price decimal(18,2), @ColumnName nvarchar(50), @Status bit, @RoundTrip bit
as
insert into AirWaySpecialClassPrice(ClassCode, Price, ColumnName, Status, RoundTrip) values(@ClassCode, @Price, @ColumnName, @Status, @RoundTrip)
go

create proc [dbo].[AirWaySpecialClassPriceDelete]
@CarrierCode nvarchar(5)
as
delete from AirWaySpecialClassPrice
where CarrierCode=@CarrierCode
go

create proc [dbo].[AirWaySpecialClassPriceList]
as
select * from AirWaySpecialClassPrice
go

create proc [dbo].[AirWaySpecialClassPriceListById]
@CarrierCode nvarchar(5)
as
select * from AirWaySpecialClassPrice
where CarrierCode=@CarrierCode
go

create proc [dbo].[AirWaySpecialClassPriceUpdate]
@CarrierCode nvarchar(5), @ClassCode nvarchar(5), @Price decimal(18,2), @ColumnName nvarchar(50), @Status bit, @RoundTrip bit
as
update AirWaySpecialClassPrice set ClassCode=@ClassCode, Price=@Price, ColumnName=@ColumnName, Status=@Status, RoundTrip=@RoundTrip
where CarrierCode=@CarrierCode
go

create proc [dbo].[AirWaySuppliersAdd]
@SupplierName nvarchar(50), @ProcessOrder int
as
insert into AirWaySuppliers(SupplierName, ProcessOrder) values(@SupplierName, @ProcessOrder)
go

create proc [dbo].[AirWaySuppliersDelete]
@SupplierId int
as
delete from AirWaySuppliers
where SupplierId=@SupplierId
go

create proc [dbo].[AirWaySuppliersList]
as
select * from AirWaySuppliers
go

create proc [dbo].[AirWaySuppliersListById]
@SupplierId int
as
select * from AirWaySuppliers
where SupplierId=@SupplierId
go

create proc [dbo].[AirWaySuppliersUpdate]
@SupplierId int, @SupplierName nvarchar(50), @ProcessOrder int
as
update AirWaySuppliers set SupplierName=@SupplierName, ProcessOrder=@ProcessOrder
where SupplierId=@SupplierId
go

CREATE proc [dbo].[AirWaysAdd]
@AirWayId uniqueidentifier,
@AirWayName nvarchar(MAX), 
@CarrierCode nvarchar(MAX), 
@WebServicesUserName nvarchar(MAX),
@WebServisPassword nvarchar(MAX), 
@WebServicesParamOne nvarchar(MAX), 
@WebServicesParamTwo nvarchar(MAX),  
@ServicesPrice decimal(18,2),
@DefaultAgencyCommissionsPrice decimal(18,2),
@Status bit,
@WebServicesUrl nvarchar(max),
@CanCreateRezervation bit,
@SupplierId int,
@AccountId int,
@SearchServiceTimeOutSecond int
as
insert into AirWays(
AirWayId,
AirWayName,
CarrierCode,
WebServicesUserName, 
WebServisPassword,
WebServicesParamOne,
WebServicesParamTwo,
ServicesPrice,
DefaultAgencyCommissionsPrice,
Status,
WebServicesUrl, 
CanCreateRezervation,
SupplierId,
AccountId,
SearchServiceTimeOutSecond)
values(
@AirWayId,
@AirWayName,
@CarrierCode,
@WebServicesUserName,
@WebServisPassword,
@WebServicesParamOne,
@WebServicesParamTwo,
@ServicesPrice,
@DefaultAgencyCommissionsPrice,
@Status,
@WebServicesUrl,
@CanCreateRezervation,
@SupplierId,
@AccountId,
@SearchServiceTimeOutSecond)
go

create proc [dbo].[AirWaysClassTypesAdd]
@CarrierCode nvarchar(5), @ClassCode nvarchar(15), @ClassTypeName nvarchar(15), @Status bit
as
insert into AirWaysClassTypes(CarrierCode, ClassCode, ClassTypeName, Status) values(@CarrierCode, @ClassCode, @ClassTypeName, @Status)
go

CREATE proc [dbo].[AirWaysClassTypesByCarrierCodeAndClassCode]
@CarrierCode nvarchar(15),
@ClassCode nvarchar(15)
as
select Top 1 * from AirWaysClassTypes with(nolock) where CarrierCode=@CarrierCode and ClassCode=@ClassCode and Status=1
go

create proc [dbo].[AirWaysClassTypesDelete]
@AirWayClassTypeId int
as
delete from AirWaysClassTypes
where AirWayClassTypeId=@AirWayClassTypeId
go

create proc [dbo].[AirWaysClassTypesList]
as
select * from AirWaysClassTypes
go

create proc [dbo].[AirWaysClassTypesListById]
@AirWayClassTypeId int
as
select * from AirWaysClassTypes
where AirWayClassTypeId=@AirWayClassTypeId
go

create proc [dbo].[AirWaysClassTypesUpdate]
@AirWayClassTypeId int, @CarrierCode nvarchar(5), @ClassCode nvarchar(15), @ClassTypeName nvarchar(15), @Status bit
as
update AirWaysClassTypes set CarrierCode=@CarrierCode, ClassCode=@ClassCode, ClassTypeName=@ClassTypeName, Status=@Status
where AirWayClassTypeId=@AirWayClassTypeId
go

create proc [dbo].[AirWaysDelete]
@AirWayId uniqueidentifier
as
delete from AirWays
where AirWayId=@AirWayId
go

create proc [dbo].[AirWaysList]
as
select * from AirWays
go

create proc [dbo].[AirWaysListById]
@AirWayId uniqueidentifier
as
select * from AirWays
where AirWayId=@AirWayId
go

create proc [dbo].[AirWaysOneItemByCarrierCode]
@CarrierCode nvarchar(5)
as
select * from AirWays where CarrierCode= @CarrierCode
go

create proc [dbo].[AirWaysPriceColumnsAdd]
@CarrierCode nvarchar(3), @ClassCode nvarchar(10), @ColumnName nvarchar(50), @Status bit
as
insert into AirWaysPriceColumns(CarrierCode, ClassCode, ColumnName, Status) values(@CarrierCode, @ClassCode, @ColumnName, @Status)
go

CREATE PROCEDURE [dbo].[AirWaysPriceColumnsByCarrierAndClassCode] 
	@CarrierCode nvarchar(10),
	@ClassCode nvarchar(10)  
AS
BEGIN

	Select REPLACE(concat(ltrim(rtrim(ClassTypeName)),'Price'),' ','') From AirWaysClassTypes Where Status=1 and CarrierCode=@CarrierCode and ClassCode=@ClassCode
END
go

create proc [dbo].[AirWaysPriceColumnsDelete]
@AirWayPriceColumnId int
as
delete from AirWaysPriceColumns
where AirWayPriceColumnId=@AirWayPriceColumnId
go

create proc [dbo].[AirWaysPriceColumnsList]
as
select * from AirWaysPriceColumns
go

create proc [dbo].[AirWaysPriceColumnsListById]
@AirWayPriceColumnId int
as
select * from AirWaysPriceColumns
where AirWayPriceColumnId=@AirWayPriceColumnId
go

create proc [dbo].[AirWaysPriceColumnsUpdate]
@AirWayPriceColumnId int, @CarrierCode nvarchar(3), @ClassCode nvarchar(10), @ColumnName nvarchar(50), @Status bit
as
update AirWaysPriceColumns set CarrierCode=@CarrierCode, ClassCode=@ClassCode, ColumnName=@ColumnName, Status=@Status
where AirWayPriceColumnId=@AirWayPriceColumnId
go

CREATE proc [dbo].[AirWaysUpdate]
@AirWayId uniqueidentifier, @AirWayName nvarchar(MAX),
 @CarrierCode nvarchar(MAX),
  @WebServicesUserName nvarchar(MAX),
   @WebServisPassword nvarchar(MAX),
    @WebServicesParamOne nvarchar(MAX),
	 @WebServicesParamTwo nvarchar(MAX),	 
	   @ServicesPrice decimal(18,2),
	    @DefaultAgencyCommissionsPrice decimal(18,2),		 
		  @Status bit,
		   @WebServicesUrl nvarchar(max),
		    @CanCreateRezervation bit,			 
			  @SupplierId int,
			   @AccountId int,
			   @SearchServiceTimeOutSecond int
as
update AirWays 
set AirWayName=@AirWayName, 
CarrierCode=@CarrierCode,
 WebServicesUserName=@WebServicesUserName,
  WebServisPassword=@WebServisPassword,
   WebServicesParamOne=@WebServicesParamOne,
    WebServicesParamTwo=@WebServicesParamTwo,  
	ServicesPrice=@ServicesPrice, 
	 Status=@Status,
	  WebServicesUrl=@WebServicesUrl,
	   CanCreateRezervation=@CanCreateRezervation,
	    SupplierId=@SupplierId,
		 AccountId=@AccountId,
		 SearchServiceTimeOutSecond=@SearchServiceTimeOutSecond
where AirWayId=@AirWayId
go

create proc [dbo].[AirportAllCityControl]
@AirportCode nvarchar(3)
as
select * from AirPorts where AirportCode = @AirportCode and IsCity=1
go

CREATE proc [dbo].[AirportsAndAllInCity]   
@AirportCode nvarchar(3)
as
declare @CityCode nvarchar(5)
set @CityCode= (Select  TOP 1 CityCode from AirPorts where AirportCode=@AirportCode and IsCity=1)
select * from  AirPorts where CityCode=@CityCode and ISCity=0
go

create proc [dbo].[AnnouncementDetailsAdd]
@UserId uniqueidentifier, @AnnouncementId uniqueidentifier, @Readed bit, @ReadDate datetime
as
insert into AnnouncementDetails(UserId, AnnouncementId, Readed, ReadDate) values(@UserId, @AnnouncementId, @Readed, @ReadDate)
go

create proc [dbo].[AnnouncementDetailsDelete]
@AnnouncementDetailId uniqueidentifier
as
delete from AnnouncementDetails
where AnnouncementDetailId=@AnnouncementDetailId
go

create proc [dbo].[AnnouncementDetailsList]
as
select * from AnnouncementDetails
go

create proc [dbo].[AnnouncementDetailsListById]
@AnnouncementDetailId uniqueidentifier
as
select * from AnnouncementDetails
where AnnouncementDetailId=@AnnouncementDetailId
go

create proc [dbo].[AnnouncementDetailsUpdate]
@AnnouncementDetailId uniqueidentifier, @UserId uniqueidentifier, @AnnouncementId uniqueidentifier, @Readed bit, @ReadDate datetime
as
update AnnouncementDetails set UserId=@UserId, AnnouncementId=@AnnouncementId, Readed=@Readed, ReadDate=@ReadDate
where AnnouncementDetailId=@AnnouncementDetailId
go

CREATE proc [dbo].[AnnouncementsAdd]
@AnnouncementId uniqueidentifier,
@Title nvarchar(max),
 @LongText nvarchar(max),
  @CreationDate datetime, 
  @Status bit, 
  @Lang nvarchar(5)
as
insert into Announcements(AnnouncementId,Title, LongText, CreationDate, Status, Lang) values(@AnnouncementId,@Title, @LongText, @CreationDate, @Status, @Lang)
go

CREATE proc [dbo].[AnnouncementsByUserIdAndStatus]
@UserId uniqueidentifier,
@Readed bit
as
select d.* from AnnouncementDetails  d
inner join Announcements a on a.AnnouncementId=d.AnnouncementId
where d.Readed=@Readed and d.UserId=@UserId
order by a.CreationDate desc
go

create proc [dbo].[AnnouncementsDelete]
@AnnouncementId uniqueidentifier
as
delete from Announcements
where AnnouncementId=@AnnouncementId
go

create proc [dbo].[AnnouncementsList]
as
select * from Announcements
go

create proc [dbo].[AnnouncementsListById]
@AnnouncementId uniqueidentifier
as
select * from Announcements
where AnnouncementId=@AnnouncementId
go

create proc [dbo].[AnnouncementsUpdate]
@AnnouncementId uniqueidentifier, @Title nvarchar(200), @LongText nvarchar(max), @CreationDate datetime, @Status bit, @Lang nvarchar(5)
as
update Announcements set Title=@Title, LongText=@LongText, CreationDate=@CreationDate, Status=@Status, Lang=@Lang
where AnnouncementId=@AnnouncementId
go

create proc [dbo].[BaggageInfoAdd]
@Carrier nvarchar(50), @ColumnName nvarchar(50), @BagValue nvarchar(50), @PassegerType nvarchar(10), @Unit nvarchar(50), @IsDomestic bit, @ETicketInfo nvarchar(max), @Lang nvarchar(5)
as
insert into BaggageInfo(Carrier, ColumnName, BagValue, PassegerType, Unit, IsDomestic, ETicketInfo, Lang) values(@Carrier, @ColumnName, @BagValue, @PassegerType, @Unit, @IsDomestic, @ETicketInfo, @Lang)
go

create proc [dbo].[BaggageInfoDelete]
@AirWayBagId int
as
delete from BaggageInfo
where AirWayBagId=@AirWayBagId
go

create proc [dbo].[BaggageInfoList]
as
select * from BaggageInfo
go

create proc [dbo].[BaggageInfoListById]
@AirWayBagId int
as
select * from BaggageInfo
where AirWayBagId=@AirWayBagId
go

create proc [dbo].[BaggageInfoOneItemByClassType]
@Carrier nvarchar(50),
@ColumnName nvarchar(50),
@PassegerType nvarchar(10),
@IsDomestic nvarchar(1)
as
select * from BaggageInfo
where Carrier = @Carrier and ColumnName = @ColumnName and PassegerType = @PassegerType and IsDomestic = @IsDomestic
go

create proc [dbo].[BaggageInfoUpdate]
@AirWayBagId int, @Carrier nvarchar(50), @ColumnName nvarchar(50), @BagValue nvarchar(50), @PassegerType nvarchar(10), @Unit nvarchar(50), @IsDomestic bit, @ETicketInfo nvarchar(max), @Lang nvarchar(5)
as
update BaggageInfo set Carrier=@Carrier, ColumnName=@ColumnName, BagValue=@BagValue, PassegerType=@PassegerType, Unit=@Unit, IsDomestic=@IsDomestic, ETicketInfo=@ETicketInfo, Lang=@Lang
where AirWayBagId=@AirWayBagId
go

CREATE proc  [dbo].[BankInstallmentSingleOrDefaultCommissionRate]
as
 select i.*  from Banks  b
 inner join BankInstallments i on i.BankId=b.BankId
 where b.DefaultBank=1 and i.InstallmentCount=1
 order by i.InstallmentCount
go

CREATE proc [dbo].[BankInstallmentsAdd]
@BankId uniqueidentifier, @InstallmentCount int, @CommissionRate decimal(18,2), @Status bit, @ExpenseInstallmentRate decimal(18,2),@OtherBankInstallmentRate decimal(18,2)
as

IF EXISTS(SELECT * FROM BankInstallments WHERE BankId = @BankId and InstallmentCount = @InstallmentCount)
begin
	update BankInstallments set CommissionRate=@CommissionRate, ExpenseInstallmentRate=@ExpenseInstallmentRate, Status=@Status, OtherBankInstallmentRate=@OtherBankInstallmentRate
	where BankId=@BankId and InstallmentCount=@InstallmentCount
end
else
begin
	insert into BankInstallments(BankId, InstallmentCount, CommissionRate, Status, ExpenseInstallmentRate, OtherBankInstallmentRate) values(@BankId, @InstallmentCount, @CommissionRate, @Status, @ExpenseInstallmentRate, @OtherBankInstallmentRate)
end
go

create proc [dbo].[BankInstallmentsDelete]
@BankInstallmetId uniqueidentifier
as
delete from BankInstallments
where BankInstallmetId=@BankInstallmetId
go

CREATE proc [dbo].[BankInstallmentsGetExpenseInstallmentCommissionPrice]
 @Amount decimal(18,2),
 @InstallmentCount int,
 @BankId uniqueidentifier
as
declare  @CommissionRate decimal(18,2)
declare @Result decimal(18,2)
set  @CommissionRate=(select ExpenseInstallmentRate from BankInstallments where BankId=@BankId and InstallmentCount=@InstallmentCount)
set @Result=((@Amount * @CommissionRate)/100)

select isnull(@Result,0)
go

CREATE proc [dbo].[BankInstallmentsGetInstallmentCommissionPrice]
 @Amount decimal(18,2),
 @InstallmentCount int,
 @BankId uniqueidentifier
as
declare  @CommissionRate decimal(18,2)
declare @Result decimal(18,2)
set  @CommissionRate=(select CommissionRate from BankInstallments where BankId=@BankId and InstallmentCount=@InstallmentCount)
set @Result=((@Amount * @CommissionRate)/100)

select isnull(@Result,0)
go

create proc [dbo].[BankInstallmentsList]
as
select * from BankInstallments
go

create proc [dbo].[BankInstallmentsListById]
@BankInstallmetId uniqueidentifier
as
select * from BankInstallments
where BankInstallmetId=@BankInstallmetId
go

CREATE proc [dbo].[BankInstallmentsUpdate]
@BankInstallmetId uniqueidentifier, @BankId uniqueidentifier, @InstallmentCount int, @CommissionRate decimal(18,2), @Status bit, @ExpenseInstallmentRate decimal(18,2), @OtherBankInstallmentRate decimal(18,2)
as
update BankInstallments set BankId=@BankId, InstallmentCount=@InstallmentCount, CommissionRate=@CommissionRate, ExpenseInstallmentRate=@ExpenseInstallmentRate, Status=@Status, OtherBankInstallmentRate=@OtherBankInstallmentRate
where BankInstallmetId=@BankInstallmetId
go

create proc [dbo].[BankPosInformationsAdd]
@BankId uniqueidentifier, @PosInfoName nvarchar(50), @ServicesUrl nvarchar(500), @ClientId nvarchar(50), @ClientUserName nvarchar(50), @ClientPassword nvarchar(50), @MerchantId nvarchar(50), @TreeDStoreKey nvarchar(500), @TreeDServicesUrl nvarchar(500), @AuthType nvarchar(10), @SupplierName nvarchar(50), @TreeDPaymentLocalUrl nvarchar(500), @TreeDPaymentLocalSuccsessUrl nvarchar(500), @TreeDPaymentLocalFailUrl nvarchar(500), @ProcessOrder int, @Status bit
as
insert into BankPosInformations(BankId, PosInfoName, ServicesUrl, ClientId, ClientUserName, ClientPassword, MerchantId, TreeDStoreKey, TreeDServicesUrl, AuthType, SupplierName, TreeDPaymentLocalUrl, TreeDPaymentLocalSuccsessUrl, TreeDPaymentLocalFailUrl, ProcessOrder, Status) values(@BankId, @PosInfoName, @ServicesUrl, @ClientId, @ClientUserName, @ClientPassword, @MerchantId, @TreeDStoreKey, @TreeDServicesUrl, @AuthType, @SupplierName, @TreeDPaymentLocalUrl, @TreeDPaymentLocalSuccsessUrl, @TreeDPaymentLocalFailUrl, @ProcessOrder, @Status)
go

CREATE proc [dbo].[BankPosInformationsByBankId]
@BankId uniqueidentifier
as
select * from BankPosInformations where BankId=@BankId
go

create proc [dbo].[BankPosInformationsDelete]
@BankPosInformationId uniqueidentifier
as
delete from BankPosInformations
where BankPosInformationId=@BankPosInformationId
go

create proc [dbo].[BankPosInformationsList]
as
select * from BankPosInformations
go

create proc [dbo].[BankPosInformationsListById]
@BankPosInformationId uniqueidentifier
as
select * from BankPosInformations
where BankPosInformationId=@BankPosInformationId
go

create proc [dbo].[BankPosInformationsUpdate]
@BankPosInformationId uniqueidentifier, @BankId uniqueidentifier, @PosInfoName nvarchar(50), @ServicesUrl nvarchar(500), @ClientId nvarchar(50), @ClientUserName nvarchar(50), @ClientPassword nvarchar(50), @MerchantId nvarchar(50), @TreeDStoreKey nvarchar(500), @TreeDServicesUrl nvarchar(500), @AuthType nvarchar(10), @SupplierName nvarchar(50), @TreeDPaymentLocalUrl nvarchar(500), @TreeDPaymentLocalSuccsessUrl nvarchar(500), @TreeDPaymentLocalFailUrl nvarchar(500), @ProcessOrder int, @Status bit
as
update BankPosInformations set BankId=@BankId, PosInfoName=@PosInfoName, ServicesUrl=@ServicesUrl, ClientId=@ClientId, ClientUserName=@ClientUserName, ClientPassword=@ClientPassword, MerchantId=@MerchantId, TreeDStoreKey=@TreeDStoreKey, TreeDServicesUrl=@TreeDServicesUrl, AuthType=@AuthType, SupplierName=@SupplierName, TreeDPaymentLocalUrl=@TreeDPaymentLocalUrl, TreeDPaymentLocalSuccsessUrl=@TreeDPaymentLocalSuccsessUrl, TreeDPaymentLocalFailUrl=@TreeDPaymentLocalFailUrl, ProcessOrder=@ProcessOrder, Status=@Status
where BankPosInformationId=@BankPosInformationId
go

CREATE proc [dbo].[BankPosLogPaymentStatusAdd]
@EnumEqual nvarchar(50), @Description nvarchar(50),@ReceiptReferance bit, @Lang nvarchar(5)
as
insert into BankPosLogPaymentStatus(EnumEqual, Description,ReceiptReferance, Lang) values(@EnumEqual, @Description,@ReceiptReferance, @Lang)
go

create proc [dbo].[BankPosLogPaymentStatusDelete]
@BankPosLogStatuId int
as
delete from BankPosLogPaymentStatus
where BankPosLogStatuId=@BankPosLogStatuId
go

create proc [dbo].[BankPosLogPaymentStatusList]
as
select * from BankPosLogPaymentStatus
go

create proc [dbo].[BankPosLogPaymentStatusListById]
@BankPosLogStatuId int
as
select * from BankPosLogPaymentStatus
where BankPosLogStatuId=@BankPosLogStatuId
go

CREATE proc [dbo].[BankPosLogPaymentStatusUpdate]
@BankPosLogStatuId int, @EnumEqual nvarchar(50), @Description nvarchar(50),@ReceiptReferance bit, @Lang nvarchar(5)
as
update BankPosLogPaymentStatus set EnumEqual=@EnumEqual, Description=@Description,ReceiptReferance=@ReceiptReferance, Lang=@Lang
where BankPosLogStatuId=@BankPosLogStatuId
go

create proc [dbo].[BankPosLogsAdd]
@BankPosId uniqueidentifier, @ProcessType int, @PaymentStatus int, @InstallmentCount int, @InstallmentCommisionAmount decimal(18,2), @Amount decimal(18,2), @TotalAmount decimal(18,2), @CurrencyId int, @AuthType nvarchar(50), @XId nvarchar(50), @BankProcessId nvarchar(50), @HostRefNum nvarchar(50), @TransId nvarchar(50), @CardOwner nvarchar(50), @CardMasked nvarchar(20), @ClientIpAdress nvarchar(50), @Notes nvarchar(1500), @BankResponse nvarchar(500), @ProcessId uniqueidentifier, @SupplierName nvarchar(25), @CreationDate datetime, @CanceledTran bit, @IsSuccess bit, @UserId uniqueidentifier, @AgencyId uniqueidentifier
as
insert into BankPosLogs(BankPosId, ProcessType, PaymentStatus, InstallmentCount, InstallmentCommisionAmount, Amount, TotalAmount, CurrencyId, AuthType, XId, BankProcessId, HostRefNum, TransId, CardOwner, CardMasked, ClientIpAdress, Notes, BankResponse, ProcessId, SupplierName, CreationDate, CanceledTran, IsSuccess, UserId, AgencyId) values(@BankPosId, @ProcessType, @PaymentStatus, @InstallmentCount, @InstallmentCommisionAmount, @Amount, @TotalAmount, @CurrencyId, @AuthType, @XId, @BankProcessId, @HostRefNum, @TransId, @CardOwner, @CardMasked, @ClientIpAdress, @Notes, @BankResponse, @ProcessId, @SupplierName, @CreationDate, @CanceledTran, @IsSuccess, @UserId, @AgencyId)
go

create proc [dbo].[BankPosLogsDelete]
@BankPosLogId uniqueidentifier
as
delete from BankPosLogs
where BankPosLogId=@BankPosLogId
go

create proc [dbo].[BankPosLogsList]
as
select * from BankPosLogs
go

create proc [dbo].[BankPosLogsListByBankProcessId] 
@BankProcessId nvarchar(50)
as
select * from BankPosLogs where BankProcessId=@BankProcessId
go

create proc [dbo].[BankPosLogsListById]
@BankPosLogId uniqueidentifier
as
select * from BankPosLogs
where BankPosLogId=@BankPosLogId
go

create proc [dbo].[BankPosLogsListByProcessId]
 @ProcessId uniqueidentifier
 as
 select * from BankPosLogs where ProcessId=@ProcessId order by CreationDate desc
go

create proc [dbo].[BankPosLogsOneItemIsTPaymentByProcessId]
@ProcessId uniqueidentifier
as
select * from BankPosLogs where IsTPayment=1 and ProcessId=@ProcessId
go

create proc [dbo].[BankPosLogsUpdate]
@BankPosLogId uniqueidentifier, @BankPosId uniqueidentifier, @ProcessType int, @PaymentStatus int, @InstallmentCount int, @InstallmentCommisionAmount decimal(18,2), @Amount decimal(18,2), @TotalAmount decimal(18,2), @CurrencyId int, @AuthType nvarchar(50), @XId nvarchar(50), @BankProcessId nvarchar(50), @HostRefNum nvarchar(50), @TransId nvarchar(50), @CardOwner nvarchar(50), @CardMasked nvarchar(20), @ClientIpAdress nvarchar(50), @Notes nvarchar(1500), @BankResponse nvarchar(500), @ProcessId uniqueidentifier, @SupplierName nvarchar(25), @CreationDate datetime, @CanceledTran bit, @IsSuccess bit, @UserId uniqueidentifier, @AgencyId uniqueidentifier
as
update BankPosLogs set BankPosId=@BankPosId, ProcessType=@ProcessType, PaymentStatus=@PaymentStatus, InstallmentCount=@InstallmentCount, InstallmentCommisionAmount=@InstallmentCommisionAmount, Amount=@Amount, TotalAmount=@TotalAmount, CurrencyId=@CurrencyId, AuthType=@AuthType, XId=@XId, BankProcessId=@BankProcessId, HostRefNum=@HostRefNum, TransId=@TransId, CardOwner=@CardOwner, CardMasked=@CardMasked, ClientIpAdress=@ClientIpAdress, Notes=@Notes, BankResponse=@BankResponse, ProcessId=@ProcessId, SupplierName=@SupplierName, CreationDate=@CreationDate, CanceledTran=@CanceledTran, IsSuccess=@IsSuccess, UserId=@UserId, AgencyId=@AgencyId
where BankPosLogId=@BankPosLogId
go

create proc [dbo].[BankRefundOrCancelErrorsAdd]
@BankId uniqueidentifier, @Amont decimal(18,2), @ReservationId uniqueidentifier, @UserId uniqueidentifier, @CreationDate datetime
as
insert into BankRefundOrCancelErrors(BankId, Amont, ReservationId, UserId, CreationDate) values(@BankId, @Amont, @ReservationId, @UserId, @CreationDate)
go

create proc [dbo].[BankRefundOrCancelErrorsDelete]
@BankRefundOrCancelErrorId uniqueidentifier
as
delete from BankRefundOrCancelErrors
where BankRefundOrCancelErrorId=@BankRefundOrCancelErrorId
go

create proc [dbo].[BankRefundOrCancelErrorsList]
as
select * from BankRefundOrCancelErrors
go

create proc [dbo].[BankRefundOrCancelErrorsListById]
@BankRefundOrCancelErrorId uniqueidentifier
as
select * from BankRefundOrCancelErrors
where BankRefundOrCancelErrorId=@BankRefundOrCancelErrorId
go

create proc [dbo].[BankRefundOrCancelErrorsUpdate]
@BankRefundOrCancelErrorId uniqueidentifier, @BankId uniqueidentifier, @Amont decimal(18,2), @ReservationId uniqueidentifier, @UserId uniqueidentifier, @CreationDate datetime
as
update BankRefundOrCancelErrors set BankId=@BankId, Amont=@Amont, ReservationId=@ReservationId, UserId=@UserId, CreationDate=@CreationDate
where BankRefundOrCancelErrorId=@BankRefundOrCancelErrorId
go

CREATE proc [dbo].[BanksAdd]
@BankName nvarchar(50), @BankLogo nvarchar(max), @Status bit, @OrderProcess int, @AccountId int, @BankCode nvarchar(50), @DefaultBank bit, @TRYAccountNumber nvarchar(50), @USDAccountNumber nvarchar(50), @EURAccountNumber nvarchar(50)
as
insert into Banks(BankName, BankLogo, Status, OrderProcess, AccountId, BankCode, DefaultBank, TRYAccountNumber, USDAccountNumber, EURAccountNumber) values(@BankName, @BankLogo, @Status, @OrderProcess, @AccountId, @BankCode, @DefaultBank, @TRYAccountNumber, @USDAccountNumber, @EURAccountNumber)
go

create proc [dbo].[BanksClearOtherDefaultStatus]
@BankId uniqueidentifier
as
update Banks SET DefaultBank = 0
where BankId<>@BankId
go

create proc [dbo].[BanksDelete]
@BankId uniqueidentifier
as
delete from Banks
where BankId=@BankId
go

create proc [dbo].[BanksList]
as
select * from Banks
go

create proc [dbo].[BanksListById]
@BankId uniqueidentifier
as
select * from Banks
where BankId=@BankId
go

create proc [dbo].[BanksOneItemByAccountId]
@AccountId int
as
select * from Banks where AccountId=@AccountId
go

CREATE proc [dbo].[BanksUpdate]
@BankId uniqueidentifier, @BankName nvarchar(50), @BankLogo nvarchar(max), @Status bit, @OrderProcess int, @AccountId int, @BankCode nvarchar(50), @DefaultBank bit, @TRYAccountNumber nvarchar(50), @USDAccountNumber nvarchar(50), @EURAccountNumber nvarchar(50)
as
update Banks set BankName=@BankName, BankLogo=@BankLogo, Status=@Status, OrderProcess=@OrderProcess, AccountId=@AccountId, BankCode=@BankCode, DefaultBank = @DefaultBank, TRYAccountNumber = @TRYAccountNumber, USDAccountNumber = @USDAccountNumber, EURAccountNumber = @EURAccountNumber
where BankId=@BankId
go

CREATE proc [dbo].[CanceledPnrsAdd]
@PnrNumber nvarchar(50),@Supplier nvarchar(50), @CreationDate datetime, @AgencyId uniqueidentifier
as
insert into CanceledPnrs(PnrNumber,Supplier, CreationDate, AgencyId) values(@PnrNumber,@Supplier, @CreationDate, @AgencyId)
go

create proc [dbo].[CanceledPnrsDelete]
@PnrNumber nvarchar(50)
as
delete from CanceledPnrs
where PnrNumber=@PnrNumber
go

create proc [dbo].[CanceledPnrsList]
as
select * from CanceledPnrs
go

create proc [dbo].[CanceledPnrsListById]
@PnrNumber nvarchar(50)
as
select * from CanceledPnrs
where PnrNumber=@PnrNumber
go

CREATE proc [dbo].[CanceledPnrsListFilter]
@StartDate date,
@EndDate date
as
select c.*,p.AgencyName as [AgencyName] from CanceledPnrs c 
inner join AgencyProfile p on p.AgencyId=c.AgencyId
where CAST(c.CreationDate as date) between @StartDate and @EndDate
order by CreationDate asc
go

create proc [dbo].[CanceledPnrsUpdate]
@PnrNumber nvarchar(50), @Supplier nvarchar(50), @CreationDate datetime, @AgencyId uniqueidentifier
as
update CanceledPnrs set Supplier=@Supplier, CreationDate=@CreationDate, AgencyId=@AgencyId
where PnrNumber=@PnrNumber
go

CREATE proc [dbo].[CharterDARouteList]
as
select Distinct Departure from CharterFlights where DepartureDate>=Cast(getdate() as date) and IsApproved=1 and IsReturnFlight=0
order by Departure
go

CREATE proc [dbo].[CharterDARouteListPairFind] 
@Departure nvarchar(3)
as
select Distinct Arrival from CharterFlights where Departure =@Departure and DepartureDate>=Cast(getdate() as date) and IsApproved=1
order by Arrival
go

CREATE proc [dbo].[CharterFlightCumulatedJob]
as

DELETE FROM CharterFlightsCached
DECLARE @CharterGroupId uniqueidentifier
DECLARE @IsRoundTrip bit
declare @DeparturePort nvarchar(3)
declare @ArrivalPort nvarchar(3)
declare @IsApproveded bit
DECLARE  DistinctedCharters cursor  for 
select distinct  CharterGroupId,IsRoundTrip,IsApproved from CharterFlights with(nolock)
where  (CAST(DepartureDate AS DATETIME) + CAST(DepartureTime AS DATETIME))>GETDATE()
OPEN DistinctedCharters   
FETCH NEXT FROM DistinctedCharters INTO	@CharterGroupId,@IsRoundTrip,@IsApproveded
WHILE @@FETCH_STATUS = 0  	
BEGIN 	 

set @DeparturePort=(Select Top 1 Departure From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)
set @ArrivalPort=(Select Top 1 Arrival From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)

declare @DepartureCity nvarchar(100)=(Select Top 1 CityName from AirPorts with(nolock) where AirportCode=@DeparturePort)
declare @ArrivalCity nvarchar(100)=(Select Top 1 CityName from AirPorts with(nolock) where AirportCode=@ArrivalPort)

declare @DepartureCountry nvarchar(50)= (Select top 1 CountryName  From AirPorts with(nolock) where AirportCode=@DeparturePort)
declare @ArrivalCountry nvarchar(50)= (Select top 1 CountryName From AirPorts with(nolock) where AirportCode=@ArrivalPort)

declare @DepartureDate date=(Select Top 1 DepartureDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)
declare @DepartureTime time=(Select Top 1 DepartureTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)


declare @ArrivalDate date=(Select Top 1 ArrivalDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)
declare @ArrivalTime time=(Select Top 1 ArrivalTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)

declare @CarrierCode nvarchar(5) =(Select Top 1 CarrierCode From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
declare @FlightNumber nvarchar(10) =(Select Top 1 FlightNumber From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)

declare @StartTerminal nvarchar(20) =(Select Top 1 StartTerminal From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
declare @EndTerminal nvarchar(20) =(Select Top 1 EndTerminal From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)

declare @RTDepartureDate date=null
declare @RTDepartureTime time=null
declare @RTArrivalDate date=null
declare @RTArrivalTime time=null
declare @RTCarriercode nvarchar(5)
declare @RTFlightNumber nvarchar(10)
declare @RtStartTerminal nvarchar(20)
declare @RtEndTerminal nvarchar(20)

if(@IsRoundTrip=1)
BEGIN

set @RTDepartureDate =(Select Top 1 DepartureDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate desc)
set @RTDepartureTime =(Select Top 1 DepartureTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate desc)

set @RTArrivalDate =(Select Top 1 ArrivalDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate desc)
set @RTArrivalTime =(Select Top 1 ArrivalTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate desc)
  
set  @RTCarriercode =(Select Top 1 CarrierCode From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)
set  @RTFlightNumber =(Select Top 1 FlightNumber From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)

set @RtStartTerminal  =(Select Top 1 StartTerminal From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
set @RtEndTerminal  =(Select Top 1 EndTerminal From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)


END

declare @CharterPriceId uniqueidentifier =(Select Top 1  CharterPriceId from CharterPrices with(nolock) where  SeatCount>0 and CharterGroupId=@CharterGroupId order by BasePrice asc)

declare @Price decimal(18,4)= (Select  Top 1 (BasePrice+TaxPrice+ServicesPrice) from CharterPrices with(nolock) where  CharterPriceId=@CharterPriceId)
declare @CurrencyName nvarchar(3)=(select Top 1 CurrencyName from Currencies with(nolock) where CurrencyId=(Select Top 1 CurrencyId from CharterPrices where  CharterPriceId=@CharterPriceId))


declare @SeatCount int =(Select  Top 1 SeatCount from CharterPrices with(nolock) where  CharterPriceId=@CharterPriceId)

if(@CharterPriceId is not null)
begin
insert into CharterFlightsCached
(DeparturePort,
ArrivalPort,
DepartureCity,
ArrivalCity,
DepartureDate,
DepartureTime,
ArrivalDate,
ArrivalTime,
RTDepartureDate,
RTDepartureTime,
RTArrivalDate,
RTArrivalTime,
Price,
CurrencyName,
SeatCount,
DepartureCountry,
ArrivalCountry,
IsRoundTrip,
CharterGroupId,
CarrierCode,
FlightNumber,
RtCarrierCode,
RtFlightNumber,
StartTerminal,
EndTerminal,
RtStartTerminal,
RtEndTerminal,
IsApproveded)
values(
@DeparturePort,
@ArrivalPort,
@DepartureCity,
@ArrivalCity,
@DepartureDate,
@DepartureTime,
@ArrivalDate,
@ArrivalTime,
@RTDepartureDate,
@RTDepartureTime,
@RTArrivalDate,
@RTArrivalTime,
@Price,
@CurrencyName,
@SeatCount,
@DepartureCountry,
@ArrivalCountry,
@IsRoundTrip,
@CharterGroupId,
@CarrierCode,
@FlightNumber,
@RTCarrierCode,
@RTFlightNumber,
@StartTerminal,
@EndTerminal,
@RtStartTerminal,
@RtEndTerminal,
@IsApproveded)
end
FETCH NEXT FROM DistinctedCharters INTO	@CharterGroupId,@IsRoundTrip ,@IsApproveded
END


CLOSE DistinctedCharters   
DEALLOCATE DistinctedCharters
go

CREATE proc [dbo].[CharterFlightSearch]   
@Departure nvarchar(3),
@Arrival nvarchar(3),
@DepartureDate date,
@IsRoundTrip bit
as
 


if(@IsRoundTrip=0)
begin
select * from CharterFlights where IsRoundTrip=0 and Departure=@Departure and Arrival=@Arrival and DepartureDate=@DepartureDate  and IsApproved=1


end
else
begin

select * from CharterFlights  dp
where dp.DepartureDate=@DepartureDate and dp.Departure=@Departure and dp.Arrival=@Arrival and  dp.IsApproved=1 and dp.IsRoundTrip=1 



end
go

CREATE proc [dbo].[CharterFlightsAdd]
@CharterFlightId uniqueidentifier,
@Departure nvarchar(3), 
@Arrival nvarchar(3),
@StartTerminal nvarchar(50),
@EndTerminal nvarchar(50),
@DepartureDate DateTime,
@DepartureTime Time,
@ArrivalDate DateTime,
@ArrivalTime Time,
@CarrierCode nvarchar(3),
@FlightNumber nvarchar(50),
@Baggage nvarchar(50),
@CreationDate datetime,
@IsRoundTrip bit,
@IsApproved bit,
@NotValidAfter datetime,  
@ProviderId uniqueidentifier,
@CharterGroupId uniqueidentifier,
@IsReturnFlight bit,
@LogoFileName nvarchar(50)
as
insert into CharterFlights(CharterFlightId,Departure, Arrival,
StartTerminal,
EndTerminal,
 DepartureDate, DepartureTime, ArrivalDate, ArrivalTime, CarrierCode, FlightNumber, Baggage, CreationDate, IsRoundTrip,IsApproved, NotValidAfter,  ProviderId, CharterGroupId,IsReturnFlight,LogoFileName) values(@CharterFlightId,@Departure, @Arrival,
 @StartTerminal,
 @EndTerminal,
  @DepartureDate, 
  @DepartureTime, @ArrivalDate, @ArrivalTime, @CarrierCode, @FlightNumber, @Baggage, @CreationDate, @IsRoundTrip,@IsApproved, @NotValidAfter,  @ProviderId, @CharterGroupId,@IsReturnFlight,@LogoFileName)
go

CREATE proc [dbo].[CharterFlightsCumulated]     
 
 @IsApproved bit,
 @Departure nvarchar(3),
 @Arrival nvarchar(3)
 as
IF OBJECT_ID('tempdb..#TempCharter') IS NOT NULL DROP TABLE #TempCharter

create table #TempCharter
(
DeparturePort nvarchar(3),
ArrivalPort nvarchar(3),
DepartureCity nvarchar(500),
ArrivalCity  nvarchar(500),
DepartureDate date,
DepartureTime Time,
ArrivalDate date,
ArrivalTime time,
RtDepartureDate date,
RtDepartureTime time,
RtArrivalDate date,
RtArrivalTime time,
Price decimal(18,2),
CurrencyName nvarchar(3),
SeatCount int,
DepartureCountry nvarchar(50),
ArrivalCountry  nvarchar(50),
IsRoundTrip bit,
CharterGroupId uniqueidentifier,

CarrierCode nvarchar(5),
FlightNumber nvarchar(10),
RtCarrierCode nvarchar(5),
RtFlightNumber nvarchar(10),
StartTerminal nvarchar(20),
EndTerminal nvarchar(20),
RtStartTerminal nvarchar(20),
RtEndTerminal nvarchar(20)

)

DECLARE @CharterGroupId uniqueidentifier
DECLARE @IsRoundTrip bit
declare @DeparturePort nvarchar(3)
declare @ArrivalPort nvarchar(3)

DECLARE  DistinctedCharters cursor  for 
select distinct  CharterGroupId,IsRoundTrip from CharterFlights with(nolock)
where IsApproved= @IsApproved   and Departure=Isnull(@Departure,Departure) and Arrival=Isnull(@Arrival,Arrival)
  and (CAST(DepartureDate AS DATETIME) + CAST(DepartureTime AS DATETIME))>GETDATE()

OPEN DistinctedCharters   
FETCH NEXT FROM DistinctedCharters INTO	@CharterGroupId,@IsRoundTrip
WHILE @@FETCH_STATUS = 0  	
BEGIN 	 

set @DeparturePort=(Select Top 1 Departure From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)
set @ArrivalPort=(Select Top 1 Arrival From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)

declare @DepartureCity nvarchar(100)=(Select Top 1 CityName from AirPorts with(nolock) where AirportCode=@DeparturePort)
declare @ArrivalCity nvarchar(100)=(Select Top 1 CityName from AirPorts with(nolock) where AirportCode=@ArrivalPort)

declare @DepartureCountry nvarchar(50)= (Select top 1 CountryName  From AirPorts with(nolock) where CityName=@DepartureCity)
declare @ArrivalCountry nvarchar(50)= (Select top 1 CountryName From AirPorts with(nolock) where CityName=@ArrivalCity)

declare @DepartureDate date=(Select Top 1 DepartureDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)
declare @DepartureTime time=(Select Top 1 DepartureTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)


declare @ArrivalDate date=(Select Top 1 ArrivalDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)
declare @ArrivalTime time=(Select Top 1 ArrivalTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate asc)

declare @CarrierCode nvarchar(5) =(Select Top 1 CarrierCode From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
declare @FlightNumber nvarchar(10) =(Select Top 1 FlightNumber From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)

declare @StartTerminal nvarchar(20) =(Select Top 1 StartTerminal From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
declare @EndTerminal nvarchar(20) =(Select Top 1 EndTerminal From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)

declare @RTDepartureDate date=null
declare @RTDepartureTime time=null
declare @RTArrivalDate date=null
declare @RTArrivalTime time=null
declare @RTCarriercode nvarchar(5)
declare @RTFlightNumber nvarchar(10)
declare @RtStartTerminal nvarchar(20)
declare @RtEndTerminal nvarchar(20)

if(@IsRoundTrip=1)
BEGIN

 set @RTDepartureDate =(Select Top 1 DepartureDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate desc)
 set @RTDepartureTime =(Select Top 1 DepartureTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate desc)

 set @RTArrivalDate =(Select Top 1 ArrivalDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate desc)
 set @RTArrivalTime =(Select Top 1 ArrivalTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId order by DepartureDate desc)
  
 set  @RTCarriercode =(Select Top 1 CarrierCode From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)
  set  @RTFlightNumber =(Select Top 1 FlightNumber From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)

  set @RtStartTerminal  =(Select Top 1 StartTerminal From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
set @RtEndTerminal  =(Select Top 1 EndTerminal From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)


END

declare @CharterPriceId uniqueidentifier =(Select Top 1  CharterPriceId from CharterPrices with(nolock) where  SeatCount>0 and CharterGroupId=@CharterGroupId order by BasePrice asc)

declare @Price decimal(18,4)= (Select  Top 1 (BasePrice+TaxPrice+ServicesPrice) from CharterPrices with(nolock) where  CharterPriceId=@CharterPriceId)
declare @CurrencyName nvarchar(3)=(select Top 1 CurrencyName from Currencies with(nolock) where CurrencyId=(Select Top 1 CurrencyId from CharterPrices where  CharterPriceId=@CharterPriceId))


declare @SeatCount int =(Select  Top 1 SeatCount from CharterPrices with(nolock) where  CharterPriceId=@CharterPriceId)

if(@CharterPriceId is not null)
begin
insert into #TempCharter
(DeparturePort,ArrivalPort,DepartureCity,ArrivalCity,DepartureDate,DepartureTime,ArrivalDate,ArrivalTime,RTDepartureDate,RTDepartureTime,RTArrivalDate,RTArrivalTime,Price,CurrencyName,
SeatCount,DepartureCountry,ArrivalCountry,IsRoundTrip,CharterGroupId,CarrierCode,FlightNumber,RtCarrierCode,RtFlightNumber,StartTerminal,EndTerminal,RtStartTerminal,RtEndTerminal)
 values(@DeparturePort,@ArrivalPort,@DepartureCity,@ArrivalCity,@DepartureDate,@DepartureTime,@ArrivalDate,@ArrivalTime,@RTDepartureDate,@RTDepartureTime,@RTArrivalDate,@RTArrivalTime,@Price,@CurrencyName,@SeatCount,@DepartureCountry,@ArrivalCountry,@IsRoundTrip,@CharterGroupId,@CarrierCode,@FlightNumber,@RTCarrierCode,@RTFlightNumber,@StartTerminal,@EndTerminal,@RtStartTerminal,@RtEndTerminal)
end


FETCH NEXT FROM DistinctedCharters INTO	@CharterGroupId,@IsRoundTrip
END


CLOSE DistinctedCharters   
DEALLOCATE DistinctedCharters




 select * from #TempCharter with(nolock)
 order by DepartureDate asc
go

create proc [dbo].[CharterFlightsDelete]
@CharterFlightId uniqueidentifier
as
delete from CharterFlights
where CharterFlightId=@CharterFlightId
go

create proc [dbo].[CharterFlightsList]
as
select * from CharterFlights
go

create proc [dbo].[CharterFlightsListById]
@CharterFlightId uniqueidentifier
as
select * from CharterFlights
where CharterFlightId=@CharterFlightId
go

CREATE proc [dbo].[CharterFlightsManageCumulated] 
 
 @IsApproved bit,
 @StartDate date,
 @EndDate date,
 @ProviderId uniqueidentifier
 as
IF OBJECT_ID('tempdb..#TempCharter') IS NOT NULL DROP TABLE #TempCharter
 
create table #TempCharter
(
DeparturePort nvarchar(3),
ArrivalPort nvarchar(3),
DepartureCity nvarchar(500),
ArrivalCity  nvarchar(500),
DepartureDate date,
DepartureTime Time,
ArrivalDate date,
ArrivalTime time,
RtDepartureDate date,
RtDepartureTime time,
RtArrivalDate date,
RtArrivalTime time,
Price decimal(18,2),
CurrencyName nvarchar(3),
SeatCount int,
DepartureCountry nvarchar(50),
ArrivalCountry  nvarchar(50),
IsRoundTrip bit,
CharterGroupId uniqueidentifier,
IsApproved bit
)

DECLARE @CharterGroupId uniqueidentifier
DECLARE @IsRoundTrip bit
declare @DeparturePort nvarchar(3)
declare @ArrivalPort nvarchar(3)

DECLARE  DistinctedCharters cursor  for 
select distinct  CharterGroupId,IsRoundTrip from CharterFlights with(nolock)
where IsApproved= @IsApproved  and DepartureDate  between @StartDate and @EndDate and 
ProviderId=(case when @ProviderId = dbo.EmptyGuid() then ProviderId else @ProviderId end)
 


OPEN DistinctedCharters   
FETCH NEXT FROM DistinctedCharters INTO	@CharterGroupId,@IsRoundTrip
WHILE @@FETCH_STATUS = 0  	
BEGIN 	 

set @DeparturePort=(Select Top 1 Departure From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId  and IsReturnFlight=0)
set @ArrivalPort=(Select Top 1 Arrival From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)

declare @DepartureCity nvarchar(100)=(Select Top 1 CityName from AirPorts with(nolock) where AirportCode=@DeparturePort)
declare @ArrivalCity nvarchar(100)=(Select Top 1 CityName from AirPorts with(nolock) where AirportCode=@ArrivalPort)

declare @DepartureCountry nvarchar(50)= (Select top 1 CountryName  From AirPorts with(nolock) where CityName=@DepartureCity)
declare @ArrivalCountry nvarchar(50)= (Select top 1 CountryName From AirPorts with(nolock) where CityName=@ArrivalCity)

declare @DepartureDate date=(Select Top 1 DepartureDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
declare @DepartureTime time=(Select Top 1 DepartureTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)


declare @ArrivalDate date=(Select Top 1 ArrivalDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
declare @ArrivalTime time=(Select Top 1 ArrivalTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)


declare @RTDepartureDate date=null
declare @RTDepartureTime time=null
declare @RTArrivalDate date=null
declare @RTArrivalTime time=null

if(@IsRoundTrip=1)
BEGIN

 set @RTDepartureDate =(Select Top 1 DepartureDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)
 set @RTDepartureTime =(Select Top 1 DepartureTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)

 set @RTArrivalDate =(Select Top 1 ArrivalDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)
 set @RTArrivalTime =(Select Top 1 ArrivalTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)
  
END

declare @CharterPriceId uniqueidentifier =(Select Top 1  CharterPriceId from CharterPrices with(nolock) where  SeatCount>0 and CharterGroupId=@CharterGroupId order by BasePrice asc)

declare @Price decimal(18,4)= (Select  Top 1 (BasePrice+TaxPrice+ServicesPrice) from CharterPrices with(nolock) where  CharterPriceId=@CharterPriceId)
declare @CurrencyName nvarchar(3)=(select Top 1 CurrencyName from Currencies with(nolock) where CurrencyId=(Select Top 1 CurrencyId from CharterPrices where  CharterPriceId=@CharterPriceId))


declare @SeatCount int =(Select  Top 1 SeatCount from CharterPrices with(nolock) where  CharterPriceId=@CharterPriceId)

if(@CharterPriceId is not null)
begin
insert into #TempCharter
(DeparturePort,ArrivalPort,DepartureCity,ArrivalCity,DepartureDate,DepartureTime,ArrivalDate,ArrivalTime,RTDepartureDate,RTDepartureTime,RTArrivalDate,RTArrivalTime,Price,CurrencyName,
SeatCount,DepartureCountry,ArrivalCountry,IsRoundTrip,CharterGroupId,IsApproved)
 values(@DeparturePort,@ArrivalPort,@DepartureCity,@ArrivalCity,@DepartureDate,@DepartureTime,@ArrivalDate,@ArrivalTime,@RTDepartureDate,@RTDepartureTime,@RTArrivalDate,@RTArrivalTime,@Price,@CurrencyName,@SeatCount,@DepartureCountry,@ArrivalCountry,@IsRoundTrip,@CharterGroupId,@IsApproved)
end


FETCH NEXT FROM DistinctedCharters INTO	@CharterGroupId,@IsRoundTrip
END


CLOSE DistinctedCharters   
DEALLOCATE DistinctedCharters




 select * from #TempCharter with(nolock)
 order by DepartureDate asc
go

CREATE proc [dbo].[CharterFlightsManageCumulatedEvenSeatNotAvail]   
 
 @IsApproved bit,
 @StartDate date,
 @EndDate date,
 @ProviderId uniqueidentifier,
 @Departure nvarchar(3),
 @Arrival nvarchar(3),
 @IsRT bit
 as
IF OBJECT_ID('tempdb..#TempCharter') IS NOT NULL DROP TABLE #TempCharter
 
create table #TempCharter
(
DeparturePort nvarchar(3),
ArrivalPort nvarchar(3),
DepartureCity nvarchar(500),
ArrivalCity  nvarchar(500),
DepartureDate date,
DepartureTime Time,
ArrivalDate date,
ArrivalTime time,
RtDepartureDate date,
RtDepartureTime time,
RtArrivalDate date,
RtArrivalTime time,
Price decimal(18,2),
CurrencyName nvarchar(3),
SeatCount int,
DepartureCountry nvarchar(50),
ArrivalCountry  nvarchar(50),
IsRoundTrip bit,
CharterGroupId uniqueidentifier,
IsApproved bit,
AgencyId uniqueidentifier,
AgencyName nvarchar(max),
LogoFileName nvarchar(50)
)

DECLARE @CharterGroupId uniqueidentifier
DECLARE @IsRoundTrip bit
declare @DeparturePort nvarchar(3)
declare @ArrivalPort nvarchar(3)

DECLARE  DistinctedCharters cursor  for 
select distinct  CharterGroupId,IsRoundTrip from CharterFlights with(nolock)  where IsApproved= @IsApproved  and Departure =Isnull(@Departure,Departure) and Arrival=Isnull(@Arrival,Arrival) and DepartureDate between @StartDate and @EndDate and ProviderId=(case when @ProviderId = dbo.EmptyGuid() then ProviderId else @ProviderId end)
and IsRoundTrip=Isnull(@IsRt,IsRoundTrip)

 


OPEN DistinctedCharters   
FETCH NEXT FROM DistinctedCharters INTO	@CharterGroupId,@IsRoundTrip
WHILE @@FETCH_STATUS = 0  	
BEGIN 	 

set @DeparturePort=(Select Top 1 Departure From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId  and IsReturnFlight=0)
set @ArrivalPort=(Select Top 1 Arrival From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)

declare @DepartureCity nvarchar(100)=(Select Top 1 CityName from AirPorts with(nolock) where AirportCode=@DeparturePort)
declare @ArrivalCity nvarchar(100)=(Select Top 1 CityName from AirPorts with(nolock) where AirportCode=@ArrivalPort)

declare @DepartureCountry nvarchar(50)= (Select top 1 CountryName  From AirPorts with(nolock) where CityName=@DepartureCity)
declare @ArrivalCountry nvarchar(50)= (Select top 1 CountryName From AirPorts with(nolock) where CityName=@ArrivalCity)

declare @DepartureDate date=(Select Top 1 DepartureDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
declare @DepartureTime time=(Select Top 1 DepartureTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)


declare @ArrivalDate date=(Select Top 1 ArrivalDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)
declare @ArrivalTime time=(Select Top 1 ArrivalTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=0)


declare @RTDepartureDate date=null
declare @RTDepartureTime time=null
declare @RTArrivalDate date=null
declare @RTArrivalTime time=null

if(@IsRoundTrip=1)
BEGIN

 set @RTDepartureDate =(Select Top 1 DepartureDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)
 set @RTDepartureTime =(Select Top 1 DepartureTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)

 set @RTArrivalDate =(Select Top 1 ArrivalDate From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)
 set @RTArrivalTime =(Select Top 1 ArrivalTime From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId and IsReturnFlight=1)
  
END

declare @CharterPriceId uniqueidentifier =(Select Top 1  CharterPriceId from CharterPrices with(nolock) where  CharterGroupId=@CharterGroupId order by BasePrice asc)

declare @Price decimal(18,4)= (Select  Top 1 (BasePrice+TaxPrice+ServicesPrice) from CharterPrices with(nolock) where  CharterPriceId=@CharterPriceId)
declare @CurrencyName nvarchar(3)=(select Top 1 CurrencyName from Currencies with(nolock) where CurrencyId=(Select Top 1 CurrencyId from CharterPrices where  CharterPriceId=@CharterPriceId))


declare @SeatCount int =(Select  Top 1 SeatCount from CharterPrices with(nolock) where  CharterPriceId=@CharterPriceId)

declare @AgencyId uniqueidentifier =(Select Top 1  ProviderId from CharterFlights with(nolock) where  CharterGroupId=@CharterGroupId)
declare @AgencyName nvarchar(max) =(Select   AgencyName from  AgencyProfile with(nolock) where  AgencyId=@AgencyId)

declare @LogoFileName nvarchar(50) = (Select Top 1 LogoFileName From CharterFlights with(nolock) where CharterGroupId=@CharterGroupId)

if(@CharterPriceId is not null)
begin
insert into #TempCharter
(
DeparturePort,
ArrivalPort,
DepartureCity,
ArrivalCity,
DepartureDate,
DepartureTime,
ArrivalDate,
ArrivalTime,
RTDepartureDate,
RTDepartureTime,
RTArrivalDate,
RTArrivalTime,
Price,
CurrencyName,
SeatCount,
DepartureCountry,
ArrivalCountry,
IsRoundTrip,
CharterGroupId,
IsApproved,
AgencyId,
AgencyName,
LogoFileName)
values(@DeparturePort,
@ArrivalPort,
@DepartureCity,
@ArrivalCity,
@DepartureDate,
@DepartureTime,
@ArrivalDate,
@ArrivalTime,
@RTDepartureDate,
@RTDepartureTime,
@RTArrivalDate,
@RTArrivalTime,
@Price,
@CurrencyName,
@SeatCount,
@DepartureCountry,
@ArrivalCountry,
@IsRoundTrip,
@CharterGroupId,
@IsApproved,
@AgencyId,
@AgencyName,
@LogoFileName)
end
FETCH NEXT FROM DistinctedCharters INTO	@CharterGroupId,@IsRoundTrip
END
CLOSE DistinctedCharters   
DEALLOCATE DistinctedCharters

 select t.* from #TempCharter t with(nolock) 
 
  order by t.DepartureDate asc
go

create proc [dbo].[CharterFlightsOneItemByCharterGroupId]
@CharterGroupId uniqueidentifier
as
select * from CharterFlights where CharterGroupId=@CharterGroupId
go

CREATE proc [dbo].[CharterFlightsUpdate]
@CharterFlightId uniqueidentifier,
@Departure nvarchar(3),
@Arrival nvarchar(3),
@StartTerminal nvarchar(50),
@EndTerminal nvarchar(50),
@DepartureDate DateTime,
@DepartureTime Time, 
@ArrivalDate DateTime, 
@ArrivalTime Time, 
@CarrierCode nvarchar(3), 
@FlightNumber nvarchar(50), 
@Baggage nvarchar(50), 
@CreationDate datetime, 
@IsRoundTrip bit,
@IsApproved bit, 
@NotValidAfter datetime, 
@ProviderId uniqueidentifier, 
@CharterGroupId uniqueidentifier,
@IsReturnFlight bit,
@LogoFileName nvarchar(50)
as
update CharterFlights set Departure=@Departure, Arrival=@Arrival, 
StartTerminal=@StartTerminal,
EndTerminal=@EndTerminal,
DepartureDate=@DepartureDate, DepartureTime=@DepartureTime, ArrivalDate=@ArrivalDate, ArrivalTime=@ArrivalTime, CarrierCode=@CarrierCode, FlightNumber=@FlightNumber, Baggage=@Baggage, CreationDate=@CreationDate, IsRoundTrip=@IsRoundTrip,IsApproved=@IsApproved,
 NotValidAfter=@NotValidAfter, ProviderId=@ProviderId, CharterGroupId=@CharterGroupId,IsReturnFlight=@IsReturnFlight,LogoFileName=@LogoFileName
where CharterFlightId=@CharterFlightId
go

CREATE proc [dbo].[CharterPricesAdd]
@CharterPriceId uniqueidentifier, 
@ClassCode nvarchar(3), @TaxPrice decimal(18,2), @BasePrice decimal(18,2), @ServicesPrice decimal(18,2), @SeatCount int,  @CurrencyId int, @CharterGroupId uniqueidentifier
as
insert into CharterPrices(CharterPriceId,ClassCode, TaxPrice, BasePrice, ServicesPrice, SeatCount,  CurrencyId, CharterGroupId) values(@CharterPriceId,@ClassCode, @TaxPrice, @BasePrice, @ServicesPrice, @SeatCount,  @CurrencyId, @CharterGroupId)
go

create proc [dbo].[CharterPricesBySeatClass] 
@CharterGroupId uniqueidentifier,
@ClassCode nvarchar(5)
as
select * from CharterPrices where  ClassCode=@ClassCode and  CharterGroupId=@CharterGroupId
go

create proc [dbo].[CharterPricesBySeatClassAndPassengerCount] 
@CharterGroupId uniqueidentifier,
@ClassCode nvarchar(5),
@SeatCount int 
as
select * from CharterPrices 
where    ClassCode=@ClassCode
 and
 CharterGroupId=@CharterGroupId
 and SeatCount>=@SeatCount
go

create proc [dbo].[CharterPricesDelete]
@CharterPriceId uniqueidentifier
as
delete from CharterPrices
where CharterPriceId=@CharterPriceId
go

create proc [dbo].[CharterPricesDeleteByCharterGroupId]
@CharterGroupId uniqueidentifier
as
delete from CharterPrices where CharterGroupId=@CharterGroupId
go

create proc [dbo].[CharterPricesList]
as
select * from CharterPrices
go

CREATE proc [dbo].[CharterPricesListByCharterGroupId]
@CharterGroupId uniqueidentifier
as
select * from CharterPrices where CharterGroupId=@CharterGroupId
go

create proc [dbo].[CharterPricesListById]
@CharterPriceId uniqueidentifier
as
select * from CharterPrices
where CharterPriceId=@CharterPriceId
go

CREATE proc [dbo].[CharterPricesRollBack]
@TicketNumber nvarchar(50)
as
declare @PassengerId uniqueidentifier
declare @CharterPriceId uniqueidentifier 
declare  @PassengerType int

set @PassengerId=(select top 1 PassengerId from PassengersInfo where TicketNumber=@TicketNumber  and SupplierName='Charter')
set @PassengerType=(select top 1 PassengerType from PassengersInfo where TicketNumber=@TicketNumber  and SupplierName='Charter')
set @CharterPriceId =(Select  FareReferanceId from FlightPriceInfo where  PassengerId=@PassengerId)


if(@PassengerType<>3)
Begin
 update CharterPrices set SeatCount=(SeatCount + 1) where  CharterPriceId=@CharterPriceId
End
go

CREATE proc [dbo].[CharterPricesUpdate]
@CharterPriceId uniqueidentifier, @ClassCode nvarchar(3), @TaxPrice decimal(18,2), @BasePrice decimal(18,2), @ServicesPrice decimal(18,2), @SeatCount int,  @CurrencyId int, @CharterGroupId uniqueidentifier
as
update CharterPrices set ClassCode=@ClassCode, TaxPrice=@TaxPrice, BasePrice=@BasePrice, ServicesPrice=@ServicesPrice, SeatCount=@SeatCount,  CurrencyId=@CurrencyId, CharterGroupId=@CharterGroupId
where CharterPriceId=@CharterPriceId
go

create proc [dbo].[CharterSupplierEmailAdressByCharterGroupId]
@CharterGroupId uniqueidentifier
as
declare @ProviderId uniqueidentifier =(select  Top 1 ProviderId from CharterFlights where CharterGroupId=@CharterGroupId)
declare @UserId  uniqueidentifier =(select AgencyOwnerUserId from AgencyProfile  where AgencyId=@ProviderId)
select Email from AspNetUsers where Id=@UserId
go

create proc [dbo].[CitiesAdd]
@CountryId int, @CityName nvarchar(255)
as
insert into Cities(CountryId, CityName) values(@CountryId, @CityName)
go

create proc [dbo].[CitiesDelete]
@CityId int
as
delete from Cities
where CityId=@CityId
go

create proc [dbo].[CitiesList]
as
select * from Cities
go

create proc [dbo].[CitiesListByCountryId]
@CountryId int
as
select * from  Cities where CountryId=@CountryId
order by CityName
go

create proc [dbo].[CitiesListById]
@CityId int
as
select * from Cities
where CityId=@CityId
go

create proc [dbo].[CitiesUpdate]
@CityId int, @CountryId int, @CityName nvarchar(255)
as
update Cities set CountryId=@CountryId, CityName=@CityName
where CityId=@CityId
go

Create Proc CollectiveManuelTicketAdd
@Id uniqueidentifier,
@AirwayId uniqueidentifier,
@UserId uniqueidentifier,
@FileExtension nvarchar(10),
@CreationDate datetime
as
INSERT INTO CollectiveManuelTicket(
Id,
AirwayId,
UserId,
FileExtension,
CreationDate
)
VALUES
(
@Id,
@AirwayId,
@UserId,
@FileExtension,
@CreationDate
)
go

Create Proc CollectiveManuelTicketDelete
@Id uniqueidentifier
AS
DELETE  FROM CollectiveManuelTicket
WHERE Id=@Id
go

CREATE Proc CollectiveManuelTicketDetailAdd
@Id uniqueidentifier,
@CollectiveManuelTicketId uniqueidentifier,
@AgencyId uniqueidentifier = null,
@AirWayId uniqueidentifier = null,
@CurrencyId int = null,
@CreationDate datetime = null,
@PnrNumber nvarchar(10) = null,
@IsDomestic bit = null,
@CarrierCode nvarchar(5) = null,
@PassengerType int = null,
@GenderType int = null,
@Name nvarchar(50) = null,
@Surname nvarchar(50) = null,
@PassportNumber nvarchar(50) = null,
@CitizenNumber nvarchar(50) = null,
@DateOfBirth datetime = null,
@TicketNumber nvarchar(50) = null,
@PhoneNumber nvarchar(50) = null,
@Email nvarchar(254) = null,
@BasePrice decimal(18,9) = null,
@TaxPrice decimal(18,9) = null,
@VqPrice decimal(18,9) = null,
@SecretServicePrice decimal(18,9) = null,
@ServicePrice decimal(18,9) = null,
@AgencyCommissionPrice decimal(18,9) = null,
@ExtraCommissionPrice decimal(18,9) = null,
@TaxIdentifier nvarchar(100) = null,
@TaxOffice nvarchar(100) = null,
@InvoiceAddress nvarchar(500) = null,
@Status int = null,
@Reason nvarchar(500) = null,
@Type int = null,
@TransactionPrice decimal(18,9) = null,
@TransactionOwnerUserId uniqueidentifier = null,
@FlightData nvarchar(max) = null,
@Notes nvarchar(1000) = null,
@IsManuelPaid bit = null
as
INSERT INTO CollectiveManuelTicketDetail(
Id,
CollectiveManuelTicketId,
AgencyId,
AirWayId,
CurrencyId,
CreationDate,
PnrNumber,
IsDomestic,
CarrierCode,
PassengerType,
GenderType,
Name,
Surname,
PassportNumber,
CitizenNumber,
DateOfBirth,
TicketNumber,
PhoneNumber,
Email,
BasePrice,
TaxPrice,
VqPrice,
SecretServicePrice,
ServicePrice,
AgencyCommissionPrice,
ExtraCommissionPrice,
TaxIdentifier,
TaxOffice,
InvoiceAddress,
Status,
Reason,
Type,
TransactionPrice,
TransactionOwnerUserId,
FlightData,
Notes,
IsManuelPaid
)
VALUES
(
@Id,
@CollectiveManuelTicketId,
@AgencyId,
@AirWayId,
@CurrencyId,
@CreationDate,
@PnrNumber,
@IsDomestic,
@CarrierCode,
@PassengerType,
@GenderType,
@Name,
@Surname,
@PassportNumber,
@CitizenNumber,
@DateOfBirth,
@TicketNumber,
@PhoneNumber,
@Email,
@BasePrice,
@TaxPrice,
@VqPrice,
@SecretServicePrice,
@ServicePrice,
@AgencyCommissionPrice,
@ExtraCommissionPrice,
@TaxIdentifier,
@TaxOffice,
@InvoiceAddress,
@Status,
@Reason,
@Type,
@TransactionPrice,
@TransactionOwnerUserId,
@FlightData,
@Notes,
@IsManuelPaid
)
go

Create Proc CollectiveManuelTicketDetailDelete
@Id uniqueidentifier
AS
DELETE  FROM CollectiveManuelTicketDetail
WHERE Id=@Id
go

Create Proc CollectiveManuelTicketDetailList
as
SELECT * FROM CollectiveManuelTicketDetail order by CreationDate desc
go

Create Proc CollectiveManuelTicketDetailListByCollectiveManuelTicketId
@CollectiveManuelTicketId uniqueidentifier
AS
SELECT * FROM CollectiveManuelTicketDetail
WHERE CollectiveManuelTicketId=@CollectiveManuelTicketId order by CreationDate desc
go

Create Proc CollectiveManuelTicketDetailListById
@Id uniqueidentifier
AS
SELECT * FROM CollectiveManuelTicketDetail
WHERE Id=@Id
go

CREATE Proc CollectiveManuelTicketDetailUpdate
@Id uniqueidentifier,
@CollectiveManuelTicketId uniqueidentifier,
@AgencyId uniqueidentifier = null,
@AirWayId uniqueidentifier = null,
@CurrencyId int = null,
@CreationDate datetime = null,
@PnrNumber nvarchar(10) = null,
@IsDomestic bit = null,
@CarrierCode nvarchar(5) = null,
@PassengerType int = null,
@GenderType int = null,
@Name nvarchar(50) = null,
@Surname nvarchar(50) = null,
@PassportNumber nvarchar(50) = null,
@CitizenNumber nvarchar(50) = null,
@DateOfBirth datetime = null,
@TicketNumber nvarchar(50) = null,
@PhoneNumber nvarchar(50) = null,
@Email nvarchar(254) = null,
@BasePrice decimal(18,9) = null,
@TaxPrice decimal(18,9) = null,
@VqPrice decimal(18,9) = null,
@SecretServicePrice decimal(18,9) = null,
@ServicePrice decimal(18,9) = null,
@AgencyCommissionPrice decimal(18,9) = null,
@ExtraCommissionPrice decimal(18,9) = null,
@TaxIdentifier nvarchar(100) = null,
@TaxOffice nvarchar(100) = null,
@InvoiceAddress nvarchar(500) = null,
@Status int = null,
@Reason nvarchar(500) = null,
@Type int = null,
@TransactionPrice decimal(18,9) = null,
@TransactionOwnerUserId  uniqueidentifier = null,
@FlightData nvarchar(max) = null,
@Notes nvarchar(1000) = null,
@IsManuelPaid bit = null
AS
UPDATE CollectiveManuelTicketDetail
SET
Id=@Id,
CollectiveManuelTicketId=@CollectiveManuelTicketId,
AgencyId=@AgencyId,
AirWayId=@AirWayId,
CurrencyId=@CurrencyId,
CreationDate=@CreationDate,
PnrNumber=@PnrNumber,
IsDomestic=@IsDomestic,
CarrierCode=@CarrierCode,
PassengerType=@PassengerType,
GenderType=@GenderType,
Name=@Name,
Surname=@Surname,
PassportNumber=@PassportNumber,
CitizenNumber=@CitizenNumber,
DateOfBirth=@DateOfBirth,
TicketNumber=@TicketNumber,
PhoneNumber=@PhoneNumber,
Email=@Email,
BasePrice=@BasePrice,
TaxPrice=@TaxPrice,
VqPrice=@VqPrice,
SecretServicePrice=@SecretServicePrice,
ServicePrice=@ServicePrice,
AgencyCommissionPrice=@AgencyCommissionPrice,
ExtraCommissionPrice=@ExtraCommissionPrice,
TaxIdentifier=@TaxIdentifier,
TaxOffice=@TaxOffice,
InvoiceAddress=@InvoiceAddress,
Status = @Status,
Reason = @Reason,
Type = @Type,
TransactionPrice = @TransactionPrice,
TransactionOwnerUserId = @TransactionOwnerUserId,
FlightData = @FlightData,
Notes = @Notes,
IsManuelPaid = @IsManuelPaid
WHERE Id=@Id
go

Create Proc CollectiveManuelTicketList
as
SELECT * FROM CollectiveManuelTicket order by CreationDate desc
go

Create Proc CollectiveManuelTicketListById
@Id uniqueidentifier
AS
SELECT * FROM CollectiveManuelTicket
WHERE Id=@Id
go

Create Proc CollectiveManuelTicketUpdate
@Id uniqueidentifier,
@AirwayId uniqueidentifier,
@UserId uniqueidentifier,
@FileExtension nvarchar(10),
@CreationDate datetime
AS
UPDATE CollectiveManuelTicket
SET
Id=@Id,
AirwayId=@AirwayId,
UserId=@UserId,
FileExtension=@FileExtension,
CreationDate=@CreationDate
WHERE Id=@Id
go

CREATE proc [dbo].[CommissionInvoiceAdd]
	@CommissionInvoiceId uniqueidentifier,
	@AgencyId uniqueidentifier,
	@ProductType nvarchar(10),
	@IsDomestic bit,
	@Description nvarchar(100),
	@Name nvarchar(100),
	@TotalAmount decimal,
	@Currency nvarchar(10),
	@InvoiceDate datetime,
	@LastTicketDate datetime,
	@InvoiceNumber nvarchar(50),
	@IsGeneratedInvoice bit,
	@CreatedBy nvarchar(128),
	@CreationDate datetime,
	@CommissionInvoiceType int, 
	@ParentAgencyId uniqueidentifier null
as

declare @CalculatedAmount decimal(18,2)

declare @temp_reservation_list TABLE
(
	ReservationId uniqueidentifier NOT NULL
);

insert into @temp_reservation_list(ReservationId)
select distinct( r.ReservationId)
from dbo.PassengersInfo AS p 
INNER JOIN dbo.FlightPriceInfo AS pr ON pr.PassengerId = p.PassengerId 
LEFT OUTER JOIN dbo.FlightsInfo AS f ON f.ReservationId = p.ReservationId 
LEFT OUTER JOIN dbo.Reservations AS r ON r.ReservationId = p.ReservationId
LEFT OUTER JOIN dbo.FareStatuList AS s ON s.FareStatuId = pr.FareStatus
WHERE 
	(f.FlightIndex = 0) 
	and r.AgencyId = @AgencyId
    and (@CommissionInvoiceType	= 1 or   r.IsDomestic = @IsDomestic)
	and cast(r.CreationDate as date) <=  cast(@LastTicketDate as date)
	and s.EnumEqual = 'Ticket'
	and not exists (select * from CommissionInvoiceDetails cid where cid.ReservationId = r.ReservationId)

select @CalculatedAmount = sum(pr.TotalPrice + pr.ExtraCommisson)
from dbo.PassengersInfo AS p 
INNER JOIN dbo.FlightPriceInfo AS pr ON pr.PassengerId = p.PassengerId 
LEFT OUTER JOIN dbo.Reservations AS r ON r.ReservationId = p.ReservationId
LEFT OUTER JOIN dbo.FareStatuList AS s ON s.FareStatuId = pr.FareStatus
WHERE 
	 r.AgencyId = @AgencyId
	and (@CommissionInvoiceType	= 1 or r.IsDomestic = @IsDomestic)
	and cast(r.CreationDate as date) <=  cast(@LastTicketDate as date)
	and s.EnumEqual = 'Ticket'
	and not exists (select * from CommissionInvoiceDetails cid where cid.ReservationId = r.ReservationId)


if(select count(*) from @temp_reservation_list) > 0
begin
	insert into CommissionInvoice(CommissionInvoiceId, AgencyId, ProductType, IsDomestic, Description, Name, TotalAmount, Currency, InvoiceDate, LastTicketDate, InvoiceNumber, IsGeneratedInvoice, CreatedBY, CreationDate, CommissionInvoiceType, ParentAgencyId) 
	values(@CommissionInvoiceId, @AgencyId, @ProductType, @IsDomestic, @Description, @Name, @CalculatedAmount, @Currency, @InvoiceDate, @LastTicketDate, @InvoiceNumber, @IsGeneratedInvoice, @CreatedBy, @CreationDate, @CommissionInvoiceType, @ParentAgencyId)

	insert into dbo.CommissionInvoiceDetails
	select @CommissionInvoiceId, ReservationId
	from @temp_reservation_list
end
go

CREATE proc [dbo].[CommissionInvoiceAddByReservationDetail]
	@CommissionInvoiceId uniqueidentifier,
	@AgencyId uniqueidentifier,
	@ProductType nvarchar(10),
	@IsDomestic bit,
	@Description nvarchar(100),
	@Name nvarchar(100),
	@TotalAmount decimal,
	@Currency nvarchar(10),
	@InvoiceDate datetime,
	@LastTicketDate datetime,
	@InvoiceNumber nvarchar(50),
	@IsGeneratedInvoice bit,
	@CreatedBy nvarchar(128),
	@CreationDate datetime,
	@CommissionInvoiceType int, 
	@ParentAgencyId uniqueidentifier null
as

declare @CalculatedAmount decimal(18,2)

declare @temp_reservation_list TABLE
(
	ReservationId uniqueidentifier NOT NULL
);

insert into @temp_reservation_list(ReservationId)
select distinct( r.ReservationId)
from dbo.PassengersInfo AS p 
INNER JOIN dbo.FlightPriceInfo AS pr ON pr.PassengerId = p.PassengerId 
LEFT OUTER JOIN dbo.FlightsInfo AS f ON f.ReservationId = p.ReservationId 
LEFT OUTER JOIN dbo.Reservations AS r ON r.ReservationId = p.ReservationId
LEFT OUTER JOIN dbo.FareStatuList AS s ON s.FareStatuId = pr.FareStatus
WHERE 
	(f.FlightIndex = 0) 
	and r.AgencyId = @AgencyId
	and r.IsDomestic = @IsDomestic
	and cast(r.CreationDate as date) <=  cast(@LastTicketDate as date)
	and s.EnumEqual = 'Ticket'
	and not exists (select * from CommissionInvoiceDetails cid where cid.ReservationId = r.ReservationId)

select @CalculatedAmount = sum(pr.AgencyCommission + pr.ExtraCommisson)
from dbo.PassengersInfo AS p 
INNER JOIN dbo.FlightPriceInfo AS pr ON pr.PassengerId = p.PassengerId 
LEFT OUTER JOIN dbo.Reservations AS r ON r.ReservationId = p.ReservationId
LEFT OUTER JOIN dbo.FareStatuList AS s ON s.FareStatuId = pr.FareStatus
WHERE 
	 r.AgencyId = @AgencyId
	and r.IsDomestic = @IsDomestic
	and cast(r.CreationDate as date) <=  cast(@LastTicketDate as date)
	and s.EnumEqual = 'Ticket'
	and not exists (select * from CommissionInvoiceDetails cid where cid.ReservationId = r.ReservationId)


if(select count(*) from @temp_reservation_list) > 0
begin
	insert into CommissionInvoice(CommissionInvoiceId, AgencyId, ProductType, IsDomestic, Description, Name, TotalAmount, Currency, InvoiceDate, LastTicketDate, InvoiceNumber, IsGeneratedInvoice, CreatedBY, CreationDate, CommissionInvoiceType, ParentAgencyId) 
	values(@CommissionInvoiceId, @AgencyId, @ProductType, @IsDomestic, @Description, @Name, @CalculatedAmount, @Currency, @InvoiceDate, @LastTicketDate, @InvoiceNumber, @IsGeneratedInvoice, @CreatedBy, @CreationDate, @CommissionInvoiceType, @ParentAgencyId)

	insert into dbo.CommissionInvoiceDetails
	select @CommissionInvoiceId, ReservationId
	from @temp_reservation_list
end
go

create proc [dbo].[CommissionInvoiceDetailsByCommissionId]
    @CommissionInvoiceId uniqueidentifier
as
select ReservationId
from CommissionInvoiceDetails
where CommissionInvoiceId = @CommissionInvoiceId
go

CREATE proc [dbo].[CommissionInvoiceIsValidDate]
	@LastTicketDate datetime,
	@AgencyId uniqueidentifier,
	@IsDomestic bit
as
select count(*) as ValidCount from CommissionInvoice
where
	CommissionInvoiceType = 0
	and AgencyId = @AgencyId 
	and IsDomestic = @IsDomestic
	and LastTicketDate >= @LastTicketDate
go

CREATE proc [dbo].[CommissionInvoiceListByFilters] 
    @AgencyId uniqueidentifier =null,
    @Product nvarchar(100)=null,
    @StartDate date,
    @EndDate date,
	@ByaAgencyId uniqueidentifier = null,
	@CorporateAgencyId uniqueidentifier = null,
	@CommissionInvoiceType int = null
as

select * 
from CommissionInvoice
where 
	((@CommissionInvoiceType is null and CommissionInvoiceType = 0) or (@CommissionInvoiceType is not null and CommissionInvoiceType = @CommissionInvoiceType ))
	
    and (@AgencyId is null or AgencyId = @AgencyId)
    and (@Product is null or ProductType = @Product)
	and cast(InvoiceDate as date) >= cast( @StartDate as date) 
	and cast(InvoiceDate as date) <= cast(@EndDate as date)
	and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
	and (@CorporateAgencyId is null or ParentAgencyId = @CorporateAgencyId)
go

create proc [dbo].[CommissionInvoiceListById]
    @CommissionInvoiceId uniqueidentifier
as
select * 
from CommissionInvoice
where CommissionInvoiceId = @CommissionInvoiceId
go

CREATE proc [dbo].[CommissionInvoiceTotalCurrentAmount]
	@CommissionInvoiceId uniqueidentifier
as

select sum(fpi.TotalPrice) as TotalAmount
from dbo.CommissionInvoiceDetails cid
inner join Reservations r on r.ReservationId = cid.ReservationId
inner join FlightPriceInfo fpi on fpi.ReservationId = r.ReservationId
left outer join dbo.FlightsInfo f on f.ReservationId = r.ReservationId
LEFT OUTER JOIN dbo.FareStatuList AS s ON s.FareStatuId = fpi.FareStatus
where 
	cid.CommissionInvoiceId = @CommissionInvoiceId
	and s.EnumEqual = 'Ticket'
go

CREATE proc [dbo].[CommissionInvoiceUpdate]
	@CommissionInvoiceId uniqueidentifier,
	@AgencyId uniqueidentifier,
	@ProductType nvarchar(10),
	@IsDomestic bit,
	@Description nvarchar(1000),
	@Name nvarchar(100),
	@TotalAmount decimal,
	@Currency nvarchar(10),
	@InvoiceDate datetime,
	@LastTicketDate datetime,
	@InvoiceNumber nvarchar(50),
	@IsGeneratedInvoice bit,
	@GeneratedInvoiceDate datetime,
	@CreatedBy nvarchar(128),
	@CreationDate datetime,
	@CommissionInvoiceType int,
	@ParentAgencyId uniqueidentifier null
as
update CommissionInvoice 
set 
    AgencyId = @AgencyId,
	ProductType = @ProductType,
	IsDomestic = @IsDomestic,
	Description = @Description,
	Name = @Name,
	TotalAmount = @TotalAmount,
	Currency = @Currency,
	InvoiceDate = @InvoiceDate,
	LastTicketDate = @LastTicketDate,
	InvoiceNumber = @InvoiceNumber,
	IsGeneratedInvoice = @IsGeneratedInvoice,
	GeneratedInvoiceDate = @GeneratedInvoiceDate,
	CreatedBy = @CreatedBy,
	CreationDate = @CreationDate,
	CommissionInvoiceType = @CommissionInvoiceType,
	ParentAgencyId = @ParentAgencyId
 where CommissionInvoiceId = @CommissionInvoiceId
go

create proc [dbo].[CommissionInvoiceoListById]
    @CommissionInvoiceId uniqueidentifier
as
select * 
from CommissionInvoice
where CommissionInvoiceId = @CommissionInvoiceId
go

CREATE proc [dbo].[CommissionTicketDetailListByCommissionId]
    @CommissionInvoiceId uniqueidentifier
as
select  
	substring((select ' ' + p.TicketNumber as 'data()' from dbo.PassengersInfo p where p.ReservationId = cid.ReservationId for xml path('')), 2 , 13) as TicketNumbers,
	r.PnrNumber as Pnr,
	r.SupplierName as Provider,
	(select top 1 fio.Arrival from FlightsInfo fio where fio.ReservationId = r.ReservationId  ) as Arrival,
	(select top 1 fio.Departure from FlightsInfo fio where fio.ReservationId = r.ReservationId  ) as Departure,
	(select top 1 fio.DepartureDate from FlightsInfo fio where fio.ReservationId = r.ReservationId  ) as TicketDate,
	(select sum(fpi.AgencyCommission + fpi.ExtraCommisson) from FlightPriceInfo fpi where fpi.ReservationId = cid.ReservationId) as Amount
from CommissionInvoiceDetails cid
inner join Reservations r on r.ReservationId = cid.ReservationId
where cid.CommissionInvoiceId = @CommissionInvoiceId
go

CREATE proc [dbo].[CommissionTicketDetailListByCorporateAgency]
    @CommissionInvoiceId uniqueidentifier
as
select  
	substring((select ' ' + p.TicketNumber as 'data()' from dbo.PassengersInfo p where p.ReservationId = cid.ReservationId for xml path('')), 2 , 13) as TicketNumbers,
	r.PnrNumber as Pnr,
	r.SupplierName as Provider,
	(select top 1 fio.Arrival from FlightsInfo fio where fio.ReservationId = r.ReservationId  ) as Arrival,
	(select top 1 fio.Departure from FlightsInfo fio where fio.ReservationId = r.ReservationId  ) as Departure,
	(select top 1 fio.DepartureDate from FlightsInfo fio where fio.ReservationId = r.ReservationId  ) as TicketDate,
	(select sum(fpi.TotalPrice + fpi.ExtraCommisson) from FlightPriceInfo fpi where fpi.ReservationId = cid.ReservationId) as Amount
from CommissionInvoiceDetails cid
inner join Reservations r on r.ReservationId = cid.ReservationId
where cid.CommissionInvoiceId = @CommissionInvoiceId
go

CREATE proc [dbo].[CorporateInvoiceTotalAmount]
	@CorporateAgencyId uniqueidentifier
as

select sum(TotalAmount) as TotalAmount
from dbo.CommissionInvoice
where AgencyId = @CorporateAgencyId and CommissionInvoiceType = 1
go

create proc [dbo].[CountriesAdd]
@CountryName nvarchar(255), @CountryNameEnglish nvarchar(255), @Status bit, @ProcessOrder int, @TwoLetterCode nchar(2)
as
insert into Countries(CountryName, CountryNameEnglish, Status, ProcessOrder, TwoLetterCode) values(@CountryName, @CountryNameEnglish, @Status, @ProcessOrder, @TwoLetterCode)
go

create proc [dbo].[CountriesDelete]
@CountryId int
as
delete from Countries
where CountryId=@CountryId
go

create proc [dbo].[CountriesList]
as
select * from Countries
go

create proc [dbo].[CountriesListById]
@CountryId int
as
select * from Countries
where CountryId=@CountryId
go

create proc [dbo].[CountriesUpdate]
@CountryId int, @CountryName nvarchar(255), @CountryNameEnglish nvarchar(255), @Status bit, @ProcessOrder int, @TwoLetterCode nchar(2)
as
update Countries set CountryName=@CountryName, CountryNameEnglish=@CountryNameEnglish, Status=@Status, ProcessOrder=@ProcessOrder, TwoLetterCode=@TwoLetterCode
where CountryId=@CountryId
go

CREATE Proc [dbo].[CreditCardInfoAdd]
   @AgencyId uniqueidentifier,
   @BankId uniqueidentifier,
   @LongName varchar(150),
   @CardNumber varchar(16),
   @SecretCreditCard varchar(16)

AS
INSERT INTO CreditCardInfo
(
	AgencyId,
	BankId,
	LongName,
	CardNumber,
	SecretCreditCard	
)
VALUES
(
	@AgencyId,
	@BankId,
	@LongName,
	@CardNumber,
	@SecretCreditCard
);
go

CREATE Proc [dbo].[CreditCardInfoDelete] @CardNumber varchar(16)
AS
DELETE 
FROM CreditCardInfo
WHERE CardNumber=@CardNumber;
go

CREATE Proc [dbo].[CreditCardInfoList]
AS
SELECT *
FROM CreditCardInfo
go

CREATE Proc [dbo].[CreditCardInfoListByAgencyId] @AgencyId uniqueidentifier
AS
SELECT *
FROM CreditCardInfo
WHERE AgencyId=@AgencyId
go

CREATE Proc [dbo].[CreditCardInfoOneItem] @CardNumber varchar(16)
AS
SELECT *
FROM CreditCardInfo
WHERE CardNumber=@CardNumber;
go

CREATE PROC [dbo].[CreditCardListByFilters]
   @Agency uniqueidentifier=null,
   @BankId uniqueidentifier=null,
   @LongName varchar(150)=null
AS
BEGIN
	IF @Agency IS NOT NULL AND @BankId IS NOT NULL AND @LongName IS NOT NULL
	BEGIN
	   SELECT * FROM CreditCardInfo WHERE (AgencyId=@Agency AND BankId=@BankId AND LongName=@LongName) ORDER BY LongName DESC
	END
	ELSE IF @Agency IS NOT NULL AND @BankId IS NOT NULL AND @LongName IS NULL
	BEGIN
	   SELECT * FROM CreditCardInfo WHERE (AgencyId=@Agency AND BankId=@BankId) ORDER BY LongName DESC
	END
	ELSE IF @Agency IS NOT NULL AND @BankId IS NULL AND @LongName IS NOT NULL
	BEGIN
	   SELECT * FROM CreditCardInfo WHERE (AgencyId=@Agency AND LongName=@LongName) ORDER BY LongName DESC
	END
	ELSE IF @Agency IS NOT NULL AND @BankId IS NULL AND @LongName IS NULL
	BEGIN
		SELECT * FROM CreditCardInfo WHERE (AgencyId=@Agency) ORDER BY LongName DESC
	END
	ELSE IF @Agency IS NULL AND @BankId IS NOT NULL AND @LongName IS NULL
	BEGIN
	    SELECT * FROM CreditCardInfo WHERE (BankId=@BankId) ORDER BY LongName DESC 
	END
	ELSE IF @Agency IS NULL AND @BankId IS NOT NULL AND @LongName IS NOT NULL
	BEGIN 
		SELECT * FRom CreditCardInfo WHERE (BankId=@BankId AND LongName=@LongName) ORDER BY LongName DESC
	END
	ELSE
	BEGIN
		SELECT * FROM CreditCardInfo WHERE (LongName=@LongName) ORDER BY LongName DESC
	END
END
go

CREATE proc [dbo].[CurrenciesAdd]
@CurrencyName nvarchar(50), @OrderProcess int, @CurrencyCode nvarchar(3)
as
insert into Currencies(CurrencyName, OrderProcess, CurrencyCode) values(@CurrencyName, @OrderProcess, @CurrencyCode)
go

create proc [dbo].[CurrenciesDelete]
@CurrencyId int
as
delete from Currencies
where CurrencyId=@CurrencyId
go

create proc [dbo].[CurrenciesList]
as
select * from Currencies
go

create proc [dbo].[CurrenciesListById]
@CurrencyId int
as
select * from Currencies
where CurrencyId=@CurrencyId
go

create proc [dbo].[CurrenciesOneItemByCurrencyName]
@CurrencyName nvarchar(3)
as
select * from Currencies where CurrencyName=@CurrencyName
go

CREATE proc [dbo].[CurrenciesUpdate]
@CurrencyId int, @CurrencyName nvarchar(50), @OrderProcess int, @CurrencyCode nvarchar(3)
as
update Currencies set CurrencyName=@CurrencyName, OrderProcess=@OrderProcess, CurrencyCode=@CurrencyCode
where CurrencyId=@CurrencyId
go

CREATE FUNCTION  [dbo].[CurrencyName]
(
	
	@CurrencyId int
)
RETURNS  nvarchar(3)
AS
BEGIN
	 
	 return (Select CurrencyName from Currencies where CurrencyId=@CurrencyId)

END
go

Create Proc [dbo].[CustomersInfoAdd] @CustomerId uniqueidentifier,
                             @AgencyId uniqueidentifier,
                             @Name nvarchar(50),
                             @SurName nvarchar(50),
                             @PassengerType int,
                             @Gender int,
                             @GsmArea nvarchar(5),
                             @GsmNumber nvarchar(25),
                             @BirthDate DateTime,
                             @EmailAdress nvarchar(50),
                             @NeedWheelChair int,
                             @PhoneArea nvarchar(5),
                             @PhoneNumber nvarchar(50),
                             @CitizenNumber nvarchar(11),
                             @PassportSerialNumber nvarchar(10),
                             @PassportNumber nvarchar(50),
                             @PassportEndDate DateTime,
                             @PassportCountry nvarchar(5),
                             @CompanyName nvarchar(250),
                             @TaxOffice nvarchar(50),
                             @TaxNumber nvarchar(50),
                             @ZipCode nvarchar(50),
                             @Adress nvarchar(500),
                             @City nvarchar(500),
                             @Country nvarchar(50),
                             @CreationDate datetime
as
INSERT INTO CustomersInfo(CustomerId,
                          AgencyId,
                          Name,
                          SurName,
                          PassengerType,
                          Gender,
                          GsmArea,
                          GsmNumber,
                          BirthDate,
                          EmailAdress,
                          NeedWheelChair,
                          PhoneArea,
                          PhoneNumber,
                          CitizenNumber,
                          PassportSerialNumber,
                          PassportNumber,
                          PassportEndDate,
                          PassportCountry,
                          CompanyName,
                          TaxOffice,
                          TaxNumber,
                          ZipCode,
                          Adress,
                          City,
                          Country,
                          CreationDate)
VALUES (@CustomerId,
        @AgencyId,
        @Name,
        @SurName,
        @PassengerType,
        @Gender,
        @GsmArea,
        @GsmNumber,
        @BirthDate,
        @EmailAdress,
        @NeedWheelChair,
        @PhoneArea,
        @PhoneNumber,
        @CitizenNumber,
        @PassportSerialNumber,
        @PassportNumber,
        @PassportEndDate,
        @PassportCountry,
        @CompanyName,
        @TaxOffice,
        @TaxNumber,
        @ZipCode,
        @Adress,
        @City,
        @Country,
        @CreationDate);
go

Create Proc [dbo].[CustomersInfoDelete] @CustomerId uniqueidentifier
AS
DELETE
FROM CustomersInfo
WHERE CustomerId = @CustomerId;
go

Create Proc [dbo].[CustomersInfoList]
as
SELECT *
FROM CustomersInfo;
go

CREATE Proc CustomersInfoListByCitizenNumber @CitizenNumber nvarchar(11), @AgencyId uniqueidentifier
AS
SELECT *
FROM CustomersInfo
WHERE CitizenNumber = @CitizenNumber and AgencyId = @AgencyId;
go

CREATE proc [dbo].[CustomersInfoListByFilters]
	@AgencyId uniqueidentifier = null,
	@Name nvarchar(50) = null,
	@SurName nvarchar(50) = null,
	@GsmNumber nvarchar(25) = null,
	@EmailAdress nvarchar(50) = null,
	@CitizenNumber nvarchar(11) = null,
	@PassportNumber nvarchar(50) = null
as
select ci.*,
	(case when agp.IsAgencyCompany = 1 then (select top 1
		sagp.AgencyName
	from AgencyProfile sagp
	where sagp.AgencyId = agp.ParentAgencyId) else agp.AgencyName end) AgencyName
from CustomersInfo ci
	left join AgencyProfile agp on agp.AgencyId = ci.AgencyId
where (@AgencyId is null or ci.AgencyId in (select sagp.AgencyId
	from AgencyProfile sagp
	where sagp.AgencyId = @AgencyId or sagp.ParentAgencyId = @AgencyId))
	and (@Name is null or Name like '%' + @Name + '%')
	and (@SurName is null or SurName like '%' + @SurName + '%')
	and (@GsmNumber is null or GsmNumber like '%' + @GsmNumber + '%')
	and (@EmailAdress is null or EmailAdress like '%' + @EmailAdress + '%')
	and (@CitizenNumber is null or CitizenNumber like '%' + @CitizenNumber + '%')
	and (@PassportNumber is null or PassportNumber like '%' + @PassportNumber + '%')

order by CreationDate desc
go

Create Proc [dbo].[CustomersInfoListById] @CustomerId uniqueidentifier
AS
SELECT *
FROM CustomersInfo
WHERE CustomerId = @CustomerId;
go

CREATE Proc CustomersInfoListByPassportInfo @PassportSerialNumber nvarchar(10),
                                            @PassportNumber nvarchar(50),
                                            @AgencyId uniqueidentifier
AS
SELECT *
FROM CustomersInfo
WHERE PassportSerialNumber = @PassportSerialNumber
  and PassportNumber = @PassportNumber and AgencyId = @AgencyId;
go

Create Proc [dbo].[CustomersInfoUpdate] @CustomerId uniqueidentifier,
                                @AgencyId uniqueidentifier,
                                @Name nvarchar(50),
                                @SurName nvarchar(50),
                                @PassengerType int,
                                @Gender int,
                                @GsmArea nvarchar(5),
                                @GsmNumber nvarchar(25),
                                @BirthDate DateTime,
                                @EmailAdress nvarchar(50),
                                @NeedWheelChair int,
                                @PhoneArea nvarchar(5),
                                @PhoneNumber nvarchar(50),
                                @CitizenNumber nvarchar(11),
                                @PassportSerialNumber nvarchar(10),
                                @PassportNumber nvarchar(50),
                                @PassportEndDate DateTime,
                                @PassportCountry nvarchar(5),
                                @CompanyName nvarchar(250),
                                @TaxOffice nvarchar(50),
                                @TaxNumber nvarchar(50),
                                @ZipCode nvarchar(50),
                                @Adress nvarchar(500),
                                @City nvarchar(500),
                                @Country nvarchar(50),
                                @CreationDate datetime
AS
UPDATE CustomersInfo
SET AgencyId=@AgencyId,
    Name=@Name,
    SurName=@SurName,
    PassengerType=@PassengerType,
    Gender=@Gender,
    GsmArea=@GsmArea,
    GsmNumber=@GsmNumber,
    BirthDate=@BirthDate,
    EmailAdress=@EmailAdress,
    NeedWheelChair=@NeedWheelChair,
    PhoneArea=@PhoneArea,
    PhoneNumber=@PhoneNumber,
    CitizenNumber=@CitizenNumber,
    PassportSerialNumber=@PassportSerialNumber,
    PassportNumber=@PassportNumber,
    PassportEndDate=@PassportEndDate,
    PassportCountry=@PassportCountry,
    CompanyName=@CompanyName,
    TaxOffice=@TaxOffice,
    TaxNumber=@TaxNumber,
    ZipCode=@ZipCode,
    Adress=@Adress,
    City=@City,
    Country=@Country,
    CreationDate=@CreationDate
WHERE CustomerId = @CustomerId;
go

CREATE Proc CustomersInfoUpdateByCitizenNumber @CustomerId uniqueidentifier,
                                               @AgencyId uniqueidentifier,
                                               @Name nvarchar(50),
                                               @SurName nvarchar(50),
                                               @PassengerType int,
                                               @Gender int,
                                               @GsmArea nvarchar(5),
                                               @GsmNumber nvarchar(25),
                                               @BirthDate DateTime,
                                               @EmailAdress nvarchar(50),
                                               @NeedWheelChair int,
                                               @PhoneArea nvarchar(5),
                                               @PhoneNumber nvarchar(50),
                                               @CitizenNumber nvarchar(11),
                                               @PassportSerialNumber nvarchar(10),
                                               @PassportNumber nvarchar(50),
                                               @PassportEndDate DateTime,
                                               @PassportCountry nvarchar(5),
                                               @CompanyName nvarchar(250),
                                               @TaxOffice nvarchar(50),
                                               @TaxNumber nvarchar(50),
                                               @ZipCode nvarchar(50),
                                               @Adress nvarchar(500),
                                               @City nvarchar(500),
                                               @Country nvarchar(50),
                                               @CreationDate datetime
AS
UPDATE CustomersInfo
SET AgencyId=@AgencyId,
    Name=@Name,
    SurName=@SurName,
    PassengerType=@PassengerType,
    Gender=@Gender,
    GsmArea=@GsmArea,
    GsmNumber=@GsmNumber,
    BirthDate=@BirthDate,
    EmailAdress=@EmailAdress,
    NeedWheelChair=@NeedWheelChair,
    PhoneArea=@PhoneArea,
    PhoneNumber=@PhoneNumber,
    PassportSerialNumber=@PassportSerialNumber,
    PassportNumber=@PassportNumber,
    PassportEndDate=@PassportEndDate,
    PassportCountry=@PassportCountry,
    CompanyName=@CompanyName,
    TaxOffice=@TaxOffice,
    TaxNumber=@TaxNumber,
    ZipCode=@ZipCode,
    Adress=@Adress,
    City=@City,
    Country=@Country,
    CreationDate=@CreationDate
WHERE CitizenNumber = @CitizenNumber and AgencyId = @AgencyId;;
go

CREATE Proc CustomersInfoUpdateByPassportInfo @CustomerId uniqueidentifier,
                                              @AgencyId uniqueidentifier,
                                              @Name nvarchar(50),
                                              @SurName nvarchar(50),
                                              @PassengerType int,
                                              @Gender int,
                                              @GsmArea nvarchar(5),
                                              @GsmNumber nvarchar(25),
                                              @BirthDate DateTime,
                                              @EmailAdress nvarchar(50),
                                              @NeedWheelChair int,
                                              @PhoneArea nvarchar(5),
                                              @PhoneNumber nvarchar(50),
                                              @CitizenNumber nvarchar(11),
                                              @PassportSerialNumber nvarchar(10),
                                              @PassportNumber nvarchar(50),
                                              @PassportEndDate DateTime,
                                              @PassportCountry nvarchar(5),
                                              @CompanyName nvarchar(250),
                                              @TaxOffice nvarchar(50),
                                              @TaxNumber nvarchar(50),
                                              @ZipCode nvarchar(50),
                                              @Adress nvarchar(500),
                                              @City nvarchar(500),
                                              @Country nvarchar(50),
                                              @CreationDate datetime
AS
UPDATE CustomersInfo
SET AgencyId=@AgencyId,
    Name=@Name,
    SurName=@SurName,
    PassengerType=@PassengerType,
    Gender=@Gender,
    GsmArea=@GsmArea,
    GsmNumber=@GsmNumber,
    BirthDate=@BirthDate,
    EmailAdress=@EmailAdress,
    NeedWheelChair=@NeedWheelChair,
    PhoneArea=@PhoneArea,
    PhoneNumber=@PhoneNumber,
    CitizenNumber=@CitizenNumber,
    PassportEndDate=@PassportEndDate,
    PassportCountry=@PassportCountry,
    CompanyName=@CompanyName,
    TaxOffice=@TaxOffice,
    TaxNumber=@TaxNumber,
    ZipCode=@ZipCode,
    Adress=@Adress,
    City=@City,
    Country=@Country,
    CreationDate=@CreationDate
WHERE PassportSerialNumber = @PassportSerialNumber
  and PassportNumber = @PassportNumber  and AgencyId = @AgencyId;;
go

create proc [dbo].[DisabledFlightClassesAdd]
@CarrierCode nvarchar(3), @ClassCode nvarchar(3), @StartDate DateTime, @EndDate DateTime, @Departure nvarchar(3), @Arrival nvarchar(3)
as
insert into DisabledFlightClasses(CarrierCode, ClassCode, StartDate, EndDate, Departure, Arrival) values(@CarrierCode, @ClassCode, @StartDate, @EndDate, @Departure, @Arrival)
go

create proc [dbo].[DisabledFlightClassesDelete]
@DisabledFlightClassId int
as
delete from DisabledFlightClasses
where DisabledFlightClassId=@DisabledFlightClassId
go

create proc [dbo].[DisabledFlightClassesList]
as
select * from DisabledFlightClasses
go

create proc [dbo].[DisabledFlightClassesListById]
@DisabledFlightClassId int
as
select * from DisabledFlightClasses
where DisabledFlightClassId=@DisabledFlightClassId
go

create proc [dbo].[DisabledFlightClassesUpdate]
@DisabledFlightClassId int, @CarrierCode nvarchar(3), @ClassCode nvarchar(3), @StartDate DateTime, @EndDate DateTime, @Departure nvarchar(3), @Arrival nvarchar(3)
as
update DisabledFlightClasses set CarrierCode=@CarrierCode, ClassCode=@ClassCode, StartDate=@StartDate, EndDate=@EndDate, Departure=@Departure, Arrival=@Arrival
where DisabledFlightClassId=@DisabledFlightClassId
go

create FUNCTION [dbo].[EmptyGuid]
(
	 
)
RETURNS uniqueidentifier
AS
BEGIN
	 
	 
	RETURN  (select cast(cast(0 as binary) as uniqueidentifier))

END
go

create FUNCTION [dbo].[EncodeDataToBase64]
(
	@Data nvarchar(250)
)
RETURNS nvarchar(250)
AS
BEGIN

return 	(SELECT   CAST(N'' AS XML).value('xs:base64Binary(xs:hexBinary(sql:column("bin")))' , 'VARCHAR(MAX)')   Base64Encoding FROM ( SELECT CAST(@Data AS VARBINARY(MAX)) AS bin
) AS bin_sql_server_temp)


END
go

create proc [dbo].[ErrorLogsAdd]
@ErrorMessage nvarchar(max), @ErrorStackTrace nvarchar(max), @CreationDate datetime, @UserId uniqueidentifier
as
insert into ErrorLogs(ErrorMessage, ErrorStackTrace, CreationDate, UserId) values(@ErrorMessage, @ErrorStackTrace, @CreationDate, @UserId)
go

create proc [dbo].[ErrorLogsDelete]
@ErrorId int
as
delete from ErrorLogs
where ErrorId=@ErrorId
go

create proc [dbo].[ErrorLogsList]
as
select * from ErrorLogs
go

create proc [dbo].[ErrorLogsListById]
@ErrorId int
as
select * from ErrorLogs
where ErrorId=@ErrorId
go

create proc [dbo].[ErrorLogsUpdate]
@ErrorId int, @ErrorMessage nvarchar(max), @ErrorStackTrace nvarchar(max), @CreationDate datetime, @UserId uniqueidentifier
as
update ErrorLogs set ErrorMessage=@ErrorMessage, ErrorStackTrace=@ErrorStackTrace, CreationDate=@CreationDate, UserId=@UserId
where ErrorId=@ErrorId
go

create proc [dbo].[FareStatuListAdd]
@FareStatuId int,@EnumEqual nvarchar(50), @Description nvarchar(50), @Lang nvarchar(5)
as
insert into FareStatuList(FareStatuId,EnumEqual, Description, Lang) values(@FareStatuId,@EnumEqual, @Description, @Lang)
go

create proc [dbo].[FareStatuListDelete]
@FareStatuId int
as
delete from FareStatuList
where FareStatuId=@FareStatuId
go

create proc [dbo].[FareStatuListList]
as
select * from FareStatuList
go

create proc [dbo].[FareStatuListListById]
@FareStatuId int
as
select * from FareStatuList
where FareStatuId=@FareStatuId
go

create proc [dbo].[FareStatuListUpdate]
@FareStatuId int, @EnumEqual nvarchar(50), @Description nvarchar(50), @Lang nvarchar(5)
as
update FareStatuList set EnumEqual=@EnumEqual, Description=@Description, Lang=@Lang
where FareStatuId=@FareStatuId
go

CREATE PROCEDURE [dbo].[FinancialDashboardList]
@AgencyId uniqueidentifier = null,	
@StartDate datetime,
@EndDate datetime,
@ByaAgencyId uniqueidentifier = null
AS
    SELECT CreationDate Date, ReservationType Type, SUM(TotalPrice) Price,SUM(AgencyCommission) Commission, SUM(ServicesPrice) ServicesPrice
	FROM [dbo].[FinancialDashboardView]
	where 
		(@AgencyId is null or AgencyId = @AgencyId) 
		and CreationDate >= @StartDate 
		and CreationDate <= @EndDate
		and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
	group by CreationDate, [ReservationType]
	order by CreationDate
go

create proc [dbo].[FlightInfoCarries]
as
 select f.CarrierCode,count(f.CarrierCode) as ItemCount, isnull(l.AirLineName,f.CarrierCode) AirWay  from FlightsInfo f 
 left join AirLineList l on l.IataCode=f.CarrierCode
 inner join Reservations r on f.ReservationId=r.ReservationId
 where   FlightIndex=0
 group by f.CarrierCode ,l.AirLineName
 order by count(f.CarrierCode) desc
go

CREATE FUNCTION [dbo].[FlightInfoDestionation]
(
	
	@ReservationId uniqueidentifier
)
RETURNS nvarchar(max)
AS
BEGIN
	 
	 declare @Result nvarchar(max)=''

		set @Result=	(Select myfn.Departure + '-'+myfn.Arrival +'-'
                From FlightsInfo myfn
                Where myfn.ReservationId=@ReservationId
                ORDER BY myfn.FlightIndex
                For XML PATH (''))
	   
	   
	   return substring(@Result, 1, (len(@Result) - 1))
END
go

CREATE FUNCTION [dbo].[FlightInfoFlightNumbers]
(
	
	@ReservationId uniqueidentifier
)
RETURNS nvarchar(max)
AS
BEGIN
	 
	 declare @Result nvarchar(max)=''

		set @Result=	(Select myfn.FlightNumber  +'-'  From FlightsInfo myfn
                Where myfn.ReservationId=@ReservationId
                ORDER BY myfn.FlightIndex
                For XML PATH (''))
	   
	   
	   return substring(@Result, 1, (len(@Result) - 1))
END
go

CREATE proc [dbo].[FlightPriceGalileoPriceUpdate]
 @PassengerType int,
 @BasePrice decimal(18,2),
 @Tax decimal(18,2),
 @TotalPrice decimal(18,2),
 @ReservationId nvarchar(50)
 as
 
 update FlightPriceInfo set BasePrice=@BasePrice,Tax=@Tax,TotalPrice=((@TotalPrice)+ServicesPrice) where PassengerType=@PassengerType and ReservationId= @ReservationId
go

CREATE proc [dbo].[FlightPriceInfoAdd]
@ReservationId uniqueidentifier, @PassengerType int, @BasePrice decimal(18,2), @Tax decimal(18,2), @Vq decimal(18,2), @FuelOther decimal(18,2),@SecretServicesPrice decimal(18,2), @ServicesPrice decimal(18,2), @AgencyCommission decimal(18,2), @ExtraCommisson decimal(18,4), @TotalPrice decimal(18,2), @CurrencyId int,
@OriginalCurrencyId int,
@CurrencyConvertionRate decimal(18,4),
@SystemServicesPrice decimal(18,2),
 @ParentAgencyServicesPrice decimal(18,2),
  @IsRefundable bit,
   @ProviderId int,
    @PassengerId uniqueidentifier,
	@PriceIndex int, 
@FareStatus int,
@TicketStatus int,
@SupplierName nvarchar(50),
@FareReferanceId uniqueidentifier,
@CreationDate datetime,
@RefundPrice decimal(18,2),
@PenaltyPrice decimal(18,2)
as
insert into FlightPriceInfo(ReservationId, PassengerType, BasePrice, Tax, Vq, FuelOther,SecretServicesPrice, ServicesPrice, AgencyCommission, ExtraCommisson, TotalPrice, CurrencyId,OriginalCurrencyId, CurrencyConvertionRate,SystemServicesPrice, ParentAgencyServicesPrice, IsRefundable, ProviderId, PassengerId,PriceIndex,FareStatus,TicketStatus,SupplierName, FareReferanceId,CreationDate,RefundPrice,PenaltyPrice) values(@ReservationId, @PassengerType, @BasePrice, @Tax, @Vq, @FuelOther,@SecretServicesPrice, @ServicesPrice, @AgencyCommission, @ExtraCommisson, @TotalPrice, @CurrencyId,@OriginalCurrencyId, @CurrencyConvertionRate, @SystemServicesPrice, @ParentAgencyServicesPrice, @IsRefundable, @ProviderId, @PassengerId, @PriceIndex,@FareStatus,@TicketStatus,@SupplierName,@FareReferanceId,@CreationDate,@RefundPrice,@PenaltyPrice)
go

create proc [dbo].[FlightPriceInfoControlAllFaresVoid]
@ReservationId uniqueidentifier
as
declare @AvailableFareCount int =(select count(*) from FlightPriceInfo where ReservationId=@ReservationId)
declare @VoidedFares int =(select count(*) from FlightPriceInfo where ReservationId=@ReservationId and FareStatus=2)
if(@AvailableFareCount=@VoidedFares)
Begin
Select 1
End
else
Begin
Select 0
End
go

create proc [dbo].[FlightPriceInfoDelete]
@FlightPriceId uniqueidentifier
as
delete from FlightPriceInfo
where FlightPriceId=@FlightPriceId
go

create proc [dbo].[FlightPriceInfoList]
as
select * from FlightPriceInfo
go

create proc [dbo].[FlightPriceInfoListById]
@FlightPriceId uniqueidentifier
as
select * from FlightPriceInfo
where FlightPriceId=@FlightPriceId
go

create proc [dbo].[FlightPriceInfoListByReservationId]
 @ReservationId uniqueidentifier
 as
 select * from FlightPriceInfo where ReservationId=@ReservationId
 order by PriceIndex asc
go

create proc [dbo].[FlightPriceInfoOneItemByPassegerId]
@PassengerId uniqueidentifier
as
select * from FlightPriceInfo where PassengerId=@PassengerId
go

CREATE proc [dbo].[FlightPriceInfoOneItemByProcessId]
@ProcessId uniqueidentifier
as
select p.* from Reservations r with(nolock)
inner join FlightPriceInfo p on r.ReservationId=p.ReservationId
where r.ProcessId=@ProcessId
order by p.PriceIndex asc
go

create proc [dbo].[FlightPriceInfoOverThisAllPassengerTicketsVoided]
@ReservationId uniqueidentifier
as
declare @TotalPassengerCount int= (select count(*) from FlightPriceInfo where ReservationId=@ReservationId)
declare @NoTicketPassengers int= (select count(*) from FlightPriceInfo where ReservationId=@ReservationId  and FareStatus<>1)
 select @TotalPassengerCount-@NoTicketPassengers
go

CREATE proc [dbo].[FlightPriceInfoUpdate]
@FlightPriceId uniqueidentifier, @ReservationId uniqueidentifier, @PassengerType int, @BasePrice decimal(18,2), @Tax decimal(18,2), @Vq decimal(18,2), @FuelOther decimal(18,2),
@SecretServicesPrice decimal(18,2),
@ServicesPrice decimal(18,2), 
@AgencyCommission decimal(18,2), 
@ExtraCommisson decimal(18,4),
@TotalPrice decimal(18,2),
@CurrencyId int,
@OriginalCurrencyId int,
@CurrencyConvertionRate decimal(18,4),
@SystemServicesPrice decimal(18,2),
@ParentAgencyServicesPrice decimal(18,2),
@IsRefundable bit,
@ProviderId int,
@PassengerId uniqueidentifier,
@PriceIndex int, 
@FareStatus int,
@TicketStatus int,
@SupplierName nvarchar(50),
@FareReferanceId uniqueidentifier,
@CreationDate datetime,
@RefundPrice decimal(18,2),
@PenaltyPrice decimal(18,2)
as
update FlightPriceInfo set ReservationId=@ReservationId, PassengerType=@PassengerType, BasePrice=@BasePrice, Tax=@Tax, Vq=@Vq, FuelOther=@FuelOther,
SecretServicesPrice=@SecretServicesPrice,
ServicesPrice=@ServicesPrice, AgencyCommission=@AgencyCommission, ExtraCommisson=@ExtraCommisson, TotalPrice=@TotalPrice, CurrencyId=@CurrencyId,
OriginalCurrencyId=@OriginalCurrencyId,
CurrencyConvertionRate=@CurrencyConvertionRate,
 SystemServicesPrice=@SystemServicesPrice, ParentAgencyServicesPrice=@ParentAgencyServicesPrice, IsRefundable=@IsRefundable, ProviderId=@ProviderId, PassengerId=@PassengerId, PriceIndex=@PriceIndex,
 FareStatus=@FareStatus,
 TicketStatus=@TicketStatus,
 SupplierName=@SupplierName,
 FareReferanceId=@FareReferanceId,
 CreationDate=@CreationDate,
 RefundPrice = @RefundPrice,
 PenaltyPrice = @PenaltyPrice
where FlightPriceId=@FlightPriceId
go

create proc [dbo].[FlightPriceInfoWithCurrienciesAdd]
@PassengerId uniqueidentifier, @CurrencyCode nvarchar(3), @CurrencyUnitPrice decimal(18,2), @CreationDate datetime
as
insert into FlightPriceInfoWithCurriencies(PassengerId, CurrencyCode, CurrencyUnitPrice, CreationDate) values(@PassengerId, @CurrencyCode, @CurrencyUnitPrice, @CreationDate)
go

CREATE proc [dbo].[FlightPriceInfoWithCurrienciesByPriceIdAndCurrencyCode]   
@FlightPriceId uniqueidentifier,
@CurrencyCode nvarchar(3)
as
select * from FlightPriceInfoWithCurriencies where FlightPriceId=@FlightPriceId and CurrencyCode=@CurrencyCode
go

create proc [dbo].[FlightPriceInfoWithCurrienciesDelete]
@FlightPriceId uniqueidentifier
as
delete from FlightPriceInfoWithCurriencies
where FlightPriceId=@FlightPriceId
go

create proc [dbo].[FlightPriceInfoWithCurrienciesList]
as
select * from FlightPriceInfoWithCurriencies
go

create proc [dbo].[FlightPriceInfoWithCurrienciesListById]
@FlightPriceId uniqueidentifier
as
select * from FlightPriceInfoWithCurriencies
where FlightPriceId=@FlightPriceId
go

create proc [dbo].[FlightPriceInfoWithCurrienciesUpdate]
@FlightPriceId uniqueidentifier, @PassengerId uniqueidentifier, @CurrencyCode nvarchar(3), @CurrencyUnitPrice decimal(18,2), @CreationDate datetime
as
update FlightPriceInfoWithCurriencies set PassengerId=@PassengerId, CurrencyCode=@CurrencyCode, CurrencyUnitPrice=@CurrencyUnitPrice, CreationDate=@CreationDate
where FlightPriceId=@FlightPriceId
go

create proc [dbo].[FlightTotalPriceByProcessId]
@ProcessId uniqueidentifier
as
select TotalPrice from FlightPriceInfo where ReservationId in(Select ReservationId from Reservations where ProcessId=@ProcessId)
go

CREATE proc [dbo].[FlightsInfoAdd]
@ReservationId uniqueidentifier,
@NParamValue nvarchar(50),
@StartTerminal nvarchar(50),
@EndTerminal nvarchar(50),
@FlightNumber nvarchar(50),
@CarrierCode nvarchar(5),
@CooperatedCode nvarchar(10),
@Departure nvarchar(50),
@Arrival nvarchar(50),
@DepartureDate DateTime,
@ArrivalDate DateTime,
@DepartureTime Time,
@ArrivalTime Time,
@FlightClass nvarchar(5),
@SeatCount int,
@IsConnected bit,
@FlightIndex int,
@BaggageInfo nvarchar(50),
@IsReturnFlight bit,
@ProviderId int,
@SupplierName nvarchar(50),
@CharterGroupId uniqueidentifier,
@CreationDate datetime,
@FareBasisCode nvarchar(50) = null
as
insert into FlightsInfo(ReservationId, NParamValue,StartTerminal,EndTerminal, FlightNumber, CarrierCode, CooperatedCode, Departure, Arrival, DepartureDate, ArrivalDate, DepartureTime, ArrivalTime, FlightClass, SeatCount, IsConnected, FlightIndex, BaggageInfo, IsReturnFlight, ProviderId,SupplierName,CharterGroupId, CreationDate, FareBasisCode)
 values(@ReservationId, @NParamValue,@StartTerminal,@EndTerminal, @FlightNumber, @CarrierCode, @CooperatedCode, @Departure, @Arrival, @DepartureDate, @ArrivalDate, @DepartureTime, @ArrivalTime, @FlightClass, @SeatCount, @IsConnected, @FlightIndex, @BaggageInfo, @IsReturnFlight, @ProviderId,@SupplierName,@CharterGroupId, @CreationDate, @FareBasisCode)
go

CREATE proc [dbo].[FlightsInfoCharterInfoChange]
@CharterGroupId uniqueidentifier,
@DepartureDate date,
@DepartureTime time(7),
@ArrivalDate date,
@ArrivalTime time(7),
@FlightNumber nvarchar(30),
@CarrierCode nvarchar(5),
@IsReturnFlight bit,
@StartTerminal nvarchar(10),
@EndTerminal nvarchar(10)

as
 
 
 update FlightsInfo set 
 DepartureDate=@DepartureDate,
 DepartureTime=@DepartureTime,
 ArrivalDate=@ArrivalDate,
 ArrivalTime=@ArrivalTime,
 CarrierCode=@CarrierCode,
 FlightNumber=@FlightNumber,
 StartTerminal=@StartTerminal,
 EndTerminal=@EndTerminal
 where CharterGroupId=@CharterGroupId and IsReturnFlight=@IsReturnFlight
go

create proc [dbo].[FlightsInfoDelete]
@FlightInfoId uniqueidentifier
as
delete from FlightsInfo
where FlightInfoId=@FlightInfoId
go

create proc [dbo].[FlightsInfoList]
as
select * from FlightsInfo
go

create proc [dbo].[FlightsInfoListById]
@FlightInfoId uniqueidentifier
as
select * from FlightsInfo
where FlightInfoId=@FlightInfoId
go

create proc [dbo].[FlightsInfoListByProcessId]
@ProcessId uniqueidentifier
as
select * from FlightsInfo where ReservationId in (Select ReservationId from Reservations where ProcessId=@ProcessId)
order by FlightIndex asc
go

create proc [dbo].[FlightsInfoListByReservationId]
 @ReservationId uniqueidentifier
 as
 select * from FlightsInfo where ReservationId=@ReservationId
 order by FlightIndex asc
go

create proc [dbo].[FlightsInfoOneItemByCharterGroupId]
@CharterGroupId uniqueidentifier,
@IsReturnFlight bit
as
select * from  FlightsInfo where CharterGroupId=@CharterGroupId and IsReturnFlight=@IsReturnFlight
go

CREATE proc [dbo].[FlightsInfoUpdate]
@FlightInfoId uniqueidentifier,
@ReservationId uniqueidentifier,
@NParamValue nvarchar(50),
@StartTerminal nvarchar(50),
@EndTerminal nvarchar(50),
@FlightNumber nvarchar(50),
@CarrierCode nvarchar(5),
@CooperatedCode nvarchar(10),
@Departure nvarchar(50),
@Arrival nvarchar(50),
@DepartureDate DateTime,
@ArrivalDate DateTime,
@DepartureTime Time,
@ArrivalTime Time,
@FlightClass nvarchar(5),
@SeatCount int,
@IsConnected bit,
@FlightIndex int,
@BaggageInfo nvarchar(50),
@IsReturnFlight bit,
@ProviderId int,
@SupplierName nvarchar(50),
@CharterGroupId uniqueidentifier,
@CreationDate datetime,
@FareBasisCode nvarchar(50)
as
update FlightsInfo set ReservationId=@ReservationId, NParamValue=@NParamValue, 
StartTerminal=@StartTerminal,
EndTerminal=@EndTerminal,
FlightNumber=@FlightNumber, CarrierCode=@CarrierCode, CooperatedCode=@CooperatedCode, Departure=@Departure, Arrival=@Arrival, DepartureDate=@DepartureDate, ArrivalDate=@ArrivalDate, DepartureTime=@DepartureTime, ArrivalTime=@ArrivalTime, FlightClass=@FlightClass, SeatCount=@SeatCount, IsConnected=@IsConnected, FlightIndex=@FlightIndex, BaggageInfo=@BaggageInfo, IsReturnFlight=@IsReturnFlight, ProviderId=@ProviderId,SupplierName=@SupplierName,
CharterGroupId=@CharterGroupId,
 CreationDate=@CreationDate,
                       FareBasisCode=@FareBasisCode
where FlightInfoId=@FlightInfoId
go

create proc [dbo].[GalileoDisabledCarriesAdd]
@Status bit
as
insert into GalileoDisabledCarries(Status) values(@Status)
go

create proc [dbo].[GalileoDisabledCarriesDelete]
@CarrierCode nvarchar(3)
as
delete from GalileoDisabledCarries
where CarrierCode=@CarrierCode
go

create proc [dbo].[GalileoDisabledCarriesList]
as
select * from GalileoDisabledCarries
go

create proc [dbo].[GalileoDisabledCarriesListById]
@CarrierCode nvarchar(3)
as
select * from GalileoDisabledCarries
where CarrierCode=@CarrierCode
go

create proc [dbo].[GalileoDisabledCarriesUpdate]
@CarrierCode nvarchar(3), @Status bit
as
update GalileoDisabledCarries set Status=@Status
where CarrierCode=@CarrierCode
go

create proc [dbo].[GenderTypesAdd]
@GenderTypeName nvarchar(50), @GenderTypeValue int, @Description nvarchar(50), @Lang nvarchar(5)
as
insert into GenderTypes(GenderTypeName, GenderTypeValue, Description, Lang) values(@GenderTypeName, @GenderTypeValue, @Description, @Lang)
go

create proc [dbo].[GenderTypesDelete]
@PassengerGenderTypeId int
as
delete from GenderTypes
where PassengerGenderTypeId=@PassengerGenderTypeId
go

create proc [dbo].[GenderTypesList]
as
select * from GenderTypes
go

create proc [dbo].[GenderTypesListById]
@PassengerGenderTypeId int
as
select * from GenderTypes
where PassengerGenderTypeId=@PassengerGenderTypeId
go

CREATE proc [dbo].[GenderTypesListByLang]  
@Lang nvarchar(5)
as
select * from GenderTypes where Lang=@Lang Order by GenderTypeValue desc
go

create proc [dbo].[GenderTypesUpdate]
@PassengerGenderTypeId int, @GenderTypeName nvarchar(50), @GenderTypeValue int, @Description nvarchar(50), @Lang nvarchar(5)
as
update GenderTypes set GenderTypeName=@GenderTypeName, GenderTypeValue=@GenderTypeValue, Description=@Description, Lang=@Lang
where PassengerGenderTypeId=@PassengerGenderTypeId
go

CREATE proc [dbo].[GetDailyOptionCountForDashboard]
@AgencyId uniqueidentifier = null,
@ByaAgencyId uniqueidentifier = null
as
select count(*) from dbo.vw_ReservationSummaryDetail 
where 
	(@AgencyId is null or AgencyId = @AgencyId) 
	and CONVERT(DATE, LastDateToTicket) = CONVERT (date, GETDATE())
	and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
go

CREATE proc [dbo].[GetOpenSupportCountForDashboard]
@AgencyId uniqueidentifier = null,
@ByaAgencyId uniqueidentifier = null
as
select count(*) 
from dbo.Support 
where  
	(@AgencyId is null or AgencyId = @AgencyId) 
	and ResolvedDate IS NULL
	and RelatedId IS NOT NULL
	and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
go

CREATE Proc [dbo].[GetOptionDateChangeCountForDashboard]
@AgencyId uniqueidentifier = null,
@ByaAgencyId uniqueidentifier = null
AS
SELECT COUNT(odh.Id)
FROM OptionDateHistory odh
INNER JOIN Reservations reservation on reservation.ReservationId = odh.ReservationId
WHERE 
	(@AgencyId is null or reservation.AgencyId = @AgencyId)
	and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
go

Create Proc [dbo].[GroupReservationOfferListByGroupReservationId]
@GroupReservationId uniqueidentifier
as
SELECT * FROM GroupReservationOffers

Where GroupReservationId = @GroupReservationId

order by CreationDate desc
go

CREATE Proc [dbo].[GroupReservationOffersAdd]
@OfferId uniqueidentifier,
@Title nvarchar(500),
@PaymentType int,
@OfferrerId uniqueidentifier,
@OfferSelectorId uniqueidentifier = null,
@IsSelected bit = null,
@SelectionDate datetime = null,
@CreationDate datetime,
@GroupReservationId uniqueidentifier,
@FileExtension nvarchar(50) = null
as
INSERT INTO GroupReservationOffers(
OfferId,
Title,
PaymentType,
OfferrerId,
OfferSelectorId,
IsSelected,
SelectionDate,
CreationDate,
GroupReservationId,
FileExtension
)
VALUES
(
@OfferId,
@Title,
@PaymentType,
@OfferrerId,
@OfferSelectorId,
@IsSelected,
@SelectionDate,
@CreationDate,
@GroupReservationId,
@FileExtension
)
go

Create Proc [dbo].[GroupReservationOffersDelete]
@OfferId uniqueidentifier
AS
DELETE  FROM GroupReservationOffers
WHERE OfferId=@OfferId
go

Create Proc [dbo].[GroupReservationOffersList]
as
SELECT * FROM GroupReservationOffers
go

Create Proc [dbo].[GroupReservationOffersListById]
@OfferId uniqueidentifier
AS
SELECT * FROM GroupReservationOffers
WHERE OfferId=@OfferId
go

CREATE Proc [dbo].[GroupReservationOffersUpdate]
@OfferId uniqueidentifier,
@Title nvarchar(500),
@PaymentType int,
@OfferrerId uniqueidentifier,
@OfferSelectorId uniqueidentifier = null,
@IsSelected bit = null,
@SelectionDate datetime = null,
@CreationDate datetime,
@GroupReservationId uniqueidentifier,
@FileExtension nvarchar(50) = null
AS
UPDATE GroupReservationOffers
SET
OfferId=@OfferId,
Title=@Title,
PaymentType=@PaymentType,
OfferrerId=@OfferrerId,
OfferSelectorId=@OfferSelectorId,
IsSelected=@IsSelected,
SelectionDate=@SelectionDate,
CreationDate=@CreationDate,
GroupReservationId=@GroupReservationId,
FileExtension = @FileExtension
WHERE OfferId=@OfferId
go

CREATE Proc [dbo].[GroupReservationsAdd]
@GroupReservationId uniqueidentifier,
@GroupReservationName nvarchar(100),
@GroupReservationType int,
@Departure nvarchar(3),
@Arrival nvarchar(3),
@DepartureDate datetime,
@DepartureFlightNumber nvarchar(7),
@IsRoundTrip bit,
@ArrivalDate datetime = null,
@ArrivalFlightNumber nvarchar(7) = null,
@PaxAdult int,
@PaxChild int,
@PaxInfant int,
@ContactMail nvarchar(320),
@AgencyNotes nvarchar(max) = null,
@Status int,
@AgencyId uniqueidentifier,
@UserId uniqueidentifier,
@PnrOrBookingId nvarchar(100) = null,
@IsDomestic bit,
@ReservationId uniqueidentifier = null,
@CreationDate datetime
as
INSERT INTO GroupReservations(
GroupReservationId,
GroupReservationName,
GroupReservationType,
Departure,
Arrival,
DepartureDate,
DepartureFlightNumber,
IsRoundTrip,
ArrivalDate,
ArrivalFlightNumber,
PaxAdult,
PaxChild,
PaxInfant,
ContactMail,
AgencyNotes,
Status,
AgencyId,
UserId,
PnrOrBookingId,
IsDomestic,
ReservationId,
CreationDate
)
VALUES
(
@GroupReservationId,
@GroupReservationName,
@GroupReservationType,
@Departure,
@Arrival,
@DepartureDate,
@DepartureFlightNumber,
@IsRoundTrip,
@ArrivalDate,
@ArrivalFlightNumber,
@PaxAdult,
@PaxChild,
@PaxInfant,
@ContactMail,
@AgencyNotes,
@Status,
@AgencyId,
@UserId,
@PnrOrBookingId,
@IsDomestic,
@ReservationId,
@CreationDate
)
go

Create Proc [dbo].[GroupReservationsDelete]
@GroupReservationId uniqueidentifier
AS
DELETE  FROM GroupReservations
WHERE GroupReservationId=@GroupReservationId
go

Create Proc [dbo].[GroupReservationsList]
as
SELECT * FROM GroupReservations
go

CREATE Proc [dbo].[GroupReservationsListByFilters]
    @AgencyId uniqueidentifier = null,
        @GroupReservationName nvarchar(100) = null,
        @GroupReservationType int = null,
        @Departure nvarchar(3) = null,
        @Arrival nvarchar(3) = null,
        @DepartureDateStart date =null,
        @DepartureDateEnd date = null,
        @IsRoundTrip bit = null,
        @Status int = null
    AS
    select *
    from GroupReservations
    where (@AgencyId is null or AgencyId = @AgencyId)
      and (@GroupReservationName is null or GroupReservationName = @GroupReservationName)
      and (@GroupReservationType is null or GroupReservationType = @GroupReservationType)
      and (@Departure is null or Departure = @Departure)
      and (@Arrival is null or Arrival = @Arrival)
      and (@DepartureDateStart is null or (cast(DepartureDate as date) >= cast(@DepartureDateStart as date)))
      and (@DepartureDateEnd is null or (cast(DepartureDate as date) <= cast(@DepartureDateEnd as date)))
      and (@IsRoundTrip is null or IsRoundTrip = @IsRoundTrip)
      and (@Status is null or Status = @Status)
    order by CreationDate desc
go

Create Proc [dbo].[GroupReservationsListById]
@GroupReservationId uniqueidentifier
AS
SELECT * FROM GroupReservations
WHERE GroupReservationId=@GroupReservationId
go

CREATE Proc [dbo].[GroupReservationsUpdate]
@GroupReservationId uniqueidentifier,
@GroupReservationName nvarchar(100),
@GroupReservationType int,
@Departure nvarchar(3),
@Arrival nvarchar(3),
@DepartureDate datetime,
@DepartureFlightNumber nvarchar(7),
@IsRoundTrip bit,
@ArrivalDate datetime,
@ArrivalFlightNumber nvarchar(7),
@PaxAdult int,
@PaxChild int,
@PaxInfant int,
@ContactMail nvarchar(320),
@AgencyNotes nvarchar(max),
@Status int,
@AgencyId uniqueidentifier,
@UserId uniqueidentifier,
@PnrOrBookingId nvarchar(100),
@IsDomestic bit,
@ReservationId uniqueidentifier = null,
@CreationDate datetime
AS
UPDATE GroupReservations
SET
GroupReservationId=@GroupReservationId,
GroupReservationName=@GroupReservationName,
GroupReservationType=@GroupReservationType,
Departure=@Departure,
Arrival=@Arrival,
DepartureDate=@DepartureDate,
DepartureFlightNumber=@DepartureFlightNumber,
IsRoundTrip=@IsRoundTrip,
ArrivalDate=@ArrivalDate,
ArrivalFlightNumber=@ArrivalFlightNumber,
PaxAdult=@PaxAdult,
PaxChild=@PaxChild,
PaxInfant=@PaxInfant,
ContactMail=@ContactMail,
AgencyNotes=@AgencyNotes,
Status=@Status,
AgencyId=@AgencyId,
UserId=@UserId,
PnrOrBookingId=@PnrOrBookingId,
IsDomestic=@IsDomestic,
ReservationId=@ReservationId,
CreationDate=@CreationDate
WHERE GroupReservationId=@GroupReservationId
go

create proc [dbo].[IataClassTypesAdd]
@ClassType nvarchar(5), @Carrier nvarchar(5), @ClassTypeName nvarchar(50), @SupplierId int
as
insert into IataClassTypes(ClassType, Carrier, ClassTypeName, SupplierId) values(@ClassType, @Carrier, @ClassTypeName, @SupplierId)
go

create proc [dbo].[IataClassTypesDelete]
@IataClassTypeId int
as
delete from IataClassTypes
where IataClassTypeId=@IataClassTypeId
go

create proc [dbo].[IataClassTypesGalileoClassTypeOneItemByCarrierAndClassType]
@Carrier nvarchar(5),
@ClassType nvarchar(5)
as
select * from IataClassTypes where Carrier=@Carrier and ClassType=@ClassType
go

create proc [dbo].[IataClassTypesList]
as
select * from IataClassTypes
go

create proc [dbo].[IataClassTypesListById]
@IataClassTypeId int
as
select * from IataClassTypes
where IataClassTypeId=@IataClassTypeId
go

create proc [dbo].[IataClassTypesUpdate]
@IataClassTypeId int, @ClassType nvarchar(5), @Carrier nvarchar(5), @ClassTypeName nvarchar(50), @SupplierId int
as
update IataClassTypes set ClassType=@ClassType, Carrier=@Carrier, ClassTypeName=@ClassTypeName, SupplierId=@SupplierId
where IataClassTypeId=@IataClassTypeId
go

CREATE proc [dbo].[InternalOptionPriceAdd]
@AgencyId uniqueidentifier, @OptionalPrice decimal(18,2), @SupplierId int, @CreationDate datetime, @Status bit
as

IF NOT EXISTS(SELECT AgencyId from InternalOptionPrice where AgencyId=@AgencyId and SupplierId=@SupplierId)
BEGIN
insert into InternalOptionPrice(AgencyId, OptionalPrice, SupplierId, CreationDate, Status) values(@AgencyId, @OptionalPrice, @SupplierId, @CreationDate, @Status)
END
ELSE
BEGIN
update InternalOptionPrice
set OptionalPrice=@OptionalPrice,
CreationDate=@CreationDate,
Status=@Status
where AgencyId=@AgencyId and SupplierId=@SupplierId	  
END
go

create proc [dbo].[InternalOptionPriceDelete]
@InternalOptionPriceId int
as
delete from InternalOptionPrice
where InternalOptionPriceId=@InternalOptionPriceId
go

create proc [dbo].[InternalOptionPriceList]
as
select * from InternalOptionPrice
go

create proc [dbo].[InternalOptionPriceListByAgencyId]
@AgencyId uniqueidentifier
as
select * from InternalOptionPrice where AgencyId= @AgencyId
go

CREATE Proc [dbo].[InternalOptionPriceListByAgencyIdAndSupplierId]
 @AgencyId uniqueidentifier,
 @SupplierId int
 as

if exists(Select * From InternalOptionPrice Where AgencyId=@AgencyId and SupplierId=@SupplierId and Status=1)
begin 
Select OptionalPrice From InternalOptionPrice Where AgencyId=@AgencyId and SupplierId=@SupplierId and Status=1
end
else

begin

Select ServicesPrice as OptionalPrice From AirWays where SupplierId=@SupplierId 

end
go

create proc [dbo].[InternalOptionPriceListById]
@InternalOptionPriceId int
as
select * from InternalOptionPrice
where InternalOptionPriceId=@InternalOptionPriceId
go

create proc [dbo].[InternalOptionPriceUpdate]
@InternalOptionPriceId int, @AgencyId uniqueidentifier, @OptionalPrice decimal(18,2), @SupplierId int, @CreationDate datetime, @Status bit
as
update InternalOptionPrice set AgencyId=@AgencyId, OptionalPrice=@OptionalPrice, SupplierId=@SupplierId, CreationDate=@CreationDate, Status=@Status
where InternalOptionPriceId=@InternalOptionPriceId
go

CREATE FUNCTION [dbo].[IsNullOrEmpty]
(
	@Value nvarchar(10)
)
RETURNS bit
AS
BEGIN

declare @Result bit
	IF @Value IS NOT NULL AND LEN(@Value) > 0
    set @Result= 0
ELSE
    set @Result= 1



	return @Result
END
go

CREATE FUNCTION  [dbo].[IsTPayment]
(
	@ProcessType int,
	@PaymentStatus int
)
RETURNS  bit
AS
BEGIN
	declare @Status bit
	if((@PaymentStatus =4 or @PaymentStatus=10) and @ProcessType=1)
	 begin
	 set  @Status=1
	 end
	 else
	 begin
	  set  @Status=0
	 end
	return @Status


	

END
go

create proc [dbo].[LogDisabledAgenciesAdd]
@AgencyId uniqueidentifier, @Status bit, @MethodName nvarchar(50)
as
insert into LogDisabledAgencies(Status, MethodName) values(@Status, @MethodName)
go

create proc [dbo].[LogDisabledAgenciesDelete]
@AgencyId uniqueidentifier
as
delete from LogDisabledAgencies
where AgencyId=@AgencyId
go

create proc [dbo].[LogDisabledAgenciesList]
as
select * from LogDisabledAgencies
go

create proc [dbo].[LogDisabledAgenciesListById]
@AgencyId uniqueidentifier
as
select * from LogDisabledAgencies
where AgencyId=@AgencyId
go

create proc [dbo].[LogDisabledAgenciesOneItemMethodName]
@AgencyId uniqueidentifier, @MethodName nvarchar(50)
as
select * from LogDisabledAgencies where AgencyId=@AgencyId and MethodName=@MethodName
go

create proc [dbo].[LogDisabledAgenciesUpdate]
@AgencyId uniqueidentifier, @Status bit, @MethodName nvarchar(50)
as
update LogDisabledAgencies set Status=@Status, MethodName=@MethodName
where AgencyId=@AgencyId
go

CREATE proc [dbo].[NotificationAdd]
@Id uniqueidentifier,
@SourceUserId nvarchar(128) = null,
@NotificationType int,
@GroupType int, 
@MessageCode nvarchar(50),
@RelatedLink nvarchar(max),
@CreationDate datetime
as
insert into Notifications(
Id,
SourceUserId,
NotificationType,
GroupType,
MessageCode,
RelatedLink,
CreationDate) values(@Id,
@SourceUserId,
@NotificationType,
@GroupType,
@MessageCode,
@RelatedLink,
@CreationDate)
go

CREATE proc [dbo].[NotificationListById]
    @Id uniqueidentifier
as
select *
from Notifications
where Id=@Id
order by CreationDate desc
go

CREATE proc [dbo].[NotificationListByUserId]
@UserId nvarchar(128),
@Top int
as
select TOP (@Top) NotificationUsers.Id as NotificationUserId,SourceUserId, NotificationType,GroupType,MessageCode,RelatedLink,CreationDate,IsViewed,ViewDate from NotificationUsers right join Notifications on NotificationUsers.NotificationId = Notifications.Id 
where UserId=@UserId
order by CreationDate desc
go

CREATE proc [dbo].[NotificationNotViewedCountByUserId]
@UserId nvarchar(128)
as
select  Count(*) from NotificationUsers
where UserId=@UserId and IsViewed = 0
go

CREATE proc [dbo].[NotificationUserAdd]
@Id uniqueidentifier,
@NotificationId uniqueidentifier, 
@UserId nvarchar(128),
@IsViewed bit,
@ViewDate datetime = null
as
insert into NotificationUsers(
Id,
UserId,
NotificationId,
IsViewed,
ViewDate) values(@Id,
@UserId,
@NotificationId,
@IsViewed,
@ViewDate)
go

CREATE proc [dbo].[NotificationUserSettingAdd]
@Id uniqueidentifier,
@UserId nvarchar(128),
@SettingType int
as
insert into NotificationUserSettings(
Id,
UserId,
SettingType) values(@Id,
@UserId,
@SettingType)
go

CREATE proc [dbo].[NotificationUserSettingDelete]
@UserId nvarchar(128),
@SettingType nvarchar(50)
as
delete from NotificationUserSettings
where UserId=@UserId and SettingType = @SettingType
go

create proc [dbo].[NotificationUserSettingListByUserId]
@UserId nvarchar(128)
as
select * from NotificationUserSettings
where UserId=@UserId
go

CREATE proc [dbo].[NotificationUserUpdate]
@UserId uniqueidentifier,
@IsViewed bit,
@ViewDate datetime
as
update NotificationUsers set IsViewed=@IsViewed, ViewDate=@ViewDate
where UserId=@UserId
go

Create Proc [dbo].[OptionDateHistoryAdd]
@ReservationId uniqueidentifier,
@OptionDate datetime,
@CreationDate datetime
as
INSERT INTO OptionDateHistory(
ReservationId,
OptionDate,
CreationDate
)
VALUES
(
@ReservationId,
@OptionDate,
@CreationDate
)
go

create proc [dbo].[OptionDateHistoryByReservationId]
@ReservationId uniqueidentifier
as
select * from OptionDateHistory
where ReservationId=@ReservationId
go

Create Proc [dbo].[OptionDateHistoryDeleteByReservationId]
@ReservationId uniqueidentifier
AS
DELETE  FROM OptionDateHistory
WHERE ReservationId = @ReservationId
go

CREATE proc [dbo].[OrderTransactionAdd]
@OrderTransactionTypeId int, @Credit decimal(18,2), @Debt decimal(18,2), @CurrencyId int,
@OriginalCurrencyId int,
 @ConvertionRate decimal(18,2), @UserId uniqueidentifier,
 @ProcessId uniqueidentifier,
 @ReservationId uniqueidentifier, @PassengerId uniqueidentifier,@Notes nvarchar(500), @CreationDate DateTime, @CreationTime Time, @AccountId bigint,
 @SalesType int
as
insert into OrderTransaction(OrderTransactionTypeId, Credit, Debt, CurrencyId,OriginalCurrencyId, ConvertionRate, UserId,ProcessId, ReservationId, PassengerId,Notes, CreationDate, CreationTime, AccountId, SalesType) 
values(@OrderTransactionTypeId, @Credit, @Debt, @CurrencyId,@OriginalCurrencyId, @ConvertionRate, @UserId,@ProcessId, @ReservationId, @PassengerId,@Notes, @CreationDate, @CreationTime, @AccountId, @SalesType)
go

create Proc [dbo].[OrderTransactionAgencyRowListByProcessId]   
@ProcessId uniqueidentifier
as

declare @AgencyId uniqueidentifier =(Select Top 1 AgencyId from Reservations where ProcessId=@ProcessId) 
declare @AgencyAccountId int =(Select AccountId from AgencyProfile where AgencyId=@AgencyId)
select * from OrderTransaction  t
where t.AccountId=@AgencyAccountId and t.ProcessId=@ProcessId
go

CREATE Proc [dbo].[OrderTransactionAgencyRowListByReservationId]   
@ReservationId uniqueidentifier
as

declare @AgencyId uniqueidentifier =(Select AgencyId from Reservations where ReservationId=@ReservationId) 
declare @AgencyAccountId int =(Select AccountId from AgencyProfile where AgencyId=@AgencyId)
select * from OrderTransaction  t
where t.AccountId=@AgencyAccountId and t.ReservationId=@ReservationId
go

CREATE Proc [dbo].[OrderTransactionAirProviderRowListByProcessId]   
@ProcessId uniqueidentifier
as

 
 
select * from OrderTransaction  t
where t.AccountId in (Select ProviderId from Reservations where ProcessId=@ProcessId)  and t.ProcessId=@ProcessId
go

create Proc [dbo].[OrderTransactionAirProviderRowListByReservationId]   
@ReservationId uniqueidentifier
as

declare @ProviderId int =(Select ProviderId from Reservations where ReservationId=@ReservationId) 
 
select * from OrderTransaction  t
where t.AccountId=@ProviderId and t.ReservationId=@ReservationId
go

CREATE Proc [dbo].[OrderTransactionBankProviderRowListByProcessId]   
@ProcessId uniqueidentifier
as

declare @BankPosInformationId uniqueidentifier=(Select  top 1 BankPosId from BankPosLogs where ProcessId=@ProcessId and IsTPayment=1)
declare @BankId uniqueidentifier = (Select top 1 BankId from BankPosInformations where BankPosInformationId=@BankPosInformationId)
declare @BankAccountId int = (Select AccountId from Banks where BankId=@BankId) 
select * from OrderTransaction  t
where t.AccountId=@BankAccountId and t.ProcessId=@ProcessId
go

create Proc [dbo].[OrderTransactionBankProviderRowListByReservationId]   
@ReservationId uniqueidentifier
as

declare @ProcessId uniqueidentifier=(Select Top 1 ProcessId from Reservations where ReservationId=@ReservationId)
declare @BankPosInformationId uniqueidentifier=(Select BankPosId from BankPosLogs where ProcessId=@ProcessId and IsTPayment=1)
declare @BankId uniqueidentifier = (Select BankId from BankPosInformations where BankPosInformationId=@BankPosInformationId)
declare @BankAccountId int = (Select AccountId from Banks where BankId=@BankId)
 
select * from OrderTransaction  t
where t.AccountId=@BankAccountId and t.ReservationId=@ReservationId
go

CREATE proc [dbo].[OrderTransactionCreate] 
@Amount decimal(18,4),
@OrderTransactionTypeId int,
@CurrencyId int,
@OriginalCurrencyId int,
@ConvertionRate decimal(18,4),
@UserId uniqueidentifier,
@ProcessId uniqueidentifier,
@ReservationId uniqueidentifier,
@PassengerId uniqueidentifier,
@Notes nvarchar(500),
@AccountId bigint,
@DOC char(1),
@CreationDate datetime,
@SalesType int
as
	declare @Path nvarchar(max)=(Select  AccountPath from SystemAccounts where ParentAccountId=@AccountId and CurrencyId=@CurrencyId)
    declare @Id bigint	 
	declare AccountCursor cursor for SELECT  item FROM    dbo.Split(@Path,'/')
	
	open AccountCursor

	FETCH  NEXT FROM AccountCursor INTO @Id

	 WHILE @@FETCH_STATUS = 0  
	 BEGIN   	

	 IF(@DOC='C')
		BEGIN
			INSERT INTO OrderTransaction 
			(
				OrderTransactionTypeId,
				Credit,
				Debt,
				CurrencyId,
				OriginalCurrencyId,
				ConvertionRate,
				UserId,
				ProcessId,
				ReservationId,
				PassengerId,
				Notes,
				CreationDate,
				CreationTime,
				AccountId,
				SalesType
			)
			VALUES
			(
				@OrderTransactionTypeId,
				@Amount,
				0,
				@CurrencyId,
				@OriginalCurrencyId,
				@ConvertionRate,
				@UserId,
				@ProcessId,
				@ReservationId,
				@PassengerId,
				@Notes,
				@CreationDate,
				@CreationDate,
				@Id,
				@SalesType
			);
		END
	 IF(@DOC='D')
		BEGIN
			INSERT INTO OrderTransaction 
			(
				OrderTransactionTypeId,
				Credit,
				Debt,
				CurrencyId,
				OriginalCurrencyId,
				ConvertionRate,
				UserId,
				ProcessId,
				ReservationId,
				PassengerId,
				Notes,
				CreationDate,
				CreationTime,
				AccountId,
				SalesType
			)
			VALUES
			(
				@OrderTransactionTypeId,		
				0,
				@Amount,
				@CurrencyId,
				@OriginalCurrencyId,
				@ConvertionRate,
				@UserId,
				@ProcessId,
				@ReservationId,
				@PassengerId,
				@Notes,
				@CreationDate,
				@CreationDate,
				@Id,
				@SalesType
			);
		END

    FETCH  NEXT FROM AccountCursor INTO @Id
	 END
	 CLOSE AccountCursor 	   
	 DEALLOCATE AccountCursor
go

CREATE proc [dbo].[OrderTransactionCreateBySubAccountId] 
	@OrderTransactionTypeId int,
	@Credit decimal(18,2), 
	@Debit decimal(18,2),
	@CurrencyId int,
	@OriginalCurrencyId int,
	@ConvertionRate decimal(18,2),
	@UserId uniqueidentifier,
	@ProcessId uniqueidentifier,
	@ReservationId uniqueidentifier, 
	@PassengerId uniqueidentifier,
	@Notes nvarchar(500), 
	@CreationDate DateTime, 
	@AccountId bigint,
	@SalesType int
as
	declare @Path nvarchar(max)=(Select  AccountPath from SystemAccounts where AccountId=@AccountId)
    declare @Id bigint	 
	declare AccountCursor cursor for SELECT  item FROM    dbo.Split(@Path,'/')
	
	open AccountCursor

	FETCH  NEXT FROM AccountCursor INTO @Id

	 WHILE @@FETCH_STATUS = 0  
	 BEGIN   	

	 INSERT INTO OrderTransaction 
		(
			OrderTransactionTypeId,
			Credit,
			Debt,
			CurrencyId,
			OriginalCurrencyId,
			ConvertionRate,
			UserId,
			ProcessId,
			ReservationId,
			PassengerId,
			Notes,
			CreationDate,
			CreationTime,
			AccountId,
			SalesType
		)
		VALUES
		(
			@OrderTransactionTypeId,
			@Credit,
			@Debit,
			@CurrencyId,
			@OriginalCurrencyId,
			@ConvertionRate,
			@UserId,
			@ProcessId,
			@ReservationId,
			@PassengerId,
			@Notes,
			@CreationDate,
			@CreationDate,
			@Id,
			@SalesType		
		)

    FETCH  NEXT FROM AccountCursor INTO @Id
	 END
	 CLOSE AccountCursor 	   
	 DEALLOCATE AccountCursor
go

create proc [dbo].[OrderTransactionDelete]
@OrderId bigint
as
delete from OrderTransaction
where OrderId=@OrderId
go

create proc [dbo].[OrderTransactionDeleteManuelEnty]
@OrderId bigint
as
declare @ProcessId uniqueidentifier=(select ProcessId from OrderTransaction o
inner join OrderTransactionTypes t on t.OrderTransactionTypeId=o.OrderTransactionTypeId
where o.OrderId=@OrderId and t.SpecialCodes='ME')
delete from OrderTransaction where ProcessId=@ProcessId
go

CREATE proc [dbo].[OrderTransactionDetailsListByAccountIdAndDateRage]    
@AccountId bigint,
@CurrencyId int,
@StartDate date,
@EndDate date
as

create table #TempAccountId(
 AccountId int
 )

create table #TempOrderTranDetails
(
Credit decimal(18,4),
Debt decimal(18,4),
CurrencyName nvarchar(3),
CreationDate datetime,
TransactionDescription nvarchar(100),
PnrNumber nvarchar(10),
TicketNumber nvarchar(20),
PaymentType nvarchar(10),
AccountId int,
OrderId int,
Notes nvarchar(max),
Issuer nvarchar(100),
ProcessId uniqueidentifier,
AccountName nvarchar(400)
)

if((select top 1 CurrencyId from SystemAccounts where AccountId = @AccountId) = 0)
begin
	DECLARE	@return_value int

	EXEC	@return_value = [dbo].[SystemAccountsParentAccountId]
			@AccountId = @AccountId

	insert into #TempAccountId
	EXEC	[dbo].[SystemAccountsIdByParentAccountId]
			@ParentAccountId = @return_value

end 
else
begin 
	insert into #TempAccountId values(@AccountId)
end




insert into #TempOrderTranDetails  select isnull(sum(m.Credit),0) as Credit ,isnull(Sum(m.Debt),0) as Debt ,'' as CurrencyName,dateadd(day,-1,@StartDate) as CreationDate,'Devir' as TransactionDescription,'' as PnrNumber,'' as TicketNumber,isnull(null,'') as PaymentType,isnull(null,'') as AccountId, null as OrderId,'','',dbo.EmptyGuid(), 
(select top 1 syac.AccountName from SystemAccounts syac where syac.AccountId = @AccountId) as AccountName
from OrderTransaction m with(nolock) 
inner join #TempAccountId tmpa on tmpa.AccountId = m.AccountId
where   m.CreationDate<@StartDate

union all

select o.Credit,o.Debt , c.CurrencyName,(CAST(o.CreationDate as datetime)+ CAST(o.CreationTime as datetime)) as CreationDate
,ot.TransactionDescription,

 case when  r.SubProviderId=@AccountId then '-' else  r.PnrNumber end,
 case when  r.SubProviderId=@AccountId then '-' else  p.TicketNumber end,

case

when r.SubProviderId=@AccountId then '-'
else (case when  r.PaymentType=1 then 'CH'  when r.PaymentType=2  then 'CC' when r.PaymentType=3 then 'CC' when r.PaymentType=0 then '-'  end) end ,o.AccountId,
case 
when ( select Count(*) from OrderTransactionTypes k where SpecialCodes='ME' and o.OrderTransactionTypeId=k.OrderTransactionTypeId ) >0  then o.OrderId  end,

o.Notes,(agu.Name+' '+agu.SurName) as Issuer,r.ProcessId,
(select top 1 AccountName from SystemAccounts syac where syac.AccountId = o.AccountId) as AccountName
from OrderTransaction o with(nolock) 

inner join OrderTransactionTypes ot on ot.OrderTransactionTypeId=o.OrderTransactionTypeId
left join Reservations r on r.ReservationId=o.ReservationId
left join PassengersInfo p on p.PassengerId=o.PassengerId
inner join Currencies c on c.CurrencyId=o.CurrencyId
inner join AgencyUsers agu on agu.UserId=o.UserId

inner join #TempAccountId tmpa on tmpa.AccountId = o.AccountId
where  o.CreationDate between @StartDate and @EndDate

select * , SUM( Credit-Debt) OVER(ORDER BY CreationDate, orderId) AS Balance from #TempOrderTranDetails
go

create proc [dbo].[OrderTransactionList]
as
select * from OrderTransaction
go

CREATE proc [dbo].[OrderTransactionListByFilters]    
@AccountId bigint,
@AgencyId uniqueidentifier null,
@CurrencyId int,
@StartDate date,
@EndDate date
as

create table #TempAccountId(
 AccountId int
 )

 create table #AgencyAccountId(
 AccountId int
 )


create table #TempOrderTranDetails
(
	Credit decimal(18,4),
	Debt decimal(18,4),
	CurrencyName nvarchar(3),
	CreationDate datetime,
	TransactionDescription nvarchar(100),
	PnrNumber nvarchar(10),
	TicketNumber nvarchar(20),
	PaymentType nvarchar(10),
	AccountId int,
	OrderId int,
	Notes nvarchar(max),
	Issuer nvarchar(100),
	ProcessId uniqueidentifier,
	AccountName nvarchar(400),
	CorporateAgencyName nvarchar(400),
	SalesType int
)

 if( exists(select top 1 * from AgencyProfile where AgencyId = @AgencyId and IsCreateCorporateAgency = 1))
 begin
	insert into #AgencyAccountId(AccountId)
	select AccountId from AgencyProfile where ParentAgencyId = @AgencyId
	 declare @Id bigint	
	declare AccountCursor cursor for SELECT  AccountId FROM   #AgencyAccountId
	open AccountCursor
	FETCH  NEXT FROM AccountCursor INTO @Id
	 WHILE @@FETCH_STATUS = 0  
	 BEGIN   	

		    if((select top 1 CurrencyId from SystemAccounts where AccountId = @Id) = 0)
			begin
				DECLARE	@return_value1 int

				EXEC	@return_value1 = [dbo].[SystemAccountsParentAccountId]
						@AccountId = @Id

				insert into #TempAccountId
				EXEC	[dbo].[SystemAccountsIdByParentAccountId]
						@ParentAccountId = @return_value1

			end 
			else
			begin 
				insert into #TempAccountId values(@Id)
			end					

	FETCH  NEXT FROM AccountCursor INTO @Id
	 END
	 CLOSE AccountCursor 	   
	 DEALLOCATE AccountCursor


 end

if((select top 1 CurrencyId from SystemAccounts where AccountId = @AccountId) = 0)
begin
	DECLARE	@return_value int

	EXEC	@return_value = [dbo].[SystemAccountsParentAccountId]
			@AccountId = @AccountId

	insert into #TempAccountId
	EXEC	[dbo].[SystemAccountsIdByParentAccountId]
			@ParentAccountId = @return_value

end 
else
begin 
	insert into #TempAccountId values(@AccountId)
end




insert into #TempOrderTranDetails  select isnull(sum(m.Credit),0) as Credit ,isnull(Sum(m.Debt),0) as Debt ,'' as CurrencyName,dateadd(day,-1,@StartDate) as CreationDate,'Devir' as TransactionDescription,'' as PnrNumber,'' as TicketNumber,isnull(null,'') as PaymentType,isnull(null,'') as AccountId, null as OrderId,'','',dbo.EmptyGuid(), 
(select top 1 syac.AccountName from SystemAccounts syac where syac.AccountId = @AccountId) as AccountName,'' as CorporateAgencyName, 0 as SalesType
from OrderTransaction m with(nolock) 
inner join #TempAccountId tmpa on tmpa.AccountId = m.AccountId
where   m.CreationDate<@StartDate

union all

select o.Credit,o.Debt , c.CurrencyName,(CAST(o.CreationDate as datetime)+ CAST(o.CreationTime as datetime)) as CreationDate
,ot.TransactionDescription,

 case when  r.SubProviderId=@AccountId then '-' else  r.PnrNumber end,
 case when  r.SubProviderId=@AccountId then '-' else  p.TicketNumber end,

case

when r.SubProviderId=@AccountId then '-'
else (case when  r.PaymentType=1 then 'CH'  when r.PaymentType=2  then 'CC' when r.PaymentType=3 then 'CC' when r.PaymentType=0 then '-'  end) end ,o.AccountId,
case 
when ( select Count(*) from OrderTransactionTypes k where SpecialCodes='ME' and o.OrderTransactionTypeId=k.OrderTransactionTypeId ) >0  then o.OrderId  end,

o.Notes,(agu.Name+' '+agu.SurName) as Issuer,r.ProcessId,
(select top 1 AccountName from SystemAccounts syac where syac.AccountId = o.AccountId) as AccountName,
 (select top 1 AgencyName from AgencyProfile agp where agp.AgencyId = r.AgencyId) as CorporateAgencyName,
 o.SalesType	
from OrderTransaction o with(nolock) 

inner join OrderTransactionTypes ot on ot.OrderTransactionTypeId=o.OrderTransactionTypeId
left join Reservations r on r.ReservationId=o.ReservationId
left join PassengersInfo p on p.PassengerId=o.PassengerId
inner join Currencies c on c.CurrencyId=o.CurrencyId
inner join AgencyUsers agu on agu.UserId=o.UserId

inner join #TempAccountId tmpa on tmpa.AccountId = o.AccountId
where  o.CreationDate between @StartDate and @EndDate

select * , SUM( Credit-Debt) OVER(ORDER BY CreationDate, orderId) AS Balance from #TempOrderTranDetails
go

create proc [dbo].[OrderTransactionListById]
@OrderId bigint
as
select * from OrderTransaction
where OrderId=@OrderId
go

CREATE proc [dbo].[OrderTransactionTypesAdd]
@TransactionName nvarchar(50), @TransactionDescription nvarchar(50),
@SpecialCodes nvarchar(50),
 @Lang nvarchar(5)
as
insert into OrderTransactionTypes(TransactionName, TransactionDescription,SpecialCodes ,Lang) values(@TransactionName, @TransactionDescription,@SpecialCodes, @Lang)
go

create proc [dbo].[OrderTransactionTypesDelete]
@OrderTransactionTypeId int
as
delete from OrderTransactionTypes
where OrderTransactionTypeId=@OrderTransactionTypeId
go

create proc [dbo].[OrderTransactionTypesList]
as
select * from OrderTransactionTypes
go

create proc [dbo].[OrderTransactionTypesListById]
@OrderTransactionTypeId int
as
select * from OrderTransactionTypes
where OrderTransactionTypeId=@OrderTransactionTypeId
go

create proc [dbo].[OrderTransactionTypesOneItemByCode]
@TransactionName nvarchar(200)
as
select * from OrderTransactionTypes where TransactionName=@TransactionName
go

CREATE proc [dbo].[OrderTransactionTypesUpdate]
@OrderTransactionTypeId int, @TransactionName nvarchar(50), @TransactionDescription nvarchar(50),@SpecialCodes nvarchar(50), @Lang nvarchar(5)
as
update OrderTransactionTypes set TransactionName=@TransactionName, TransactionDescription=@TransactionDescription,SpecialCodes=@SpecialCodes, Lang=@Lang
where OrderTransactionTypeId=@OrderTransactionTypeId
go

CREATE proc [dbo].[OrderTransactionUpdate]
@OrderId bigint, @OrderTransactionTypeId int, @Credit decimal(18,2), @Debt decimal(18,2), @CurrencyId int,
@OriginalCurrencyId int,
 @ConvertionRate decimal(18,2), @UserId uniqueidentifier,@ProcessId uniqueidentifier,
  @ReservationId uniqueidentifier, @PassengerId uniqueidentifier, @Notes nvarchar(500), @CreationDate DateTime, @CreationTime Time, @AccountId bigint,
  @SalesType int
as
update OrderTransaction 
set OrderTransactionTypeId=@OrderTransactionTypeId, Credit=@Credit, Debt=@Debt, CurrencyId=@CurrencyId,OriginalCurrencyId=@OriginalCurrencyId, ConvertionRate=@ConvertionRate, UserId=@UserId,ProcessId=@ProcessId, ReservationId=@ReservationId, PassengerId=@PassengerId,Notes=@Notes, CreationDate=@CreationDate, CreationTime=@CreationTime, 
	AccountId = @AccountId, SalesType = @SalesType
where OrderId = @OrderId
go

CREATE PROCEDURE  [dbo].[OrderTransactionsAccountLastBalance]
@AccountId int 
AS
BEGIN
	 
	 
		select   isnull(SUM( m.Credit-m.Debt), 0) AS Balance 
		from OrderTransaction m with(nolock)
	where m.AccountId=@AccountId 
END
go

CREATE PROCEDURE  [dbo].[OrderTransactionsAccountLastBalanceWithCurrencyId]
@AccountId int ,
@CurrencyId int
AS
BEGIN
	 
	 select   isnull(SUM( m.Credit-m.Debt), 0) AS Balance 
		from OrderTransaction m with(nolock)
	where m.AccountId=@AccountId and m.CurrencyId=@CurrencyId
END
go

CREATE PROCEDURE  [dbo].[OrderTransactionsAgencyLastBalance]
@AgencyId uniqueidentifier 
AS
BEGIN
	 
	declare @AccountId int=(Select AccountId from AgencyProfile where AgencyId=@AgencyId)	 
	select  top 1  isnull(SUM( m.Credit-m.Debt) OVER(ORDER BY (cast((m.CreationDate) as datetime)+cast((m.CreationTime) as datetime)), m.OrderId),0) AS Balance from OrderTransaction m with(nolock)
	where m.AccountId=@AccountId
	order by (cast((m.CreationDate) as datetime)+cast((m.CreationTime) as datetime)) desc

END
go

CREATE PROCEDURE  [dbo].[OrderTransactionsAgencyLastBalanceWithCurrencyId]
@AgencyId uniqueidentifier ,
@CurrencyId int
AS
BEGIN
	declare @AccountId int;	 
	declare @IsCreateCorporateAgency bit;

	Select @AccountId = AccountId, @IsCreateCorporateAgency = IsCreateCorporateAgency from AgencyProfile where AgencyId=@AgencyId

	if(@IsCreateCorporateAgency = 1)
	begin
		select isnull(SUM( m.Credit-m.Debt) ,0) AS Balance from OrderTransaction m with(nolock)
		where m.CurrencyId=@CurrencyId
		and (m.AccountId=@AccountId or m.AccountId in (select agp.AccountId from AgencyProfile agp where agp.ParentAgencyId = @AgencyId ))
	end
	else
	begin 
		select isnull(SUM( m.Credit-m.Debt) ,0) AS Balance from OrderTransaction m with(nolock)
		where m.AccountId=@AccountId and m.CurrencyId=@CurrencyId
	end
	

END
go

create PROCEDURE  [dbo].[OrderTransactionsAgencyLastBalanceWithCurrencyIdBackup]
@AgencyId uniqueidentifier ,
@CurrencyId int
AS
BEGIN
	 
	declare @AccountId int=(Select AccountId from AgencyProfile where AgencyId=@AgencyId)	 
	select  top 1  isnull(SUM( m.Credit-m.Debt) OVER(ORDER BY (cast((m.CreationDate) as datetime)+cast((m.CreationTime) as datetime)), m.OrderId),0) AS Balance from OrderTransaction m with(nolock)
	where m.AccountId=@AccountId and m.CurrencyId=@CurrencyId
	order by (cast((m.CreationDate) as datetime)+cast((m.CreationTime) as datetime)) desc

END
go

create PROCEDURE  [dbo].[OrderTransactionsCorporateAgencyBalanceWithSalesType]
@AccountId int ,
@CurrencyId int,
@SalesType int
AS
BEGIN
	 
	 
	select  top 1  isnull(SUM( m.Credit-m.Debt) OVER(ORDER BY (cast((m.CreationDate) as datetime)+cast((m.CreationTime) as datetime)), m.OrderId),0) AS Balance 
	from OrderTransaction m with(nolock)
	where m.AccountId=@AccountId and m.CurrencyId=@CurrencyId and m.SalesType = @SalesType
	order by (cast((m.CreationDate) as datetime)+cast((m.CreationTime) as datetime)) desc

END
go

CREATE proc [dbo].[PassengerCharterTicketNumber]
as
select COUNT(r.ReservationId)+1 from Reservations r 
inner join PassengersInfo p on p.ReservationId=r.ReservationId
where r.SupplierName='Charter'
go

create proc [dbo].[PassengerInfoByReservationId]
 @ReservationId uniqueidentifier
 as
 select * from PassengersInfo where ReservationId=@ReservationId
 order by PassengerIndex asc
go

create proc [dbo].[PassengerInfosCharterProvided]
@CharterGroupId uniqueidentifier
as

select * from PassengersInfo where PassengerId in(
(Select PassengerId from FlightPriceInfo where FareReferanceId in ( select p.CharterPriceId from CharterPrices p where p.CharterGroupId=@CharterGroupId))) and PassengerIndex=0
go

create proc [dbo].[PassengerTypesAdd]
@PassengerTypeName nvarchar(50), @PassengerTypeValue int, @Description nvarchar(50), @Lang nvarchar(5)
as
insert into PassengerTypes(PassengerTypeName, PassengerTypeValue, Description, Lang) values(@PassengerTypeName, @PassengerTypeValue, @Description, @Lang)
go

create proc [dbo].[PassengerTypesDelete]
@PassengerTypeId int
as
delete from PassengerTypes
where PassengerTypeId=@PassengerTypeId
go

create proc [dbo].[PassengerTypesList]
as
select * from PassengerTypes
go

create proc [dbo].[PassengerTypesListById]
@PassengerTypeId int
as
select * from PassengerTypes
where PassengerTypeId=@PassengerTypeId
go

create proc [dbo].[PassengerTypesListByLang]
@Lang nvarchar(5)
as
select * from PassengerTypes where Lang=@Lang Order by PassengerTypeValue
go

create proc [dbo].[PassengerTypesUpdate]
@PassengerTypeId int, @PassengerTypeName nvarchar(50), @PassengerTypeValue int, @Description nvarchar(50), @Lang nvarchar(5)
as
update PassengerTypes set PassengerTypeName=@PassengerTypeName, PassengerTypeValue=@PassengerTypeValue, Description=@Description, Lang=@Lang
where PassengerTypeId=@PassengerTypeId
go

CREATE proc [dbo].[PassengersInfoAdd] @PassengerId uniqueidentifier,
                                      @ReservationId uniqueidentifier,
                                      @Name nvarchar(50),
                                      @SurName nvarchar(50),
                                      @PassengerType int,
                                      @Gender int,
                                      @GsmArea nvarchar(5),
                                      @GsmNumber nvarchar(25),
                                      @BirthDate DateTime,
                                      @EmailAdress nvarchar(50),
                                      @PassengerIndex int,
                                      @TicketNumber nvarchar(50),
                                      @NeedWheelChair int,
                                      @PhoneArea nvarchar(5),
                                      @PhoneNumber nvarchar(50),
                                      @CitizenNumber nvarchar(11),
                                      @PassportSerialNumber nvarchar(10),
                                      @PassportNumber nvarchar(50),
                                      @PassportEndDate DateTime,
                                      @PassportCountry nvarchar(5),
                                      @SupplierCardNumber nvarchar(50),
                                      @ForcePassportInfo bit,
                                      @ProviderId int,
                                      @SupplierName nvarchar(50),
                                      @CompanyName nvarchar(250),
                                      @TaxOffice nvarchar(50),
                                      @TaxNumber nvarchar(50),
                                      @ZipCode nvarchar(50) = null,
                                      @Adress nvarchar(500) = null,
                                      @City nvarchar(50) = null,
                                      @Country nvarchar(50) = null,
                                      @CreationDate datetime,
                                      @SendSMS bit,
                                      @FakeNameApprove bit
as
insert into PassengersInfo(PassengerId, ReservationId, Name, SurName, PassengerType, Gender, GsmArea, GsmNumber,
                           BirthDate, EmailAdress, PassengerIndex, TicketNumber, NeedWheelChair, PhoneArea, PhoneNumber,
                           CitizenNumber, PassportSerialNumber, PassportNumber, PassportEndDate, PassportCountry,
                           SupplierCardNumber, ForcePassportInfo, ProviderId, SupplierName,
                           CompanyName,
                           TaxOffice,
                           TaxNumber,
                           ZipCode,
                           Adress,
                           City,
                           Country, CreationDate, SendSMS, FakeNameApprove)
values (@PassengerId, @ReservationId, @Name, @SurName, @PassengerType, @Gender, @GsmArea, @GsmNumber, @BirthDate,
        @EmailAdress, @PassengerIndex, @TicketNumber, @NeedWheelChair, @PhoneArea, @PhoneNumber, @CitizenNumber,
        @PassportSerialNumber, @PassportNumber, @PassportEndDate, @PassportCountry, @SupplierCardNumber,
        @ForcePassportInfo, @ProviderId, @SupplierName,
        @CompanyName, @TaxOffice, @TaxNumber, @ZipCode, @Adress, @City, @Country, @CreationDate, @SendSMS, @FakeNameApprove)
go

create proc [dbo].[PassengersInfoByProcessId]
@ProcessId uniqueidentifier
as
select * from Reservations r 
inner Join PassengersInfo p on p.ReservationId=r.ReservationId
where r.ProcessId=@ProcessId
go

create proc [dbo].[PassengersInfoByProcessIdAndSupplierName]
@SupplierName nvarchar(50),
@ProcessId uniqueidentifier
as

declare @ReservationId uniqueidentifier
set @ReservationId= (select  ReservationId from Reservations  where ProcessId=@ProcessId and SupplierName=@SupplierName)
select * from  PassengersInfo where ReservationId=@ReservationId 
Order By PassengerIndex asc
go

create proc [dbo].[PassengersInfoByTicketNumber]
@TicketNumber nvarchar(20)
as
Select * from PassengersInfo where TicketNumber=@TicketNumber and TicketNumber<>''
go

create proc [dbo].[PassengersInfoDelete]
@PassengerId uniqueidentifier
as
delete from PassengersInfo
where PassengerId=@PassengerId
go

create proc [dbo].[PassengersInfoList]
as
select * from PassengersInfo
go

create proc [dbo].[PassengersInfoListById]
@PassengerId uniqueidentifier
as
select * from PassengersInfo
where PassengerId=@PassengerId
go

create proc [dbo].[PassengersInfoOneItemDefaultPassengerByProcessId]
@ProcessId uniqueidentifier
as
select Top 1 * from PassengersInfo where ReservationId=(Select Top 1 ReservationId  From Reservations where ProcessId=@ProcessId) and PassengerIndex=0
go

CREATE proc [dbo].[PassengersInfoUpdate] @PassengerId uniqueidentifier, @ReservationId uniqueidentifier,
                                         @Name nvarchar(50), @SurName nvarchar(50), @PassengerType int, @Gender int,
                                         @GsmArea nvarchar(5), @GsmNumber nvarchar(25), @BirthDate DateTime,
                                         @EmailAdress nvarchar(50), @PassengerIndex int, @TicketNumber nvarchar(50),
                                         @NeedWheelChair int, @PhoneArea nvarchar(5), @PhoneNumber nvarchar(50),
                                         @CitizenNumber nvarchar(11), @PassportSerialNumber nvarchar(10),
                                         @PassportNumber nvarchar(50), @PassportEndDate DateTime,
                                         @PassportCountry nvarchar(5), @SupplierCardNumber nvarchar(50),
                                         @ForcePassportInfo bit, @ProviderId int, @SupplierName nvarchar(50),
                                         @CompanyName nvarchar(250),
                                         @TaxOffice nvarchar(50),
                                         @TaxNumber nvarchar(50),
                                         @ZipCode nvarchar(50) = null,
                                         @Adress nvarchar(500) = null,
                                         @City nvarchar(50) = null,
                                         @Country nvarchar(50) = null,
                                         @CreationDate datetime,
                                         @SendSMS bit
as
update PassengersInfo
set ReservationId=@ReservationId,
    Name=@Name,
    SurName=@SurName,
    PassengerType=@PassengerType,
    Gender=@Gender,
    GsmArea=@GsmArea,
    GsmNumber=@GsmNumber,
    BirthDate=@BirthDate,
    EmailAdress=@EmailAdress,
    PassengerIndex=@PassengerIndex,
    TicketNumber=@TicketNumber,
    NeedWheelChair=@NeedWheelChair,
    PhoneArea=@PhoneArea,
    PhoneNumber=@PhoneNumber,
    CitizenNumber=@CitizenNumber,
    PassportSerialNumber=@PassportSerialNumber,
    PassportNumber=@PassportNumber,
    PassportEndDate=@PassportEndDate,
    PassportCountry=@PassportCountry,
    SupplierCardNumber=@SupplierCardNumber,
    ForcePassportInfo=@ForcePassportInfo,
    ProviderId=@ProviderId,
    SupplierName=@SupplierName,

    CompanyName=@CompanyName,
    TaxOffice=@TaxOffice,
    TaxNumber=@TaxNumber,
    ZipCode=@ZipCode,
    Adress=@Adress,
    City=@City,
    Country=@Country,
    CreationDate=@CreationDate,
    SendSMS=@SendSMS
where PassengerId = @PassengerId
go

create proc [dbo].[PassportRequieredCountriesAdd]
@IsRequiered bit
as
insert into PassportRequieredCountries(IsRequiered) values(@IsRequiered)
go

create proc [dbo].[PassportRequieredCountriesDelete]
@CountryName nvarchar(500)
as
delete from PassportRequieredCountries
where CountryName=@CountryName
go

create proc [dbo].[PassportRequieredCountriesList]
as
select * from PassportRequieredCountries
go

create proc [dbo].[PassportRequieredCountriesListById]
@CountryName nvarchar(500)
as
select * from PassportRequieredCountries
where CountryName=@CountryName
go

create proc [dbo].[PassportRequieredCountriesUpdate]
@CountryName nvarchar(500), @IsRequiered bit
as
update PassportRequieredCountries set IsRequiered=@IsRequiered
where CountryName=@CountryName
go

create proc [dbo].[PnrHistoryAdd]
@ReservationId uniqueidentifier, @TicketProcessType int, @UserId uniqueidentifier, @Notes nvarchar(max), @CreationDate datetime
as
insert into PnrHistory(ReservationId, TicketProcessType, UserId, Notes, CreationDate) values(@ReservationId, @TicketProcessType, @UserId, @Notes, @CreationDate)
go

create proc [dbo].[PnrHistoryDelete]
@PnrHistoryId int
as
delete from PnrHistory
where PnrHistoryId=@PnrHistoryId
go

create proc [dbo].[PnrHistoryList]
as
select * from PnrHistory
go

create proc [dbo].[PnrHistoryListById]
@PnrHistoryId int
as
select * from PnrHistory
where PnrHistoryId=@PnrHistoryId
go

create proc [dbo].[PnrHistoryUpdate]
@PnrHistoryId int, @ReservationId uniqueidentifier, @TicketProcessType int, @UserId uniqueidentifier, @Notes nvarchar(max), @CreationDate datetime
as
update PnrHistory set ReservationId=@ReservationId, TicketProcessType=@TicketProcessType, UserId=@UserId, Notes=@Notes, CreationDate=@CreationDate
where PnrHistoryId=@PnrHistoryId
go

create proc [dbo].[PnrVendorRemaksAdd]
@PnrNumber nvarchar(50), @AirWayName nvarchar(225), @VendorMessage nvarchar(max), @CreationDate datetime
as
insert into PnrVendorRemaks(PnrNumber, AirWayName, VendorMessage, CreationDate) values(@PnrNumber, @AirWayName, @VendorMessage, @CreationDate)
go

create proc [dbo].[PnrVendorRemaksDelete]
@VendorRemarksId uniqueidentifier
as
delete from PnrVendorRemaks
where VendorRemarksId=@VendorRemarksId
go

create proc [dbo].[PnrVendorRemaksList]
as
select * from PnrVendorRemaks
go

create proc [dbo].[PnrVendorRemaksListById]
@VendorRemarksId uniqueidentifier
as
select * from PnrVendorRemaks
where VendorRemarksId=@VendorRemarksId
go

create proc [dbo].[PnrVendorRemaksListByPnrNumber]
@PnrNumber nvarchar(6)
as
select * from PnrVendorRemaks where PnrNumber=@PnrNumber
go

create proc [dbo].[PnrVendorRemaksUpdate]
@VendorRemarksId uniqueidentifier, @PnrNumber nvarchar(50), @AirWayName nvarchar(225), @VendorMessage nvarchar(max), @CreationDate datetime
as
update PnrVendorRemaks set PnrNumber=@PnrNumber, AirWayName=@AirWayName, VendorMessage=@VendorMessage, CreationDate=@CreationDate
where VendorRemarksId=@VendorRemarksId
go

create proc [dbo].[PnrVendorRemarkPatternsAdd]
@PatternType nvarchar(500), @PatternFormat nvarchar(50), @Description nvarchar(250)
as
insert into PnrVendorRemarkPatterns(PatternType, PatternFormat, Description) values(@PatternType, @PatternFormat, @Description)
go

create proc [dbo].[PnrVendorRemarkPatternsDelete]
@PnrVendorRemarkPatternId uniqueidentifier
as
delete from PnrVendorRemarkPatterns
where PnrVendorRemarkPatternId=@PnrVendorRemarkPatternId
go

create proc [dbo].[PnrVendorRemarkPatternsList]
as
select * from PnrVendorRemarkPatterns
go

create proc [dbo].[PnrVendorRemarkPatternsListById]
@PnrVendorRemarkPatternId uniqueidentifier
as
select * from PnrVendorRemarkPatterns
where PnrVendorRemarkPatternId=@PnrVendorRemarkPatternId
go

create proc [dbo].[PnrVendorRemarkPatternsUpdate]
@PnrVendorRemarkPatternId uniqueidentifier, @PatternType nvarchar(500), @PatternFormat nvarchar(50), @Description nvarchar(250)
as
update PnrVendorRemarkPatterns set PatternType=@PatternType, PatternFormat=@PatternFormat, Description=@Description
where PnrVendorRemarkPatternId=@PnrVendorRemarkPatternId
go

create proc [dbo].[ProcessTransactionTypesAdd]
@Description nvarchar(max)
as
insert into ProcessTransactionTypes(Description) values(@Description)
go

create proc [dbo].[ProcessTransactionTypesDelete]
@ProcessTransactionTypeId int
as
delete from ProcessTransactionTypes
where ProcessTransactionTypeId=@ProcessTransactionTypeId
go

create proc [dbo].[ProcessTransactionTypesList]
as
select * from ProcessTransactionTypes
go

create proc [dbo].[ProcessTransactionTypesListById]
@ProcessTransactionTypeId int
as
select * from ProcessTransactionTypes
where ProcessTransactionTypeId=@ProcessTransactionTypeId
go

create proc [dbo].[ProcessTransactionTypesUpdate]
@ProcessTransactionTypeId int, @Description nvarchar(max)
as
update ProcessTransactionTypes set Description=@Description
where ProcessTransactionTypeId=@ProcessTransactionTypeId
go

create proc [dbo].[ProcessTransactionsAdd]
@ExceptionText nvarchar(max), @CreationDate datetime, @ProcessTransactionTypeId int
as
insert into ProcessTransactions(ExceptionText, CreationDate, ProcessTransactionTypeId) values(@ExceptionText, @CreationDate, @ProcessTransactionTypeId)
go

create proc [dbo].[ProcessTransactionsDelete]
@ProcessId uniqueidentifier
as
delete from ProcessTransactions
where ProcessId=@ProcessId
go

create proc [dbo].[ProcessTransactionsList]
as
select * from ProcessTransactions
go

create proc [dbo].[ProcessTransactionsListById]
@ProcessId uniqueidentifier
as
select * from ProcessTransactions
where ProcessId=@ProcessId
go

create proc [dbo].[ProcessTransactionsUpdate]
@ProcessId uniqueidentifier, @ExceptionText nvarchar(max), @CreationDate datetime, @ProcessTransactionTypeId int
as
update ProcessTransactions set ExceptionText=@ExceptionText, CreationDate=@CreationDate, ProcessTransactionTypeId=@ProcessTransactionTypeId
where ProcessId=@ProcessId
go

CREATE proc [dbo].[ProviderDashboardList]
@AgencyId uniqueidentifier = null,
@StartDate datetime,
@EndDate datetime,
@ByaAgencyId uniqueidentifier = null
as
SELECT CreationDate Date, [SupplierName] Type, COUNT(*) Value
FROM [dbo].[ReservationDashboardView]
where 
	(@AgencyId is null or AgencyId = @AgencyId) 
	and CreationDate >= @StartDate 
	and CreationDate <= @EndDate 
	and PnrStatus = 1
	and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
group by CreationDate, [SupplierName]
order by CreationDate
go

CREATE PROCEDURE [dbo].[ProviderFinancialDashboardList]
@AgencyId uniqueidentifier = null,	
@StartDate datetime,
@EndDate datetime,
@ByaAgencyId uniqueidentifier = null
AS
    SELECT CreationDate Date, SupplierName Type, SUM(TotalPrice) Price
	FROM [dbo].[FinancialDashboardView]
	where 
		(@AgencyId is null or AgencyId = @AgencyId) 
		and CreationDate >= @StartDate 
		and CreationDate <= @EndDate 
		and ReservationType='Ticketed'
		and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
	group by CreationDate, [SupplierName]
	order by CreationDate
go

Create Proc [dbo].[ProviderRouteListAdd]
@Departure nvarchar(5),
@Arrival nvarchar(5),
@ProviderDesc nvarchar(50),
@Status bit
as
INSERT INTO ProviderRouteList(
Departure,
Arrival,
ProviderDesc,
Status
)
VALUES
(
@Departure,
@Arrival,
@ProviderDesc,
@Status
)
go

Create Proc [dbo].[ProviderRouteListDelete]
@ProviderRouteListId uniqueidentifier
AS
DELETE  FROM ProviderRouteList
WHERE ProviderRouteListId=@ProviderRouteListId
go

Create Proc [dbo].[ProviderRouteListList]
as
SELECT * FROM ProviderRouteList
go

Create Proc [dbo].[ProviderRouteListListById]
@ProviderRouteListId uniqueidentifier
AS
SELECT * FROM ProviderRouteList
WHERE ProviderRouteListId=@ProviderRouteListId
go

Create Proc [dbo].[ProviderRouteListUpdate]
@ProviderRouteListId uniqueidentifier,
@Departure nvarchar(5),
@Arrival nvarchar(5),
@ProviderDesc nvarchar(50),
@Status bit
AS
UPDATE ProviderRouteList
SET
Departure=@Departure,
Arrival=@Arrival,
ProviderDesc=@ProviderDesc,
Status=@Status
WHERE ProviderRouteListId=@ProviderRouteListId
go

create proc [dbo].[ReceiptInfoAdd]
@ProcessId uniqueidentifier, @Name nvarchar(50), @Surname nvarchar(50), @TcNo nvarchar(50), @Adress nvarchar(50), @City nvarchar(50), @Country nvarchar(50), @IsCompany bit, @CompanyName nvarchar(500), @TaxOffice nvarchar(50), @TaxNumber nvarchar(50), @ZipCode nvarchar(50), @PassengerIndex int
as
insert into ReceiptInfo(ProcessId, Name, Surname, TcNo, Adress, City, Country, IsCompany, CompanyName, TaxOffice, TaxNumber, ZipCode, PassengerIndex) values(@ProcessId, @Name, @Surname, @TcNo, @Adress, @City, @Country, @IsCompany, @CompanyName, @TaxOffice, @TaxNumber, @ZipCode, @PassengerIndex)
go

create proc [dbo].[ReceiptInfoByProcessId]
@ProcessId uniqueidentifier
as
select * from ReceiptInfo where ProcessId=@ProcessId
go

create proc [dbo].[ReceiptInfoDelete]
@ReceiptId int
as
delete from ReceiptInfo
where ReceiptId=@ReceiptId
go

create proc [dbo].[ReceiptInfoList]
as
select * from ReceiptInfo
go

create proc [dbo].[ReceiptInfoListById]
@ReceiptId int
as
select * from ReceiptInfo
where ReceiptId=@ReceiptId
go

create proc [dbo].[ReceiptInfoUpdate]
@ReceiptId int, @ProcessId uniqueidentifier, @Name nvarchar(50), @Surname nvarchar(50), @TcNo nvarchar(50), @Adress nvarchar(50), @City nvarchar(50), @Country nvarchar(50), @IsCompany bit, @CompanyName nvarchar(500), @TaxOffice nvarchar(50), @TaxNumber nvarchar(50), @ZipCode nvarchar(50), @PassengerIndex int
as
update ReceiptInfo set ProcessId=@ProcessId, Name=@Name, Surname=@Surname, TcNo=@TcNo, Adress=@Adress, City=@City, Country=@Country, IsCompany=@IsCompany, CompanyName=@CompanyName, TaxOffice=@TaxOffice, TaxNumber=@TaxNumber, ZipCode=@ZipCode, PassengerIndex=@PassengerIndex
where ReceiptId=@ReceiptId
go

CREATE proc [dbo].[ReportsCarrierSelling]  
 @Carriercode nvarchar(5),
 @StartDate date,
 @EndDate date
 as
 

 select r.ProcessId, c.CurrencyName, r.PnrNumber,p.BasePrice,p.Tax,ps.TicketNumber,ps.Name,ps.SurName,r.CreationDate from Reservations r 
 inner join FlightPriceInfo p on p.ReservationId=r.ReservationId
 inner  join FlightsInfo f on f.ReservationId=r.ReservationId
 inner join PassengersInfo ps on ps.PassengerId=p.PassengerId
 inner join Currencies c on c.CurrencyId=p.CurrencyId
 where  r.CreationDate between @StartDate and @EndDate  and p.FareStatus=1
 and  FlightIndex=0 and f.CarrierCode=@Carriercode
 order by r.CreationDate desc
go

CREATE proc [dbo].[ReportsSellingReports]  
@AgencyId uniqueidentifier,
@ProviderId int,
@FareStatus int,
@StartDate nvarchar(50),
@EndDate nvarchar(50),
@CurrencyId int,
@ByaAgencyId uniqueidentifier = null
as



declare @query nvarchar(500)= 'select * from vw_TicketBaseReporting rs where cast(rs.CreationDate as date) between cast(@StartDate as date) and  cast(@EndDate as date)  and CurrencyId=@CurrencyId'

if (dbo.EmptyGuid()<>@AgencyId)
begin

 set @query = @query + ' and  AgencyId=@AgencyId '

end

if(@FareStatus<>-1)
begin 
 set @query = @query + ' and FareStatus=@FareStatus '
end

if(@ProviderId<>-1)
begin 
 set @query = @query + ' and SupplierId=@ProviderId '
end

if(@ByaAgencyId is not null)
begin 
	set @query = @query + ' and AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId) '
end

set @query = @query +' order by rs.CreationDate  desc '

declare @ParamDef nvarchar(max) 

set @ParamDef='@AgencyId uniqueidentifier, @StartDate nvarchar(50),@EndDate nvarchar(50),@ProviderId int,@FareStatus int , @CurrencyId int, @ByaAgencyId uniqueidentifier = null'

EXECUTE sp_Executesql @query,@ParamDef,@AgencyId,@StartDate,@EndDate,@ProviderId,@FareStatus,@CurrencyId, @ByaAgencyId
go

CREATE proc [dbo].[ReportsSellingReportsNextFlight]
	@AgencyId uniqueidentifier,
	@ProviderId int,
	@FareStatus int,
	@StartDate nvarchar(50),
	@EndDate nvarchar(50),
	@CurrencyId int,
	@ParentAgencyId uniqueidentifier = null
as
declare @query nvarchar(500)= 'select * from vw_TicketBaseReporting rs where cast(rs.FlightDate as date) between cast(@StartDate as date) and  cast(@EndDate as date)  and CurrencyId=@CurrencyId'

if (dbo.EmptyGuid()<>@AgencyId)
begin

	set @query = @query + ' and  AgencyId=@AgencyId '

end

if(@FareStatus<>-1)
begin
	set @query = @query + ' and FareStatus=@FareStatus '
end

if(@ProviderId<>-1)
begin
	set @query = @query + ' and SupplierId=@ProviderId '
end

if(@ParentAgencyId is not null and @ParentAgencyId <> dbo.EmptyGuid())
begin
	set @query = @query + ' and AgencyId in (select pagp.AgencyId from AgencyProfile pagp where pagp.AgencyId = @ParentAgencyId or pagp.ParentAgencyId = @ParentAgencyId ) '
end

set @query = @query +' order by rs.FlightDate  asc '

declare @ParamDef nvarchar(max) 

set @ParamDef='@AgencyId uniqueidentifier, @StartDate nvarchar(50),@EndDate nvarchar(50),@ProviderId int,@FareStatus int , @CurrencyId int, @ParentAgencyId uniqueidentifier = null'

EXECUTE sp_Executesql @query,@ParamDef,@AgencyId,@StartDate,@EndDate,@ProviderId,@FareStatus,@CurrencyId, @ParentAgencyId
go

Create proc [dbo].[ReportsSubProviderSellingReports]  

@ProviderId int,
@StartDate nvarchar(50),
@EndDate nvarchar(50)

as
 
declare @query nvarchar(500)= 'select * from vw_TicketBaseReporting rs where cast(rs.CreationDate as date) between cast(@StartDate as date) and  cast(@EndDate as date)'
 

if(@ProviderId<>-1)
begin 
 set @query = @query + ' and SubProviderId=@ProviderId '
end

set @query = @query +' order by rs.CreationDate  desc '

declare @ParamDef nvarchar(max) 

set @ParamDef='@StartDate nvarchar(50),@EndDate nvarchar(50),@ProviderId int'

EXECUTE sp_Executesql @query,@ParamDef,@StartDate,@EndDate,@ProviderId
go

CREATE proc [dbo].[ReportsVPosReports]  
@AgencyId uniqueidentifier,
@BankId uniqueidentifier,
@PaymentStatus int,
@StartDate nvarchar(50),
@EndDate nvarchar(50),
@CurrencyId int,
@ByaAgencyId uniqueidentifier = null
as



declare @query nvarchar(500)= 'select * from vw_BankPosLogs rs where cast(rs.CreationDate as date) between cast(@StartDate as date) and  cast(@EndDate as date)  and CurrencyId=@CurrencyId '

if (dbo.EmptyGuid()<>@AgencyId)
begin

 set @query = @query + ' and  AgencyId=@AgencyId '

end

if (dbo.EmptyGuid()<>@BankId)
begin

 set @query = @query + ' and  BankId=@BankId '

end

if(@PaymentStatus<>-1)
begin 
 set @query = @query + ' and PaymentStatus=@PaymentStatus '
end
 
if(@ByaAgencyId is not null)
begin 
	set @query = @query + ' and AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId) '
end

set @query = @query +' order by rs.CreationDate  desc '

declare @ParamDef nvarchar(max) 

set @ParamDef='@AgencyId uniqueidentifier, @StartDate nvarchar(50),@EndDate nvarchar(50),@BankId uniqueidentifier, @PaymentStatus int,@CurrencyId int, @ByaAgencyId uniqueidentifier = null'

EXECUTE sp_Executesql @query,@ParamDef,@AgencyId,@StartDate,@EndDate,@BankId,@PaymentStatus,@CurrencyId,@ByaAgencyId
go

CREATE FUNCTION [dbo].[RequestEqualSearchIdToProcessId]
(
	 @ProcessId uniqueidentifier,
	 @SearchId uniqueidentifier
)
RETURNS  bit
AS
BEGIN
	 
	 declare @Status bit =0
	if(@ProcessId<>@SearchId)
	Begin
	set @Status=1
	End
	Else
	Begin
	Set @Status=0
	End

	Return @Status

END
go

CREATE PROC [dbo].[ReservationByPnrNumber]
@PnrNumber nvarchar(10)
AS
SELECT * FROM Reservations WHERE PnrNumber=@PnrNumber
go

CREATE proc [dbo].[ReservationDashboardList]
@AgencyId uniqueidentifier = null,
@StartDate datetime,
@EndDate datetime,
@ByaAgencyId uniqueidentifier = null
as
SELECT CreationDate Date, [ReservationType] Type, COUNT(*) Value
FROM [dbo].[ReservationDashboardView]
where
	(@AgencyId is null or AgencyId = @AgencyId)
	and CreationDate >= @StartDate
	and CreationDate <= @EndDate
	and PnrStatus in (0,1,2,3)
	and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
group by CreationDate, [ReservationType]
order by CreationDate
go

create proc [dbo].[ReservationForceSSRSFOIDInfo]
 @ProcessId uniqueidentifier
 as
 select p.* from Reservations r 
 inner join PassengersInfo p on p.ReservationId=r.ReservationId
where r.ProcessId=@ProcessId and p.ForcePassportInfo=1
go

create proc [dbo].[ReservationHXControlList]
as
select * from Reservations  where PnrStatus=4   and CreationDate > DATEADD(DAY,-1,GETDATE()) order by CreationDate desc
go

CREATE Proc [dbo].[ReservationHistoryAdd]
@Id uniqueidentifier,
@ReservationId uniqueidentifier,
@ParentReservationId uniqueidentifier,
@UserId uniqueidentifier,
@ProcessId uniqueidentifier = null,
@CreationDate datetime
as
INSERT INTO ReservationHistory(
Id,
ReservationId,
ParentReservationId,
UserId,
ProcessId,
CreationDate
)
VALUES
(
@Id,
@ReservationId,
@ParentReservationId,
@UserId,
@ProcessId,
@CreationDate
)
go

Create Proc [dbo].[ReservationHistoryDelete]
@Id uniqueidentifier
AS
DELETE  FROM ReservationHistory
WHERE Id=@Id
go

Create Proc [dbo].[ReservationHistoryList]
as
SELECT * FROM ReservationHistory
go

Create Proc [dbo].[ReservationHistoryListById]
@Id uniqueidentifier
AS
SELECT * FROM ReservationHistory
WHERE Id=@Id
go

Create Proc [dbo].[ReservationHistoryOneItemByReservationId]
@ReservationId uniqueidentifier
AS
SELECT * FROM ReservationHistory
WHERE ReservationId=@ReservationId
go

CREATE Proc [dbo].[ReservationHistoryTopParentReservation]
@ReservationId uniqueidentifier 
AS

 DECLARE @TopParentReservationId uniqueidentifier = null;
 
WITH TopParentFinder AS
(
    SELECT ReservationId,ParentReservationId,UserId,CreationDate FROM ReservationHistory 
    WHERE ReservationId = @ReservationId

    UNION ALL

    SELECT rh.ReservationId,rh.ParentReservationId,rh.UserId,rh.CreationDate  FROM ReservationHistory rh
    INNER JOIN TopParentFinder rc ON rh.ReservationId = rc.ParentReservationId
)

SELECT @TopParentReservationId = tpf.ReservationId
FROM TopParentFinder tpf left join Reservations r on tpf.ReservationId = r.ReservationId where (r.PnrStatus = 1 or r.PnrStatus = 3 or r.PnrStatus = 5 or r.PnrStatus = 6)
ORDER BY tpf.CreationDate ASC

Select * from Reservations where ReservationId = @TopParentReservationId
go

CREATE Proc [dbo].[ReservationHistoryUpdate]
@Id uniqueidentifier,
@ReservationId uniqueidentifier,
@ParentReservationId uniqueidentifier,
@UserId uniqueidentifier,
@ProcessId uniqueidentifier = null,
@CreationDate datetime
AS
UPDATE ReservationHistory
SET
Id=@Id,
ReservationId=@ReservationId,
ParentReservationId=@ParentReservationId,
UserId=@UserId,
ProcessId = @ProcessId,
CreationDate=@CreationDate
WHERE Id=@Id
go

Create Proc [dbo].[ReservationInvoiceCustomerAdd]
@CustomerId uniqueidentifier,
@ReservationId uniqueidentifier
as
INSERT INTO ReservationInvoiceCustomer(
CustomerId,
ReservationId
)
VALUES
(
@CustomerId,
@ReservationId)
go

create proc [dbo].[ReservationInvoiceCustomerOneItemByReservationId]
     @ReservationId uniqueidentifier
as
select * 
from ReservationInvoiceCustomer
where ReservationId = @ReservationId
go

create proc [dbo].[ReservationListByProcessId]
@ProcessId uniqueidentifier
as
select * from Reservations where ProcessId=@ProcessId
order by CreationDate desc
go

CREATE proc [dbo].[ReservationNotesAdd]
@ReservationNote nvarchar(4000), @CreationDate datetime, @ProcessId uniqueidentifier
as
insert into ReservationNotes(ReservationNote, CreationDate, ProcessId) values(@ReservationNote, @CreationDate, @ProcessId)
go

create proc [dbo].[ReservationNotesDelete]
@ReservationNoteId uniqueidentifier
as
delete from ReservationNotes
where ReservationNoteId=@ReservationNoteId
go

create proc [dbo].[ReservationNotesList]
as
select * from ReservationNotes
go

create proc [dbo].[ReservationNotesListById]
@ReservationNoteId uniqueidentifier
as
select * from ReservationNotes
where ReservationNoteId=@ReservationNoteId
go

create proc [dbo].[ReservationNotesListByProcessId]
@ProcessId uniqueidentifier
as
select * from ReservationNotes
where ProcessId=@ProcessId
go

CREATE proc [dbo].[ReservationNotesUpdate]
@ReservationNoteId uniqueidentifier, @ReservationNote nvarchar(4000), @CreationDate datetime, @ProcessId uniqueidentifier
as
update ReservationNotes set ReservationNote=@ReservationNote, CreationDate=@CreationDate, ProcessId=@ProcessId
where ReservationNoteId=@ReservationNoteId
go

CREATE proc [dbo].[ReservationProviderInfoAdd]
@ReservationId uniqueidentifier, @ReferenceNumber nvarchar(50)
as
insert into ReservationProviderInfo(ReservationId, ReferenceNumber) values(@ReservationId, @ReferenceNumber)
go

CREATE proc [dbo].[ReservationProviderInfoByRsrvtionId]
@ReservationId uniqueidentifier
as
select * from ReservationProviderInfo
where ReservationId = @ReservationId
go

CREATE proc [dbo].[ReservationProviderInfoDelete]
@ProviderId uniqueidentifier
as
delete from ReservationProviderInfo
where ReservationProviderInfoId = @ProviderId
go

CREATE proc [dbo].[ReservationProviderInfoList]
as
select * from ReservationProviderInfo
go

CREATE proc [dbo].[ReservationProviderInfoUpdate]
@ProviderId uniqueidentifier, @ReservationId uniqueidentifier, @ReferenceNumber nvarchar(50)
as
update ReservationProviderInfo set ReservationId = @ReservationId, ReferenceNumber = @ReferenceNumber where ReservationProviderInfoId = @ProviderId
go

create proc [dbo].[ReservationReminderLastDateToTicket]
as

select * from Reservations where LastDateToTicket>GETDATE() and PnrStatus=2
go

create proc [dbo].[ReservationStatus]
@ProcessId uniqueidentifier,
@Status int
as
select * from Reservations where ProcessId=@ProcessId and  PnrStatus=@Status
go

create proc [dbo].[ReservationStatusListAdd]
@ReservationStatuId int,
@EnumEqual nvarchar(50), @Description nvarchar(50), @Lang nvarchar(5)
as
insert into ReservationStatusList(ReservationStatuId,EnumEqual, Description, Lang) values(@ReservationStatuId,@EnumEqual, @Description, @Lang)
go

create proc [dbo].[ReservationStatusListDelete]
@ReservationStatuId int
as
delete from ReservationStatusList
where ReservationStatuId=@ReservationStatuId
go

create proc [dbo].[ReservationStatusListList]
as
select * from ReservationStatusList
go

create proc [dbo].[ReservationStatusListListById]
@ReservationStatuId int
as
select * from ReservationStatusList
where ReservationStatuId=@ReservationStatuId
go

create proc [dbo].[ReservationStatusListListByIdAndLang]

@ReservationStatuId int,
@Lang nvarchar(5)
as
select * from ReservationStatusList where Lang=@Lang and ReservationStatuId=@ReservationStatuId
go

create proc [dbo].[ReservationStatusListUpdate]
@ReservationStatuId int, @EnumEqual nvarchar(50), @Description nvarchar(50), @Lang nvarchar(5)
as
update ReservationStatusList set EnumEqual=@EnumEqual, Description=@Description, Lang=@Lang
where ReservationStatuId=@ReservationStatuId
go

CREATE proc [dbo].[ReservationSummaryAgencySide]  
@AgencyId uniqueidentifier,
@StartDate nvarchar(50),
@EndDate nvarchar(50),
@PnrOrETicketOrSurName nvarchar(300)
as



declare @query nvarchar(500)= 'select * from vw_ReservationSummary rs where AgencyId=@AgencyId '

if (dbo.IsNullOrEmpty(@StartDate)=0 and dbo.IsNullOrEmpty(@EndDate)=0)
begin

 set @query = @query + ' and cast(rs.CreationDate as date) between cast(@StartDate as date) and  cast(@EndDate as date) '

end

if(dbo.IsNullOrEmpty(@PnrOrETicketOrSurName)=0)
begin 
 set @query = @query + ' and (rs.PnrNumber=@PnrOrETicketOrSurName or rs.TicketNumber=@PnrOrETicketOrSurName or rs.SurName=@PnrOrETicketOrSurName) '
end

set @query = @query +' order by rs.CreationDate  desc '

declare @ParamDef nvarchar(max) 

set @ParamDef='@AgencyId uniqueidentifier, @StartDate nvarchar(50),@EndDate nvarchar(50),@PnrOrETicketOrSurName nvarchar(300)'

EXECUTE sp_Executesql @query,@ParamDef,@AgencyId,@StartDate,@EndDate,@PnrOrETicketOrSurName
go

CREATE proc [dbo].[ReservationSummaryAgencySideDetail]
@AgencyId uniqueidentifier = null,
@ArrivalCode nvarchar(50) = null,
@CarrierCode nvarchar(50) = null,
@DepartureCode nvarchar(50) = null,
@FlightStartDate datetime = null,
@FlightEndDate datetime = null,
@OptionStartDate datetime = null,
@OptionEndDate datetime = null,
@ProcessStartDate datetime = null,
@ProcessEndDate datetime = null,
@SearchString nvarchar(300) = null,
@Supplier nvarchar(50) = null,
@Status int = null,
@UserId nvarchar(50) = null,
@IsOptionDateChange bit,
@LastHour bit,
@ByaAgencyId uniqueidentifier = null
as
DECLARE @date varchar(10)=CONVERT(varchar(10),GETDATE(),121),
        @dateAdd varchar(10)=CONVERT(VARCHAR(10), DATEADD(day,1,GETDATE()), 121)

select
	rs.ProcessId,
	rs.CreationDate,
	au.Name + ' ' + au.SurName as CreatedBy,
	rs.TicketNumber,
	rs.Name,
	rs.ArrivalCity,
	rs.Arrival,
	rs.CarrierCode,
	rs.DepartureCity,
	rs.Departure,
	rs.PnrNumber as Pnr,
	rs.FareStatus as Status,
	rs.SupplierName as Supplier,
	rs.SurName,
	rs.Description,
	rs.DepartureDate as FlightDate,
	rs.DepartureTime as FlightTime,
	rs.LastDateToTicket as OptionDate,
	rs.TicketStatus,
	rs.AgencyName,
	(select top 1 fi.CooperatedCode from FlightsInfo fi where fi.ReservationId = rs.ReservationId) as AirPnrNumber

from vw_ReservationSummaryDetail rs
left join AgencyUsers au on au.UserId = rs.UserId

where (@AgencyId is null or rs.AgencyId = @AgencyId)
	and (@ArrivalCode is null or rs.ArrivalCode = @ArrivalCode )
	and (@CarrierCode is null or rs.CarrierCode = @CarrierCode )
	and (@DepartureCode is null or rs.DepartureCode = @DepartureCode)
	and (@FlightStartDate is null or rs.DepartureDate >= @FlightStartDate)
	and (@FlightEndDate is null or rs.DepartureDate < @FlightEndDate)
	and (@OptionStartDate is null or LastDateToTicket >= @OptionStartDate)
	and (@OptionEndDate is null or LastDateToTicket < @OptionEndDate)
	and (@ProcessStartDate is null or rs.CreationDate >= @ProcessStartDate)
	and (@ProcessEndDate is null or rs.CreationDate < @ProcessEndDate)
	and (@SearchString is null or PnrNumber = @SearchString or TicketNumber = @SearchString or rs.SurName = @SearchString)
	and (@Supplier is null or rs.SupplierName = @Supplier)
	and (@Status is null or @Status = -1 or TicketStatus = @Status)
	and (@UserId is null or rs.UserId = @UserId)
	and (@IsOptionDateChange = 0 or (select COUNT(*) from OptionDateHistory opdh where opdh.ReservationId = rs.ReservationId)  > 0)
	and (@ByaAgencyId is null or rs.AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
	and(@LastHour=0 or (rs.DepartureDate BETWEEN @date AND @dateAdd))
order by CreationDate desc
go

CREATE proc [dbo].[ReservationSummaryCallCenterDetailList]
	@AgencyId uniqueidentifier = null,
	@ArrivalCode nvarchar(50) = null,
	@CarrierCode nvarchar(50) = null,
	@DepartureCode nvarchar(50) = null,
	@FlightStartDate datetime = null,
	@FlightEndDate datetime = null,
	@OptionStartDate datetime = null,
	@OptionEndDate datetime = null,
	@ProcessStartDate datetime = null,
	@ProcessEndDate datetime = null,
	@SearchString nvarchar(300) = null,
	@Supplier nvarchar(50) = null,
	@Status int = null,
	@UserId nvarchar(50) = null,
	@IsOptionDateChange bit,
	@LastHour bit
as
	DECLARE @date varchar(10)=CONVERT(varchar(10),GETDATE(),121),
			@dateAdd varchar(10)=CONVERT(VARCHAR(10), DATEADD(day,1,GETDATE()), 121)

	select
	rs.ProcessId,
	rs.CreationDate,
	au.Name + ' ' + au.SurName as CreatedBy,
	rs.TicketNumber,
	rs.Name,
	rs.ArrivalCity,
	rs.Arrival,
	rs.CarrierCode,
	rs.DepartureCity,
	rs.Departure,
	rs.PnrNumber as Pnr,
	rs.FareStatus as Status,
	rs.SupplierName as Supplier,
	rs.SurName,
	rs.Description,
	rs.DepartureDate as FlightDate,
	rs.DepartureTime as FlightTime,
	rs.LastDateToTicket as OptionDate,
	rs.AgencyName,
	rs.TicketStatus,
	(select top 1
		fi.CooperatedCode
	from FlightsInfo fi
	where fi.ReservationId = rs.ReservationId) as AirPnrNumber,
	rs.ParentAgencyName

from vw_ReservationSummaryDetail rs
	left join AgencyUsers au on au.UserId = rs.UserId

where (@AgencyId is null or rs.AgencyId = @AgencyId or rs.ParentAgencyId = @AgencyId)
	and (@ArrivalCode is null or rs.ArrivalCode = @ArrivalCode )
	and (@CarrierCode is null or rs.CarrierCode = @CarrierCode )
	and (@DepartureCode is null or rs.DepartureCode = @DepartureCode)
	and (@FlightStartDate is null or rs.DepartureDate >= @FlightStartDate)
	and (@FlightEndDate is null or rs.DepartureDate < @FlightEndDate)
	and (@OptionStartDate is null or LastDateToTicket >= @OptionStartDate)
	and (@OptionEndDate is null or LastDateToTicket < @OptionEndDate)
	and (@ProcessStartDate is null or rs.CreationDate >= @ProcessStartDate)
	and (@ProcessEndDate is null or rs.CreationDate < @ProcessEndDate)
	and (@SearchString is null or PnrNumber = @SearchString or TicketNumber = @SearchString or rs.SurName = @SearchString)
	and (@Supplier is null or rs.SupplierName = @Supplier)
	and (@Status is null or @Status = -1 or TicketStatus = @Status)
	and (@UserId is null or rs.UserId = @UserId)
	and (@IsOptionDateChange = 0 or (select COUNT(*)
	from OptionDateHistory opdh
	where opdh.ReservationId = rs.ReservationId)  > 0)
	and(@LastHour=0 or (rs.DepartureDate BETWEEN @date AND @dateAdd))
order by CreationDate desc
go

CREATE proc [dbo].[ReservationSummaryCallCenterDetailListV2]
@AgencyId uniqueidentifier = null,
@ArrivalCode nvarchar(50) = null,
@CarrierCode nvarchar(50) = null,
@DepartureCode nvarchar(50) = null,
@FlightStartDate datetime = null,
@FlightEndDate datetime = null,
@OptionStartDate datetime = null,
@OptionEndDate datetime = null,
@ProcessStartDate datetime = null,
@ProcessEndDate datetime = null,
@SearchString nvarchar(300) = null,
@Supplier nvarchar(50) = null,
@Status int = null,
@UserId nvarchar(50) = null,
@IsOptionDateChange bit,
@LastHour bit,
@PageSize int,
@PageNumber int
as
DECLARE @date varchar(10)=CONVERT(varchar(10),GETDATE(),121),
        @dateAdd varchar(10)=CONVERT(VARCHAR(10), DATEADD(day,1,GETDATE()), 121)

select
	rs.ProcessId,
	rs.CreationDate,
	au.Name + ' ' + au.SurName as CreatedBy,
	rs.TicketNumber,
	rs.Name,
	rs.ArrivalCity,
	rs.Arrival,
	rs.CarrierCode,
	rs.DepartureCity,
	rs.Departure,
	rs.PnrNumber as Pnr,
	rs.FareStatus as Status,
	rs.SupplierName as Supplier,
	rs.SurName,
	rs.Description,
	rs.DepartureDate as FlightDate,
	rs.DepartureTime as FlightTime,
	rs.LastDateToTicket as OptionDate,
	rs.AgencyName,
	rs.TicketStatus,
    (select top 1 fi.CooperatedCode from FlightsInfo fi where fi.ReservationId = rs.ReservationId) as AirPnrNumber

from vw_ReservationSummaryDetail rs
left join AgencyUsers au on au.UserId = rs.UserId

where (@AgencyId is null or rs.AgencyId = @AgencyId)
	and (@ArrivalCode is null or rs.ArrivalCode = @ArrivalCode )
	and (@CarrierCode is null or rs.CarrierCode = @CarrierCode )
	and (@DepartureCode is null or rs.DepartureCode = @DepartureCode)
	and (@FlightStartDate is null or rs.DepartureDate >= @FlightStartDate)
	and (@FlightEndDate is null or rs.DepartureDate < @FlightEndDate)
	and (@OptionStartDate is null or LastDateToTicket >= @OptionStartDate)
	and (@OptionEndDate is null or LastDateToTicket < @OptionEndDate)
	and (@ProcessStartDate is null or rs.CreationDate >= @ProcessStartDate)
	and (@ProcessEndDate is null or rs.CreationDate < @ProcessEndDate)
	and (@SearchString is null or PnrNumber = @SearchString or TicketNumber = @SearchString or rs.SurName = @SearchString)
	and (@Supplier is null or rs.SupplierName = @Supplier)
	and (@Status is null or @Status = -1 or TicketStatus = @Status)
	and (@UserId is null or rs.UserId = @UserId)
	and (@IsOptionDateChange = 0 or (select COUNT(*) from OptionDateHistory opdh where opdh.ReservationId = rs.ReservationId)  > 0)
	and(@LastHour=0 or (rs.DepartureDate BETWEEN @date AND @dateAdd))
order by CreationDate desc
    OFFSET @PageSize * (@PageNumber - 1) ROWS
FETCH NEXT @PageSize ROWS ONLY;
go

create proc [dbo].[ReservationSummaryCallCenterList]
@StartDate nvarchar(50),
@EndDate nvarchar(50),
@PnrOrETicketOrSurName nvarchar(300)
as



declare @query nvarchar(500)= 'select * from vw_ReservationSummary rs where AgencyId=AgencyId '

if (dbo.IsNullOrEmpty(@StartDate)=0 and dbo.IsNullOrEmpty(@EndDate)=0)
begin

 set @query = @query + ' and cast(rs.CreationDate as date) between cast(@StartDate as date) and  cast(@EndDate as date) '

end

if(dbo.IsNullOrEmpty(@PnrOrETicketOrSurName)=0)
begin 
 set @query = @query + ' and (rs.PnrNumber=@PnrOrETicketOrSurName or rs.TicketNumber=@PnrOrETicketOrSurName or rs.SurName=@PnrOrETicketOrSurName) '
end

set @query = @query +' order by rs.CreationDate  desc '

declare @ParamDef nvarchar(max) 

set @ParamDef='@StartDate nvarchar(50),@EndDate nvarchar(50),@PnrOrETicketOrSurName nvarchar(300)'

EXECUTE sp_Executesql @query,@ParamDef,@StartDate,@EndDate,@PnrOrETicketOrSurName
go

CREATE proc [dbo].[ReservationsAdd]
@ReservationId uniqueidentifier,
@ProcessId uniqueidentifier, @PnrNumber nvarchar(10), @PnrStatus int,  @AgencyId uniqueidentifier, @UserId uniqueidentifier, @IsDomestic bit, @IsCIP bit, @Notes nvarchar(max), @PaymentType int, @ProcessType int, @LastDateToTicket datetime, @ProviderId int,@SubProviderId int, @CreationDate datetime, @SupplierName nvarchar(50), @InvoiceType int
as
insert into Reservations(ReservationId,ProcessId, PnrNumber, PnrStatus,  AgencyId, UserId, IsDomestic, IsCIP, Notes, PaymentType, ProcessType, LastDateToTicket, ProviderId,SubProviderId, CreationDate, SupplierName, InvoiceType) values(@ReservationId,@ProcessId, @PnrNumber, @PnrStatus,  @AgencyId, @UserId, @IsDomestic, @IsCIP, @Notes, @PaymentType, @ProcessType, @LastDateToTicket, @ProviderId,@SubProviderId, @CreationDate, @SupplierName, @InvoiceType)
go

create proc [dbo].[ReservationsCheckIfPnrExists]
@PnrNumber nvarchar(6)
as
select Count(0) from Reservations  with(nolock) where PnrNumber=@PnrNumber
go

CREATE proc [dbo].[ReservationsCountCheck] @Name nvarchar(50) = null,
                                           @SurName nvarchar(50) = null,
                                           @BirthDate DateTime = null,
                                           @CitizenNumber nvarchar(11) = null,
                                           @PassportSerialNumber nvarchar(10) = null,
                                           @PassportNumber nvarchar(50) = null,
                                           @IsReservationCountExceeded bit output
as

Declare @NameStatement int
Declare @CitizenNumberStatement int
Declare @PassportNumberStatement int
    if (@Name is not null and @SurName is not null and @BirthDate is not null)
        Begin
            set @NameStatement = (select count(*)
                                  from PassengersInfo as pas
                                           inner join Reservations as res on (pas.ReservationId = res.ReservationId)
                                  where res.PnrStatus = 2
                                    and Name = @Name
                                    and SurName = @SurName
                                    and BirthDate = @BirthDate)
        end
    if (@CitizenNumber is not null)
        Begin
            set @CitizenNumberStatement = (select count(*)
                                           from PassengersInfo as pas
                                                    inner join Reservations as res on (pas.ReservationId = res.ReservationId)
                                           where res.PnrStatus = 2
                                             and CitizenNumber = @CitizenNumber)
        end
    if (@PassportSerialNumber is not null and @PassportNumber is not null)
        Begin
            set @PassportNumberStatement = (select count(*)
                                            from PassengersInfo as pas
                                                     inner join Reservations as res on (pas.ReservationId = res.ReservationId)
                                            where res.PnrStatus = 2
                                              and PassportSerialNumber = @PassportSerialNumber
                                              and PassportNumber = @PassportNumber)
        end
    if (@NameStatement >= 4 or @CitizenNumberStatement >= 4 or @PassportNumberStatement >= 4)
        begin
            SET @IsReservationCountExceeded = 1;
        end
    else
        begin
            SET @IsReservationCountExceeded = 0;
        end
go

CREATE proc [dbo].[ReservationsCountCheckOnSameFlight] @Name nvarchar(50) = null,
                                           @SurName nvarchar(50) = null,
                                           @BirthDate DateTime = null,
                                           @CitizenNumber nvarchar(11) = null,
                                           @PassportSerialNumber nvarchar(10) = null,
                                           @PassportNumber nvarchar(50) = null,
                                           @FlightNumber nvarchar(50),
                                           @DepartureDate DateTime,
                                           @IsReservationCountOnSameFlightExceeded bit output
as

Declare @NameStatement int
Declare @CitizenNumberStatement int
Declare @PassportNumberStatement int
    if (@Name is not null and @SurName is not null and @BirthDate is not null)
        Begin
            set @NameStatement = (select count(*)
                                  from PassengersInfo as pas
                                           inner join Reservations as res on (pas.ReservationId = res.ReservationId)
                                           inner join FlightsInfo as fli on (fli.ReservationId = res.ReservationId)
                                  where res.PnrStatus = 2
                                    and Name = @Name
                                    and SurName = @SurName
                                    and BirthDate = @BirthDate
                                    and FlightNumber = @FlightNumber
                                    and DepartureDate = @DepartureDate)
        end
    if (@CitizenNumber is not null)
        Begin
            set @CitizenNumberStatement = (select count(*)
                                           from PassengersInfo as pas
                                                    inner join Reservations as res on (pas.ReservationId = res.ReservationId)
                                                    inner join FlightsInfo as fli on (fli.ReservationId = res.ReservationId)
                                           where res.PnrStatus = 2
                                             and CitizenNumber = @CitizenNumber
                                             and FlightNumber = @FlightNumber
                                             and DepartureDate = @DepartureDate)
        end
    if (@PassportSerialNumber is not null and @PassportNumber is not null)
        Begin
            set @PassportNumberStatement = (select count(*)
                                            from PassengersInfo as pas
                                                     inner join Reservations as res on (pas.ReservationId = res.ReservationId)
                                                     inner join FlightsInfo as fli on (fli.ReservationId = res.ReservationId)
                                            where res.PnrStatus = 2
                                              and PassportSerialNumber = @PassportSerialNumber
                                              and PassportNumber = @PassportNumber
                                              and FlightNumber = @FlightNumber
                                              and DepartureDate = @DepartureDate)
        end
    if (@NameStatement >= 1 or @CitizenNumberStatement >= 1 or @PassportNumberStatement >= 1)
        begin
            SET @IsReservationCountOnSameFlightExceeded = 1;
        end
    else
        begin
            SET @IsReservationCountOnSameFlightExceeded = 0;
        end
go

create proc [dbo].[ReservationsDelete]
@ReservationId uniqueidentifier
as
delete from Reservations
where ReservationId=@ReservationId
go

create proc [dbo].[ReservationsErroredPnrNumber]
as
select Count(*) from Reservations where PnrStatus=8
go

CREATE proc [dbo].[ReservationsGalileoReservedPriceControlList]
as
select *  from Reservations 
where PnrStatus=2 and SupplierName='Galileo'
 and   DateAdd(hour,-6,CreationDate)  < GetDate()   and PnrNumber<>'' 
 order by CreationDate desc
go

create proc [dbo].[ReservationsInformationsDelete]
@ProcessId uniqueidentifier
as

 
DECLARE @ReservationId uniqueidentifier 

declare PreReservations cursor for select ReservationId from Reservations where ProcessId=@ProcessId
 open PreReservations

FETCH  NEXT FROM PreReservations INTO @ReservationId
 WHILE @@FETCH_STATUS = 0  
 BEGIN 

delete from Reservations where ReservationId=@ReservationId
delete from PassengersInfo where ReservationId=@ReservationId
delete from FlightPriceInfo where ReservationId=@ReservationId
delete from FlightsInfo where ReservationId=@ReservationId
delete from OrderTransaction where ProcessId=@ProcessId
 delete from BankPosLogs where ProcessId=@ProcessId

FETCH  NEXT FROM PreReservations INTO @ReservationId
 END
 CLOSE PreReservations   
DEALLOCATE PreReservations
go

create proc [dbo].[ReservationsList]
as
select * from Reservations
go

CREATE proc [dbo].[ReservationsListById]
@ReservationId uniqueidentifier
as
select * from Reservations with(nolock)
where ReservationId=@ReservationId
go

create proc [dbo].[ReservationsListReserved]
as
select * from Reservations where PnrStatus =2 and CreationDate < DATEADD(hour,-1,getdate())
order by CreationDate asc
go

create proc [dbo].[ReservationsOneItemByProcessId]
@ProcessId uniqueidentifier
as
select * from Reservations where ProcessId=@ProcessId
go

create proc [dbo].[ReservationsOneItemByProcessIdAndSupplierName]
@ProcessId uniqueidentifier,
@SupplierName nvarchar(50)
as
select * from Reservations where SupplierName=@SupplierName and ProcessId=@ProcessId
go

CREATE proc [dbo].[ReservationsPreInformationsDelete]
@ProcessId uniqueidentifier
as

DECLARE @ReservationId uniqueidentifier 

declare PreReservations cursor for select ReservationId from Reservations where ProcessId=@ProcessId
 open PreReservations

FETCH  NEXT FROM PreReservations INTO @ReservationId
 WHILE @@FETCH_STATUS = 0  
 BEGIN 

delete from Reservations where ReservationId=@ReservationId
delete from PassengersInfo where ReservationId=@ReservationId
delete from FlightPriceInfo where ReservationId=@ReservationId
delete from FlightsInfo where ReservationId=@ReservationId
delete from OrderTransaction where ProcessId=@ProcessId

FETCH  NEXT FROM PreReservations INTO @ReservationId
 END
 CLOSE PreReservations   
DEALLOCATE PreReservations
go

CREATE proc [dbo].[ReservationsSabreReservedPriceControlList]
as
select *  from Reservations 
where PnrStatus=2 and SupplierName='Sabre'
 and   DateAdd(hour,-6,CreationDate)  < GetDate()   and PnrNumber<>'' 
 order by CreationDate desc
go

CREATE proc [dbo].[ReservationsToBeCanceled]
as

select * from Reservations where LastDateToTicket<GETDATE() and PnrStatus=2
go

CREATE proc [dbo].[ReservationsUpdate]
@ReservationId uniqueidentifier, @ProcessId uniqueidentifier, @PnrNumber nvarchar(10), @PnrStatus int,  @AgencyId uniqueidentifier, @UserId uniqueidentifier, @IsDomestic bit, @IsCIP bit, @Notes nvarchar(max), @PaymentType int, @ProcessType int, @LastDateToTicket datetime, @ProviderId int,@SubProviderId int, @CreationDate datetime, @SupplierName nvarchar(50), @InvoiceType int
as
update Reservations set ProcessId=@ProcessId, PnrNumber=@PnrNumber, PnrStatus=@PnrStatus,  AgencyId=@AgencyId, UserId=@UserId, IsDomestic=@IsDomestic, IsCIP=@IsCIP, Notes=@Notes, PaymentType=@PaymentType, ProcessType=@ProcessType, LastDateToTicket=@LastDateToTicket, ProviderId=@ProviderId,SubProviderId=@SubProviderId, CreationDate=@CreationDate, SupplierName=@SupplierName, InvoiceType = @InvoiceType
where ReservationId=@ReservationId
go

create proc [dbo].[SiteMapMenuAdd]
@ParentSiteMapId int, @SiteMapTitle nvarchar(500), @SiteMapControl nvarchar(50), @SiteMapAction nvarchar(50), @AlowedRoles nvarchar(max), @OrderProcess int, @Status bit, @Lang nvarchar(5)
as
insert into SiteMapMenu(ParentSiteMapId, SiteMapTitle, SiteMapControl, SiteMapAction, AlowedRoles, OrderProcess, Status, Lang) values(@ParentSiteMapId, @SiteMapTitle, @SiteMapControl, @SiteMapAction, @AlowedRoles, @OrderProcess, @Status, @Lang)
go

create proc [dbo].[SiteMapMenuDelete]
@SiteMapId int
as
delete from SiteMapMenu
where SiteMapId=@SiteMapId
go

create proc [dbo].[SiteMapMenuList]
as
select * from SiteMapMenu
go

create proc [dbo].[SiteMapMenuListById]
@SiteMapId int
as
select * from SiteMapMenu
where SiteMapId=@SiteMapId
go

create proc [dbo].[SiteMapMenuUpdate]
@SiteMapId int, @ParentSiteMapId int, @SiteMapTitle nvarchar(500), @SiteMapControl nvarchar(50), @SiteMapAction nvarchar(50), @AlowedRoles nvarchar(max), @OrderProcess int, @Status bit, @Lang nvarchar(5)
as
update SiteMapMenu set ParentSiteMapId=@ParentSiteMapId, SiteMapTitle=@SiteMapTitle, SiteMapControl=@SiteMapControl, SiteMapAction=@SiteMapAction, AlowedRoles=@AlowedRoles, OrderProcess=@OrderProcess, Status=@Status, Lang=@Lang
where SiteMapId=@SiteMapId
go

CREATE proc [dbo].[SmsCounterAdd]
@ProcessId uniqueidentifier,
@SmsCount int
as
insert into SmsCounter(ProcessId,SmsCount) values(@ProcessId,@SmsCount)
go

CREATE proc [dbo].[SmsCounterCheckByProcessId]
@ProcessId uniqueidentifier
as
select Count(*) as SmsCount from SmsCounter where ProcessId=@ProcessId
go

create proc [dbo].[SmsCounterDelete]
@ProcessId uniqueidentifier
as
delete from SmsCounter
where ProcessId=@ProcessId
go

create proc [dbo].[SmsCounterList]
as
select * from SmsCounter
go

create proc [dbo].[SmsCounterListById]
@ProcessId uniqueidentifier
as
select * from SmsCounter
where ProcessId=@ProcessId
go

create proc [dbo].[SmsCounterUpdate]
@ProcessId uniqueidentifier, @SmsCount int
as
update SmsCounter set SmsCount=@SmsCount
where ProcessId=@ProcessId
go

create FUNCTION [dbo].[Split] (
	@Text nvarchar(max),  
	@Delimiter nvarchar(1000)   
)

RETURNS @retTable TABLE 
(
	
	[item] nvarchar(max) COLLATE DATABASE_DEFAULT NOT NULL,

	
	
	[item_int] as 
	(
		
		TRY_CONVERT([int], NULLIF([item],'')) 
		
	)
) 
WITH SCHEMABINDING
AS
BEGIN 
	
	IF RTRIM(ISNULL(@Text,'')) = '' OR RTRIM(ISNULL(@Delimiter,'')) = ''
		RETURN

	DECLARE
	   @ix bigint 
	 , @pix bigint 
	 , @del_len int 
	 , @text_len bigint 
	 , @item nvarchar(max) 

	SELECT @del_len = LEN(@Delimiter)
		 , @text_len = LEN(@Text)

	IF @del_len = 1
	BEGIN 
		SELECT @ix = CHARINDEX(@Delimiter, @Text) 
			 , @pix = 0
	
		
		IF @ix = 0
		BEGIN
			INSERT INTO @retTable(item) 
				SELECT LTRIM(RTRIM(@Text)) 
		END
		ELSE
		BEGIN
			
			WHILE @ix > 0
			BEGIN
				SELECT 
					
					  @item = LTRIM(RTRIM(SUBSTRING(@Text,@pix,(@ix - @pix)))) 
					
					, @pix = @ix + @del_len 
					
					, @ix = CHARINDEX(@Delimiter, @Text, (@ix + @del_len)) 
				
				IF @item <> '' AND @item IS NOT NULL 
					INSERT INTO @retTable(item) VALUES (@item)
			END

			
			SET @item = LTRIM(RTRIM(SUBSTRING(@Text,@pix,@text_len)))
			IF @item <> '' AND @item IS NOT NULL  
				INSERT INTO @retTable(item) VALUES (@item)
		END 
	END
	ELSE 
	BEGIN 

		DECLARE @del_pat nvarchar(3002)  

		
		SELECT @del_pat = '%' + REPLACE(REPLACE(REPLACE(@Delimiter
				, '[','[[]')
				, '%','[%]')
				, '_', '[_]') 
			+ '%'

		SELECT @ix = PATINDEX(@del_pat, @Text) 
			 , @pix = 0
	
		
		IF @ix = 0
		BEGIN
			INSERT INTO @retTable(item) 
				SELECT LTRIM(RTRIM(@Text)) 
		END
		ELSE
		BEGIN
			
			WHILE @ix > 0
			BEGIN
				SELECT 
					
					@item = LTRIM(RTRIM(SUBSTRING(@Text,@pix,(@ix - @pix))))
					
					, @pix = @ix + @del_len 
					
					, @ix = PATINDEX(@del_pat, SUBSTRING(@Text, (@ix + @del_len), @text_len)) 

				IF @item <> '' AND @item IS NOT NULL  
					INSERT INTO @retTable(item) VALUES (@item)

				IF @ix > 0 SET @ix = ((@ix + @pix) - 1) 
			END

			
			SET @item = LTRIM(RTRIM(SUBSTRING(@Text,@pix,@text_len)))
			IF @item <> '' AND @item IS NOT NULL  
				INSERT INTO @retTable(item) VALUES (@item)
		END 
	END 

	RETURN
END
go

CREATE PROC [dbo].[SupplierCallCenterAdd]
	@SupplierId nvarchar(50),
	@CallCenterId uniqueidentifier,
	@UserName nvarchar(250),
	@Password nvarchar(50),
	@PortalUrl text,
	@UserCode nvarchar(150)
AS

INSERT INTO SupplierCallCenterManager
(
  SupplierId,
  CallCenterId,
  UserName,
  Password,
  PortalUrl,
  UserCode
)
VALUES
(
	@SupplierId,
	@CallCenterId,
	@UserName,
	@Password,
	@PortalUrl,
	@UserCode
)
go

CREATE PROC [dbo].[SupplierCallCenterBySupplierAndUserName]
		@SupplierId  nvarchar(50),
		@UserCode  nvarchar(150)
AS
SELECT *
FROM SupplierCallCenterManager
WHERE (SupplierId=@SupplierId AND UserCode=@UserCode)
go

CREATE PROC [dbo].[SupplierCallCenterDelete] 
		@CallCenterId uniqueidentifier,
		@SupplierId nvarchar(50)
AS
DELETE
FROM SupplierCallCenterManager
WHERE (CallCenterId=@CallCenterId AND SupplierId=@SupplierId)
go

CREATE PROC [dbo].[SupplierCallCenterFilters]
		@SupplierId nvarchar(50)=null,
		@CallCenterId uniqueidentifier=null
AS
BEGIN
	IF @SupplierId IS NOT NULL AND @CallCenterId IS NOT NULL
	BEGIN
		SELECT * FROM SupplierCallCenterManager
		WHERE (SupplierId=@SupplierId AND CallCenterId=@CallCenterId) 
		ORDER BY UserName DESC
	END
	ELSE IF @SupplierId IS NOT NULL AND @CallCenterId IS NULL
	BEGIN 
		SELECT * FROM SupplierCallCenterManager
		WHERE SupplierId=@SupplierId
		ORDER BY UserName DESC
	END
	ELSE IF @SupplierId IS NULL AND @CallCenterId IS NOT NULL
	BEGIN
		SELECT * FROM SupplierCallCenterManager
		WHERE CallCenterId=@CallCenterId
		ORDER BY UserName DESC
	END
	ELSE
	BEGIN
		SELECT * FROM SupplierCallCenterManager
	END
END
go

CREATE PROC [dbo].[SupplierCallCenterList]	
AS
SELECT * FROM SupplierCallCenterManager
go

CREATE PROC [dbo].[SupplierCallCenterListSupplierId] @SupplierId nvarchar(50)
AS
SELECT *
FROM SupplierCallCenterManager
WHERE SupplierId=@SupplierId
go

CREATE PROC [dbo].[SupplierCallCenterOneItem] @CallCenterId uniqueidentifier
AS
SELECT *
FROM SupplierCallCenterManager
WHERE CallCenterId=@CallCenterId
go

CREATE PROC [dbo].[SupplierCallCenterUpdate]
		@SupplierId nvarchar(50),
		@CallCenterId uniqueidentifier,
		@UserName nvarchar(250),
		@Password nvarchar(50),
		@PortalUrl text,
		@UserCode nvarchar(150)
AS
UPDATE SupplierCallCenterManager
SET
	SupplierId=@SupplierId,
	CallCenterId=@CallCenterId,
	UserName=@UserName,
	Password=@Password,
	PortalUrl=@PortalUrl,
	UserCode=@UserCode
WHERE (CallCenterId=@CallCenterId AND SupplierId=@SupplierId AND UserCode=@UserCode)
go

Create Proc [dbo].[SupplierPnrLogsAdd]
@SupplierName nvarchar(50),
@PnrNumber nvarchar(50),
@CreationDate datetime,
@AgencyId uniqueidentifier
as
INSERT INTO SupplierPnrLogs(
SupplierName,
PnrNumber,
CreationDate,
AgencyId
)
VALUES
(
@SupplierName,
@PnrNumber,
@CreationDate,
@AgencyId
)
go

Create Proc [dbo].[SupplierPnrLogsDelete]
@SupplierPnrLogId int
AS
DELETE  FROM SupplierPnrLogs
WHERE SupplierPnrLogId=@SupplierPnrLogId
go

CREATE proc [dbo].[SupplierPnrLogsFilter]
@SupplierName nvarchar(50),
@StartDate date,
@EndDate date
as
select s.*,p.CommercialTitle as [AgencyName], 
ISNULL(r.PnrNumber,'0') [ExistsInRecord] 
from SupplierPnrLogs s
inner join AgencyProfile p on p.AgencyId=s.AgencyId
left join Reservations r on r.PnrNumber=s.PnrNumber
where
s.SupplierName=ISNULL(@SupplierName,s.SupplierName)
and
CAST(s.CreationDate as date) between  CAST(@StartDate as date) and CAST(@EndDate as date)
go

Create Proc [dbo].[SupplierPnrLogsList]
as
SELECT * FROM SupplierPnrLogs
go

Create Proc [dbo].[SupplierPnrLogsListById]
@SupplierPnrLogId int
AS
SELECT * FROM SupplierPnrLogs
WHERE SupplierPnrLogId=@SupplierPnrLogId
go

Create Proc [dbo].[SupplierPnrLogsUpdate]
@SupplierPnrLogId int,
@SupplierName nvarchar(50),
@PnrNumber nvarchar(50),
@CreationDate datetime,
@AgencyId uniqueidentifier
AS
UPDATE SupplierPnrLogs
SET
SupplierName=@SupplierName,
PnrNumber=@PnrNumber,
CreationDate=@CreationDate,
AgencyId=@AgencyId
WHERE SupplierPnrLogId=@SupplierPnrLogId
go

CREATE proc [dbo].[SupportAdd]
@AgencyId uniqueidentifier, 
@SupporterId uniqueidentifier = null,
@IsReaded bit, 
@ProcessId uniqueidentifier = null, 
@Topic int,
@SupportType int,
@RelatedId nvarchar(128) = null,
@Description nvarchar(1000), 
@CreationDate datetime,
@TakeOver bit,
@UserName nvarchar(150) = null
as

if not exists(select * from Support where ProcessId=@ProcessId)
	Begin
	insert into Support(AgencyId, SupporterId, IsReaded, ProcessId, Topic, SupportType, RelatedId, Description, CreationDate,TakeOver,UserName) values(@AgencyId, @SupporterId, @IsReaded, @ProcessId, @Topic,@SupportType,@RelatedId, @Description,@CreationDate,@TakeOver,@UserName)
	select SCOPE_IDENTITY()
 end
 else
 begin
 update Support set IsReaded=@IsReaded  where ProcessId=@ProcessId
select SupportId from Support where ProcessId=@ProcessId
 end
go

CREATE proc [dbo].[SupportDashboardList]
@AgencyId uniqueidentifier = null,
@StartDate datetime,
@EndDate datetime,
@ByaAgencyId uniqueidentifier = null
as
SELECT CreationDate Date, [SupportType] Type, COUNT(*) Value
FROM [dbo].[SupportDashboardView]
where 
	(@AgencyId is null or AgencyId = @AgencyId) 
	and CreationDate >= @StartDate 
	and CreationDate <= @EndDate
	and (@ByaAgencyId is null or AgencyId in (select sAp.AgencyId from AgencyProfile sAp where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))
group by CreationDate, [SupportType]
order by CreationDate
go

create proc [dbo].[SupportDelete]
@SupportId bigint
as
delete from Support
where SupportId=@SupportId
go

create proc [dbo].[SupportDetailsAdd]
@SupportMessage nvarchar(max), @UserId uniqueidentifier, @CreationDate datetime, @SupportId bigint
as
insert into SupportDetails(SupportMessage, UserId, CreationDate, SupportId) values(@SupportMessage, @UserId, @CreationDate, @SupportId)
go

create proc [dbo].[SupportDetailsDelete]
@SupportDetailId bigint
as
delete from SupportDetails
where SupportDetailId=@SupportDetailId
go

create proc [dbo].[SupportDetailsList]
as
select * from SupportDetails
go

create proc [dbo].[SupportDetailsListById]
@SupportDetailId bigint
as
select * from SupportDetails
where SupportDetailId=@SupportDetailId
go

CREATE proc [dbo].[SupportDetailsListByProcessId]
@ProcessId uniqueidentifier
as

declare @SupportId bigint=(Select SupportId from Support where ProcessId=@ProcessId)

select s.*,isnull((a.Name +' '+a.SurName),'-') as UserName from SupportDetails s 
left join AgencyUsers a on a.UserId=s.UserId
where s.SupportId=@SupportId 
order by s.CreationDate asc
go

create proc [dbo].[SupportDetailsUpdate]
@SupportDetailId bigint, @SupportMessage nvarchar(max), @UserId uniqueidentifier, @CreationDate datetime, @SupportId bigint
as
update SupportDetails set SupportMessage=@SupportMessage, UserId=@UserId, CreationDate=@CreationDate, SupportId=@SupportId
where SupportDetailId=@SupportDetailId
go

CREATE proc [dbo].[SupportList]
as
select * from Support order by CreationDate desc
go

CREATE proc [dbo].[SupportListByAgencyId]
@AgencyId uniqueidentifier
as
select * from Support
where AgencyId=@AgencyId order by CreationDate desc
go

CREATE proc [dbo].[SupportListByFilters]
    @Code int= null,
        @AgencyId uniqueidentifier =null,
        @Topic int=null,
        @IsReaded bit,
        @StartDate date,
        @EndDate date
    as
    select * 
    from Support 
    where (@AgencyId is null or AgencyId = @AgencyId)
      and (@Topic is null or Topic = @Topic)
      and (IsReaded = @IsReaded)
      and (@StartDate is null or (cast(CreationDate as date) >= cast(@StartDate as date)))
      and (@EndDate is null or (cast(CreationDate as date) <= cast(@EndDate as date)))
    order by CreationDate desc
go

CREATE proc [dbo].[SupportListById]
@SupportId bigint
as
select * from Support where SupportId=@SupportId order by CreationDate desc
go

Create proc [dbo].[SupportListByRelatedId]
@RelatedId nvarchar(128)
as
select * from Support where RelatedId=@RelatedId and IsReaded = 1 order by CreationDate desc
go

CREATE proc [dbo].[SupportListByStatus]
@IsReaded bit
as
select * from Support where IsReaded = @IsReaded order by CreationDate desc
go

Create proc [dbo].[SupportOneItemByRelatedId]
@RelatedId nvarchar(128)
as
select * from Support where RelatedId=@RelatedId and IsReaded = 0 order by CreationDate desc
go

CREATE proc [dbo].[SupportUpdate]
@SupportId bigint, 
@AgencyId uniqueidentifier, 
@SupporterId uniqueidentifier, 
@IsReaded bit, 
@ProcessId uniqueidentifier,  
@Topic int, 
@SupportType int,
@RelatedId nvarchar(128) = null,
@Description nvarchar(1000), 
@ResolvedDate datetime,
@TakeOver bit,
@UserName nvarchar(150) = null
as
update Support set 
AgencyId=@AgencyId, 
SupporterId=@SupporterId, 
IsReaded=@IsReaded, 
ProcessId=@ProcessId, 
Topic=@Topic, 
SupportType =@SupportType,
RelatedId = @RelatedId,
Description= @Description, 
ResolvedDate= @ResolvedDate,
TakeOver=@TakeOver,
UserName=@UserName
where SupportId=@SupportId
go

CREATE proc [dbo].[SysAccountNameIsExist]
    @AccountName nvarchar(200),
	@ParentAccountId int

as

declare @result bit;

if ((select count(*) from SystemAccounts where AccountName = @AccountName and ParentAccountId = @ParentAccountId) > 0)
begin
	set @result = 1;
end
else
begin
	set @result = 0;
end

select (@result) as result
go

CREATE proc [dbo].[SysAccountsCreateAgencyAccount]
    @RegionLetter nvarchar(5),
    @NewAgencyId uniqueidentifier
as
    declare @AccountPath nvarchar(100) 
    declare @TempAccountPath  nvarchar(100)  
    declare @AgencyName nvarchar(max)
    declare @LastAgencyScopeId  bigint
    declare @ParentAgencyId bigint
    declare @CurrencyId int
    declare @CurrencyName nvarchar(3)

    select top 1 @TempAccountPath = AccountPath, @LastAgencyScopeId = AccountId from SystemAccounts where AccountCode = 'CustomersAccount'
    select top 1 @AgencyName = AgencyName from AgencyProfile where AgencyId = @NewAgencyId

    insert into [dbo].[SystemAccounts]([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate])
    values(@LastAgencyScopeId, @AgencyName, 0, @RegionLetter, '', getdate())		
    set @LastAgencyScopeId=(select scope_identity())
    set @ParentAgencyId =@LastAgencyScopeId
    set @AccountPath = @TempAccountPath + '/' + convert(nvarchar, @LastAgencyScopeId) 

    update [dbo].[SystemAccounts] set AccountPath = @AccountPath where AccountId = @LastAgencyScopeId
    update AgencyProfile set AccountId=@ParentAgencyId where AgencyId=@NewAgencyId

    declare CurrencyCursor cursor for select CurrencyId, CurrencyName from Currencies
    open CurrencyCursor
    fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
    while @@fetch_status = 0  
    begin  
		insert into [dbo].[SystemAccounts]([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate])
        values(@ParentAgencyId, (@AgencyName +' '+@CurrencyName), @CurrencyId, @RegionLetter, '', getdate())
        set @LastAgencyScopeId=(select scope_identity())
        update [dbo].[SystemAccounts] set AccountPath = @AccountPath + '/' + convert(nvarchar, @LastAgencyScopeId) where AccountId = @LastAgencyScopeId
        fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
    end
    close CurrencyCursor
    deallocate CurrencyCursor

    select @ParentAgencyId
go

CREATE proc [dbo].[SysAccountsCreateAirProviderAccount]
    @RegionLetter nvarchar(5),
    @NewAirwayId uniqueidentifier
as

    declare @AirwayName nvarchar(max) 
    declare @LastAirwayScopeId  bigint
    declare @AccountPath nvarchar(100) 
    declare @TempAccountPath  nvarchar(100)  
	declare @ParentAirwayId bigint
    declare @CurrencyId int
    declare @CurrencyName nvarchar(3)

    select top 1 @TempAccountPath = AccountPath, @LastAirwayScopeId = AccountId from SystemAccounts where AccountCode = 'OtherSupplier'
    select top 1 @AirwayName = AirWayName from AirWays where AirWayId = @NewAirwayId

    insert into [dbo].[SystemAccounts]([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate])
    values(@LastAirwayScopeId, @AirwayName, 0, @RegionLetter, '', getdate())		
	set @LastAirwayScopeId=(select scope_identity())
	set @ParentAirwayId =@LastAirwayScopeId
	set @AccountPath = @TempAccountPath + '/' + convert(nvarchar, @LastAirwayScopeId) 
	update [dbo].[SystemAccounts] set AccountPath = @AccountPath where AccountId = @LastAirwayScopeId
	update AirWays set AccountId=@ParentAirwayId where AirWayId=@NewAirwayId
   
    declare CurrencyCursor cursor for select CurrencyId, CurrencyName from Currencies
    open CurrencyCursor
        fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
        while @@fetch_status = 0  
        begin
            insert into [dbo].[SystemAccounts]([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate])
            values(@ParentAirwayId, (@AirwayName +' '+@CurrencyName), @CurrencyId, @RegionLetter, '', getdate())

            set @LastAirwayScopeId=(select scope_identity())
		    update [dbo].[SystemAccounts] set AccountPath = @AccountPath + '/' + convert(nvarchar, @LastAirwayScopeId) where AccountId = @LastAirwayScopeId

            fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
        end
    close CurrencyCursor
    deallocate CurrencyCursor

    select @ParentAirwayId
go

CREATE proc [dbo].[SysAccountsCreateBankAccount]
    @RegionLetter nvarchar(5),
    @NewBankId uniqueidentifier
as 

    declare @AccountPath nvarchar(100)
    declare @LastBankScopeId  bigint 
    declare @TempScopeId  bigint
    declare @BankName nvarchar(max)
    declare @TRYAccountNumber nvarchar(max)
    declare @USDAccountNumber nvarchar(max)
    declare @EURAccountNumber nvarchar(max)
    declare @CurrencyId int
	declare @CurrencyName nvarchar(3)

    select top 1 @BankName = BankName, @TRYAccountNumber = TRYAccountNumber, @USDAccountNumber = USDAccountNumber, @EURAccountNumber = EURAccountNumber from Banks where BankId = @NewBankId
    select top 1 @AccountPath = AccountPath, @LastBankScopeId = AccountId from SystemAccounts where AccountCode = 'BankAccount'

    insert into [dbo].[SystemAccounts]([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate])
    values(@LastBankScopeId, @BankName, 0, @RegionLetter, '', getdate()) 
    set @LastBankScopeId=(select scope_identity())
    set @TempScopeId = @LastBankScopeId
    set @AccountPath = @AccountPath + '/' + convert(nvarchar, @LastBankScopeId) 
    update [dbo].[SystemAccounts] set AccountPath = @AccountPath where AccountId = @LastBankScopeId
    update Banks set AccountId=@TempScopeId where BankId=@NewBankId

    declare CurrencyCursor cursor for select CurrencyId,CurrencyName from Currencies
	open CurrencyCursor			
	fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
	while @@fetch_status = 0  
    begin   
		if @CurrencyName = 'TRY' or @CurrencyName = 'USD' or @CurrencyName = 'EUR'
		begin
		    insert into [dbo].[SystemAccounts] ([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate]) 
		    values(@LastBankScopeId,(@BankName +' ('+ @TRYAccountNumber + ' Nolu Hesap) ' +  @CurrencyName),@CurrencyId,@RegionLetter,'',getdate())
		end
		else
		begin
			insert into [dbo].[SystemAccounts] ([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate]) 
			values(@LastBankScopeId,(@BankName +' '+  @CurrencyName),@CurrencyId,@RegionLetter,'',getdate())
		end

        set @LastBankScopeId=(select scope_identity())
        update [dbo].[SystemAccounts] set AccountPath = @AccountPath + '/' + convert(nvarchar, @LastBankScopeId)  where AccountId = @LastBankScopeId

        fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
    end
	close CurrencyCursor   
	deallocate CurrencyCursor  

    select @TempScopeId
go

CREATE proc [dbo].[SysAccountsCreateBankVPosAccount]
    @RegionLetter nvarchar(5),
    @NewBankId uniqueidentifier
as 

    declare @AccountPath nvarchar(100)
    declare @LastBankScopeId  bigint 
    declare @TempScopeId  bigint
    declare @BankName nvarchar(max)
    declare @VposBankName nvarchar(100)
    declare @CurrencyId int
	declare @CurrencyName nvarchar(3)

    select top 1 @BankName = BankName from Banks where BankId = @NewBankId
    select top 1 @AccountPath = AccountPath, @LastBankScopeId = AccountId from SystemAccounts where AccountCode = 'BankVPosAccount'
    set @VposBankName = @BankName + ' VPOS'

    insert into [dbo].[SystemAccounts] ([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate])
    values(@LastBankScopeId, @VposBankName, 0, @RegionLetter, '', getdate()) 
    set @LastBankScopeId=(select scope_identity())
    set @TempScopeId = @LastBankScopeId
    set @AccountPath = @AccountPath + '/' + convert(nvarchar, @LastBankScopeId) 
    update [dbo].[SystemAccounts] set AccountPath = @AccountPath where AccountId = @LastBankScopeId
   
	declare CurrencyCursor cursor for select CurrencyId,CurrencyName from Currencies
	open CurrencyCursor				
	fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
	while @@fetch_status = 0  
	begin   
	    insert into[dbo].[SystemAccounts]([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate]) 
	    values(@LastBankScopeId,(@VposBankName + ' ' +  @CurrencyName),@CurrencyId,@RegionLetter,'',getdate())
        set @LastBankScopeId=(select scope_identity())
        update [dbo].[SystemAccounts] set AccountPath = @AccountPath + '/' + convert(nvarchar, @LastBankScopeId)  where AccountId = @LastBankScopeId
        fetch next from CurrencyCursor INTO @CurrencyId,@CurrencyName
	end
	close CurrencyCursor   
	deallocate CurrencyCursor  

    select @TempScopeId
go

CREATE proc [dbo].[SysAccountsCreateCompanyAccount]
    @RegionLetter nvarchar(5),
    @CompanyName nvarchar(200),
    @IsSupplier bit
as

    declare @last_scope_id  bigint;
    declare @account_path nvarchar(200);
    declare @customer_id int
    declare @CurrencyId int
	declare @CurrencyName nvarchar(3)
	declare @parent_customer_id int

    if(@IsSupplier = 0)
    begin
	    select top 1 @account_path = AccountPath, @customer_id = AccountId from [dbo].[SystemAccounts] where AccountCode = 'CustomersAccount';
	    insert into [dbo].[SystemAccounts] ([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate]) 
	    values(@customer_id,@CompanyName,0,@RegionLetter,'',getdate());
	    set @last_scope_id=(select scope_identity());
	    set @account_path =  @account_path + '/' + convert(nvarchar, @last_scope_id);
	    update [dbo].[SystemAccounts] set AccountPath = @account_path where AccountId = @last_scope_id;
	    set @parent_customer_id = @last_scope_id;
    end
    else
    begin
        select top 1 @account_path = AccountPath, @customer_id = AccountId from [dbo].[SystemAccounts] where AccountCode = 'OtherSupplier';
	    insert into [dbo].[SystemAccounts] ([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate]) 
	    values(@customer_id,@CompanyName,0,@RegionLetter,'',getdate());
	    set @last_scope_id=(select scope_identity());
	    set @account_path =  @account_path + '/' + convert(nvarchar, @last_scope_id);
	    update [dbo].[SystemAccounts] set AccountPath = @account_path where AccountId = @last_scope_id;
	    set @parent_customer_id = @last_scope_id;
    end

    declare CurrencyCursor cursor for select CurrencyId,CurrencyName from Currencies
	open CurrencyCursor
	fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
	while @@fetch_status = 0  
    begin  
		insert into [dbo].[SystemAccounts]([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate]) 
        values(@parent_customer_id,(@CompanyName +' '+@CurrencyName),@CurrencyId,@RegionLetter,'',getdate());	
		set @last_scope_id=(select scope_identity());
		update [dbo].[SystemAccounts] set AccountPath = @account_path + '/' + convert(nvarchar, @last_scope_id) where AccountId = @last_scope_id;
		fetch next from CurrencyCursor into @CurrencyId,@CurrencyName
	end
	close CurrencyCursor   
	deallocate CurrencyCursor 

    select @last_scope_id
go

create proc [dbo].[SysSystemInformationListAdd]
@InformationType nvarchar(500), @ExceptionText nvarchar(max), @Lang nvarchar(2)
as
insert into SysSystemInformationList(InformationType, ExceptionText, Lang) values(@InformationType, @ExceptionText, @Lang)
go

create proc [dbo].[SysSystemInformationListDelete]
@SystemInformationId int
as
delete from SysSystemInformationList
where SystemInformationId=@SystemInformationId
go

create proc [dbo].[SysSystemInformationListList]
as
select * from SysSystemInformationList
go

create proc [dbo].[SysSystemInformationListListById]
@SystemInformationId int
as
select * from SysSystemInformationList
where SystemInformationId=@SystemInformationId
go

create proc [dbo].[SysSystemInformationListOneItemByInformationType]
@InformationType nvarchar(300),
@Lang nvarchar(2)
as
select * from SysSystemInformationList where InformationType=@InformationType and Lang=@Lang
go

create proc [dbo].[SysSystemInformationListUpdate]
@SystemInformationId int, @InformationType nvarchar(500), @ExceptionText nvarchar(max), @Lang nvarchar(2)
as
update SysSystemInformationList set InformationType=@InformationType, ExceptionText=@ExceptionText, Lang=@Lang
where SystemInformationId=@SystemInformationId
go

CREATE proc [dbo].[SystemAccountFilter]
    @ParentAccountId bigint,
    @GroupAccountId int,
    @AccountId int,
    @SubAccountId int
as
    if (@ParentAccountId <> -1 and @GroupAccountId = -1 and @AccountId = -1 and @SubAccountId = -1)
        begin
            select *, isnull(dbo.SystemAccountLastBalance(AccountId, CurrencyId), 0) as LastBalance
            from SystemAccounts
            where ParentAccountId = @ParentAccountId
        end
    else
    if (@ParentAccountId <> -1 and @GroupAccountId <> -1 and @AccountId = -1 and @SubAccountId = -1)
        begin
            select *, isnull(dbo.SystemAccountLastBalance(AccountId, CurrencyId), 0) as LastBalance
            from SystemAccounts
            where ParentAccountId = @GroupAccountId
        end
    else
    if (@ParentAccountId <> -1 and @GroupAccountId <> -1 and @AccountId <> -1 and @SubAccountId = -1)
        begin
            select *, isnull(dbo.SystemAccountLastBalance(AccountId, CurrencyId), 0) as LastBalance
            from SystemAccounts
            where ParentAccountId = @AccountId
        end
    else
    if (@ParentAccountId <> -1 and @GroupAccountId <> -1 and @AccountId <> -1 and @SubAccountId <> -1)
        begin
            select *, isnull(dbo.SystemAccountLastBalance(AccountId, CurrencyId), 0) as LastBalance
            from SystemAccounts
            where ParentAccountId = @SubAccountId
        end
    else
        begin
            select *, isnull(dbo.SystemAccountLastBalance(AccountId, CurrencyId), 0) as LastBalance
            from SystemAccounts
            where ParentAccountId = 0
        end
go

CREATE FUNCTION  [dbo].[SystemAccountLastBalance]
(
	 @AccountId bigint,
	 @currencyId int
)
RETURNS decimal(18,4)
AS
BEGIN

    Return(

        select   isnull(SUM( m.Credit-m.Debt), 0) AS Balance 
            from OrderTransaction m with(nolock)
        where m.AccountId=@AccountId 
        
        )
END
go

create proc [dbo].[SystemAccountsAdd]
@ParentAccountId bigint, @AccountName nvarchar(max), @CurrencyId int, @AccountPath nvarchar(max), @AccountCode nvarchar(50), @RegionLetter nvarchar(50), @CreationDate datetime
as
insert into SystemAccounts(ParentAccountId, AccountName, CurrencyId, AccountPath, AccountCode, RegionLetter, CreationDate) values(@ParentAccountId, @AccountName, @CurrencyId, @AccountPath, @AccountCode, @RegionLetter, @CreationDate)
go

create proc [dbo].[SystemAccountsAddAndUpdatePath] 
    @ParentAccountId bigint, 
    @AccountName nvarchar(max), 
    @CurrencyId int,
    @AccountPath nvarchar(max),
    @AccountCode nvarchar(50),
    @RegionLetter nvarchar(50),
    @CreationDate datetime
as
    declare @LastScopeId bigint
    insert into SystemAccounts(ParentAccountId, AccountName, CurrencyId, AccountPath, AccountCode, RegionLetter, CreationDate)
    values (@ParentAccountId, @AccountName, @CurrencyId, @AccountPath, @AccountCode, @RegionLetter, @CreationDate)
    set @LastScopeId = (select scope_identity())
    update SystemAccounts set AccountPath = (select AccountPath from SystemAccounts where AccountId = @LastScopeId) + CAST(@LastScopeId as varchar(255))   
    where AccountId = @LastScopeId
go

create proc [dbo].[SystemAccountsDelete]
@AccountId bigint
as
delete from SystemAccounts
where AccountId=@AccountId
go

create proc [dbo].[SystemAccountsDeleteByAccountIdOrParentAccountId] 
    @AccountId bigint
as
    delete  from SystemAccounts where (AccountId = @AccountId or ParentAccountId = @AccountId)
go

create proc [dbo].[SystemAccountsIdByParentAccountId]
@ParentAccountId bigint
as

DECLARE @LastSystemAccountId bigint = @ParentAccountId;

WITH TopParentFinder AS
(
    SELECT AccountId, CreationDate, ParentAccountId, AccountPath
	FROM SystemAccounts 
    WHERE ParentAccountId = @ParentAccountId

    UNION ALL

    SELECT rh.AccountId,rh.CreationDate, rh.ParentAccountId, rh.AccountPath   
	FROM SystemAccounts rh
    INNER JOIN TopParentFinder rc ON rh.ParentAccountId = rc.AccountId
)
select tp.AccountId
from TopParentFinder tp
where (select top 1 AccountId from TopParentFinder where ParentAccountId = tp.AccountId ) is null
order by tp.AccountId
go

create proc [dbo].[SystemAccountsList]
as
select * from SystemAccounts
go

create proc [dbo].[SystemAccountsListById]
@AccountId bigint
as
select * from SystemAccounts
where AccountId=@AccountId
go

create proc [dbo].[SystemAccountsOneItemByAccountCodeAndCurrencyId]
@AccountCode nvarchar(50),
@CurrencyId int
as
select * from SystemAccounts where AccountCode=@AccountCode and CurrencyId=@CurrencyId
go

CREATE proc [dbo].[SystemAccountsParentAccountId]
@AccountId bigint
as
DECLARE @LastSystemAccountId bigint = @AccountId;

WITH TopParentFinder AS
(
    SELECT AccountId, CreationDate, ParentAccountId, AccountPath
	FROM SystemAccounts 
    WHERE AccountId = @AccountId

    UNION ALL

    SELECT rh.AccountId,rh.CreationDate, rh.ParentAccountId, rh.AccountPath   
	FROM SystemAccounts rh
    INNER JOIN TopParentFinder rc ON rh.AccountId = rc.ParentAccountId
)

SELECT @LastSystemAccountId = tpf.AccountId
FROM TopParentFinder tpf 
left join SystemAccounts r on tpf.AccountId= r.AccountId 
ORDER BY tpf.CreationDate ASC

return @LastSystemAccountId
go

create proc [dbo].[SystemAccountsUpdate]
@AccountId bigint, @ParentAccountId bigint, @AccountName nvarchar(max), @CurrencyId int, @AccountPath nvarchar(max), @AccountCode nvarchar(50), @RegionLetter nvarchar(50), @CreationDate datetime
as
update SystemAccounts set ParentAccountId=@ParentAccountId, AccountName=@AccountName, CurrencyId=@CurrencyId, AccountPath=@AccountPath, AccountCode=@AccountCode, RegionLetter=@RegionLetter, CreationDate=@CreationDate
where AccountId=@AccountId
go

CREATE proc [dbo].[SystemCurrenciesAdd]
@CurrencyCode nvarchar(50), @CurrencyName nvarchar(50), @ForexBuying decimal(18,4), @ForexSelling decimal(18,4), @BanknoteBuying decimal(18,4), @BanknoteSelling decimal(18,4), @CreationDate datetime, @OrderProcess int
as
insert into SystemCurrencies(CurrencyCode, CurrencyName, ForexBuying, ForexSelling, BanknoteBuying, BanknoteSelling, CreationDate, OrderProcess) values(@CurrencyCode, @CurrencyName, @ForexBuying, @ForexSelling, @BanknoteBuying, @BanknoteSelling, @CreationDate, @OrderProcess)
go

create proc [dbo].[SystemCurrenciesDelete]
@SystemCurrencyId uniqueidentifier
as
delete from SystemCurrencies
where SystemCurrencyId=@SystemCurrencyId
go

create proc [dbo].[SystemCurrenciesDeleteAll]
as
delete  from SystemCurrencies where Currencycode<>'TRY'
go

create proc [dbo].[SystemCurrenciesList]
as
select * from SystemCurrencies
go

create proc [dbo].[SystemCurrenciesListById]
@SystemCurrencyId uniqueidentifier
as
select * from SystemCurrencies
where SystemCurrencyId=@SystemCurrencyId
go

Create Proc [dbo].[SystemCurrenciesOneItemByCurrencyCode]
@CurrencyCode nvarchar(3)
as
select * from SystemCurrencies where CurrencyCode =@CurrencyCode
go

CREATE proc [dbo].[SystemCurrenciesUpdate]
@SystemCurrencyId uniqueidentifier, @CurrencyCode nvarchar(50), @CurrencyName nvarchar(50), @ForexBuying decimal(18,4), @ForexSelling decimal(18,4), @BanknoteBuying decimal(18,4), @BanknoteSelling decimal(18,4), @CreationDate datetime, @OrderProcess int
as
update SystemCurrencies set CurrencyCode=@CurrencyCode, CurrencyName=@CurrencyName, ForexBuying=@ForexBuying, ForexSelling=@ForexSelling, BanknoteBuying=@BanknoteBuying, BanknoteSelling=@BanknoteSelling, CreationDate=@CreationDate, OrderProcess=@OrderProcess
where SystemCurrencyId=@SystemCurrencyId
go

create proc [dbo].[SystemLocalProcessSettingsAdd]
@ServicesInvokerAgencyId uniqueidentifier, @SecurityId uniqueidentifier, @Interval int
as
insert into SystemLocalProcessSettings(ServicesInvokerAgencyId, SecurityId, Interval) values(@ServicesInvokerAgencyId, @SecurityId, @Interval)
go

create proc [dbo].[SystemLocalProcessSettingsDelete]
@ServicesName nvarchar(50)
as
delete from SystemLocalProcessSettings
where ServicesName=@ServicesName
go

create proc [dbo].[SystemLocalProcessSettingsList]
as
select * from SystemLocalProcessSettings
go

create proc [dbo].[SystemLocalProcessSettingsListById]
@ServicesName nvarchar(50)
as
select * from SystemLocalProcessSettings
where ServicesName=@ServicesName
go

create proc [dbo].[SystemLocalProcessSettingsUpdate]
@ServicesName nvarchar(50), @ServicesInvokerAgencyId uniqueidentifier, @SecurityId uniqueidentifier, @Interval int
as
update SystemLocalProcessSettings set ServicesInvokerAgencyId=@ServicesInvokerAgencyId, SecurityId=@SecurityId, Interval=@Interval
where ServicesName=@ServicesName
go

CREATE proc [dbo].[SystemMasterAccountChildAccountsList]  
@AccountId bigint
as

SELECT  *
FROM    SystemAccounts 
where ParentAccountId = @AccountId
order by AccountId
go

CREATE proc [dbo].[SystemMasterAccountChildAccountsSummaryList]
@ParentAccountId bigint,
@CurrencyId int
as
if(@CurrencyId=-1)
begin


;WITH ret AS(
        SELECT  *
        FROM    SystemAccounts with(nolock)
        WHERE   ParentAccountId =@ParentAccountId
        UNION ALL
        SELECT  t.*
        FROM    SystemAccounts t INNER JOIN
                ret r ON t.ParentAccountId = r.AccountId
)

SELECT  ret.*, isnull(dbo.SystemAccountLastBalance(ret.AccountId,ret.CurrencyId),0) as LastBalance
FROM    ret 
order by AccountId 




end
else
Begin

;WITH ret AS(
        SELECT  *
        FROM    SystemAccounts with(nolock)
       WHERE   ParentAccountId =@ParentAccountId 
        UNION ALL
        SELECT  t.*
        FROM    SystemAccounts t INNER JOIN
                ret r ON t.ParentAccountId = r.AccountId
)

SELECT  ret.*, isnull(dbo.SystemAccountLastBalance(ret.AccountId,ret.CurrencyId),0) as LastBalance
FROM    ret with(nolock) where ret.CurrencyId=@CurrencyId
order by AccountId 

End
go

create proc [dbo].[SystemMasterAccountsList]
as
Select * from SystemAccounts where ParentAccountId=0
order by AccountId
go

CREATE proc [dbo].[TicketInvoiceAdd]
	@TicketInvoiceId uniqueidentifier,
    @AgencyId uniqueidentifier, 
    @Currency nvarchar(10), 
    @Description nvarchar(1000), 
    @InvoiceDate datetime, 
    @InvoiceGuid uniqueidentifier, 
	@InvoiceNumber nvarchar(16),
    @Name nvarchar(200), 
    @PaymentMethod nvarchar(200), 
    @ProductType nvarchar(10),
    @ReservationId uniqueidentifier,
    @TotalAmount decimal(18,2),
    @CreationDate datetime,
	@CancellationDate datetime = null ,
	@TicketInvoiceType int,
	@PassengerId uniqueidentifier = null,
	@TicketInvoiceProcessType int
as


insert into TicketInvoice(TicketInvoiceId, AgencyId, Currency, Description, InvoiceDate, InvoiceGuid, InvoiceNumber, Name, PaymentMethod, ProductType, ReservationId, TotalAmount, CreationDate, CancellationDate, TicketInvoiceType, PassengerId,TicketInvoiceProcessType) 
values(@TicketInvoiceId, @AgencyId, @Currency, @Description, @InvoiceDate, @InvoiceGuid, @InvoiceNumber, @Name, @PaymentMethod, @ProductType, @ReservationId, @TotalAmount, @CreationDate, @CancellationDate, @TicketInvoiceType, @PassengerId,@TicketInvoiceProcessType)
go

CREATE proc [dbo].[TicketInvoiceCounterGetCounter]
    @Prefix nvarchar(3),
    @Year nvarchar(4)
as

DECLARE @temp_counter_table TABLE
(
	[Counter] [int] NOT NULL
);

if (select top 1 1 from TicketInvoiceCounter where [Prefix] = @Prefix and [Year] = @Year) is null
begin
		insert into TicketInvoiceCounter(TicketInvoiceCounterId, Prefix, Year, Counter)
		output INSERTED.Counter
		into @temp_counter_table
		values (NEWID(), @Prefix, @Year, 1)
	end

else
begin
	update [dbo].[TicketInvoiceCounter] WITH (ROWLOCK)
	set [Counter] = (select top 1 [Counter] from TicketInvoiceCounter where [Prefix] = @Prefix and [Year] = @Year) + 1
	output INSERTED.Counter
	into @temp_counter_table
	where [Prefix] = @Prefix and [Year] = @Year
end

select * from @temp_counter_table
go

CREATE Proc [dbo].[TicketInvoiceCustomerAdd]
@CustomerId uniqueidentifier,
@AgencyId uniqueidentifier,
@Identifier nvarchar(20),
@Name nvarchar(250) = null,
@SurName nvarchar(250) =null,
@CitySubdivisionName nvarchar(200) = null,
@CityName nvarchar(100) = null,
@Country nvarchar(250) =null,
@EMail nvarchar(300)  null,
@TaxOffice nvarchar(200) = null,
@Address nvarchar(1000) = null,
@EInvoicePkAlias nvarchar(300) = null,
@CreationDate datetime
as
INSERT INTO TicketInvoiceCustomer(
CustomerId,
AgencyId,
Identifier,
Name,
SurName,
CitySubdivisionName,
CityName,
Country,
EMail,
TaxOffice,
Address,
EInvoicePkAlias,
CreationDate
)
VALUES
(
@CustomerId,
@AgencyId,
@Identifier,
@Name,
@SurName,
@CitySubdivisionName,
@CityName,
@Country,
@EMail,
@TaxOffice,
@Address,
@EInvoicePkAlias,
@CreationDate
)
go

create proc [dbo].[TicketInvoiceCustomerListByAgencyId]
     @AgencyId uniqueidentifier
as
select * 
from TicketInvoiceCustomer
where AgencyId = @AgencyId
go

CREATE proc [dbo].[TicketInvoiceCustomerListByFilters] 
	@AgencyId uniqueidentifier = null,
    @Name nvarchar(50) = null,
    @SurName nvarchar(50) = null,
    @Identifier nvarchar(25) = null
as

select *
from TicketInvoiceCustomer
where (@AgencyId is null or AgencyId = @AgencyId)
  and (@Name is null or Name like '%' + @Name + '%')
  and (@SurName is null or SurName like '%' + @SurName + '%')
  and (@Identifier is null or Identifier like '%' + @Identifier + '%')

order by CreationDate desc
go

create proc [dbo].[TicketInvoiceCustomerOneItem]
     @CustomerId uniqueidentifier
as
select * 
from TicketInvoiceCustomer
where CustomerId = @CustomerId
go

CREATE proc [dbo].[TicketInvoiceCustomerUpdate]
    @CustomerId uniqueidentifier,
	@AgencyId uniqueidentifier,
	@Identifier nvarchar(20),
	@Name nvarchar(250) = null,
	@SurName nvarchar(250) =null,
	@CitySubdivisionName nvarchar(200) = null,
	@CityName nvarchar(100) = null,
	@Country nvarchar(250) =null,
	@EMail nvarchar(300)  null,
	@TaxOffice nvarchar(200) = null,
	@Address nvarchar(1000) = null,
	@EInvoicePkAlias nvarchar(300) = null,
	@CreationDate datetime

as
update TicketInvoiceCustomer
set 
  AgencyId = @AgencyId,
  Identifier = @Identifier,
  Name = @Name,
  SurName = @SurName,
  CitySubdivisionName = @CitySubdivisionName,
  CityName = @CityName,
  Country = @Country,
  EMail = @EMail,
  TaxOffice = @TaxOffice,
  Address = @Address,
  EInvoicePkAlias = @EInvoicePkAlias,
  CreationDate = @CreationDate
 where CustomerId = @CustomerId
go

create proc [dbo].[TicketInvoiceDelete]
    @TicketInvoiceId uniqueidentifier
as
delete from TicketInvoice
where TicketInvoiceId = @TicketInvoiceId
go

create proc [dbo].[TicketInvoiceList]
as
select * 
from TicketInvoice
go

create proc [dbo].[TicketInvoiceListByAgencyId]
     @AgencyId uniqueidentifier
as
select * 
from TicketInvoice 
where AgencyId = @AgencyId
go

CREATE proc [dbo].[TicketInvoiceListByFilters]
	@AgencyId uniqueidentifier =null,
	@Product nvarchar(100)=null,
	@StartDate date,
	@EndDate date,
	@ByaAgencyId uniqueidentifier = null
as

select distinct
	ti.TicketInvoiceId as TicketInvoiceId
	  , pai.SurName + '/' + pai.Name as PassengerName
	  , pai.CitizenNumber as TaxNo
	  , (select STRING_AGG(fli.Departure + ' - ' + fli.Arrival , ' | ') within group (ORDER BY (CONVERT(datetime, (CONVERT(nvarchar, fli.DepartureDate, 102) + ' ' + CONVERT(nvarchar, fli.DepartureTime, 108)), 120))) "flightList"
	from FlightsInfo fli
	where fli.ReservationId = ti.ReservationId) as Racecourse
	  , CAST(ROUND((fpi.ServicesPrice + fpi.AgencyCommission + fpi.ExtraCommisson), 2) as decimal(18,2)) as TotalCommission
	  , CAST(ROUND(((fpi.ServicesPrice + fpi.AgencyCommission + fpi.ExtraCommisson) / 1.18), 2) as decimal(18,2)) as TaxableCommission
	  , CAST(ROUND(((fpi.ServicesPrice + fpi.AgencyCommission + fpi.ExtraCommisson) / 1.18 * 0.18), 2) as decimal(18,2)) as KdvCommission
	  , fpi.Vq as ZeroBasePrice
	  , fpi.Vq as AirportTax
      , ti.TotalAmount as TotalAmount
	  , CAST(ROUND(((ti.TotalAmount - fpi.Vq) / 1.18), 2) as decimal(18,2)) as BasePrice
	  , CAST(ROUND((((ti.TotalAmount - fpi.Vq) / 1.18) * 0.18), 2) as decimal(18,2)) as TaxAmount
	  , CAST(ROUND((ti.TotalAmount - (fpi.ServicesPrice + fpi.AgencyCommission + fpi.ExtraCommisson) - fpi.Vq), 2) as decimal(18,2)) as TicketAmount
      , ti.AgencyId as AgencyId
      , ti.ProductType as ProductType
      , ti.ReservationId as ReservationId
      , ti.Description as Description
      , ti.Name as Name
      , ti.InvoiceNumber as InvoiceNumber
      , ti.InvoiceGuid as InvoiceGuid
      , ti.Currency as Currency
      , ti.PaymentMethod as PaymentMethod
      , ti.CreationDate as CreationDate
      , ti.InvoiceDate as InvoiceDate
      , ti.CancellationDate as CancellationDate
      , ti.TicketInvoiceType as TicketInvoiceType
      , ti.PassengerId as PassengerId  
	  , ti.TicketInvoiceProcessType as TicketInvoiceProcessType
	  , res.IsDomestic as IsDomestic
	  , (case when agp.IsAgencyCompany = 1  then (select top 1
		sagp.AgencyName
	from AgencyProfile sagp
	where sagp.AgencyId = agp.ParentAgencyId) else agp.AgencyName end) as AgencyName
from TicketInvoice ti
	left join PassengersInfo pai on ti.PassengerId = pai.PassengerId
	inner join FlightPriceInfo fpi on ti.ReservationId = fpi.ReservationId
	left join Reservations res on res.ReservationId = ti.ReservationId
	left join AgencyProfile agp on agp.AgencyId = ti.AgencyId
where 
    (@AgencyId is null or ti.AgencyId = @AgencyId)
	and (@Product is null or ti.ProductType = @Product)
	and cast(ti.CreationDate as date) >= cast( @StartDate as date)
	and cast(ti.CreationDate as date) <= cast(@EndDate as date)
	and (@ByaAgencyId is null or ti.AgencyId in (select sAp.AgencyId
	from AgencyProfile sAp
	where sAp.ParentAgencyId = @ByaAgencyId or sAp.AgencyId = @ByaAgencyId))

order by CreationDate desc
go

create proc [dbo].[TicketInvoiceListById]
    @TicketInvoiceId uniqueidentifier
as
select * 
from TicketInvoice
where TicketInvoiceId = @TicketInvoiceId
go

create proc [dbo].[TicketInvoiceListByReservationId]
    @ReservationId uniqueidentifier
as
select * 
from TicketInvoice
where ReservationId = @ReservationId
go

CREATE proc [dbo].[TicketInvoiceUpdate]
    @TicketInvoiceId uniqueidentifier,
    @AgencyId uniqueidentifier, 
    @Currency nvarchar(10), 
    @Description nvarchar(1000), 
    @InvoiceDate datetime, 
    @InvoiceGuid uniqueidentifier, 
	@InvoiceNumber nvarchar(16),
    @Name nvarchar(200), 
    @PaymentMethod nvarchar(200), 
    @ProductType nvarchar(10),
    @ReservationId uniqueidentifier,
    @TotalAmount decimal(12,2),
    @CreationDate datetime,
	@CancellationDate datetime = null,
	@TicketInvoiceType int,
	@PassengerId uniqueidentifier = null,
	@TicketInvoiceProcessType int

as
update TicketInvoice 
set 
    TicketInvoiceId = @TicketInvoiceId,
    AgencyId = @AgencyId,
    Currency = @Currency,
    Description = @Description,
    InvoiceDate = @InvoiceDate,
    InvoiceGuid = @InvoiceGuid,
	InvoiceNumber = @InvoiceNumber,
    Name = @Name,
    PaymentMethod = @PaymentMethod,
    ProductType = @ProductType,
    ReservationId = @ReservationId,
    TotalAmount = @TotalAmount,
    CreationDate = @CreationDate,
	CancellationDate = @CancellationDate,
	TicketInvoiceType = @TicketInvoiceType,
	PassengerId = @PassengerId,
	TicketInvoiceProcessType = @TicketInvoiceProcessType

 where TicketInvoiceId = @TicketInvoiceId
go

create proc [dbo].[TicketInvoiceoListById]
    @TicketInvoiceId uniqueidentifier
as
select * 
from TicketInvoice
where TicketInvoiceId = @TicketInvoiceId
go

create proc  [dbo].[UpdateProcessIdReatedTables]
@OldProcessId uniqueidentifier,
@NewProcessId uniqueidentifier
as

UPDATE [dbo].[BankPosLogs] SET ProcessId=@NewProcessId where ProcessId=@OldProcessId
UPDATE [dbo].[OrderTransaction] SET ProcessId=@NewProcessId where ProcessId=@OldProcessId
UPDATE [dbo].[ProcessTransactions] SET ProcessId=@NewProcessId where ProcessId=@OldProcessId
UPDATE [dbo].[ReceiptInfo] SET ProcessId=@NewProcessId where ProcessId=@OldProcessId
UPDATE [dbo].[ReservationNotes] SET ProcessId=@NewProcessId where ProcessId=@OldProcessId
UPDATE [dbo].[Reservations] SET ProcessId=@NewProcessId where ProcessId=@OldProcessId
UPDATE [dbo].[SmsCounter] SET ProcessId=@NewProcessId where ProcessId=@OldProcessId
UPDATE [dbo].[Support] SET ProcessId=@NewProcessId where ProcessId=@OldProcessId
go

create proc [dbo].[VisitorCommentsAdd]
@NameSurname nvarchar(50), @CommentTitle nvarchar(225), @CommentContext nvarchar(500), @IpAdress nvarchar(50), @EMailAdres nvarchar(50), @CommentDate datetime, @Status bit, @Lang nvarchar(5)
as
insert into VisitorComments(NameSurname, CommentTitle, CommentContext, IpAdress, EMailAdres, CommentDate, Status, Lang) values(@NameSurname, @CommentTitle, @CommentContext, @IpAdress, @EMailAdres, @CommentDate, @Status, @Lang)
go

create proc [dbo].[VisitorCommentsDelete]
@VisitorCommentId uniqueidentifier
as
delete from VisitorComments
where VisitorCommentId=@VisitorCommentId
go

create proc [dbo].[VisitorCommentsList]
as
select * from VisitorComments
go

create proc [dbo].[VisitorCommentsListById]
@VisitorCommentId uniqueidentifier
as
select * from VisitorComments
where VisitorCommentId=@VisitorCommentId
go

create proc [dbo].[VisitorCommentsUpdate]
@VisitorCommentId uniqueidentifier, @NameSurname nvarchar(50), @CommentTitle nvarchar(225), @CommentContext nvarchar(500), @IpAdress nvarchar(50), @EMailAdres nvarchar(50), @CommentDate datetime, @Status bit, @Lang nvarchar(5)
as
update VisitorComments set NameSurname=@NameSurname, CommentTitle=@CommentTitle, CommentContext=@CommentContext, IpAdress=@IpAdress, EMailAdres=@EMailAdres, CommentDate=@CommentDate, Status=@Status, Lang=@Lang
where VisitorCommentId=@VisitorCommentId
go

create proc [dbo].[XmlAuthSessionsAdd]
@AgencyId uniqueidentifier, @ExpirationDate datetime
as
insert into XmlAuthSessions(AgencyId, ExpirationDate) values(@AgencyId, @ExpirationDate)
go

CREATE proc [dbo].[XmlAuthSessionsCreateSession] 
	@AgencyId uniqueidentifier,
	@Password nvarchar(50)
	as

	 
	declare @AllowToXML int =(Select count(*) from AgencyProfile where AgencyId=@AgencyId and XMLAuthPassword=@Password)

	if(@AllowToXML> 0)
	BEGIN

	declare @NewSessionParam nvarchar(max)
	declare @NewGuid nvarchar(50)
	declare @ExpirationDate datetime=(select  top 1 ExpirationDate from XmlAuthSessions where AgencyId=@AgencyId order by ExpirationDate desc)		
	set @NewGuid=(Select NEWID())
	
 
	if(@ExpirationDate < getdate())
	BEGIN
					Delete from XmlAuthSessions where AgencyId=@AgencyId	
					set @NewSessionParam =(cast(@AgencyId as nvarchar(300))+cast(getdate() as nvarchar(300))+@NewGuid)
					set @NewSessionParam=(dbo.EncodeDataToBase64(CONVERT(VARCHAR(32), HashBytes('SHA2_512  ', @NewSessionParam), 2)))
					insert into XmlAuthSessions(SessionId,AgencyId,ExpirationDate) values(@NewSessionParam,@AgencyId,DATEADD(MINUTE,20,getdate()))
					select   * from XmlAuthSessions where AgencyId=@AgencyId  
	END
	else
	Begin
				if exists(select SessionId from XmlAuthSessions where AgencyId=@AgencyId)
					BEGIN
					select * from XmlAuthSessions where AgencyId=@AgencyId
					END
				ELSE
							BEGIN	
							set @NewSessionParam =(cast(@AgencyId as nvarchar(300))+cast(getdate() as nvarchar(300))+@NewGuid)
							set @NewSessionParam=(dbo.EncodeDataToBase64(CONVERT(VARCHAR(32), HashBytes('SHA2_512  ', @NewSessionParam), 2)))
							insert into XmlAuthSessions(SessionId,AgencyId,ExpirationDate) values(@NewSessionParam,@AgencyId,DATEADD(MINUTE,20,getdate()))
							select * from XmlAuthSessions where AgencyId=@AgencyId	
			End
		END
	END
go

create proc [dbo].[XmlAuthSessionsDelete]
@SessionId nvarchar(255)
as
delete from XmlAuthSessions
where SessionId=@SessionId
go

CREATE proc [dbo].[XmlAuthSessionsIsAvailable]  
@AgencyId uniqueidentifier
as
declare @ExpirationDate datetime=( select ExpirationDate from XmlAuthSessions where AgencyId=@AgencyId)	

if(DATEADD(MINUTE,-20,getdate()) < @ExpirationDate  )
	BEGIN

	 select * from XmlAuthSessions where AgencyId=@AgencyId
	END
go

CREATE proc [dbo].[XmlAuthSessionsKillSession]
	@AgencyId uniqueidentifier
	as
	delete  XmlAuthSessions where AgencyId=@AgencyId
go

create proc [dbo].[XmlAuthSessionsList]
as
select * from XmlAuthSessions
go

create proc [dbo].[XmlAuthSessionsListById]
@SessionId nvarchar(255)
as
select * from XmlAuthSessions
where SessionId=@SessionId
go

create proc [dbo].[XmlAuthSessionsUpdate]
@SessionId nvarchar(255), @AgencyId uniqueidentifier, @ExpirationDate datetime
as
update XmlAuthSessions set AgencyId=@AgencyId, ExpirationDate=@ExpirationDate
where SessionId=@SessionId
go

create Proc [dbo].[_____a]
as
go

CREATE proc [dbo].[_deleteall]
as
delete from Reservations
delete from PassengersInfo
delete from FlightsInfo
delete from ErrorLogs
delete from FlightPriceInfo
delete from OrderTransaction
delete from BankPosLogs
delete from Support
delete from SupportDetails
delete from FlightPriceInfoWithCurriencies
go

create or replace function sys.dm_cryptographic_provider_algorithms(@ProviderId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_cryptographic_provider_keys(@ProviderId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_cryptographic_provider_sessions(@all int) as
begin
-- missing source code
end
go

create or replace function sys.dm_db_database_page_allocations(@DatabaseId smallint, @IndexId int, @Mode nvarchar(64), @PartitionId bigint, @TableId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_db_index_operational_stats(@DatabaseId smallint, @IndexId int, @PartitionNumber int, @TableId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_db_index_physical_stats(@DatabaseId smallint, @IndexId int, @Mode nvarchar(20), @ObjectId int, @PartitionNumber int) as
begin
-- missing source code
end
go

create or replace function sys.dm_db_missing_index_columns(@handle int) as
begin
-- missing source code
end
go

create or replace function sys.dm_db_objects_disabled_on_compatibility_level_change(@compatibility_level int) as
begin
-- missing source code
end
go

create or replace function sys.dm_db_stats_properties(@object_id int, @stats_id int) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_cached_plan_dependent_objects(@planhandle varbinary(64)) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_cursors(@spid int) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_describe_first_result_set(@browse_information_mode tinyint, @params nvarchar(max), @tsql nvarchar(max)) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_describe_first_result_set_for_object(@browse_information_mode tinyint, @object_id int) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_plan_attributes(@handle varbinary(64)) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_query_plan(@handle varbinary(64)) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_sql_text(@handle varbinary(64)) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_text_query_plan(@handle varbinary(64), @stmt_end_offset int, @stmt_start_offset int) as
begin
-- missing source code
end
go

create or replace function sys.dm_exec_xml_handles(@spid int) as
begin
-- missing source code
end
go

create or replace function sys.dm_fts_index_keywords(@dbid int, @objid int) as
begin
-- missing source code
end
go

create or replace function sys.dm_fts_index_keywords_by_document(@dbid int, @objid int) as
begin
-- missing source code
end
go

create or replace function sys.dm_fts_index_keywords_by_property(@dbid int, @objid int) as
begin
-- missing source code
end
go

create or replace function sys.dm_fts_index_keywords_position_by_document(@dbid int, @objid int) as
begin
-- missing source code
end
go

create or replace function sys.dm_fts_parser(@accentsensitive bit, @lcid int, @querystring nvarchar(4000), @stoplistid int) as
begin
-- missing source code
end
go

create or replace function sys.dm_io_virtual_file_stats(@DatabaseId int, @FileId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_logconsumer_cachebufferrefs(@ConsumerId bigint, @DatabaseId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_logconsumer_privatecachebuffers(@ConsumerId bigint, @DatabaseId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_logpool_consumers(@DatabaseId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_logpool_sharedcachebuffers(@DatabaseId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_logpoolmgr_freepools(@DatabaseId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_logpoolmgr_respoolsize(@DatabaseId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_logpoolmgr_stats(@DatabaseId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_os_volume_stats(@DatabaseId int, @FileId int) as
begin
-- missing source code
end
go

create or replace function sys.dm_sql_referenced_entities(@name nvarchar(517), @referencing_class nvarchar(60)) as
begin
-- missing source code
end
go

create or replace function sys.dm_sql_referencing_entities(@name nvarchar(517), @referenced_class nvarchar(60)) as
begin
-- missing source code
end
go

create or replace function sys.fn_EnumCurrentPrincipals() as
begin
-- missing source code
end
go

create or replace function sys.fn_GetCurrentPrincipal(@db_name sysname) returns sysname as
begin
-- missing source code
end
go

create or replace function sys.fn_GetRowsetIdFromRowDump(@rowdump varbinary(max)) returns bigint as
begin
-- missing source code
end
go

create or replace function sys.fn_IsBitSetInBitmask(@bitmask varbinary(500), @colid int) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_MSdayasnumber(@day datetime) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_MSgeneration_downloadonly(@generation bigint, @tablenick int) returns bigint as
begin
-- missing source code
end
go

create or replace function sys.fn_MSget_dynamic_filter_login(@partition_id int, @publication_number int) returns sysname as
begin
-- missing source code
end
go

create or replace function sys.fn_MSorbitmaps(@bm1 varbinary(128), @bm2 varbinary(128)) returns varbinary(128) as
begin
-- missing source code
end
go

create or replace function sys.fn_MSrepl_map_resolver_clsid(@article_resolver nvarchar(255), @compatibility_level int, @resolver_clsid nvarchar(60)) returns nvarchar(60) as
begin
-- missing source code
end
go

create or replace function sys.fn_MStestbit(@bitmap varbinary(128), @colidx smallint) returns bit as
begin
-- missing source code
end
go

create or replace function sys.fn_MSvector_downloadonly(@tablenick int, @vector varbinary(2953)) returns varbinary(311) as
begin
-- missing source code
end
go

create or replace function sys.fn_MSxe_read_event_stream(@source nvarchar(260), @source_opt int) as
begin
-- missing source code
end
go

create or replace function sys.fn_MapSchemaType(@schemasubtype int, @schematype int) returns sysname as
begin
-- missing source code
end
go

create or replace function sys.fn_PhysLocCracker(@physical_locator binary(8)) as
begin
-- missing source code
end
go

create or replace function sys.fn_PhysLocFormatter(@physical_locator binary(8)) returns varchar(128) as
begin
-- missing source code
end
go

create or replace function sys.fn_RowDumpCracker(@rowdump varbinary(max)) as
begin
-- missing source code
end
go

create or replace function sys.fn_builtin_permissions(@level nvarchar(60)) as
begin
-- missing source code
end
go

create or replace function sys.fn_cColvEntries_80(@artnick int, @pubid uniqueidentifier) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_cdc_check_parameters(@capture_instance sysname, @from_lsn binary(10), @net_changes bit, @row_filter_option nvarchar(30), @to_lsn binary(10)) returns bit as
begin
-- missing source code
end
go

create or replace function sys.fn_cdc_get_column_ordinal(@capture_instance sysname, @column_name sysname) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_cdc_get_max_lsn() returns binary(10) as
begin
-- missing source code
end
go

create or replace function sys.fn_cdc_get_min_lsn(@capture_instance sysname) returns binary(10) as
begin
-- missing source code
end
go

create or replace function sys.fn_cdc_has_column_changed(@capture_instance sysname, @column_name sysname, @update_mask varbinary(128)) returns bit as
begin
-- missing source code
end
go

create or replace function sys.fn_cdc_hexstrtobin(@hexstr nvarchar(40)) returns binary(10) as
begin
-- missing source code
end
go

create or replace function sys.fn_cdc_map_lsn_to_time(@lsn binary(10)) returns datetime as
begin
-- missing source code
end
go

create or replace function sys.fn_cdc_map_time_to_lsn(@relational_operator nvarchar(30), @tracking_time datetime) returns binary(10) as
begin
-- missing source code
end
go

create or replace function sys.fn_check_object_signatures(@class sysname, @thumbprint varbinary(20)) as
begin
-- missing source code
end
go

create or replace function sys.fn_dblog(@end nvarchar(25), @start nvarchar(25)) as
begin
-- missing source code
end
go

create or replace function sys.fn_dump_dblog(@devtype nvarchar(260), @end nvarchar(25), @fname1 nvarchar(260), @fname10 nvarchar(260), @fname11 nvarchar(260), @fname12 nvarchar(260), @fname13 nvarchar(260), @fname14 nvarchar(260), @fname15 nvarchar(260), @fname16 nvarchar(260), @fname17 nvarchar(260), @fname18 nvarchar(260), @fname19 nvarchar(260), @fname2 nvarchar(260), @fname20 nvarchar(260), @fname21 nvarchar(260), @fname22 nvarchar(260), @fname23 nvarchar(260), @fname24 nvarchar(260), @fname25 nvarchar(260), @fname26 nvarchar(260), @fname27 nvarchar(260), @fname28 nvarchar(260), @fname29 nvarchar(260), @fname3 nvarchar(260), @fname30 nvarchar(260), @fname31 nvarchar(260), @fname32 nvarchar(260), @fname33 nvarchar(260), @fname34 nvarchar(260), @fname35 nvarchar(260), @fname36 nvarchar(260), @fname37 nvarchar(260), @fname38 nvarchar(260), @fname39 nvarchar(260), @fname4 nvarchar(260), @fname40 nvarchar(260), @fname41 nvarchar(260), @fname42 nvarchar(260), @fname43 nvarchar(260), @fname44 nvarchar(260), @fname45 nvarchar(260), @fname46 nvarchar(260), @fname47 nvarchar(260), @fname48 nvarchar(260), @fname49 nvarchar(260), @fname5 nvarchar(260), @fname50 nvarchar(260), @fname51 nvarchar(260), @fname52 nvarchar(260), @fname53 nvarchar(260), @fname54 nvarchar(260), @fname55 nvarchar(260), @fname56 nvarchar(260), @fname57 nvarchar(260), @fname58 nvarchar(260), @fname59 nvarchar(260), @fname6 nvarchar(260), @fname60 nvarchar(260), @fname61 nvarchar(260), @fname62 nvarchar(260), @fname63 nvarchar(260), @fname64 nvarchar(260), @fname7 nvarchar(260), @fname8 nvarchar(260), @fname9 nvarchar(260), @seqnum int, @start nvarchar(25)) as
begin
-- missing source code
end
go

create or replace function sys.fn_fIsColTracked(@artnick int) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_get_audit_file(@audit_record_offset bigint, @file_pattern nvarchar(260), @initial_file_name nvarchar(260)) as
begin
-- missing source code
end
go

create or replace function sys.fn_get_sql(@handle varbinary(64)) as
begin
-- missing source code
end
go

create or replace function sys.fn_hadr_backup_is_preferred_replica(@database_name sysname) returns bit as
begin
-- missing source code
end
go

create or replace function sys.fn_helpcollations() as
begin
-- missing source code
end
go

create or replace function sys.fn_helpdatatypemap(@defaults_only bit, @destination_dbms sysname, @destination_type sysname, @destination_version sysname, @source_dbms sysname, @source_type sysname, @source_version sysname) as
begin
-- missing source code
end
go

create or replace function sys.fn_isrolemember(@login sysname, @mode int, @tranpubid int) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_listextendedproperty(@level0name sysname, @level0type varchar(128), @level1name sysname, @level1type varchar(128), @level2name sysname, @level2type varchar(128), @name sysname) as
begin
-- missing source code
end
go

create or replace function sys.fn_my_permissions(@class nvarchar(60), @entity sysname) as
begin
-- missing source code
end
go

create or replace function sys.fn_numberOf1InBinaryAfterLoc(@byte binary(1), @loc int) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_numberOf1InVarBinary(@bm varbinary(128)) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_repladjustcolumnmap(@inmap varbinary(4000), @objid int, @total_col int) returns varbinary(4000) as
begin
-- missing source code
end
go

create or replace function sys.fn_repldecryptver4(@password nvarchar(524)) returns nvarchar(524) as
begin
-- missing source code
end
go

create or replace function sys.fn_replformatdatetime(@datetime datetime) returns nvarchar(50) as
begin
-- missing source code
end
go

create or replace function sys.fn_replgetcolidfrombitmap(@columns binary(32)) as
begin
-- missing source code
end
go

create or replace function sys.fn_replgetparsedddlcmd(@FirstToken sysname, @dbname sysname, @ddlcmd nvarchar(max), @objectType sysname, @objname sysname, @owner sysname, @targetobject nvarchar(512)) returns nvarchar(max) as
begin
-- missing source code
end
go

create or replace function sys.fn_replp2pversiontotranid(@varbin varbinary(32)) returns nvarchar(40) as
begin
-- missing source code
end
go

create or replace function sys.fn_replreplacesinglequote(@pstrin nvarchar(max)) returns nvarchar(max) as
begin
-- missing source code
end
go

create or replace function sys.fn_replreplacesinglequoteplusprotectstring(@pstrin nvarchar(4000)) returns nvarchar(4000) as
begin
-- missing source code
end
go

create or replace function sys.fn_repluniquename(@guid uniqueidentifier, @prefix1 sysname, @prefix2 sysname, @prefix3 sysname, @prefix4 sysname) returns nvarchar(100) as
begin
-- missing source code
end
go

create or replace function sys.fn_replvarbintoint(@varbin varbinary(32)) returns int as
begin
-- missing source code
end
go

create or replace function sys.fn_servershareddrives() as
begin
-- missing source code
end
go

create or replace function sys.fn_sqlvarbasetostr(@ssvar sql_variant) returns nvarchar(max) as
begin
-- missing source code
end
go

create or replace function sys.fn_trace_geteventinfo(@handle int) as
begin
-- missing source code
end
go

create or replace function sys.fn_trace_getfilterinfo(@handle int) as
begin
-- missing source code
end
go

create or replace function sys.fn_trace_getinfo(@handle int) as
begin
-- missing source code
end
go

create or replace function sys.fn_trace_gettable(@filename nvarchar(4000), @numfiles int) as
begin
-- missing source code
end
go

create or replace function sys.fn_translate_permissions(@level nvarchar(60), @perms varbinary(16)) as
begin
-- missing source code
end
go

create or replace function sys.fn_validate_plan_guide(@plan_guide_id int) as
begin
-- missing source code
end
go

create or replace function sys.fn_varbintohexstr(@pbinin varbinary(max)) returns nvarchar(max) as
begin
-- missing source code
end
go

create or replace function sys.fn_varbintohexsubstring(@cbytesin int, @fsetprefix bit, @pbinin varbinary(max), @startoffset int) returns nvarchar(max) as
begin
-- missing source code
end
go

create or replace function sys.fn_virtualfilestats(@DatabaseId int, @FileId int) as
begin
-- missing source code
end
go

create or replace function sys.fn_virtualservernodes() as
begin
-- missing source code
end
go

create or replace function sys.fn_xe_file_target_read_file(@initial_file_name nvarchar(260), @initial_offset bigint, @mdpath nvarchar(260), @path nvarchar(260)) as
begin
-- missing source code
end
go

create or replace function sys.fn_yukonsecuritymodelrequired(@username sysname) returns bit as
begin
-- missing source code
end
go

create or replace procedure sys.sp_AddFunctionalUnitToComponent() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_FuzzyLookupTableMaintenanceInstall(@etiTableName nvarchar(1024)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_FuzzyLookupTableMaintenanceInvoke(@etiTableName nvarchar(1024)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_FuzzyLookupTableMaintenanceUninstall(@etiTableName nvarchar(1024)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_IHScriptIdxFile(@article_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_IHScriptSchFile(@article_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_IHValidateRowFilter(@columnmask binary(128), @owner sysname, @publisher sysname, @rowfilter nvarchar(max), @table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_IHXactSetJob(@LRinterval int, @LRthreshold int, @enabled bit, @interval int, @publisher sysname, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_IH_LR_GetCacheData(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_IHadd_sync_command(@article_id int, @command varbinary(1024), @command_id int, @originator sysname, @originator_db sysname, @partial_command bit, @publisher sysname, @publisher_db sysname, @publisher_id smallint, @type int, @xact_id varbinary(16), @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_IHarticlecolumn(@article sysname, @change_active int, @column sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @ignore_distributor bit, @operation nvarchar(4), @publication sysname, @publisher sysname, @publisher_dbms sysname, @publisher_type sysname, @publisher_version sysname, @refresh_synctran_procs bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_IHget_loopback_detection(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSCleanupForPullReinit(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSFixSubColumnBitmaps(@artid uniqueidentifier, @bm varbinary(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSGetCurrentPrincipal(@current_principal sysname, @db_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSGetServerProperties() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSIfExistsSubscription(@publication sysname, @publisher sysname, @publisher_db sysname, @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSNonSQLDDL(@columnName sysname, @pubid uniqueidentifier, @qual_source_object nvarchar(540), @schemasubtype int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSNonSQLDDLForSchemaDDL(@artid uniqueidentifier, @ddlcmd nvarchar(max), @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSSQLDMO70_version() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSSQLDMO80_version() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSSQLDMO90_version() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSSQLOLE65_version() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSSQLOLE_version() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSSetServerProperties(@auto_start int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSSharedFixedDisk() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MS_marksystemobject(@namespace varchar(10), @objname nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MS_replication_installed() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSacquireHeadofQueueLock(@DbPrincipal sysname, @no_result bit, @process_name sysname, @queue_timeout int, @return_immediately bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSacquireSlotLock(@DbPrincipal sysname, @concurrent_max int, @process_name sysname, @queue_timeout int, @return_immediately bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSacquireserverresourcefordynamicsnapshot(@max_concurrent_dynamic_snapshots int, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSacquiresnapshotdeliverysessionlock() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSactivate_auto_sub(@article sysname, @publication sysname, @publisher sysname, @skipobjectactivation int, @status sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSactivatelogbasedarticleobject(@qualified_logbased_object_name nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSactivateprocedureexecutionarticleobject(@is_repl_serializable_only bit, @qualified_procedure_execution_object_name nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_anonymous_agent(@agent_id int, @anonymous_subid uniqueidentifier, @publication sysname, @publisher_db sysname, @publisher_id int, @reinitanon bit, @subscriber_db sysname, @subscriber_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_article(@article sysname, @article_id int, @description nvarchar(255), @destination_object sysname, @destination_owner sysname, @internal sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @source_object sysname, @source_owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_compensating_cmd(@article_id int, @cmdstate bit, @command nvarchar(max), @mode int, @orig_db sysname, @orig_srv sysname, @publication_id int, @setprefix bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_distribution_agent(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @agent_id int, @command nvarchar(4000), @distribution_jobid binary(16), @dts_package_location int, @dts_package_name sysname, @dts_package_password nvarchar(524), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @internal sysname, @job_login nvarchar(257), @job_password sysname, @local_job bit, @name sysname, @offloadagent bit, @offloadserver sysname, @publication sysname, @publisher_db sysname, @publisher_id smallint, @retryattempts int, @retrydelay int, @subscriber_catalog sysname, @subscriber_datasrc nvarchar(4000), @subscriber_db sysname, @subscriber_id smallint, @subscriber_location nvarchar(4000), @subscriber_login sysname, @subscriber_password nvarchar(524), @subscriber_provider sysname, @subscriber_provider_string nvarchar(4000), @subscriber_security_mode smallint, @subscription_type int, @update_mode int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_distribution_history(@agent_id int, @command_id int, @comments nvarchar(max), @delivered_commands int, @delivered_transactions int, @delivery_rate float, @do_raiserror bit, @log_error bit, @perfmon_increment bit, @runstatus int, @update_existing_row bit, @updateable_row bit, @xact_seqno binary(16), @xactseq varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_dynamic_snapshot_location(@dynsnap_location nvarchar(255), @partition_id int, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_filteringcolumn(@column_name sysname, @pubid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_log_shipping_error_detail(@agent_id uniqueidentifier, @agent_type tinyint, @database sysname, @help_url nvarchar(4000), @message nvarchar(4000), @sequence_number int, @session_id int, @source nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_log_shipping_history_detail(@agent_id uniqueidentifier, @agent_type tinyint, @database sysname, @last_processed_file_name nvarchar(500), @message nvarchar(4000), @session_id int, @session_status tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_logreader_agent(@internal sysname, @job_existing bit, @job_id binary(16), @job_login nvarchar(257), @job_password sysname, @local_job bit, @name nvarchar(100), @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_engine_edition int, @publisher_login sysname, @publisher_password nvarchar(524), @publisher_security_mode smallint, @publisher_type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_logreader_history(@agent_id int, @comments nvarchar(4000), @delivered_commands int, @delivered_transactions int, @delivery_latency int, @delivery_time int, @do_raiserror bit, @log_error bit, @perfmon_increment bit, @runstatus int, @update_existing_row bit, @updateable_row bit, @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_merge_agent(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @hostname sysname, @internal sysname, @job_login nvarchar(257), @job_password sysname, @local_job bit, @merge_jobid binary(16), @name sysname, @offloadagent bit, @offloadserver sysname, @optional_command_line nvarchar(255), @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_engine_edition int, @publisher_login sysname, @publisher_password nvarchar(524), @publisher_security_mode smallint, @subscriber sysname, @subscriber_db sysname, @subscriber_login sysname, @subscriber_password nvarchar(524), @subscriber_security_mode smallint, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_merge_anonymous_agent(@first_anonymous int, @publication sysname, @publisher_db sysname, @publisher_engine_edition int, @publisher_id smallint, @subid uniqueidentifier, @subscriber_db sysname, @subscriber_name sysname, @subscriber_version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_merge_history(@agent_id int, @called_by_nonlogged_shutdown_detection_agent bit, @comments nvarchar(1000), @delivery_time int, @do_raiserror bit, @download_conflicts int, @download_deletes int, @download_inserts int, @download_updates int, @log_error bit, @perfmon_increment bit, @runstatus int, @session_id_override int, @update_existing_row bit, @updateable_row bit, @upload_conflicts int, @upload_deletes int, @upload_inserts int, @upload_updates int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_merge_history90(@agent_id int, @article_conflicts int, @article_deletes int, @article_estimated_changes int, @article_inserts int, @article_name sysname, @article_percent_complete decimal(5,2), @article_relative_cost decimal(12,2), @article_rows_retried int, @article_updates int, @comments nvarchar(1000), @connection_type int, @delivery_rate decimal(12,2), @delivery_time int, @download_time int, @info_filter int, @log_error bit, @phase_id int, @prepare_snapshot_time int, @runstatus int, @schema_change_time int, @session_bulk_inserts int, @session_download_conflicts int, @session_download_deletes int, @session_download_inserts int, @session_download_rows_retried int, @session_download_updates int, @session_duration int, @session_estimated_download_changes int, @session_estimated_upload_changes int, @session_id int, @session_metadata_rows_cleanedup int, @session_percent_complete decimal(5,2), @session_schema_changes int, @session_upload_conflicts int, @session_upload_deletes int, @session_upload_inserts int, @session_upload_rows_retried int, @session_upload_updates int, @subid uniqueidentifier, @time_remaining int, @update_existing_row bit, @update_stats bit, @updateable_row bit, @upload_time int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_merge_subscription(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @agent_name sysname, @description nvarchar(255), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @hostname sysname, @internal sysname, @merge_jobid binary(16), @offloadagent bit, @offloadserver sysname, @optional_command_line nvarchar(4000), @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_engine_edition int, @status tinyint, @subid uniqueidentifier, @subscriber sysname, @subscriber_db sysname, @subscription_type tinyint, @sync_type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_mergereplcommand(@article sysname, @publication sysname, @schematext nvarchar(2000), @schematype int, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_mergesubentry_indistdb(@description nvarchar(255), @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_id smallint, @status tinyint, @subid uniqueidentifier, @subscriber sysname, @subscriber_db sysname, @subscriber_version int, @subscription_type tinyint, @sync_type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_publication(@allow_anonymous bit, @allow_initialize_from_backup bit, @allow_pull bit, @allow_push bit, @allow_queued_tran bit, @allow_subscription_copy bit, @description nvarchar(255), @immediate_sync bit, @independent_agent bit, @logreader_agent nvarchar(100), @options int, @publication sysname, @publication_id int, @publication_type int, @publisher sysname, @publisher_db sysname, @publisher_engine_edition int, @publisher_type sysname, @queue_type int, @retention int, @retention_period_unit tinyint, @snapshot_agent nvarchar(100), @sync_method int, @thirdparty_options int, @vendor_name nvarchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_qreader_agent(@agent_id int, @agent_jobid binary(16), @internal sysname, @job_login nvarchar(257), @job_password sysname, @name nvarchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_qreader_history(@agent_id int, @commands_processed int, @comments nvarchar(1000), @do_raiserror bit, @log_error bit, @perfmon_increment bit, @pubid int, @runstatus int, @seconds_elapsed int, @subscriber sysname, @subscriberdb sysname, @transaction_id nvarchar(40), @transaction_status int, @transactions_processed int, @update_existing_row bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_repl_alert(@agent_id int, @agent_type int, @alert_error_code int, @alert_error_text ntext, @command_id int, @error_id int, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_repl_command(@article_id int, @command varbinary(1024), @command_id int, @originator sysname, @originator_db sysname, @partial_command bit, @publisher sysname, @publisher_db sysname, @publisher_id smallint, @type int, @xact_id varbinary(16), @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_repl_commands27hp([@10data] varbinary(1575), [@11data] varbinary(1575), [@12data] varbinary(1575), [@13data] varbinary(1575), [@14data] varbinary(1575), [@15data] varbinary(1575), [@16data] varbinary(1575), [@17data] varbinary(1575), [@18data] varbinary(1575), [@19data] varbinary(1575), [@1data] varbinary(1575), [@20data] varbinary(1575), [@21data] varbinary(1575), [@22data] varbinary(1575), [@23data] varbinary(1575), [@24data] varbinary(1575), [@25data] varbinary(1575), [@26data] varbinary(1575), [@2data] varbinary(1575), [@3data] varbinary(1575), [@4data] varbinary(1575), [@5data] varbinary(1575), [@6data] varbinary(1575), [@7data] varbinary(1575), [@8data] varbinary(1575), [@9data] varbinary(1575), @data varbinary(1575), @publisher_db sysname, @publisher_id smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_repl_error(@add_event_log int, @error_code sysname, @error_text nvarchar(max), @error_type_id int, @event_log_context nvarchar(max), @id int, @map_source_type bit, @session_id int, @source_name sysname, @source_type_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_replcmds_mcit([@10data] varbinary(1595), [@11data] varbinary(1595), [@12data] varbinary(1595), [@13data] varbinary(1595), [@14data] varbinary(1595), [@15data] varbinary(1595), [@16data] varbinary(1595), [@17data] varbinary(1595), [@18data] varbinary(1595), [@19data] varbinary(1595), [@1data] varbinary(1595), [@20data] varbinary(1595), [@21data] varbinary(1595), [@22data] varbinary(1595), [@23data] varbinary(1595), [@24data] varbinary(1595), [@25data] varbinary(1595), [@26data] varbinary(1595), [@2data] varbinary(1595), [@3data] varbinary(1595), [@4data] varbinary(1595), [@5data] varbinary(1595), [@6data] varbinary(1595), [@7data] varbinary(1595), [@8data] varbinary(1595), [@9data] varbinary(1595), @data varbinary(1595), @publisher_database_id int, @publisher_db sysname, @publisher_id smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_replmergealert(@agent_id int, @agent_type int, @alert_error_code int, @alert_error_text ntext, @article sysname, @destination_object sysname, @error_id int, @publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @source_object sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_snapshot_agent(@activeenddate int, @activeendtimeofday int, @activestartdate int, @activestarttimeofday int, @command nvarchar(4000), @freqinterval int, @freqrecurrencefactor int, @freqrelativeinterval int, @freqsubinterval int, @freqsubtype int, @freqtype int, @internal sysname, @job_existing bit, @job_login nvarchar(257), @job_password sysname, @local_job bit, @name nvarchar(100), @publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @publisher_login sysname, @publisher_password nvarchar(524), @publisher_security_mode smallint, @publisher_type sysname, @snapshot_jobid binary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_snapshot_history(@agent_id int, @comments nvarchar(1000), @delivered_commands int, @delivered_transactions int, @do_raiserror bit, @duration int, @log_error bit, @perfmon_increment bit, @runstatus int, @start_time_string nvarchar(25), @update_existing_row bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_subscriber_info(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @commit_batch_size int, @description nvarchar(255), @encrypted_password bit, @flush_frequency int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @internal sysname, @login sysname, @password nvarchar(524), @publisher sysname, @retryattempts int, @retrydelay int, @security_mode int, @status_batch_size int, @subscriber sysname, @type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_subscriber_schedule(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @agent_type smallint, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_subscription(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @article sysname, @article_id int, @distribution_job_name sysname, @distribution_jobid binary(16), @dts_package_location int, @dts_package_name sysname, @dts_package_password nvarchar(524), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @internal sysname, @loopback_detection bit, @nosync_type tinyint, @offloadagent bit, @offloadserver sysname, @optional_command_line nvarchar(4000), @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_engine_edition int, @snapshot_seqno_flag bit, @status tinyint, @subscriber sysname, @subscriber_db sysname, @subscription_seqno varbinary(16), @subscription_type tinyint, @sync_type tinyint, @update_mode tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_subscription_3rd(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @distribution_jobid binary(8), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @publication sysname, @publisher sysname, @publisher_db sysname, @status tinyint, @subscriber sysname, @subscriber_db sysname, @subscription_type tinyint, @sync_type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_tracer_history(@tracer_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadd_tracer_token(@publication sysname, @publisher sysname, @publisher_db sysname, @subscribers_found bit, @tracer_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddanonymousreplica(@anonymous int, @preexists bit, @publication sysname, @publisher sysname, @publisherDB sysname, @sync_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadddynamicsnapshotjobatdistributor(@activeenddate int, @activeendtimeofday int, @activestartdate int, @activestarttimeofday int, @dynamic_filter_hostname sysname, @dynamic_filter_login sysname, @dynamic_snapshot_agent_id int, @dynamic_snapshot_job_step_uid uniqueidentifier, @dynamic_snapshot_jobid uniqueidentifier, @dynamic_snapshot_jobname nvarchar(128), @dynamic_snapshot_location nvarchar(255), @freqinterval int, @freqrecurrencefactor int, @freqrelativeinterval int, @freqsubinterval int, @freqsubtype int, @freqtype int, @partition_id int, @regular_snapshot_jobid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddguidcolumn(@source_owner sysname, @source_table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddguidindex(@publication sysname, @source_owner sysname, @source_table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddinitialarticle(@article sysname, @article_resolver nvarchar(255), @artid uniqueidentifier, @column_tracking int, @compensate_for_errors bit, @delete_tracking bit, @destination_object sysname, @destination_owner sysname, @excluded_cols varbinary(128), @excluded_count int, @fast_multicol_updateproc bit, @filter_clause nvarchar(2000), @identity_range bigint, @identity_support int, @insert_proc nvarchar(255), @logical_record_level_conflict_detection bit, @logical_record_level_conflict_resolution bit, @missing_cols varbinary(128), @missing_count int, @nickname int, @partition_options tinyint, @pre_creation_command int, @preserve_rowguidcol bit, @processing_order int, @pub_identity_range bigint, @pubid uniqueidentifier, @published_in_tran_pub bit, @resolver_clsid nvarchar(255), @resolver_info nvarchar(517), @select_proc nvarchar(255), @status int, @stream_blob_columns bit, @threshold int, @update_proc nvarchar(255), @upload_options tinyint, @verify_resolver_signature int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddinitialpublication(@allow_anonymous int, @allow_pull int, @allow_push int, @allow_subscription_copy int, @allow_synctoalternate int, @automatic_reinitialization_policy bit, @backward_comp_level int, @conflict_logging int, @conflict_retention int, @description nvarchar(255), @enabled_for_internet int, @generation_leveling_threshold int, @pubid uniqueidentifier, @publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @replicate_ddl int, @replnickname binary(6), @retention int, @retention_period_unit tinyint, @snapshot_ready int, @status int, @sync_mode int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddinitialschemaarticle(@artid uniqueidentifier, @destination_object sysname, @destination_owner sysname, @name sysname, @pre_creation_command tinyint, @pubid uniqueidentifier, @status int, @type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddinitialsubscription(@distributor sysname, @pubid uniqueidentifier, @publication sysname, @replica_version int, @replicastate uniqueidentifier, @subid uniqueidentifier, @subscriber sysname, @subscriber_db sysname, @subscriber_priority real, @subscriber_type tinyint, @subscription_type int, @sync_type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddlightweightmergearticle(@article_name sysname, @artid uniqueidentifier, @column_tracking bit, @compensate_for_errors bit, @delete_tracking bit, @destination_object sysname, @destination_owner sysname, @identity_support int, @processing_order int, @pubid uniqueidentifier, @status int, @stream_blob_columns bit, @tablenick int, @upload_options tinyint, @well_partitioned bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddmergedynamicsnapshotjob(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @dynamic_filter_hostname sysname, @dynamic_filter_login sysname, @dynamic_job_step_uid uniqueidentifier, @dynamic_snapshot_agentid int, @dynamic_snapshot_jobid uniqueidentifier, @dynamic_snapshot_jobname sysname, @dynamic_snapshot_location nvarchar(255), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @ignore_select bit, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddmergetriggers(@column_tracking int, @recreate_repl_views bit, @source_table nvarchar(517), @table_owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddmergetriggers_from_template(@column_tracking int, @genhistory_viewname sysname, @max_colv_size_in_bytes_str nvarchar(15), @replnick binary(6), @rgcol sysname, @source_table nvarchar(270), @table_owner sysname, @tablenickstr nvarchar(15), @trigger_type tinyint, @trigname sysname, @tsview sysname, @viewname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddmergetriggers_internal(@column_tracking int, @current_mappings_viewname sysname, @genhistory_viewname sysname, @past_mappings_viewname sysname, @source_table sysname, @table_owner sysname, @trigger_type tinyint, @trigname sysname, @tsview sysname, @viewname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddpeerlsn(@originator sysname, @originator_db sysname, @originator_db_version int, @originator_id int, @originator_lsn varbinary(10), @originator_publication sysname, @originator_publication_id int, @originator_version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSaddsubscriptionarticles(@article sysname, @artid int, @dest_owner sysname, @dest_table sysname, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSadjust_pub_identity(@current_max bigint, @next_seed bigint, @pub_range bigint, @publisher sysname, @publisher_db sysname, @range bigint, @tablename sysname, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSagent_retry_stethoscope() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSagent_stethoscope(@heartbeat_interval int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSallocate_new_identity_range(@artid uniqueidentifier, @next_range_begin numeric(38), @next_range_end numeric(38), @publication sysname, @range_begin numeric(38), @range_end numeric(38), @range_type tinyint, @ranges_needed tinyint, @subid uniqueidentifier, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSalreadyhavegeneration(@compatlevel int, @genguid uniqueidentifier, @subscribernick binary(6)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSanonymous_status(@agent_id int, @last_xact_seqno varbinary(16), @no_init_sync int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSarticlecleanup(@artid uniqueidentifier, @force_preserve_rowguidcol bit, @ignore_merge_metadata bit, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSbrowsesnapshotfolder(@article_id int, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScache_agent_parameter(@parameter_name sysname, @parameter_value nvarchar(255), @profile_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScdc_capture_job() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScdc_cleanup_job() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScdc_db_ddl_event(@EventData xml) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScdc_ddl_event(@EventData xml) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScdc_logddl(@commit_lsn binary(10), @ddl_command nvarchar(max), @ddl_lsn binary(10), @ddl_time nvarchar(1000), @fis_alter_column bit, @fis_drop_table bit, @source_column_id int, @source_object_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_article(@article sysname, @article_id int, @property nvarchar(20), @publication sysname, @publisher sysname, @publisher_db sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_distribution_agent_properties(@property sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @value nvarchar(524)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_logreader_agent_properties(@job_login nvarchar(257), @job_password sysname, @publisher sysname, @publisher_db sysname, @publisher_login sysname, @publisher_password nvarchar(524), @publisher_security_mode int, @publisher_type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_merge_agent_properties(@property sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @value nvarchar(524)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_mergearticle(@artid uniqueidentifier, @property sysname, @pubid uniqueidentifier, @value nvarchar(2000), @value_numeric int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_mergepublication(@property sysname, @pubid uniqueidentifier, @value nvarchar(2000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_originatorid(@originator_db sysname, @originator_db_version int, @originator_id int, @originator_node sysname, @originator_publication sysname, @originator_publication_id int, @originator_version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_priority(@subid uniqueidentifier, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_publication(@property sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_retention(@pubid uniqueidentifier, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_retention_period_unit(@pubid uniqueidentifier, @value tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_snapshot_agent_properties(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @job_login nvarchar(257), @job_password sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_login sysname, @publisher_password nvarchar(524), @publisher_security_mode int, @publisher_type sysname, @snapshot_job_name nvarchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchange_subscription_dts_info(@change_password bit, @dts_package_location int, @dts_package_name sysname, @dts_package_password nvarchar(524), @job_id varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchangearticleresolver(@article_resolver nvarchar(255), @artid uniqueidentifier, @resolver_clsid nvarchar(40), @resolver_info nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchangedynamicsnapshotjobatdistributor(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @dynamic_filter_hostname sysname, @dynamic_filter_login sysname, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @job_login nvarchar(257), @job_password sysname, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchangedynsnaplocationatdistributor(@dynamic_filter_hostname sysname, @dynamic_filter_login sysname, @dynamic_snapshot_location nvarchar(255), @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchangeobjectowner(@dest_owner sysname, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheckIsPubOfSub(@pubOfSub bit, @pubid uniqueidentifier, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_Jet_Subscriber(@Jet_datasource_path sysname, @is_jet int, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_agent_instance(@agent_type int, @application_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_logicalrecord_metadatamatch(@logical_record_lineage varbinary(311), @metadata_type tinyint, @parent_nickname int, @parent_rowguid uniqueidentifier, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_merge_subscription_count(@about_to_insert_new_subscription bit, @publisher sysname, @publisher_engine_edition int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_pub_identity(@current_max bigint, @max_identity bigint, @next_seed bigint, @pub_range bigint, @publisher sysname, @publisher_db sysname, @range bigint, @tablename sysname, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_pull_access(@agent_id int, @agent_type int, @publication_id int, @raise_fatal_error bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_snapshot_agent(@publication sysname, @publisher sysname, @publisher_db sysname, @valid_agent_exists bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_subscription(@pub_type int, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_subscription_expiry(@expired bit, @pubid uniqueidentifier, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_subscription_partition(@force_delete_other bit, @pubid uniqueidentifier, @subid uniqueidentifier, @subscriber sysname, @subscriber_db sysname, @subscriber_deleted sysname, @subscriberdb_deleted sysname, @valid bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheck_tran_retention(@agent_id int, @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheckexistsgeneration(@gen bigint, @genguid uniqueidentifier, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheckexistsrecguid(@exists bit, @recguid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheckfailedprevioussync(@last_sync_failed bit, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScheckidentityrange(@artname sysname, @checkonly int, @next_seed bigint, @pubid uniqueidentifier, @range bigint, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchecksharedagentforpublication(@publication sysname, @publisher_db sysname, @publisher_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSchecksnapshotstatus(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScleanup_agent_entry() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScleanup_conflict(@conflict_retention int, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScleanup_publication_ADinfo(@database sysname, @name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScleanup_subscription_distside_entry(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScleanupdynamicsnapshotfolder(@dynamic_filter_hostname sysname, @dynamic_filter_login sysname, @dynamic_snapshot_location nvarchar(260), @partition_id int, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScleanupdynsnapshotvws() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScleanupmergepublisher_internal() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSclear_dynamic_snapshot_location(@deletefolder bit, @partition_id int, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSclearresetpartialsnapshotprogressbit(@agent_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScomputelastsentgen(@repid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScomputemergearticlescreationorder(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScomputemergeunresolvedrefs(@article sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSconflicttableexists(@artid uniqueidentifier, @exists int, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreate_all_article_repl_views(@snapshot_application_finished bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreate_article_repl_views(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreate_dist_tables() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreate_logical_record_views(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreate_sub_tables(@p2p_table bit, @property_table bit, @sqlqueue_table bit, @subscription_articles_table bit, @tran_sub_table bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreate_tempgenhistorytable(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreatedisabledmltrigger(@source_object sysname, @source_owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreatedummygeneration(@maxgen_whenadded bigint, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreateglobalreplica(@compatlevel int, @datasource_path nvarchar(255), @datasource_type int, @distributor sysname, @pubid uniqueidentifier, @publication sysname, @replica_db sysname, @replica_priority real, @replica_server sysname, @replica_version int, @replicastate uniqueidentifier, @replnick varbinary(6), @status int, @subid uniqueidentifier, @subscriber_type tinyint, @subscription_type int, @sync_type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreatelightweightinsertproc(@artid uniqueidentifier, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreatelightweightmultipurposeproc(@artid uniqueidentifier, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreatelightweightprocstriggersconstraints(@artid uniqueidentifier, @next_seed bigint, @pubid uniqueidentifier, @range bigint, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreatelightweightupdateproc(@artid uniqueidentifier, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreatemergedynamicsnapshot(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MScreateretry() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdbuseraccess(@mode nvarchar(10), @qual nvarchar(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdbuserpriv(@mode nvarchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdefer_check(@objname sysname, @objowner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdelete_tracer_history(@cutoff_date datetime, @num_records_removed int, @publication sysname, @publisher sysname, @publisher_db sysname, @tracer_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdeletefoldercontents(@folder nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdeletemetadataactionrequest(@pubid uniqueidentifier, @rowguid1 uniqueidentifier, @rowguid10 uniqueidentifier, @rowguid100 uniqueidentifier, @rowguid11 uniqueidentifier, @rowguid12 uniqueidentifier, @rowguid13 uniqueidentifier, @rowguid14 uniqueidentifier, @rowguid15 uniqueidentifier, @rowguid16 uniqueidentifier, @rowguid17 uniqueidentifier, @rowguid18 uniqueidentifier, @rowguid19 uniqueidentifier, @rowguid2 uniqueidentifier, @rowguid20 uniqueidentifier, @rowguid21 uniqueidentifier, @rowguid22 uniqueidentifier, @rowguid23 uniqueidentifier, @rowguid24 uniqueidentifier, @rowguid25 uniqueidentifier, @rowguid26 uniqueidentifier, @rowguid27 uniqueidentifier, @rowguid28 uniqueidentifier, @rowguid29 uniqueidentifier, @rowguid3 uniqueidentifier, @rowguid30 uniqueidentifier, @rowguid31 uniqueidentifier, @rowguid32 uniqueidentifier, @rowguid33 uniqueidentifier, @rowguid34 uniqueidentifier, @rowguid35 uniqueidentifier, @rowguid36 uniqueidentifier, @rowguid37 uniqueidentifier, @rowguid38 uniqueidentifier, @rowguid39 uniqueidentifier, @rowguid4 uniqueidentifier, @rowguid40 uniqueidentifier, @rowguid41 uniqueidentifier, @rowguid42 uniqueidentifier, @rowguid43 uniqueidentifier, @rowguid44 uniqueidentifier, @rowguid45 uniqueidentifier, @rowguid46 uniqueidentifier, @rowguid47 uniqueidentifier, @rowguid48 uniqueidentifier, @rowguid49 uniqueidentifier, @rowguid5 uniqueidentifier, @rowguid50 uniqueidentifier, @rowguid51 uniqueidentifier, @rowguid52 uniqueidentifier, @rowguid53 uniqueidentifier, @rowguid54 uniqueidentifier, @rowguid55 uniqueidentifier, @rowguid56 uniqueidentifier, @rowguid57 uniqueidentifier, @rowguid58 uniqueidentifier, @rowguid59 uniqueidentifier, @rowguid6 uniqueidentifier, @rowguid60 uniqueidentifier, @rowguid61 uniqueidentifier, @rowguid62 uniqueidentifier, @rowguid63 uniqueidentifier, @rowguid64 uniqueidentifier, @rowguid65 uniqueidentifier, @rowguid66 uniqueidentifier, @rowguid67 uniqueidentifier, @rowguid68 uniqueidentifier, @rowguid69 uniqueidentifier, @rowguid7 uniqueidentifier, @rowguid70 uniqueidentifier, @rowguid71 uniqueidentifier, @rowguid72 uniqueidentifier, @rowguid73 uniqueidentifier, @rowguid74 uniqueidentifier, @rowguid75 uniqueidentifier, @rowguid76 uniqueidentifier, @rowguid77 uniqueidentifier, @rowguid78 uniqueidentifier, @rowguid79 uniqueidentifier, @rowguid8 uniqueidentifier, @rowguid80 uniqueidentifier, @rowguid81 uniqueidentifier, @rowguid82 uniqueidentifier, @rowguid83 uniqueidentifier, @rowguid84 uniqueidentifier, @rowguid85 uniqueidentifier, @rowguid86 uniqueidentifier, @rowguid87 uniqueidentifier, @rowguid88 uniqueidentifier, @rowguid89 uniqueidentifier, @rowguid9 uniqueidentifier, @rowguid90 uniqueidentifier, @rowguid91 uniqueidentifier, @rowguid92 uniqueidentifier, @rowguid93 uniqueidentifier, @rowguid94 uniqueidentifier, @rowguid95 uniqueidentifier, @rowguid96 uniqueidentifier, @rowguid97 uniqueidentifier, @rowguid98 uniqueidentifier, @rowguid99 uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdeletepeerconflictrow(@conflict_table nvarchar(270), @origin_datasource nvarchar(255), @originator_id nvarchar(32), @row_id nvarchar(19), @tran_id nvarchar(40)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdeleteretry(@rowguid uniqueidentifier, @tablenick int, @temptable nvarchar(386)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdeletetranconflictrow(@conflict_table sysname, @row_id sysname, @tran_id sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdelgenzero() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdelrow(@articleisupdateable bit, @check_permission int, @compatlevel int, @generation bigint, @lineage_new varbinary(311), @lineage_old varbinary(311), @metadata_type tinyint, @partition_id int, @pubid uniqueidentifier, @publication_number smallint, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdelrowsbatch(@check_permission int, @generation1 bigint, @generation10 bigint, @generation100 bigint, @generation11 bigint, @generation12 bigint, @generation13 bigint, @generation14 bigint, @generation15 bigint, @generation16 bigint, @generation17 bigint, @generation18 bigint, @generation19 bigint, @generation2 bigint, @generation20 bigint, @generation21 bigint, @generation22 bigint, @generation23 bigint, @generation24 bigint, @generation25 bigint, @generation26 bigint, @generation27 bigint, @generation28 bigint, @generation29 bigint, @generation3 bigint, @generation30 bigint, @generation31 bigint, @generation32 bigint, @generation33 bigint, @generation34 bigint, @generation35 bigint, @generation36 bigint, @generation37 bigint, @generation38 bigint, @generation39 bigint, @generation4 bigint, @generation40 bigint, @generation41 bigint, @generation42 bigint, @generation43 bigint, @generation44 bigint, @generation45 bigint, @generation46 bigint, @generation47 bigint, @generation48 bigint, @generation49 bigint, @generation5 bigint, @generation50 bigint, @generation51 bigint, @generation52 bigint, @generation53 bigint, @generation54 bigint, @generation55 bigint, @generation56 bigint, @generation57 bigint, @generation58 bigint, @generation59 bigint, @generation6 bigint, @generation60 bigint, @generation61 bigint, @generation62 bigint, @generation63 bigint, @generation64 bigint, @generation65 bigint, @generation66 bigint, @generation67 bigint, @generation68 bigint, @generation69 bigint, @generation7 bigint, @generation70 bigint, @generation71 bigint, @generation72 bigint, @generation73 bigint, @generation74 bigint, @generation75 bigint, @generation76 bigint, @generation77 bigint, @generation78 bigint, @generation79 bigint, @generation8 bigint, @generation80 bigint, @generation81 bigint, @generation82 bigint, @generation83 bigint, @generation84 bigint, @generation85 bigint, @generation86 bigint, @generation87 bigint, @generation88 bigint, @generation89 bigint, @generation9 bigint, @generation90 bigint, @generation91 bigint, @generation92 bigint, @generation93 bigint, @generation94 bigint, @generation95 bigint, @generation96 bigint, @generation97 bigint, @generation98 bigint, @generation99 bigint, @lineage_new1 varbinary(311), @lineage_new10 varbinary(311), @lineage_new100 varbinary(311), @lineage_new11 varbinary(311), @lineage_new12 varbinary(311), @lineage_new13 varbinary(311), @lineage_new14 varbinary(311), @lineage_new15 varbinary(311), @lineage_new16 varbinary(311), @lineage_new17 varbinary(311), @lineage_new18 varbinary(311), @lineage_new19 varbinary(311), @lineage_new2 varbinary(311), @lineage_new20 varbinary(311), @lineage_new21 varbinary(311), @lineage_new22 varbinary(311), @lineage_new23 varbinary(311), @lineage_new24 varbinary(311), @lineage_new25 varbinary(311), @lineage_new26 varbinary(311), @lineage_new27 varbinary(311), @lineage_new28 varbinary(311), @lineage_new29 varbinary(311), @lineage_new3 varbinary(311), @lineage_new30 varbinary(311), @lineage_new31 varbinary(311), @lineage_new32 varbinary(311), @lineage_new33 varbinary(311), @lineage_new34 varbinary(311), @lineage_new35 varbinary(311), @lineage_new36 varbinary(311), @lineage_new37 varbinary(311), @lineage_new38 varbinary(311), @lineage_new39 varbinary(311), @lineage_new4 varbinary(311), @lineage_new40 varbinary(311), @lineage_new41 varbinary(311), @lineage_new42 varbinary(311), @lineage_new43 varbinary(311), @lineage_new44 varbinary(311), @lineage_new45 varbinary(311), @lineage_new46 varbinary(311), @lineage_new47 varbinary(311), @lineage_new48 varbinary(311), @lineage_new49 varbinary(311), @lineage_new5 varbinary(311), @lineage_new50 varbinary(311), @lineage_new51 varbinary(311), @lineage_new52 varbinary(311), @lineage_new53 varbinary(311), @lineage_new54 varbinary(311), @lineage_new55 varbinary(311), @lineage_new56 varbinary(311), @lineage_new57 varbinary(311), @lineage_new58 varbinary(311), @lineage_new59 varbinary(311), @lineage_new6 varbinary(311), @lineage_new60 varbinary(311), @lineage_new61 varbinary(311), @lineage_new62 varbinary(311), @lineage_new63 varbinary(311), @lineage_new64 varbinary(311), @lineage_new65 varbinary(311), @lineage_new66 varbinary(311), @lineage_new67 varbinary(311), @lineage_new68 varbinary(311), @lineage_new69 varbinary(311), @lineage_new7 varbinary(311), @lineage_new70 varbinary(311), @lineage_new71 varbinary(311), @lineage_new72 varbinary(311), @lineage_new73 varbinary(311), @lineage_new74 varbinary(311), @lineage_new75 varbinary(311), @lineage_new76 varbinary(311), @lineage_new77 varbinary(311), @lineage_new78 varbinary(311), @lineage_new79 varbinary(311), @lineage_new8 varbinary(311), @lineage_new80 varbinary(311), @lineage_new81 varbinary(311), @lineage_new82 varbinary(311), @lineage_new83 varbinary(311), @lineage_new84 varbinary(311), @lineage_new85 varbinary(311), @lineage_new86 varbinary(311), @lineage_new87 varbinary(311), @lineage_new88 varbinary(311), @lineage_new89 varbinary(311), @lineage_new9 varbinary(311), @lineage_new90 varbinary(311), @lineage_new91 varbinary(311), @lineage_new92 varbinary(311), @lineage_new93 varbinary(311), @lineage_new94 varbinary(311), @lineage_new95 varbinary(311), @lineage_new96 varbinary(311), @lineage_new97 varbinary(311), @lineage_new98 varbinary(311), @lineage_new99 varbinary(311), @lineage_old1 varbinary(311), @lineage_old10 varbinary(311), @lineage_old100 varbinary(311), @lineage_old11 varbinary(311), @lineage_old12 varbinary(311), @lineage_old13 varbinary(311), @lineage_old14 varbinary(311), @lineage_old15 varbinary(311), @lineage_old16 varbinary(311), @lineage_old17 varbinary(311), @lineage_old18 varbinary(311), @lineage_old19 varbinary(311), @lineage_old2 varbinary(311), @lineage_old20 varbinary(311), @lineage_old21 varbinary(311), @lineage_old22 varbinary(311), @lineage_old23 varbinary(311), @lineage_old24 varbinary(311), @lineage_old25 varbinary(311), @lineage_old26 varbinary(311), @lineage_old27 varbinary(311), @lineage_old28 varbinary(311), @lineage_old29 varbinary(311), @lineage_old3 varbinary(311), @lineage_old30 varbinary(311), @lineage_old31 varbinary(311), @lineage_old32 varbinary(311), @lineage_old33 varbinary(311), @lineage_old34 varbinary(311), @lineage_old35 varbinary(311), @lineage_old36 varbinary(311), @lineage_old37 varbinary(311), @lineage_old38 varbinary(311), @lineage_old39 varbinary(311), @lineage_old4 varbinary(311), @lineage_old40 varbinary(311), @lineage_old41 varbinary(311), @lineage_old42 varbinary(311), @lineage_old43 varbinary(311), @lineage_old44 varbinary(311), @lineage_old45 varbinary(311), @lineage_old46 varbinary(311), @lineage_old47 varbinary(311), @lineage_old48 varbinary(311), @lineage_old49 varbinary(311), @lineage_old5 varbinary(311), @lineage_old50 varbinary(311), @lineage_old51 varbinary(311), @lineage_old52 varbinary(311), @lineage_old53 varbinary(311), @lineage_old54 varbinary(311), @lineage_old55 varbinary(311), @lineage_old56 varbinary(311), @lineage_old57 varbinary(311), @lineage_old58 varbinary(311), @lineage_old59 varbinary(311), @lineage_old6 varbinary(311), @lineage_old60 varbinary(311), @lineage_old61 varbinary(311), @lineage_old62 varbinary(311), @lineage_old63 varbinary(311), @lineage_old64 varbinary(311), @lineage_old65 varbinary(311), @lineage_old66 varbinary(311), @lineage_old67 varbinary(311), @lineage_old68 varbinary(311), @lineage_old69 varbinary(311), @lineage_old7 varbinary(311), @lineage_old70 varbinary(311), @lineage_old71 varbinary(311), @lineage_old72 varbinary(311), @lineage_old73 varbinary(311), @lineage_old74 varbinary(311), @lineage_old75 varbinary(311), @lineage_old76 varbinary(311), @lineage_old77 varbinary(311), @lineage_old78 varbinary(311), @lineage_old79 varbinary(311), @lineage_old8 varbinary(311), @lineage_old80 varbinary(311), @lineage_old81 varbinary(311), @lineage_old82 varbinary(311), @lineage_old83 varbinary(311), @lineage_old84 varbinary(311), @lineage_old85 varbinary(311), @lineage_old86 varbinary(311), @lineage_old87 varbinary(311), @lineage_old88 varbinary(311), @lineage_old89 varbinary(311), @lineage_old9 varbinary(311), @lineage_old90 varbinary(311), @lineage_old91 varbinary(311), @lineage_old92 varbinary(311), @lineage_old93 varbinary(311), @lineage_old94 varbinary(311), @lineage_old95 varbinary(311), @lineage_old96 varbinary(311), @lineage_old97 varbinary(311), @lineage_old98 varbinary(311), @lineage_old99 varbinary(311), @metadata_type1 tinyint, @metadata_type10 tinyint, @metadata_type100 tinyint, @metadata_type11 tinyint, @metadata_type12 tinyint, @metadata_type13 tinyint, @metadata_type14 tinyint, @metadata_type15 tinyint, @metadata_type16 tinyint, @metadata_type17 tinyint, @metadata_type18 tinyint, @metadata_type19 tinyint, @metadata_type2 tinyint, @metadata_type20 tinyint, @metadata_type21 tinyint, @metadata_type22 tinyint, @metadata_type23 tinyint, @metadata_type24 tinyint, @metadata_type25 tinyint, @metadata_type26 tinyint, @metadata_type27 tinyint, @metadata_type28 tinyint, @metadata_type29 tinyint, @metadata_type3 tinyint, @metadata_type30 tinyint, @metadata_type31 tinyint, @metadata_type32 tinyint, @metadata_type33 tinyint, @metadata_type34 tinyint, @metadata_type35 tinyint, @metadata_type36 tinyint, @metadata_type37 tinyint, @metadata_type38 tinyint, @metadata_type39 tinyint, @metadata_type4 tinyint, @metadata_type40 tinyint, @metadata_type41 tinyint, @metadata_type42 tinyint, @metadata_type43 tinyint, @metadata_type44 tinyint, @metadata_type45 tinyint, @metadata_type46 tinyint, @metadata_type47 tinyint, @metadata_type48 tinyint, @metadata_type49 tinyint, @metadata_type5 tinyint, @metadata_type50 tinyint, @metadata_type51 tinyint, @metadata_type52 tinyint, @metadata_type53 tinyint, @metadata_type54 tinyint, @metadata_type55 tinyint, @metadata_type56 tinyint, @metadata_type57 tinyint, @metadata_type58 tinyint, @metadata_type59 tinyint, @metadata_type6 tinyint, @metadata_type60 tinyint, @metadata_type61 tinyint, @metadata_type62 tinyint, @metadata_type63 tinyint, @metadata_type64 tinyint, @metadata_type65 tinyint, @metadata_type66 tinyint, @metadata_type67 tinyint, @metadata_type68 tinyint, @metadata_type69 tinyint, @metadata_type7 tinyint, @metadata_type70 tinyint, @metadata_type71 tinyint, @metadata_type72 tinyint, @metadata_type73 tinyint, @metadata_type74 tinyint, @metadata_type75 tinyint, @metadata_type76 tinyint, @metadata_type77 tinyint, @metadata_type78 tinyint, @metadata_type79 tinyint, @metadata_type8 tinyint, @metadata_type80 tinyint, @metadata_type81 tinyint, @metadata_type82 tinyint, @metadata_type83 tinyint, @metadata_type84 tinyint, @metadata_type85 tinyint, @metadata_type86 tinyint, @metadata_type87 tinyint, @metadata_type88 tinyint, @metadata_type89 tinyint, @metadata_type9 tinyint, @metadata_type90 tinyint, @metadata_type91 tinyint, @metadata_type92 tinyint, @metadata_type93 tinyint, @metadata_type94 tinyint, @metadata_type95 tinyint, @metadata_type96 tinyint, @metadata_type97 tinyint, @metadata_type98 tinyint, @metadata_type99 tinyint, @partition_id int, @pubid uniqueidentifier, @rowguid1 uniqueidentifier, @rowguid10 uniqueidentifier, @rowguid100 uniqueidentifier, @rowguid11 uniqueidentifier, @rowguid12 uniqueidentifier, @rowguid13 uniqueidentifier, @rowguid14 uniqueidentifier, @rowguid15 uniqueidentifier, @rowguid16 uniqueidentifier, @rowguid17 uniqueidentifier, @rowguid18 uniqueidentifier, @rowguid19 uniqueidentifier, @rowguid2 uniqueidentifier, @rowguid20 uniqueidentifier, @rowguid21 uniqueidentifier, @rowguid22 uniqueidentifier, @rowguid23 uniqueidentifier, @rowguid24 uniqueidentifier, @rowguid25 uniqueidentifier, @rowguid26 uniqueidentifier, @rowguid27 uniqueidentifier, @rowguid28 uniqueidentifier, @rowguid29 uniqueidentifier, @rowguid3 uniqueidentifier, @rowguid30 uniqueidentifier, @rowguid31 uniqueidentifier, @rowguid32 uniqueidentifier, @rowguid33 uniqueidentifier, @rowguid34 uniqueidentifier, @rowguid35 uniqueidentifier, @rowguid36 uniqueidentifier, @rowguid37 uniqueidentifier, @rowguid38 uniqueidentifier, @rowguid39 uniqueidentifier, @rowguid4 uniqueidentifier, @rowguid40 uniqueidentifier, @rowguid41 uniqueidentifier, @rowguid42 uniqueidentifier, @rowguid43 uniqueidentifier, @rowguid44 uniqueidentifier, @rowguid45 uniqueidentifier, @rowguid46 uniqueidentifier, @rowguid47 uniqueidentifier, @rowguid48 uniqueidentifier, @rowguid49 uniqueidentifier, @rowguid5 uniqueidentifier, @rowguid50 uniqueidentifier, @rowguid51 uniqueidentifier, @rowguid52 uniqueidentifier, @rowguid53 uniqueidentifier, @rowguid54 uniqueidentifier, @rowguid55 uniqueidentifier, @rowguid56 uniqueidentifier, @rowguid57 uniqueidentifier, @rowguid58 uniqueidentifier, @rowguid59 uniqueidentifier, @rowguid6 uniqueidentifier, @rowguid60 uniqueidentifier, @rowguid61 uniqueidentifier, @rowguid62 uniqueidentifier, @rowguid63 uniqueidentifier, @rowguid64 uniqueidentifier, @rowguid65 uniqueidentifier, @rowguid66 uniqueidentifier, @rowguid67 uniqueidentifier, @rowguid68 uniqueidentifier, @rowguid69 uniqueidentifier, @rowguid7 uniqueidentifier, @rowguid70 uniqueidentifier, @rowguid71 uniqueidentifier, @rowguid72 uniqueidentifier, @rowguid73 uniqueidentifier, @rowguid74 uniqueidentifier, @rowguid75 uniqueidentifier, @rowguid76 uniqueidentifier, @rowguid77 uniqueidentifier, @rowguid78 uniqueidentifier, @rowguid79 uniqueidentifier, @rowguid8 uniqueidentifier, @rowguid80 uniqueidentifier, @rowguid81 uniqueidentifier, @rowguid82 uniqueidentifier, @rowguid83 uniqueidentifier, @rowguid84 uniqueidentifier, @rowguid85 uniqueidentifier, @rowguid86 uniqueidentifier, @rowguid87 uniqueidentifier, @rowguid88 uniqueidentifier, @rowguid89 uniqueidentifier, @rowguid9 uniqueidentifier, @rowguid90 uniqueidentifier, @rowguid91 uniqueidentifier, @rowguid92 uniqueidentifier, @rowguid93 uniqueidentifier, @rowguid94 uniqueidentifier, @rowguid95 uniqueidentifier, @rowguid96 uniqueidentifier, @rowguid97 uniqueidentifier, @rowguid98 uniqueidentifier, @rowguid99 uniqueidentifier, @rows_tobe_deleted int, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdelrowsbatch_downloadonly(@check_permission int, @pubid uniqueidentifier, @rowguid1 uniqueidentifier, @rowguid10 uniqueidentifier, @rowguid100 uniqueidentifier, @rowguid11 uniqueidentifier, @rowguid12 uniqueidentifier, @rowguid13 uniqueidentifier, @rowguid14 uniqueidentifier, @rowguid15 uniqueidentifier, @rowguid16 uniqueidentifier, @rowguid17 uniqueidentifier, @rowguid18 uniqueidentifier, @rowguid19 uniqueidentifier, @rowguid2 uniqueidentifier, @rowguid20 uniqueidentifier, @rowguid21 uniqueidentifier, @rowguid22 uniqueidentifier, @rowguid23 uniqueidentifier, @rowguid24 uniqueidentifier, @rowguid25 uniqueidentifier, @rowguid26 uniqueidentifier, @rowguid27 uniqueidentifier, @rowguid28 uniqueidentifier, @rowguid29 uniqueidentifier, @rowguid3 uniqueidentifier, @rowguid30 uniqueidentifier, @rowguid31 uniqueidentifier, @rowguid32 uniqueidentifier, @rowguid33 uniqueidentifier, @rowguid34 uniqueidentifier, @rowguid35 uniqueidentifier, @rowguid36 uniqueidentifier, @rowguid37 uniqueidentifier, @rowguid38 uniqueidentifier, @rowguid39 uniqueidentifier, @rowguid4 uniqueidentifier, @rowguid40 uniqueidentifier, @rowguid41 uniqueidentifier, @rowguid42 uniqueidentifier, @rowguid43 uniqueidentifier, @rowguid44 uniqueidentifier, @rowguid45 uniqueidentifier, @rowguid46 uniqueidentifier, @rowguid47 uniqueidentifier, @rowguid48 uniqueidentifier, @rowguid49 uniqueidentifier, @rowguid5 uniqueidentifier, @rowguid50 uniqueidentifier, @rowguid51 uniqueidentifier, @rowguid52 uniqueidentifier, @rowguid53 uniqueidentifier, @rowguid54 uniqueidentifier, @rowguid55 uniqueidentifier, @rowguid56 uniqueidentifier, @rowguid57 uniqueidentifier, @rowguid58 uniqueidentifier, @rowguid59 uniqueidentifier, @rowguid6 uniqueidentifier, @rowguid60 uniqueidentifier, @rowguid61 uniqueidentifier, @rowguid62 uniqueidentifier, @rowguid63 uniqueidentifier, @rowguid64 uniqueidentifier, @rowguid65 uniqueidentifier, @rowguid66 uniqueidentifier, @rowguid67 uniqueidentifier, @rowguid68 uniqueidentifier, @rowguid69 uniqueidentifier, @rowguid7 uniqueidentifier, @rowguid70 uniqueidentifier, @rowguid71 uniqueidentifier, @rowguid72 uniqueidentifier, @rowguid73 uniqueidentifier, @rowguid74 uniqueidentifier, @rowguid75 uniqueidentifier, @rowguid76 uniqueidentifier, @rowguid77 uniqueidentifier, @rowguid78 uniqueidentifier, @rowguid79 uniqueidentifier, @rowguid8 uniqueidentifier, @rowguid80 uniqueidentifier, @rowguid81 uniqueidentifier, @rowguid82 uniqueidentifier, @rowguid83 uniqueidentifier, @rowguid84 uniqueidentifier, @rowguid85 uniqueidentifier, @rowguid86 uniqueidentifier, @rowguid87 uniqueidentifier, @rowguid88 uniqueidentifier, @rowguid89 uniqueidentifier, @rowguid9 uniqueidentifier, @rowguid90 uniqueidentifier, @rowguid91 uniqueidentifier, @rowguid92 uniqueidentifier, @rowguid93 uniqueidentifier, @rowguid94 uniqueidentifier, @rowguid95 uniqueidentifier, @rowguid96 uniqueidentifier, @rowguid97 uniqueidentifier, @rowguid98 uniqueidentifier, @rowguid99 uniqueidentifier, @rows_tobe_deleted int, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdelsubrows(@allarticlesareupdateable bit, @compatlevel int, @generation bigint, @lineage_new varbinary(311), @lineage_old varbinary(311), @metadata_type tinyint, @pubid uniqueidentifier, @rowguid uniqueidentifier, @rowsdeleted int, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdelsubrowsbatch(@allarticlesareupdateable bit, @generation_array varbinary(4000), @metadatatype_array varbinary(500), @newlineage_array image, @newlineage_len_array varbinary(1000), @oldlineage_array image, @oldlineage_len_array varbinary(1000), @pubid uniqueidentifier, @rowguid_array varbinary(8000), @rowsdeleted int, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdependencies(@flags int, @intrans int, @objlist nvarchar(128), @objname nvarchar(517), @objtype int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdetect_nonlogged_shutdown(@agent_id int, @subsystem nvarchar(60)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdetectinvalidpeerconfiguration(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdetectinvalidpeersubscription(@article sysname, @dest_owner sysname, @dest_table sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdist_activate_auto_sub(@article_id int, @publisher_db sysname, @publisher_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdist_adjust_identity(@agent_id int, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdistpublisher_cleanup(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdistribution_counters(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdistributoravailable() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdodatabasesnapshotinitiation(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdopartialdatabasesnapshotinitiation(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_6x_publication(@job_id uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_6x_replication_agent(@category_id int, @job_id uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_anonymous_entry(@login sysname, @subid uniqueidentifier, @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_article(@article sysname, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_distribution_agent(@job_only bit, @keep_for_last_run bit, @publication sysname, @publisher_db sysname, @publisher_id smallint, @subscriber_db sysname, @subscriber_id smallint, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_distribution_agentid_dbowner_proxy(@agent_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_dynamic_snapshot_agent(@agent_id int, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_logreader_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_merge_agent(@job_only bit, @keep_for_last_run bit, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_merge_subscription(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @subscription_type nvarchar(15)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_publication(@alt_snapshot_folder sysname, @cleanup_orphans bit, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_qreader_history(@publication_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_snapshot_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_snapshot_dirs() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_subscriber_info(@publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_subscription(@article sysname, @article_id int, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_subscription_3rd(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdrop_tempgenhistorytable(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdroparticleconstraints(@destination_object sysname, @destination_owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdroparticletombstones(@artid uniqueidentifier, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdropconstraints(@owner sysname, @table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdropdynsnapshotvws(@dynamic_snapshot_views_table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdropfkreferencingarticle(@destination_object_name sysname, @destination_owner_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdropmergearticle(@artid uniqueidentifier, @ignore_merge_metadata bit, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdropmergedynamicsnapshotjob(@dynamic_snapshot_jobid uniqueidentifier, @dynamic_snapshot_jobname sysname, @ignore_distributor bit, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdropretry(@pname sysname, @tname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdroptemptable(@tname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdummyupdate(@incolv varbinary(2953), @inlineage varbinary(311), @metatype tinyint, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int, @uplineage tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdummyupdate90(@incolv varbinary(2953), @inlineage varbinary(311), @logical_record_parent_rowguid uniqueidentifier, @metatype tinyint, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdummyupdate_logicalrecord(@dest_common_gen bigint, @parent_nickname int, @parent_rowguid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdummyupdatelightweight(@action int, @metatype tinyint, @rowguid uniqueidentifier, @rowvector varbinary(11), @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSdynamicsnapshotjobexistsatdistributor(@dynamic_filter_hostname sysname, @dynamic_filter_login sysname, @dynamic_snapshot_jobid uniqueidentifier, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenable_publication_for_het_sub(@publication sysname, @publisher sysname, @publisher_db sysname, @sync_method int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSensure_single_instance(@agent_type int, @application_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_distribution(@exclude_anonymous bit, @name nvarchar(100), @show_distdb bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_distribution_s(@hours int, @name nvarchar(100), @session_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_distribution_sd(@name nvarchar(100), @time datetime) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_logicalrecord_changes(@enumentirerowmetadata bit, @genlist varchar(8000), @maxgen bigint, @maxschemaguidforarticle uniqueidentifier, @mingen bigint, @oldmaxgen bigint, @parent_nickname int, @partition_id int, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_logreader(@name nvarchar(100), @show_distdb bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_logreader_s(@hours int, @name nvarchar(100), @session_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_logreader_sd(@name nvarchar(100), @time datetime) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_merge(@exclude_anonymous bit, @name nvarchar(100), @show_distdb bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_merge_agent_properties(@publication sysname, @publisher sysname, @publisher_db sysname, @show_security bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_merge_s(@hours int, @name nvarchar(100), @session_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_merge_sd(@name nvarchar(100), @time datetime) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_merge_subscriptions(@exclude_anonymous bit, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_merge_subscriptions_90_publication(@exclude_anonymous bit, @publication sysname, @publisher sysname, @publisher_db sysname, @topNum int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_merge_subscriptions_90_publisher(@exclude_anonymous bit, @publisher sysname, @topNum int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_metadataaction_requests(@max_rows int, @pubid uniqueidentifier, @rowguid_last uniqueidentifier, @tablenick_last int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_qreader(@name nvarchar(100), @show_distdb bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_qreader_s(@hours int, @publication_id int, @session_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_qreader_sd(@publication_id int, @time datetime) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_replication_agents(@check_user bit, @exclude_anonymous bit, @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_replication_job(@job_id uniqueidentifier, @step_uid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_replqueues(@curdistdb sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_replsqlqueues(@curdistdb sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_snapshot(@name nvarchar(100), @show_distdb bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_snapshot_s(@hours int, @name nvarchar(100), @session_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_snapshot_sd(@name nvarchar(100), @time datetime) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenum_subscriptions(@exclude_anonymous bit, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumallpublications(@agent_login sysname, @empty_tranpub bit, @hrepl_pub bit, @publication sysname, @publisherdb sysname, @replication_type tinyint, @security_check bit, @vendor_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumallsubscriptions(@subscriber_db sysname, @subscription_type nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumarticleslightweight(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumchanges(@blob_cols_at_the_end bit, @compatlevel int, @enumentirerowmetadata bit, @genlist varchar(8000), @maxgen bigint, @maxrows int, @maxschemaguidforarticle uniqueidentifier, @mingen bigint, @oldmaxgen bigint, @pubid uniqueidentifier, @return_count_of_rows_initially_enumerated bit, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumchanges_belongtopartition(@blob_cols_at_the_end bit, @enumentirerowmetadata bit, @genlist varchar(8000), @maxgen bigint, @maxrows int, @maxschemaguidforarticle uniqueidentifier, @mingen bigint, @partition_id int, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumchanges_notbelongtopartition(@enumentirerowmetadata bit, @genlist varchar(8000), @maxgen bigint, @maxrows int, @mingen bigint, @partition_id int, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumchangesdirect(@blob_cols_at_the_end bit, @compatlevel int, @enumentirerowmetadata bit, @genlist varchar(2000), @maxgen bigint, @maxrows int, @maxschemaguidforarticle uniqueidentifier, @mingen bigint, @oldmaxgen bigint, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumchangeslightweight(@lastrowguid uniqueidentifier, @maxrows int, @pubid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumcolumns(@artid uniqueidentifier, @maxschemaguidforarticle uniqueidentifier, @pubid uniqueidentifier, @show_filtering_columns bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumcolumnslightweight(@artid uniqueidentifier, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumdeletes_forpartition(@enumentirerowmetadata bit, @genlist varchar(8000), @maxgen bigint, @maxrows int, @mingen bigint, @partition_id int, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumdeleteslightweight(@lastrowguid uniqueidentifier, @maxrows int, @pubid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumdeletesmetadata(@compatlevel int, @enumentirerowmetadata bit, @filter_partialdeletes int, @genlist varchar(8000), @maxgen bigint, @maxrows int, @mingen bigint, @pubid uniqueidentifier, @rowguid uniqueidentifier, @specified_article_only int, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumdistributionagentproperties(@publication sysname, @publisher sysname, @publisher_db sysname, @show_security bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumerate_PAL(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumgenerations(@genstart bigint, @pubid uniqueidentifier, @return_count_of_generations bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumgenerations90(@genstart bigint, @maxgen_to_enumerate bigint, @mingen_to_enumerate bigint, @numgens int, @partition_id int, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumpartialchanges(@blob_cols_at_the_end bit, @compatlevel int, @enumentirerowmetadata bit, @maxrows int, @maxschemaguidforarticle uniqueidentifier, @pubid uniqueidentifier, @return_count_of_rows_initially_enumerated bit, @rowguid uniqueidentifier, @tablenick int, @temp_cont sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumpartialchangesdirect(@blob_cols_at_the_end bit, @compatlevel int, @enumentirerowmetadata bit, @maxrows int, @maxschemaguidforarticle uniqueidentifier, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int, @temp_cont sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumpartialdeletes(@bookmark int, @compatlevel int, @enumentirerowmetadata bit, @maxrows int, @pubid uniqueidentifier, @rowguid uniqueidentifier, @specified_article_only int, @tablenick int, @tablenotbelongs nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumpubreferences(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumreplicas(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumreplicas90() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumretries(@maxrows int, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int, @tname nvarchar(126)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumschemachange(@AlterTableOnly bit, @compatlevel int, @filter_skipped_schemachanges bit, @invalidateupload_schemachanges_for_ssce bit, @pubid uniqueidentifier, @schemaversion int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumsubscriptions(@publisher sysname, @publisher_db sysname, @reserved bit, @subscription_type nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSenumthirdpartypublicationvendornames(@within_db bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSestimatemergesnapshotworkload(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSestimatesnapshotworkload(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSevalsubscriberinfo(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSevaluate_change_membership_for_all_articles_in_pubid(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSevaluate_change_membership_for_pubid(@partition_id int, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSevaluate_change_membership_for_row(@marker uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSexecwithlsnoutput(@command nvarchar(max), @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSfast_delete_trans() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSfetchAdjustidentityrange(@adjust_only bit, @for_publisher tinyint, @next_seed bigint, @publisher sysname, @publisher_db sysname, @range bigint, @tablename sysname, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSfetchidentityrange(@adjust_only bit, @table_owner sysname, @tablename nvarchar(270)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSfillupmissingcols(@publication sysname, @source_table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSfilterclause(@article nvarchar(258), @publication nvarchar(258)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSfix_6x_tasks(@publisher sysname, @publisher_engine_edition int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSfixlineageversions() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSfixupbeforeimagetables(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSflush_access_cache() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSforce_drop_distribution_jobs(@publisher sysname, @publisher_db sysname, @type nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSforcereenumeration(@rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSforeach_worker(@command1 nvarchar(2000), @command2 nvarchar(2000), @command3 nvarchar(2000), @replacechar nchar(1), @worker_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSforeachdb(@command1 nvarchar(2000), @command2 nvarchar(2000), @command3 nvarchar(2000), @postcommand nvarchar(2000), @precommand nvarchar(2000), @replacechar nchar(1)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSforeachtable(@command1 nvarchar(2000), @command2 nvarchar(2000), @command3 nvarchar(2000), @postcommand nvarchar(2000), @precommand nvarchar(2000), @replacechar nchar(1), @whereand nvarchar(2000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgenerateexpandproc(@procname sysname, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_DDL_after_regular_snapshot(@ddl_present bit, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_MSmerge_rowtrack_colinfo() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_agent_names(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_attach_state(@publication sysname, @publisher sysname, @publisher_db sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_dynamic_snapshot_location(@dynsnap_location nvarchar(255), @partition_id int, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_identity_range_info(@artid uniqueidentifier, @next_range_begin numeric(38), @next_range_end numeric(38), @range_begin numeric(38), @range_end numeric(38), @range_type tinyint, @ranges_needed tinyint, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_jobstate(@job_id uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_last_transaction(@for_truncate bit, @max_xact_seqno varbinary(16), @publisher sysname, @publisher_db sysname, @publisher_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_latest_peerlsn(@originator sysname, @originator_db sysname, @originator_publication sysname, @xact_seqno binary(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_load_hint(@is_vertically_partitioned bit, @primary_key_only bit, @qualified_source_object_name nvarchar(4000), @qualified_sync_object_name nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_log_shipping_new_sessionid(@agent_id uniqueidentifier, @agent_type tinyint, @session_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_logicalrecord_lineage(@dest_common_gen bigint, @parent_nickname int, @parent_rowguid uniqueidentifier, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_max_used_identity(@article sysname, @max_used numeric(38), @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_min_seqno(@agent_id int, @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_new_xact_seqno(@len tinyint, @publisher_db sysname, @publisher_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_oledbinfo(@infotype nvarchar(128), @login nvarchar(128), @password nvarchar(128), @server nvarchar(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_partitionid_eval_proc(@column_list nvarchar(2000), @function_list nvarchar(2000), @partition_id_eval_clause nvarchar(2000), @partition_id_eval_proc sysname, @pubid uniqueidentifier, @publication_number smallint, @use_partition_groups smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_publication_from_taskname(@publication sysname, @publisher sysname, @publisherdb sysname, @taskname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_publisher_rpc(@connect_string nvarchar(2000), @owner sysname, @trigger_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_repl_cmds_anonymous(@agent_id int, @compatibility_level int, @get_count tinyint, @last_xact_seqno varbinary(16), @no_init_sync bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_repl_commands(@agent_id int, @compatibility_level int, @get_count tinyint, @last_xact_seqno varbinary(16), @read_query_size int, @subdb_version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_repl_error(@id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_session_statistics(@session_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_shared_agent(@agent_type int, @database_name sysname, @publisher sysname, @publisher_db sysname, @server_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_snapshot_history(@agent_id int, @rowcount int, @timestamp timestamp) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_subscriber_partition_id(@host_name_override sysname, @maxgen_whenadded bigint, @partition_id int, @publication sysname, @suser_sname_override sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_subscription_dts_info(@job_id varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_subscription_guid(@agent_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_synctran_commands(@alter bit, @article sysname, @command_only bit, @publication sysname, @publisher sysname, @publisher_db sysname, @trig_only bit, @usesqlclr bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSget_type_wrapper(@colid int, @colname sysname, @tabid int, @typestring nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetagentoffloadinfo(@job_id varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetalertinfo(@includeaddresses bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetalternaterecgens(@repid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetarticlereinitvalue(@artid int, @publication sysname, @reinit int, @subscriber sysname, @subscriberdb sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetchangecount(@changes int, @deletes int, @startgen bigint, @updates int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetconflictinsertproc(@artid uniqueidentifier, @force_generate_proc bit, @output int, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetconflicttablename(@conflict_table sysname, @publication sysname, @source_object nvarchar(520)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetdatametadatabatch(@all_articles_are_guaranteed_to_be_updateable_at_other_replica bit, @logical_record_parent_rowguid uniqueidentifier, @pubid uniqueidentifier, @rowguidarray varbinary(8000), @tablenickarray varbinary(2000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetdbversion(@current_version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetdynamicsnapshotapplock(@lock_acquired int, @partition_id int, @publication sysname, @timeout int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetdynsnapvalidationtoken(@dynamic_filter_login sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetgenstatus4rows(@repid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetisvalidwindowsloginfromdistributor(@isvalid bit, @login nvarchar(257), @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetlastrecgen(@repid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetlastsentgen(@repid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetlastsentrecgens(@repid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetlastupdatedtime(@publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetlightweightmetadatabatch(@artnickarray varbinary(2000), @pubid uniqueidentifier, @rowguidarray varbinary(8000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmakegenerationapplock(@head_of_queue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmakegenerationapplock_90(@lock_acquired int, @wait_time int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmaxbcpgen(@max_closed_gen bigint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmaxsnapshottimestamp(@agent_id int, @timestamp timestamp) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmergeadminapplock(@lock_acquired int, @lockmode nvarchar(32), @lockowner nvarchar(32), @timeout int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmetadata_changedlogicalrecordmembers(@commongen bigint, @parent_nickname int, @parent_rowguid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmetadatabatch(@compatlevel int, @lightweight int, @pubid uniqueidentifier, @rowguidarray varbinary(8000), @tablenickarray varbinary(2000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmetadatabatch90(@pubid uniqueidentifier, @rowguidarray varbinary(8000), @tablenickarray varbinary(2000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetmetadatabatch90new(@pubid uniqueidentifier, @rowguid1 uniqueidentifier, @rowguid10 uniqueidentifier, @rowguid100 uniqueidentifier, @rowguid11 uniqueidentifier, @rowguid12 uniqueidentifier, @rowguid13 uniqueidentifier, @rowguid14 uniqueidentifier, @rowguid15 uniqueidentifier, @rowguid16 uniqueidentifier, @rowguid17 uniqueidentifier, @rowguid18 uniqueidentifier, @rowguid19 uniqueidentifier, @rowguid2 uniqueidentifier, @rowguid20 uniqueidentifier, @rowguid21 uniqueidentifier, @rowguid22 uniqueidentifier, @rowguid23 uniqueidentifier, @rowguid24 uniqueidentifier, @rowguid25 uniqueidentifier, @rowguid26 uniqueidentifier, @rowguid27 uniqueidentifier, @rowguid28 uniqueidentifier, @rowguid29 uniqueidentifier, @rowguid3 uniqueidentifier, @rowguid30 uniqueidentifier, @rowguid31 uniqueidentifier, @rowguid32 uniqueidentifier, @rowguid33 uniqueidentifier, @rowguid34 uniqueidentifier, @rowguid35 uniqueidentifier, @rowguid36 uniqueidentifier, @rowguid37 uniqueidentifier, @rowguid38 uniqueidentifier, @rowguid39 uniqueidentifier, @rowguid4 uniqueidentifier, @rowguid40 uniqueidentifier, @rowguid41 uniqueidentifier, @rowguid42 uniqueidentifier, @rowguid43 uniqueidentifier, @rowguid44 uniqueidentifier, @rowguid45 uniqueidentifier, @rowguid46 uniqueidentifier, @rowguid47 uniqueidentifier, @rowguid48 uniqueidentifier, @rowguid49 uniqueidentifier, @rowguid5 uniqueidentifier, @rowguid50 uniqueidentifier, @rowguid51 uniqueidentifier, @rowguid52 uniqueidentifier, @rowguid53 uniqueidentifier, @rowguid54 uniqueidentifier, @rowguid55 uniqueidentifier, @rowguid56 uniqueidentifier, @rowguid57 uniqueidentifier, @rowguid58 uniqueidentifier, @rowguid59 uniqueidentifier, @rowguid6 uniqueidentifier, @rowguid60 uniqueidentifier, @rowguid61 uniqueidentifier, @rowguid62 uniqueidentifier, @rowguid63 uniqueidentifier, @rowguid64 uniqueidentifier, @rowguid65 uniqueidentifier, @rowguid66 uniqueidentifier, @rowguid67 uniqueidentifier, @rowguid68 uniqueidentifier, @rowguid69 uniqueidentifier, @rowguid7 uniqueidentifier, @rowguid70 uniqueidentifier, @rowguid71 uniqueidentifier, @rowguid72 uniqueidentifier, @rowguid73 uniqueidentifier, @rowguid74 uniqueidentifier, @rowguid75 uniqueidentifier, @rowguid76 uniqueidentifier, @rowguid77 uniqueidentifier, @rowguid78 uniqueidentifier, @rowguid79 uniqueidentifier, @rowguid8 uniqueidentifier, @rowguid80 uniqueidentifier, @rowguid81 uniqueidentifier, @rowguid82 uniqueidentifier, @rowguid83 uniqueidentifier, @rowguid84 uniqueidentifier, @rowguid85 uniqueidentifier, @rowguid86 uniqueidentifier, @rowguid87 uniqueidentifier, @rowguid88 uniqueidentifier, @rowguid89 uniqueidentifier, @rowguid9 uniqueidentifier, @rowguid90 uniqueidentifier, @rowguid91 uniqueidentifier, @rowguid92 uniqueidentifier, @rowguid93 uniqueidentifier, @rowguid94 uniqueidentifier, @rowguid95 uniqueidentifier, @rowguid96 uniqueidentifier, @rowguid97 uniqueidentifier, @rowguid98 uniqueidentifier, @rowguid99 uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetonerow(@pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetonerowlightweight(@pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetpeerconflictrow(@conflict_table nvarchar(270), @origin_datasource nvarchar(32), @originator_id nvarchar(32), @row_id nvarchar(32), @tran_id nvarchar(32)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetpeerlsns(@publication sysname, @xlockrows bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetpeertopeercommands(@article sysname, @publication sysname, @script_txt nvarchar(max), @snapshot_lsn varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetpeerwinnerrow(@conflict_table nvarchar(270), @originator_id nvarchar(32), @row_id nvarchar(19)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetpubinfo(@pubdb sysname, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetreplicainfo(@compatlevel int, @datasource_path nvarchar(255), @datasource_type int, @db_name sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @server_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetreplicastate(@pubid uniqueidentifier, @replicastate uniqueidentifier, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetrowmetadata(@colv varbinary(2953), @compatlevel int, @generation bigint, @lineage varbinary(311), @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int, @type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetrowmetadatalightweight(@changedcolumns varbinary(128), @columns_enumeration tinyint, @pubid uniqueidentifier, @rowguid uniqueidentifier, @rowvector varbinary(11), @tablenick int, @type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetsetupbelong_cost() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetsubscriberinfo(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetsupportabilitysettings(@compatlevel int, @db_name sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @server_name sysname, @web_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgettrancftsrcrow(@conflict_table nvarchar(270), @is_debug bit, @is_subscriber bit, @row_id sysname, @tran_id sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgettranconflictrow(@conflict_table nvarchar(270), @is_subscriber bit, @row_id sysname, @tran_id sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgetversion() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSgrantconnectreplication(@user_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShaschangeslightweight(@haschanges int, @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShasdbaccess() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_article(@article sysname, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_distdb(@publisher_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_distribution_agentid(@anonymous_subid uniqueidentifier, @publication sysname, @publisher_db sysname, @publisher_id smallint, @reinitanon bit, @subscriber_db sysname, @subscriber_id smallint, @subscriber_name sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_identity_property(@ownername sysname, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_logreader_agentid(@publisher_db sysname, @publisher_id smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_merge_agentid(@publication sysname, @publisher_db sysname, @publisher_id smallint, @subscriber sysname, @subscriber_db sysname, @subscriber_id smallint, @subscriber_version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_profile(@agent_id int, @agent_type int, @profile_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_profilecache(@profile_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_publication(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_repl_agent(@agent_type int, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_replication_status(@agent_type int, @exclude_anonymous bit, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_replication_table(@table_name sysname, @table_owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_snapshot_agent(@agent_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_snapshot_agentid(@dynamic_filter_hostname sysname, @dynamic_filter_login sysname, @dynamic_snapshot_location nvarchar(255), @job_id binary(16), @publication sysname, @publisher_db sysname, @publisher_id smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_subscriber_info(@found int, @publisher sysname, @show_password bit, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_subscription(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelp_subscription_status(@independent_agent bit, @out_of_date int, @publication sysname, @publisher sysname, @publisher_db sysname, @retention int, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpcolumns(@flags int, @flags2 int, @orderby nvarchar(10), @tablename nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpconflictpublications(@publication_type varchar(9)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpcreatebeforetable(@newname sysname, @objid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpdestowner(@spname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpdynamicsnapshotjobatdistributor(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @dynamic_filter_hostname sysname, @dynamic_filter_login sysname, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpfulltextindex(@tablename nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpfulltextscript(@tablename nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpindex(@flags int, @indexname nvarchar(258), @tablename nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelplogreader_agent(@publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpmergearticles(@compatibility_level int, @pubidin uniqueidentifier, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpmergeconflictcounts(@logical_record_conflicts int, @publication_name sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpmergedynamicsnapshotjob(@dynamic_snapshot_jobid uniqueidentifier, @dynamic_snapshot_jobname sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpmergeidentity(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpmergeschemaarticles(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpobjectpublications(@object_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpreplicationtriggers(@object_name sysname, @object_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpsnapshot_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpsummarypublication(@oename nvarchar(260), @oetype nvarchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelptracertokenhistory(@publication sysname, @publisher sysname, @publisher_db sysname, @tracer_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelptracertokens(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelptranconflictcounts(@originator_id nvarchar(32), @publication_name sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelptype(@flags nvarchar(10), @typename nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MShelpvalidationdate(@publication sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSindexspace(@index_name nvarchar(258), @tablename nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinit_publication_access(@initinfo nvarchar(max), @publication sysname, @publisher sysname, @publisher_db sysname, @skip bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinit_subscription_agent(@publication sysname, @publisher sysname, @publisher_db sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinitdynamicsubscriber(@blob_cols_at_the_end bit, @compatlevel int, @enumentirerowmetadata bit, @maxrows int, @pubid uniqueidentifier, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinsert_identity(@identity_range bigint, @identity_support int, @max_identity bigint, @next_seed bigint, @pub_identity_range bigint, @publisher sysname, @publisher_db sysname, @tablename sysname, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinsertdeleteconflict(@compatlevel int, @conflict_type int, @conflicts_logged int, @lineage varbinary(311), @origin_datasource nvarchar(255), @pubid uniqueidentifier, @reason_code int, @reason_text nvarchar(720), @rowguid uniqueidentifier, @source_id uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinserterrorlineage(@compatlevel int, @lineage varbinary(311), @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinsertgenerationschemachanges(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinsertgenhistory(@artnick int, @compatlevel int, @gen bigint, @guidsrc uniqueidentifier, @nicknames varbinary(1000), @pubid uniqueidentifier, @pubid_ins uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinsertlightweightschemachange(@pubid uniqueidentifier, @schemaguid uniqueidentifier, @schemaversion int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinsertschemachange(@artid uniqueidentifier, @pubid uniqueidentifier, @schemaguid uniqueidentifier, @schemasubtype int, @schematext nvarchar(max), @schematype int, @schemaversion int, @update_schemaversion tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSinvalidate_snapshot(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSisnonpkukupdateinconflict(@artid int, @bitmap varbinary(4000), @pubid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSispeertopeeragent(@agent_id int, @is_p2p int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSispkupdateinconflict(@artid int, @bitmap varbinary(4000), @pubid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSispublicationqueued(@allow_queued_tran bit, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSisreplmergeagent(@at_publisher bit, @is_merge bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSissnapshotitemapplied(@snapshot_progress_token nvarchar(500), @snapshot_session_token nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSkilldb(@dbname nvarchar(258)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSlock_auto_sub(@publication sysname, @publisher_db sysname, @publisher_id int, @reset bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSlock_distribution_agent(@id int, @mode int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSlocktable(@ownername sysname, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSloginmappings(@flags int, @loginname nvarchar(258)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakearticleprocs(@artid uniqueidentifier, @pubid uniqueidentifier, @recreate_conflict_proc bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakebatchinsertproc(@artid uniqueidentifier, @destination_owner sysname, @generate_subscriber_proc bit, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakebatchupdateproc(@artid uniqueidentifier, @destination_owner sysname, @generate_subscriber_proc bit, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakeconflictinsertproc(@basetableid int, @generate_subscriber_proc bit, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakectsview(@create_dynamic_views bit, @ctsview sysname, @dynamic_snapshot_views_table_name sysname, @max_bcp_gen bigint, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakedeleteproc(@artid uniqueidentifier, @destination_owner sysname, @generate_subscriber_proc bit, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakedynsnapshotvws(@dynamic_filter_login sysname, @dynamic_snapshot_views_table_name sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakeexpandproc(@filterid int, @procname sysname, @pubname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakegeneration(@commongen bigint, @commongenguid uniqueidentifier, @commongenvalid int, @compatlevel int, @gencheck int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakeinsertproc(@artid uniqueidentifier, @destination_owner sysname, @generate_downlevel_procs bit, @generate_subscriber_proc bit, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakemetadataselectproc(@artid uniqueidentifier, @destination_owner sysname, @generate_subscriber_proc bit, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakeselectproc(@artid uniqueidentifier, @destination_owner sysname, @generate_downlevel_procs bit, @generate_subscriber_proc bit, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakesystableviews(@create_dynamic_views bit, @dynamic_snapshot_views_table_name sysname, @max_bcp_gen bigint, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmakeupdateproc(@artid uniqueidentifier, @destination_owner sysname, @generate_downlevel_procs bit, @generate_subscriber_proc bit, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmap_partitionid_to_generations(@partition_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmarkreinit(@publication sysname, @publisher sysname, @publisher_db sysname, @reset_reinit int, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmatchkey(@col1 nvarchar(258), @col10 nvarchar(258), @col11 nvarchar(258), @col12 nvarchar(258), @col13 nvarchar(258), @col14 nvarchar(258), @col15 nvarchar(258), @col16 nvarchar(258), @col2 nvarchar(258), @col3 nvarchar(258), @col4 nvarchar(258), @col5 nvarchar(258), @col6 nvarchar(258), @col7 nvarchar(258), @col8 nvarchar(258), @col9 nvarchar(258), @tablename nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_alterschemaonly(@objecttype varchar(32), @objid int, @pass_through_scripts nvarchar(max), @qual_object_name nvarchar(512)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_altertrigger(@objid int, @pass_through_scripts nvarchar(max), @qual_object_name nvarchar(512), @target_object_name nvarchar(512)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_alterview(@objecttype varchar(32), @objid int, @pass_through_scripts nvarchar(max), @qual_object_name nvarchar(512)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_ddldispatcher(@EventData xml, @procmapid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_getgencount(@gencount int, @genlist varchar(8000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_getgencur_public(@changecount int, @gen_cur bigint, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_is_snapshot_required(@publication sysname, @publisher sysname, @publisher_db sysname, @run_at_subscriber bit, @schemaversion bigint, @subscriber sysname, @subscriber_db sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_log_identity_range_allocations(@article sysname, @is_pub_range bit, @next_range_begin numeric(38), @next_range_end numeric(38), @publication sysname, @publisher sysname, @publisher_db sysname, @range_begin numeric(38), @range_end numeric(38), @ranges_allocated tinyint, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_parsegenlist(@gendeclarelist varchar(max), @genlist varchar(8000), @genselectlist varchar(max), @genunionlist varchar(max)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmerge_upgrade_subscriber(@upgrade_done bit, @upgrade_metadata bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmergesubscribedb(@create_ddl_triggers bit, @value sysname, @whattocreate smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSmergeupdatelastsyncinfo(@last_sync_status int, @last_sync_summary sysname, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSneedmergemetadataretentioncleanup(@needcleanup bit, @replicaid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSobjectprivs(@flags int, @grantee nvarchar(258), @mode nvarchar(10), @objid int, @objname nvarchar(776), @prottype int, @rollup int, @srvpriv int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeerapplyresponse(@originator sysname, @originator_db sysname, @request_id int, @response_db sysname, @response_srvr sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeerapplytopologyinfo(@connection_info xml, @originator sysname, @originator_db sysname, @request_id int, @response_conflict_retention int, @response_db sysname, @response_originator_id int, @response_srvr sysname, @response_srvr_version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeerconflictdetection_statuscollection_applyresponse(@conflictdetection_enabled bit, @originator_db sysname, @originator_node sysname, @peer_conflict_retention int, @peer_continue_onconflict bit, @peer_db sysname, @peer_db_version int, @peer_histids nvarchar(max), @peer_node sysname, @peer_originator_id int, @request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeerconflictdetection_statuscollection_sendresponse(@originator_db sysname, @originator_node sysname, @publication sysname, @request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeerconflictdetection_topology_applyresponse(@peer_db sysname, @peer_node sysname, @peer_subscriptions nvarchar(max), @peer_version int, @request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeerdbinfo(@current_version int, @is_p2p bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeersendresponse(@originator sysname, @originator_db sysname, @originator_publication sysname, @request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeersendtopologyinfo(@originator sysname, @originator_db sysname, @originator_publication sysname, @request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpeertopeerfwdingexec(@change_results_originator bit, @command nvarchar(max), @execute bit, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpost_auto_proc(@alter bit, @artid int, @artname sysname, @dbname sysname, @for_p2p_ddl bit, @format int, @has_ident bit, @has_ts bit, @procmapid int, @pubid int, @publisher sysname, @pubname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpostapplyscript_forsubscriberprocs(@procsuffix sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSprep_exclusive(@objid int, @objname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSprepare_mergearticle(@publication sysname, @qualified_tablename nvarchar(270), @source_owner sysname, @source_table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSprofile_in_use(@profile_id int, @tablename nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSproxiedmetadata(@compatlevel int, @proxied_colv varbinary(2953), @proxied_lineage varbinary(311), @proxy_logical_record_lineage bit, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSproxiedmetadatabatch(@compatlevel int, @proxied_colv varbinary(2953), @proxied_lineage varbinary(311), @proxy_logical_record_lineage bit, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSproxiedmetadatalightweight(@acknowledge_only bit, @pubid uniqueidentifier, @rowguid uniqueidentifier, @rowvector varbinary(11), @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpub_adjust_identity(@artid int, @max_identity bigint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpublication_access(@has_access bit, @login sysname, @operation nvarchar(20), @publication sysname, @publisher sysname, @publisher_db sysname, @skip bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpublicationcleanup(@force_preserve_rowguidcol bit, @ignore_merge_metadata bit, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSpublicationview(@articlename sysname, @force_flag int, @max_network_optimization bit, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSquery_syncstates(@publisher_db sysname, @publisher_id smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSquerysubtype(@pubid uniqueidentifier, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrecordsnapshotdeliveryprogress(@snapshot_progress_token nvarchar(500), @snapshot_session_token nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreenable_check(@objname sysname, @objowner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrefresh_anonymous(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrefresh_publisher_idrange(@artid uniqueidentifier, @qualified_object_name nvarchar(517), @ranges_needed tinyint, @refresh_check_constraint bit, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSregenerate_mergetriggersprocs(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSregisterdynsnapseqno(@dynsnapseqno uniqueidentifier, @snapshot_session_token nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSregistermergesnappubid(@pubid uniqueidentifier, @snapshot_session_token nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSregistersubscription(@distributor sysname, @distributor_login sysname, @distributor_password nvarchar(524), @distributor_security_mode int, @failover_mode int, @hostname sysname, @independent_agent int, @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_login sysname, @publisher_password nvarchar(524), @publisher_security_mode int, @replication_type int, @subscriber sysname, @subscriber_db sysname, @subscriber_login sysname, @subscriber_password nvarchar(524), @subscriber_security_mode int, @subscription_id uniqueidentifier, @subscription_type int, @use_interactive_resolver int, @use_web_sync bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreinit_failed_subscriptions(@failure_level int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreinit_hub(@publication sysname, @publisher sysname, @publisher_db sysname, @upload_first bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreinit_subscription(@publication sysname, @publisher_db sysname, @publisher_name sysname, @subscriber_db sysname, @subscriber_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreinitoverlappingmergepublications(@pubid uniqueidentifier, @upload_before_reinit bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreleaseSlotLock(@DbPrincipal sysname, @process_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreleasedynamicsnapshotapplock(@partition_id int, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreleasemakegenerationapplock() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreleasemergeadminapplock(@lockowner nvarchar(32)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreleasesnapshotdeliverysessionlock() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSremove_mergereplcommand(@article sysname, @publication sysname, @schematype int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSremoveoffloadparameter(@agenttype nvarchar(20), @job_id varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_FixPALRole(@pubid uniqueidentifier, @role sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_IsLastPubInSharedSubscription(@publication sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_IsUserInAnyPAL(@raise_error bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_PAL_rolecheck(@artid uniqueidentifier, @objid int, @partition_id int, @pubid uniqueidentifier, @publication sysname, @repid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_agentstatussummary(@log_comments nvarchar(255), @log_duration int, @log_status int, @log_time datetime, @publication sysname, @publisher sysname, @publisher_db sysname, @snap_comments nvarchar(255), @snap_duration int, @snap_status int, @snap_time datetime) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_backup_complete() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_backup_start() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_check_publisher(@connect_timeout int, @login nvarchar(255), @password nvarchar(255), @publisher sysname, @publisher_type sysname, @security_mode bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_createdatatypemappings() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_distributionagentstatussummary(@distribution_duration int, @distribution_message nvarchar(255), @distribution_status int, @distribution_time datetime, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_dropdatatypemappings() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_enumarticlecolumninfo(@article sysname, @defaults bit, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_enumpublications(@reserved bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_enumpublishertables(@publisher sysname, @silent bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_enumsubscriptions(@publication sysname, @publisher sysname, @reserved bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_enumtablecolumninfo(@owner sysname, @publisher sysname, @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_getdistributorinfo(@distribdb sysname, @distributor sysname, @local nvarchar(5), @publisher sysname, @publisher_id int, @publisher_type sysname, @rpcsrvname sysname, @version int, @working_directory nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_getpkfkrelation(@filtered_table nvarchar(400), @joined_table nvarchar(400)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_gettype_mappings(@dbms_name sysname, @dbms_version sysname, @source_prec int, @sql_type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_helparticlermo(@article sysname, @found int, @publication sysname, @publisher sysname, @returnfilter bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_init_backup_lsns() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_isdbowner(@dbname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_linkedservers_rowset(@agent_id int, @agent_type int, @srvname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_mergeagentstatussummary(@merge_duration int, @merge_message nvarchar(1000), @merge_percent_complete decimal(5,2), @merge_status int, @merge_time datetime, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_raiserror(@agent sysname, @agent_name nvarchar(100), @article sysname, @message nvarchar(255), @publication sysname, @status int, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_schema(@artid int, @column sysname, @operation int, @pubname sysname, @qual_source_object nvarchar(517), @schema_change_script nvarchar(4000), @typetext nvarchar(3000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_setNFR(@object_name sysname, @schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_snapshot_helparticlecolumns(@article sysname, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_snapshot_helppublication(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_startup_internal() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_subscription_rowset(@agent_id int, @agent_type int, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_testadminconnection(@distributor sysname, @password sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrepl_testconnection(@connect_timeout int, @login sysname, @password sysname, @publisher sysname, @publisher_type sysname, @security_mode bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplagentjobexists(@exists bit, @frompublisher bit, @independent_agent bit, @job_id uniqueidentifier, @job_name sysname, @job_step_uid uniqueidentifier, @proxy_id int, @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_id int, @subscriber sysname, @subscriber_db sysname, @subscriber_id int, @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplcheck_permission(@objid int, @permissions int, @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplcheck_pull(@given_login sysname, @pubid uniqueidentifier, @publication sysname, @publisher sysname, @raise_fatal_error bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplcheck_subscribe() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplcheck_subscribe_withddladmin() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplcheckoffloadserver(@offloadserver sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplcopyscriptfile(@directory nvarchar(4000), @scriptfile nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplraiserror(@errorid int, @param1 sysname, @param2 sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplremoveuncdir(@dir nvarchar(260), @ignore_errors bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreplupdateschema(@object_name nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrequestreenumeration(@rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrequestreenumeration_lightweight(@rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreset_attach_state(@publication sysname, @publisher sysname, @publisher_db sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreset_queued_reinit(@artid int, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreset_subscription(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreset_subscription_seqno(@agent_id int, @get_snapshot bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreset_synctran_bit(@owner sysname, @table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSreset_transaction(@publisher sysname, @publisher_db sysname, @xact_seqno varbinary(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSresetsnapshotdeliveryprogress(@snapshot_session_token nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSrestoresavedforeignkeys(@program_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSretrieve_publication_attributes(@database sysname, @name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_article_view(@artid int, @include_timestamps bit, @view_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_dri(@article sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_pub_upd_trig(@alter bit, @article sysname, @procname sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_sync_del_proc(@alter bit, @article sysname, @procname sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_sync_del_trig(@agent_id int, @cftproc sysname, @falter bit, @filter_clause nvarchar(4000), @identity_col sysname, @objid int, @primary_key_bitmap varbinary(4000), @proc_owner sysname, @procname sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @pubversion int, @trigname sysname, @ts_col sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_sync_ins_proc(@alter bit, @article sysname, @procname sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_sync_ins_trig(@agent_id int, @cftproc sysname, @falter bit, @filter_clause nvarchar(4000), @identity_col sysname, @objid int, @primary_key_bitmap varbinary(4000), @proc_owner sysname, @procname sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @pubversion int, @trigname sysname, @ts_col sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_sync_upd_proc(@alter bit, @article sysname, @procname sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscript_sync_upd_trig(@agent_id int, @cftproc sysname, @falter bit, @filter_clause nvarchar(4000), @identity_col sysname, @objid int, @primary_key_bitmap varbinary(4000), @proc_owner sysname, @procname sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @pubversion int, @trigname sysname, @ts_col sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscriptcustomdelproc(@artid int, @inDDLrepl bit, @publisher sysname, @publishertype tinyint, @usesqlclr bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscriptcustominsproc(@artid int, @inDDLrepl bit, @publisher sysname, @publishertype tinyint, @usesqlclr bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscriptcustomupdproc(@artid int, @inDDLrepl bit, @publisher sysname, @publishertype tinyint, @usesqlclr bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscriptdatabase(@dbname nvarchar(258)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscriptdb_worker() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscriptforeignkeyrestore(@constraint_name sysname, @delete_referential_action tinyint, @is_not_for_replication bit, @is_not_trusted bit, @parent_name sysname, @parent_schema sysname, @program_name sysname, @referenced_object_name sysname, @referenced_object_schema sysname, @update_referential_action tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscriptsubscriberprocs(@article sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSscriptviewproc(@artid uniqueidentifier, @ownername sysname, @procname sysname, @pubid uniqueidentifier, @rgcol sysname, @viewname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsendtosqlqueue(@cmdstate bit, @commandtype int, @data varbinary(8000), @datalen int, @objid int, @owner sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @tranid sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSset_dynamic_filter_options(@dont_raise_error bit, @dynamic_filters bit, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSset_logicalrecord_metadata(@logical_record_lineage varbinary(311), @parent_nickname int, @parent_rowguid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSset_new_identity_range(@artid uniqueidentifier, @next_range_begin numeric(38), @next_range_end numeric(38), @range_begin numeric(38), @range_end numeric(38), @range_type tinyint, @ranges_given tinyint, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSset_oledb_prop(@property_name sysname, @property_value bit, @provider_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSset_snapshot_xact_seqno(@article_id int, @publication sysname, @publisher_db sysname, @publisher_id int, @publisher_seqno varbinary(16), @reset bit, @ss_cplt_seqno varbinary(16), @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSset_sub_guid(@publication sysname, @publisher sysname, @publisher_db sysname, @queue_id sysname, @queue_server sysname, @subscription_guid binary(16), @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSset_subscription_properties(@allow_subscription_copy bit, @attach_version binary(16), @publication sysname, @publisher sysname, @publisher_db sysname, @queue_id sysname, @queue_server sysname, @subscription_type int, @update_mode int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetaccesslist(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetalertinfo(@failsafeemailaddress nvarchar(255), @failsafenetsendaddress nvarchar(255), @failsafeoperator nvarchar(255), @failsafepageraddress nvarchar(255), @forwardalways int, @forwardingserver nvarchar(255), @forwardingseverity int, @notificationmethod int, @pagercctemplate nvarchar(255), @pagersendsubjectonly int, @pagersubjecttemplate nvarchar(255), @pagertotemplate nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetartprocs(@article sysname, @force_flag int, @pubid uniqueidentifier, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetbit(@bm varbinary(128), @coltoadd smallint, @toset int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetconflictscript(@article sysname, @conflict_script nvarchar(255), @login sysname, @password nvarchar(524), @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetconflicttable(@article sysname, @conflict_table sysname, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetcontext_bypasswholeddleventbit(@onoff bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetcontext_replagent(@agent_type tinyint, @is_publisher bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetgentozero(@metatype tinyint, @rowguid uniqueidentifier, @tablenick int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetlastrecgen(@repid uniqueidentifier, @srcgen bigint, @srcguid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetlastsentgen(@repid uniqueidentifier, @srcgen bigint, @srcguid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetreplicainfo(@activate_subscription bit, @compatlevel int, @datasource_path nvarchar(255), @datasource_type int, @db_name sysname, @partition_id int, @publication sysname, @publisher sysname, @publisher_db sysname, @replica_version int, @replnick varbinary(6), @schemaversion int, @server_name sysname, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetreplicaschemaversion(@schemaguid uniqueidentifier, @schemaversion int, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetreplicastatus(@status_value int, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetrowmetadata(@colv varbinary(2953), @compatlevel int, @generation bigint, @isinsert bit, @lineage varbinary(311), @partition_id int, @partition_options tinyint, @pubid uniqueidentifier, @publication_number smallint, @rowguid uniqueidentifier, @tablenick int, @type tinyint, @was_tombstone int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetsubscriberinfo(@expr nvarchar(500), @pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsettopology(@X int, @Y int, @server nvarchar(258)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetup_identity_range(@artid uniqueidentifier, @next_range_begin numeric(38), @next_range_end numeric(38), @pubid uniqueidentifier, @range_begin numeric(38), @range_end numeric(38), @range_type tinyint, @ranges_needed tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetup_partition_groups(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetup_use_partition_groups(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetupbelongs(@articlesoption int, @belongsname sysname, @commongen bigint, @compatlevel int, @enumentirerowmetadata bit, @genlist varchar(8000), @handle_null_tables bit, @maxgen bigint, @mingen bigint, @nicknamelist varchar(8000), @notbelongsname sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @skipgenlist varchar(8000), @subissql int, @tablenickname int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetupnosyncsubwithlsnatdist(@article sysname, @destination_db sysname, @lsnsource tinyint, @next_valid_lsn binary(10), @nosync_setup_script nvarchar(max), @originator_db_version int, @originator_meta_data nvarchar(max), @originator_publication_id int, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriptionlsn binary(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetupnosyncsubwithlsnatdist_cleanup(@article sysname, @artid int, @destination_db sysname, @next_valid_lsn binary(10), @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsetupnosyncsubwithlsnatdist_helper(@article sysname, @artid int, @destination_db sysname, @lsnsource int, @next_valid_lsn binary(10), @nosync_setup_script nvarchar(max), @pubid int, @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_db_version int, @script_txt nvarchar(max), @subscriber sysname, @subscriptionlsn binary(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSstartdistribution_agent(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSstartmerge_agent(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSstartsnapshot_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSstopdistribution_agent(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSstopmerge_agent(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSstopsnapshot_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsub_check_identity(@lower_bound_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsub_set_identity(@next_seed bigint, @objid int, @range bigint, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsubscription_status(@agent_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSsubscriptionvalidated(@log_attempt bit, @pubid uniqueidentifier, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MStablechecks(@flags int, @tablename nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MStablekeys(@colname nvarchar(258), @flags int, @keyname nvarchar(517), @tablename nvarchar(776), @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MStablerefs(@direction nvarchar(20), @flags int, @reftable nvarchar(517), @tablename nvarchar(517), @type nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MStablespace(@id int, @name nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MStestbit(@bm varbinary(128), @coltotest smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MStran_ddlrepl(@EventData xml, @procmapid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MStran_is_snapshot_required(@last_xact_seqno varbinary(16), @publication sysname, @publisher sysname, @publisher_db sysname, @run_at_distributor bit, @subid varbinary(16), @subscriber sysname, @subscriber_db sysname, @subscription_guid varbinary(16), @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MStrypurgingoldsnapshotdeliveryprogress() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSuniquename(@seed nvarchar(128), @start int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSunmarkifneeded(@object sysname, @pre_command int, @pubid uniqueidentifier, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSunmarkreplinfo(@object sysname, @owner sysname, @type smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSunmarkschemaobject(@object sysname, @owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSunregistersubscription(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdate_agenttype_default(@profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdate_singlelogicalrecordmetadata(@logical_record_parent_nickname int, @logical_record_parent_rowguid uniqueidentifier, @parent_row_inserted bit, @replnick binary(6)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdate_subscriber_info(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @commit_batch_size int, @description nvarchar(255), @flush_frequency int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @login sysname, @password nvarchar(524), @publisher sysname, @retryattempts int, @retrydelay int, @security_mode int, @status_batch_size int, @subscriber sysname, @type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdate_subscriber_schedule(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @agent_type tinyint, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdate_subscriber_tracer_history(@agent_id int, @parent_tracer_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdate_subscription(@article_id int, @destination_db sysname, @publisher sysname, @publisher_db sysname, @status int, @subscriber sysname, @subscription_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdate_tracer_history(@tracer_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdatecachedpeerlsn(@agent_id int, @originator sysname, @originator_db sysname, @originator_db_version int, @originator_lsn varbinary(16), @originator_publication_id int, @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdategenerations_afterbcp(@pubid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdategenhistory(@art_nick int, @gen bigint, @guidsrc uniqueidentifier, @is_ssce_empty_sync int, @partition_id int, @pubid uniqueidentifier, @publication_number smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdateinitiallightweightsubscription(@allow_subscription_copy bit, @allow_synctoalternate bit, @automatic_reinitialization_policy bit, @conflict_logging int, @pubid uniqueidentifier, @publication_name sysname, @publisher sysname, @publisher_db sysname, @replicate_ddl int, @retention int, @status int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdatelastsyncinfo(@last_sync_status int, @last_sync_summary sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdatepeerlsn(@originator sysname, @originator_db sysname, @originator_db_version int, @originator_lsn varbinary(10), @originator_publication_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdaterecgen(@altrecgen bigint, @altrecguid uniqueidentifier, @altrepid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdatereplicastate(@pubid uniqueidentifier, @replicastate uniqueidentifier, @subid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSupdatesysmergearticles(@artid uniqueidentifier, @object sysname, @owner sysname, @pubid uniqueidentifier, @recreate_repl_view bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSuplineageversion(@rowguid uniqueidentifier, @tablenick int, @version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSuploadsupportabilitydata(@compatlevel int, @db_name sysname, @file_name nvarchar(2000), @log_file varbinary(max), @log_file_type int, @publication sysname, @publisher sysname, @publisher_db sysname, @server_name sysname, @web_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSuselightweightreplication(@lightweight int, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSvalidate_dest_recgen(@pubid uniqueidentifier, @recgen bigint, @recguid uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSvalidate_subscription(@artid int, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSvalidate_wellpartitioned_articles(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSvalidatearticle(@artid uniqueidentifier, @expected_checksum numeric(18), @expected_rowcount bigint, @full_or_fast tinyint, @pubid uniqueidentifier, @validation_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_MSwritemergeperfcounter(@agent_id int, @counter_desc nvarchar(100), @counter_value int, @thread_num int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_OACreate() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_OADestroy() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_OAGetErrorInfo() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_OAGetProperty() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_OAMethod() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_OASetProperty() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_OAStop() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_ORbitmap(@inputbitmap1 varbinary(128), @inputbitmap2 varbinary(128), @resultbitmap3 varbinary(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_PostAgentInfo() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_SetAutoSAPasswordAndDisable() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_SetOBDCertificate() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_agent_parameter(@parameter_name sysname, @parameter_value nvarchar(255), @profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_agent_profile(@agent_type int, @default bit, @description nvarchar(3000), @profile_id int, @profile_name sysname, @profile_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_data_file_recover_suspect_db(@dbName sysname, @filegroup nvarchar(260), @filegrowth nvarchar(20), @filename nvarchar(260), @maxsize nvarchar(20), @name nvarchar(260), @size nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_log_file_recover_suspect_db(@dbName sysname, @filegrowth nvarchar(20), @filename nvarchar(260), @maxsize nvarchar(20), @name nvarchar(260), @size nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_log_shipping_alert_job(@alert_job_id uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_log_shipping_primary_database(@backup_compression tinyint, @backup_directory nvarchar(500), @backup_job_id uniqueidentifier, @backup_job_name sysname, @backup_retention_period int, @backup_share nvarchar(500), @backup_threshold int, @database sysname, @history_retention_period int, @ignoreremotemonitor bit, @monitor_server sysname, @monitor_server_login sysname, @monitor_server_password sysname, @monitor_server_security_mode bit, @overwrite bit, @primary_id uniqueidentifier, @threshold_alert int, @threshold_alert_enabled bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_log_shipping_primary_secondary(@overwrite bit, @primary_database sysname, @secondary_database sysname, @secondary_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_log_shipping_secondary_database(@block_size int, @buffer_count int, @disconnect_users bit, @history_retention_period int, @ignoreremotemonitor bit, @max_transfer_size int, @overwrite bit, @primary_database sysname, @primary_server sysname, @restore_all bit, @restore_delay int, @restore_mode bit, @restore_threshold int, @secondary_database sysname, @threshold_alert int, @threshold_alert_enabled bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_add_log_shipping_secondary_primary(@backup_destination_directory nvarchar(500), @backup_source_directory nvarchar(500), @copy_job_id uniqueidentifier, @copy_job_name sysname, @file_retention_period int, @ignoreremotemonitor bit, @monitor_server sysname, @monitor_server_login sysname, @monitor_server_password sysname, @monitor_server_security_mode bit, @overwrite bit, @primary_database sysname, @primary_server sysname, @restore_job_id uniqueidentifier, @restore_job_name sysname, @secondary_id uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addapprole(@password sysname, @rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addarticle(@article sysname, @artid int, @auto_identity_range nvarchar(5), @creation_script nvarchar(255), @del_cmd nvarchar(255), @description nvarchar(255), @destination_owner sysname, @destination_table sysname, @filter nvarchar(386), @filter_clause ntext, @filter_owner sysname, @fire_triggers_on_snapshot nvarchar(5), @force_invalidate_snapshot bit, @identity_range bigint, @identityrangemanagementoption nvarchar(10), @ins_cmd nvarchar(255), @pre_creation_cmd nvarchar(10), @pub_identity_range bigint, @publication sysname, @publisher sysname, @schema_option varbinary(8), @source_object sysname, @source_owner sysname, @source_table nvarchar(386), @status tinyint, @sync_object nvarchar(386), @sync_object_owner sysname, @threshold int, @type sysname, @upd_cmd nvarchar(255), @use_default_datatypes bit, @vertical_partition nchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_adddatatype(@createparams int, @dbms sysname, @type sysname, @version sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_adddatatypemapping(@dataloss bit, @destination_createparams int, @destination_dbms sysname, @destination_length bigint, @destination_nullable bit, @destination_precision bigint, @destination_scale int, @destination_type sysname, @destination_version varchar(10), @is_default bit, @source_dbms sysname, @source_length_max bigint, @source_length_min bigint, @source_nullable bit, @source_precision_max bigint, @source_precision_min bigint, @source_scale_max int, @source_scale_min int, @source_type sysname, @source_version varchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_adddistpublisher(@distribution_db sysname, @encrypted_password bit, @login sysname, @password sysname, @publisher sysname, @publisher_type sysname, @security_mode int, @thirdparty_flag bit, @trusted nvarchar(5), @working_directory nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_adddistributiondb(@createmode int, @data_file nvarchar(255), @data_file_size int, @data_folder nvarchar(255), @database sysname, @from_scripting bit, @history_retention int, @log_file nvarchar(255), @log_file_size int, @log_folder nvarchar(255), @login sysname, @max_distretention int, @min_distretention int, @password sysname, @security_mode int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_adddistributor(@distributor sysname, @from_scripting bit, @heartbeat_interval int, @password sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_adddynamicsnapshot_job(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @dynamic_snapshot_jobid uniqueidentifier, @dynamic_snapshot_jobname sysname, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @host_name sysname, @publication sysname, @suser_sname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addextendedproc(@dllname varchar(255), @functname nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addextendedproperty(@level0name sysname, @level0type varchar(128), @level1name sysname, @level1type varchar(128), @level2name sysname, @level2type varchar(128), @name sysname, @value sql_variant) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addlinkedserver(@catalog sysname, @datasrc nvarchar(4000), @location nvarchar(4000), @provider nvarchar(128), @provstr nvarchar(4000), @server sysname, @srvproduct nvarchar(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addlinkedsrvlogin(@locallogin sysname, @rmtpassword sysname, @rmtsrvname sysname, @rmtuser sysname, @useself varchar(8)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addlogin(@defdb sysname, @deflanguage sysname, @encryptopt varchar(20), @loginame sysname, @passwd sysname, @sid varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addlogreader_agent(@job_login nvarchar(257), @job_name sysname, @job_password sysname, @publisher sysname, @publisher_login sysname, @publisher_password sysname, @publisher_security_mode smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergealternatepublisher(@alternate_distributor sysname, @alternate_publication sysname, @alternate_publisher sysname, @alternate_publisher_db sysname, @friendly_name nvarchar(255), @publication sysname, @publisher sysname, @publisher_db sysname, @reserved nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergearticle(@allow_interactive_resolver nvarchar(5), @article sysname, @article_resolver nvarchar(255), @auto_identity_range nvarchar(5), @check_permissions int, @column_tracking nvarchar(10), @compensate_for_errors nvarchar(5), @creation_script nvarchar(255), @delete_tracking nvarchar(5), @description nvarchar(255), @destination_object sysname, @destination_owner sysname, @fast_multicol_updateproc nvarchar(5), @force_invalidate_snapshot bit, @force_reinit_subscription bit, @identity_range bigint, @identityrangemanagementoption nvarchar(10), @logical_record_level_conflict_detection nvarchar(5), @logical_record_level_conflict_resolution nvarchar(5), @partition_options tinyint, @pre_creation_cmd nvarchar(10), @processing_order int, @pub_identity_range bigint, @publication sysname, @published_in_tran_pub nvarchar(5), @resolver_info nvarchar(517), @schema_option varbinary(8), @source_object sysname, @source_owner sysname, @status nvarchar(10), @stream_blob_columns nvarchar(5), @subscriber_upload_options tinyint, @subset_filterclause nvarchar(1000), @threshold int, @type sysname, @verify_resolver_signature int, @vertical_partition nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergefilter(@article sysname, @filter_type tinyint, @filtername sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @join_articlename sysname, @join_filterclause nvarchar(1000), @join_unique_key int, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergelogsettings(@agent_xe varbinary(max), @agent_xe_ring_buffer varbinary(max), @custom_script nvarchar(2000), @delete_after_upload int, @log_file_name sysname, @log_file_path nvarchar(255), @log_file_size int, @log_modules int, @log_severity int, @message_pattern nvarchar(2000), @no_of_log_files int, @publication sysname, @sql_xe varbinary(max), @subscriber sysname, @subscriber_db sysname, @support_options int, @upload_interval int, @web_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergepartition(@host_name sysname, @publication sysname, @suser_sname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergepublication(@add_to_active_directory nvarchar(5), @allow_anonymous nvarchar(5), @allow_partition_realignment nvarchar(5), @allow_pull nvarchar(5), @allow_push nvarchar(5), @allow_subscriber_initiated_snapshot nvarchar(5), @allow_subscription_copy nvarchar(5), @allow_synctoalternate nvarchar(5), @allow_web_synchronization nvarchar(5), @alt_snapshot_folder nvarchar(255), @automatic_reinitialization_policy bit, @centralized_conflicts nvarchar(5), @compress_snapshot nvarchar(5), @conflict_logging nvarchar(15), @conflict_retention int, @description nvarchar(255), @dynamic_filters nvarchar(5), @enabled_for_internet nvarchar(5), @ftp_address sysname, @ftp_login sysname, @ftp_password sysname, @ftp_port int, @ftp_subdirectory nvarchar(255), @generation_leveling_threshold int, @keep_partition_changes nvarchar(5), @max_concurrent_dynamic_snapshots int, @max_concurrent_merge int, @post_snapshot_script nvarchar(255), @pre_snapshot_script nvarchar(255), @publication sysname, @publication_compatibility_level nvarchar(6), @replicate_ddl int, @retention int, @retention_period_unit nvarchar(10), @snapshot_in_defaultfolder nvarchar(5), @sync_mode nvarchar(10), @use_partition_groups nvarchar(5), @validate_subscriber_info nvarchar(500), @web_synchronization_url nvarchar(500)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergepullsubscription(@description nvarchar(255), @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber_type nvarchar(15), @subscription_priority real, @sync_type nvarchar(15)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergepullsubscription_agent(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @alt_snapshot_folder nvarchar(255), @distributor sysname, @distributor_login sysname, @distributor_password sysname, @distributor_security_mode int, @dynamic_snapshot_location nvarchar(260), @enabled_for_syncmgr nvarchar(5), @encrypted_password bit, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @ftp_address sysname, @ftp_login sysname, @ftp_password sysname, @ftp_port int, @hostname sysname, @internet_login sysname, @internet_password nvarchar(524), @internet_security_mode int, @internet_timeout int, @internet_url nvarchar(260), @job_login nvarchar(257), @job_name sysname, @job_password sysname, @merge_jobid binary(16), @name sysname, @offloadagent nvarchar(5), @offloadserver sysname, @optional_command_line nvarchar(255), @publication sysname, @publisher sysname, @publisher_db sysname, @publisher_encrypted_password bit, @publisher_login sysname, @publisher_password sysname, @publisher_security_mode int, @reserved nvarchar(100), @subscriber sysname, @subscriber_db sysname, @subscriber_login sysname, @subscriber_password sysname, @subscriber_security_mode int, @use_ftp nvarchar(5), @use_interactive_resolver nvarchar(5), @use_web_sync bit, @working_directory nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergepushsubscription_agent(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @enabled_for_syncmgr nvarchar(5), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @job_login nvarchar(257), @job_name sysname, @job_password sysname, @publication sysname, @publisher_login sysname, @publisher_password sysname, @publisher_security_mode smallint, @subscriber sysname, @subscriber_db sysname, @subscriber_login sysname, @subscriber_password sysname, @subscriber_security_mode smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmergesubscription(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @description nvarchar(255), @enabled_for_syncmgr nvarchar(5), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @hostname sysname, @merge_job_name sysname, @offloadagent bit, @offloadserver sysname, @optional_command_line nvarchar(4000), @publication sysname, @subscriber sysname, @subscriber_db sysname, @subscriber_type nvarchar(15), @subscription_priority real, @subscription_type nvarchar(15), @sync_type nvarchar(15), @use_interactive_resolver nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addmessage(@lang sysname, @msgnum int, @msgtext nvarchar(255), @replace varchar(7), @severity smallint, @with_log varchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addpublication(@add_to_active_directory nvarchar(10), @allow_anonymous nvarchar(5), @allow_dts nvarchar(5), @allow_initialize_from_backup nvarchar(5), @allow_partition_switch nvarchar(5), @allow_pull nvarchar(5), @allow_push nvarchar(5), @allow_queued_tran nvarchar(5), @allow_subscription_copy nvarchar(5), @allow_sync_tran nvarchar(5), @alt_snapshot_folder nvarchar(255), @autogen_sync_procs nvarchar(5), @centralized_conflicts nvarchar(5), @compress_snapshot nvarchar(5), @conflict_policy nvarchar(100), @conflict_retention int, @description nvarchar(255), @enabled_for_het_sub nvarchar(5), @enabled_for_internet nvarchar(5), @enabled_for_p2p nvarchar(5), @ftp_address sysname, @ftp_login sysname, @ftp_password sysname, @ftp_port int, @ftp_subdirectory nvarchar(255), @immediate_sync nvarchar(5), @independent_agent nvarchar(5), @logreader_job_name sysname, @p2p_conflictdetection nvarchar(5), @p2p_continue_onconflict nvarchar(5), @p2p_originator_id int, @post_snapshot_script nvarchar(255), @pre_snapshot_script nvarchar(255), @publication sysname, @publish_local_changes_only nvarchar(5), @publisher sysname, @qreader_job_name sysname, @queue_type nvarchar(10), @repl_freq nvarchar(10), @replicate_ddl int, @replicate_partition_switch nvarchar(5), @restricted nvarchar(10), @retention int, @snapshot_in_defaultfolder nvarchar(5), @status nvarchar(8), @sync_method nvarchar(40), @taskid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addpublication_snapshot(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @job_login nvarchar(257), @job_password sysname, @publication sysname, @publisher sysname, @publisher_login sysname, @publisher_password sysname, @publisher_security_mode int, @snapshot_job_name nvarchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addpullsubscription(@description nvarchar(100), @immediate_sync bit, @independent_agent nvarchar(5), @publication sysname, @publisher sysname, @publisher_db sysname, @subscription_type nvarchar(9), @update_mode nvarchar(30)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addpullsubscription_agent(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @alt_snapshot_folder nvarchar(255), @distribution_db sysname, @distribution_jobid binary(16), @distributor sysname, @distributor_login sysname, @distributor_password sysname, @distributor_security_mode int, @dts_package_location nvarchar(12), @dts_package_name sysname, @dts_package_password sysname, @enabled_for_syncmgr nvarchar(5), @encrypted_distributor_password bit, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @ftp_address sysname, @ftp_login sysname, @ftp_password sysname, @ftp_port int, @job_login nvarchar(257), @job_name sysname, @job_password sysname, @offloadagent nvarchar(5), @offloadserver sysname, @optional_command_line nvarchar(4000), @publication sysname, @publication_type tinyint, @publisher sysname, @publisher_db sysname, @reserved nvarchar(100), @subscriber sysname, @subscriber_db sysname, @subscriber_login sysname, @subscriber_password sysname, @subscriber_security_mode int, @use_ftp nvarchar(5), @working_directory nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addpushsubscription_agent(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @distribution_job_name sysname, @dts_package_location nvarchar(12), @dts_package_name sysname, @dts_package_password sysname, @enabled_for_syncmgr nvarchar(5), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @job_login nvarchar(257), @job_name sysname, @job_password sysname, @publication sysname, @publisher sysname, @subscriber sysname, @subscriber_catalog sysname, @subscriber_datasrc nvarchar(4000), @subscriber_db sysname, @subscriber_location nvarchar(4000), @subscriber_login sysname, @subscriber_password sysname, @subscriber_provider sysname, @subscriber_provider_string nvarchar(4000), @subscriber_security_mode smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addqreader_agent(@frompublisher bit, @job_login nvarchar(257), @job_name sysname, @job_password sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addqueued_artinfo(@article sysname, @artid int, @cft_table sysname, @columns binary(32), @dest_table sysname, @owner sysname, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addremotelogin(@loginame sysname, @remotename sysname, @remoteserver sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addrole(@ownername sysname, @rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addrolemember(@membername sysname, @rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addscriptexec(@publication sysname, @publisher sysname, @scriptfile nvarchar(4000), @skiperror bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addserver(@duplicate_ok varchar(13), @local varchar(10), @server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addsrvrolemember(@loginame sysname, @rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addsubscriber(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @commit_batch_size int, @description nvarchar(255), @encrypted_password bit, @flush_frequency int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @login sysname, @password nvarchar(524), @publisher sysname, @security_mode int, @status_batch_size int, @subscriber sysname, @type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addsubscriber_schedule(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @agent_type smallint, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addsubscription(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @article sysname, @backupdevicename nvarchar(1000), @backupdevicetype nvarchar(20), @destination_db sysname, @distribution_job_name sysname, @dts_package_location nvarchar(12), @dts_package_name sysname, @dts_package_password sysname, @enabled_for_syncmgr nvarchar(5), @fileidhint int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @loopback_detection nvarchar(5), @mediapassword sysname, @offloadagent bit, @offloadserver sysname, @optional_command_line nvarchar(4000), @password sysname, @publication sysname, @publisher sysname, @reserved nvarchar(10), @status sysname, @subscriber sysname, @subscriber_type tinyint, @subscription_type nvarchar(4), @subscriptionlsn binary(10), @subscriptionstreams tinyint, @sync_type nvarchar(255), @unload bit, @update_mode nvarchar(30)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addsynctriggers(@cftproc sysname, @del_proc sysname, @distributor sysname, @dump_cmds bit, @filter_clause nvarchar(4000), @identity_col sysname, @identity_support bit, @independent_agent bit, @ins_proc sysname, @primary_key_bitmap varbinary(4000), @proc_owner sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @pubversion int, @sub_table sysname, @sub_table_owner sysname, @ts_col sysname, @upd_proc sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addsynctriggerscore(@alter bit, @cftproc sysname, @del_proc sysname, @del_trig sysname, @dump_cmds bit, @filter_clause nvarchar(4000), @identity_col sysname, @identity_support bit, @independent_agent bit, @ins_proc sysname, @ins_trig sysname, @primary_key_bitmap varbinary(4000), @proc_owner sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @pubversion int, @sub_table sysname, @sub_table_owner sysname, @ts_col sysname, @upd_proc sysname, @upd_trig sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addtabletocontents(@filter_clause nvarchar(4000), @owner_name sysname, @table_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addtype(@nulltype varchar(8), @owner sysname, @phystype sysname, @typename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_addumpdevice(@cntrltype smallint, @devstatus varchar(40), @devtype varchar(20), @logicalname sysname, @physicalname nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_adduser(@grpname sysname, @loginame sysname, @name_in_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_adjustpublisheridentityrange(@publication sysname, @table_name sysname, @table_owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_altermessage(@message_id int, @parameter sysname, @parameter_value varchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_approlepassword(@newpwd sysname, @rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_article_validation(@article sysname, @full_or_fast tinyint, @publication sysname, @publisher sysname, @reserved int, @rowcount_only smallint, @shutdown_agent bit, @subscription_level bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_articlecolumn(@article sysname, @change_active int, @column sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @ignore_distributor bit, @internal bit, @operation nvarchar(5), @publication sysname, @publisher sysname, @refresh_synctran_procs bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_articlefilter(@article sysname, @filter_clause ntext, @filter_name nvarchar(517), @force_invalidate_snapshot bit, @force_reinit_subscription bit, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_articleview(@article sysname, @change_active int, @filter_clause ntext, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @internal bit, @publication sysname, @publisher sysname, @refreshsynctranprocs bit, @view_name nvarchar(386)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_assemblies_rowset(@assembly_id int, @assembly_name sysname, @assembly_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_assemblies_rowset2(@assembly_id int, @assembly_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_assemblies_rowset_rmt(@assembly_id int, @assembly_name sysname, @assembly_schema sysname, @catalog_name sysname, @server_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_assembly_dependencies_rowset(@assembly_id int, @assembly_referenced int, @assembly_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_assembly_dependencies_rowset2(@assembly_referenced int, @assembly_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_assembly_dependencies_rowset_rmt(@assembly_id int, @assembly_referenced int, @assembly_schema sysname, @catalog sysname, @server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_attach_db(@dbname sysname, @filename1 nvarchar(260), @filename10 nvarchar(260), @filename11 nvarchar(260), @filename12 nvarchar(260), @filename13 nvarchar(260), @filename14 nvarchar(260), @filename15 nvarchar(260), @filename16 nvarchar(260), @filename2 nvarchar(260), @filename3 nvarchar(260), @filename4 nvarchar(260), @filename5 nvarchar(260), @filename6 nvarchar(260), @filename7 nvarchar(260), @filename8 nvarchar(260), @filename9 nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_attach_single_file_db(@dbname sysname, @physname nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_attachsubscription(@db_master_key_password nvarchar(524), @dbname sysname, @distributor_login sysname, @distributor_password sysname, @distributor_security_mode int, @filename nvarchar(260), @job_login nvarchar(257), @job_password sysname, @publisher_login sysname, @publisher_password sysname, @publisher_security_mode int, @subscriber_login sysname, @subscriber_password sysname, @subscriber_security_mode int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_audit_write() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_autostats(@flagc varchar(10), @indname sysname, @tblname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_availability_group_command_internal() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_bcp_dbcmptlevel(@dbname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_begin_parallel_nested_tran() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_bindefault(@defname nvarchar(776), @futureonly varchar(15), @objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_bindrule(@futureonly varchar(15), @objname nvarchar(776), @rulename nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_bindsession() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_browsemergesnapshotfolder(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_browsereplcmds(@agent_id int, @article_id int, @command_id int, @compatibility_level int, @originator_id int, @publisher_database_id int, @xact_seqno_end nchar(22), @xact_seqno_start nchar(22)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_browsesnapshotfolder(@publication sysname, @publisher sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_can_tlog_be_applied(@backup_file_name nvarchar(500), @database_name sysname, @result bit, @verbose bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_catalogs(@server_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_catalogs_rowset(@catalog_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_catalogs_rowset2() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_catalogs_rowset_rmt(@catalog_name sysname, @server_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_add_job(@check_for_logreader bit, @continuous bit, @job_type nvarchar(20), @maxscans int, @maxtrans int, @pollinginterval bigint, @retention bigint, @start_job bit, @threshold bigint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_change_job(@continuous bit, @job_type nvarchar(20), @maxscans int, @maxtrans int, @pollinginterval bigint, @retention bigint, @threshold bigint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_cleanup_change_table(@capture_instance sysname, @low_water_mark binary(10), @threshold bigint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_dbsnapshotLSN(@db_snapshot sysname, @lastLSN binary(10), @lastLSNstr varchar(40)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_disable_db() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_disable_table(@capture_instance sysname, @source_name sysname, @source_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_drop_job(@job_type nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_enable_db() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_enable_table(@allow_partition_switch bit, @capture_instance sysname, @captured_column_list nvarchar(max), @filegroup_name sysname, @index_name sysname, @role_name sysname, @source_name sysname, @source_schema sysname, @supports_net_changes bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_generate_wrapper_function(@capture_instance sysname, @closed_high_end_point bit, @column_list nvarchar(max), @update_flag_list nvarchar(max)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_get_captured_columns(@capture_instance sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_get_ddl_history(@capture_instance sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_help_change_data_capture(@source_name sysname, @source_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_help_jobs() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_restoredb(@db_orig sysname, @keep_cdc int, @srv_orig sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_scan(@continuous tinyint, @is_from_job int, @maxscans int, @maxtrans int, @pollinginterval bigint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_start_job(@job_type nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_stop_job(@job_type nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_vupgrade() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cdc_vupgrade_databases() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_certify_removable(@autofix nvarchar(4), @dbname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_change_agent_parameter(@parameter_name sysname, @parameter_value nvarchar(255), @profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_change_agent_profile(@profile_id int, @property sysname, @value nvarchar(3000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_change_log_shipping_primary_database(@backup_compression tinyint, @backup_directory nvarchar(500), @backup_retention_period int, @backup_share nvarchar(500), @backup_threshold int, @database sysname, @history_retention_period int, @ignoreremotemonitor bit, @monitor_server_login sysname, @monitor_server_password sysname, @monitor_server_security_mode bit, @threshold_alert int, @threshold_alert_enabled bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_change_log_shipping_secondary_database(@block_size int, @buffer_count int, @disconnect_users bit, @history_retention_period int, @ignoreremotemonitor bit, @max_transfer_size int, @restore_all bit, @restore_delay int, @restore_mode bit, @restore_threshold int, @secondary_database sysname, @threshold_alert int, @threshold_alert_enabled bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_change_log_shipping_secondary_primary(@backup_destination_directory nvarchar(500), @backup_source_directory nvarchar(500), @file_retention_period int, @monitor_server_login sysname, @monitor_server_password sysname, @monitor_server_security_mode bit, @primary_database sysname, @primary_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_change_subscription_properties(@property sysname, @publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @value nvarchar(1000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_change_tracking_waitforchanges() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_change_users_login(@Action varchar(10), @LoginName sysname, @Password sysname, @UserNamePattern sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changearticle(@article sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @property nvarchar(100), @publication sysname, @publisher sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changearticlecolumndatatype(@article sysname, @column sysname, @length bigint, @mapping_id int, @precision bigint, @publication sysname, @publisher sysname, @scale bigint, @type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changedbowner(@loginame sysname, @map varchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changedistpublisher(@property sysname, @publisher sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changedistributiondb(@database sysname, @property sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changedistributor_password(@password sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changedistributor_property(@property sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changedynamicsnapshot_job(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @dynamic_snapshot_jobid uniqueidentifier, @dynamic_snapshot_jobname sysname, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @job_login nvarchar(257), @job_password sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changelogreader_agent(@job_login nvarchar(257), @job_password sysname, @publisher sysname, @publisher_login sysname, @publisher_password sysname, @publisher_security_mode smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changemergearticle(@article sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @property sysname, @publication sysname, @value nvarchar(2000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changemergefilter(@article sysname, @filtername sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @property sysname, @publication sysname, @value nvarchar(1000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changemergelogsettings(@agent_xe varbinary(max), @agent_xe_ring_buffer varbinary(max), @custom_script nvarchar(2000), @delete_after_upload int, @log_file_name sysname, @log_file_path nvarchar(255), @log_file_size int, @log_modules int, @log_severity int, @message_pattern nvarchar(2000), @no_of_log_files int, @publication sysname, @sql_xe varbinary(max), @subscriber sysname, @subscriber_db sysname, @support_options int, @upload_interval int, @web_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changemergepublication(@force_invalidate_snapshot bit, @force_reinit_subscription bit, @property sysname, @publication sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changemergepullsubscription(@property sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changemergesubscription(@force_reinit_subscription bit, @property sysname, @publication sysname, @subscriber sysname, @subscriber_db sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changeobjectowner(@newowner sysname, @objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changepublication(@force_invalidate_snapshot bit, @force_reinit_subscription bit, @property nvarchar(255), @publication sysname, @publisher sysname, @value nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changepublication_snapshot(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @job_login nvarchar(257), @job_password sysname, @publication sysname, @publisher sysname, @publisher_login sysname, @publisher_password sysname, @publisher_security_mode int, @snapshot_job_name nvarchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changeqreader_agent(@frompublisher bit, @job_login nvarchar(257), @job_password sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changereplicationserverpasswords(@login nvarchar(257), @login_type tinyint, @password sysname, @server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changesubscriber(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @commit_batch_size int, @description nvarchar(255), @flush_frequency int, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @login sysname, @password sysname, @publisher sysname, @security_mode int, @status_batch_size int, @subscriber sysname, @type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changesubscriber_schedule(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @agent_type smallint, @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changesubscription(@article sysname, @destination_db sysname, @property nvarchar(30), @publication sysname, @publisher sysname, @subscriber sysname, @value nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changesubscriptiondtsinfo(@dts_package_location nvarchar(12), @dts_package_name sysname, @dts_package_password sysname, @job_id varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_changesubstatus(@active_end_date int, @active_end_time_of_day int, @active_start_date int, @active_start_time_of_day int, @article sysname, @destination_db sysname, @distribution_job_name sysname, @distribution_jobid binary(16), @dts_package_location int, @dts_package_name sysname, @dts_package_password nvarchar(524), @frequency_interval int, @frequency_recurrence_factor int, @frequency_relative_interval int, @frequency_subday int, @frequency_subday_interval int, @frequency_type int, @from_auto_sync bit, @ignore_distributor bit, @ignore_distributor_failure bit, @offloadagent bit, @offloadserver sysname, @optional_command_line nvarchar(4000), @previous_status sysname, @publication sysname, @publisher sysname, @skipobjectactivation int, @status sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_checkOraclepackageversion(@packageversion nvarchar(256), @publisher sysname, @versionsmatch int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_constbytable_rowset(@constraint_name sysname, @constraint_schema sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_constbytable_rowset2(@constraint_name sysname, @constraint_schema sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_constraints_rowset(@constraint_name sysname, @constraint_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_constraints_rowset2(@constraint_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_dynamic_filters(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_for_sync_trigger(@fonpublisher bit, @tabid int, @trigger_op char(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_join_filter(@filtered_table nvarchar(400), @join_filterclause nvarchar(1000), @join_table nvarchar(400)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_log_shipping_monitor_alert() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_publication_access(@given_login sysname, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_removable(@autofix varchar(4)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_subset_filter(@dynamic_filters_function_list nvarchar(500), @filtered_table nvarchar(400), @has_dynamic_filters bit, @subset_filterclause nvarchar(1000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_check_sync_trigger(@owner sysname, @trigger_op char(10), @trigger_procid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_checkinvalidivarticle(@mode tinyint, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_clean_db_file_free_space(@cleaning_delay int, @dbname sysname, @fileid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_clean_db_free_space(@cleaning_delay int, @dbname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cleanmergelogfiles(@id int, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @web_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cleanup_log_shipping_history(@agent_id uniqueidentifier, @agent_type tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cleanupdbreplication() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_column_privileges(@column_name nvarchar(384), @table_name sysname, @table_owner sysname, @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_column_privileges_ex(@column_name sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_column_privileges_rowset(@column_name sysname, @grantee sysname, @grantor sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_column_privileges_rowset2(@column_name sysname, @grantee sysname, @grantor sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_column_privileges_rowset_rmt(@column_name sysname, @grantee sysname, @grantor sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns(@ODBCVer int, @column_name nvarchar(384), @table_name nvarchar(384), @table_owner nvarchar(384), @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_100(@NameScope int, @ODBCVer int, @column_name nvarchar(384), @fUsePattern bit, @table_name nvarchar(384), @table_owner nvarchar(384), @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_100_rowset(@column_name sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_100_rowset2(@column_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_90(@ODBCVer int, @column_name nvarchar(384), @fUsePattern bit, @table_name nvarchar(384), @table_owner nvarchar(384), @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_90_rowset(@column_name sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_90_rowset2(@column_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_90_rowset_rmt(@column_name sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_ex(@ODBCVer int, @column_name sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_ex_100(@ODBCVer int, @column_name sysname, @fUsePattern bit, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_ex_90(@ODBCVer int, @column_name sysname, @fUsePattern bit, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_managed(@Catalog sysname, @Column sysname, @Owner sysname, @SchemaType sysname, @Table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_rowset(@column_name sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_rowset2(@column_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_columns_rowset_rmt(@column_name sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_commit_parallel_nested_tran() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_configure(@configname varchar(35), @configvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_configure_peerconflictdetection(@action nvarchar(32), @conflict_retention int, @continue_onconflict nvarchar(5), @local nvarchar(5), @originator_id int, @publication sysname, @timeout int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_constr_col_usage_rowset(@column_name sysname, @constr_catalog sysname, @constr_name sysname, @constr_schema sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_constr_col_usage_rowset2(@column_name sysname, @constr_catalog sysname, @constr_name sysname, @constr_schema sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_control_dbmasterkey_password() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_control_plan_guide(@name sysname, @operation nvarchar(60)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_copymergesnapshot(@destination_folder nvarchar(255), @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_copysnapshot(@destination_folder nvarchar(255), @publication sysname, @publisher sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_copysubscription(@filename nvarchar(260), @overwrite_existing_file bit, @temp_dir nvarchar(260)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_create_plan_guide(@hints nvarchar(max), @module_or_batch nvarchar(max), @name sysname, @params nvarchar(max), @stmt nvarchar(max), @type nvarchar(60)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_create_plan_guide_from_handle(@name sysname, @plan_handle varbinary(64), @statement_start_offset int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_create_removable(@datalogical1 sysname, @datalogical10 sysname, @datalogical11 sysname, @datalogical12 sysname, @datalogical13 sysname, @datalogical14 sysname, @datalogical15 sysname, @datalogical16 sysname, @datalogical2 sysname, @datalogical3 sysname, @datalogical4 sysname, @datalogical5 sysname, @datalogical6 sysname, @datalogical7 sysname, @datalogical8 sysname, @datalogical9 sysname, @dataphysical1 nvarchar(260), @dataphysical10 nvarchar(260), @dataphysical11 nvarchar(260), @dataphysical12 nvarchar(260), @dataphysical13 nvarchar(260), @dataphysical14 nvarchar(260), @dataphysical15 nvarchar(260), @dataphysical16 nvarchar(260), @dataphysical2 nvarchar(260), @dataphysical3 nvarchar(260), @dataphysical4 nvarchar(260), @dataphysical5 nvarchar(260), @dataphysical6 nvarchar(260), @dataphysical7 nvarchar(260), @dataphysical8 nvarchar(260), @dataphysical9 nvarchar(260), @datasize1 int, @datasize10 int, @datasize11 int, @datasize12 int, @datasize13 int, @datasize14 int, @datasize15 int, @datasize16 int, @datasize2 int, @datasize3 int, @datasize4 int, @datasize5 int, @datasize6 int, @datasize7 int, @datasize8 int, @datasize9 int, @dbname sysname, @loglogical sysname, @logphysical nvarchar(260), @logsize int, @syslogical sysname, @sysphysical nvarchar(260), @syssize int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_createmergepalrole(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_createorphan() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_createstats(@fullscan char(9), @indexonly char(9), @norecompute char(12)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_createtranpalrole(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursor() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursor_list(@cursor_scope int) returns int as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursorclose() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursorexecute() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursorfetch() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursoropen() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursoroption() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursorprepare() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursorprepexec() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cursorunprepare() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_cycle_errorlog() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_databases() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_datatype_info(@ODBCVer tinyint, @data_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_datatype_info_100(@ODBCVer tinyint, @data_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_datatype_info_90(@ODBCVer tinyint, @data_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_db_ebcdic277_2(@dbname sysname, @status varchar(6)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_db_increased_partitions(@dbname sysname, @increased_partitions varchar(6)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_db_selective_xml_index(@dbname sysname, @selective_xml_index varchar(6)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_db_vardecimal_storage_format(@dbname sysname, @vardecimal_storage_format varchar(3)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbcmptlevel(@dbname sysname, @new_cmptlevel tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbfixedrolepermission(@rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitoraddmonitoring(@update_period int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitorchangealert(@alert_id int, @database_name sysname, @enabled bit, @threshold int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitorchangemonitoring(@parameter_id int, @value int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitordropalert(@alert_id int, @database_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitordropmonitoring() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitorhelpalert(@alert_id int, @database_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitorhelpmonitoring() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitorresults(@database_name sysname, @mode int, @update_table int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbmmonitorupdate(@database_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dbremove(@dbname sysname, @dropdev varchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_ddopen(@NameScope int, @ODBCVer int, @ccopt int, @fUsePattern bit, @handle int, @p1 nvarchar(774), @p2 nvarchar(774), @p3 nvarchar(774), @p4 nvarchar(774), @p5 nvarchar(774), @p6 nvarchar(774), @p7 int, @procname sysname, @rows int, @scrollopt int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_defaultdb(@defdb sysname, @loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_defaultlanguage(@language sysname, @loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_delete_http_namespace_reservation() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_delete_log_shipping_alert_job() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_delete_log_shipping_primary_database(@database sysname, @ignoreremotemonitor bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_delete_log_shipping_primary_secondary(@primary_database sysname, @secondary_database sysname, @secondary_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_delete_log_shipping_secondary_database(@ignoreremotemonitor bit, @secondary_database sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_delete_log_shipping_secondary_primary(@primary_database sysname, @primary_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_deletemergeconflictrow(@conflict_table sysname, @drop_table_if_empty varchar(10), @origin_datasource varchar(255), @rowguid uniqueidentifier, @source_object nvarchar(386)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_deletepeerrequesthistory(@cutoff_date datetime, @publication sysname, @request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_deletetracertokenhistory(@cutoff_date datetime, @publication sysname, @publisher sysname, @publisher_db sysname, @tracer_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_denylogin(@loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_depends(@objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_describe_cursor(@cursor_identity nvarchar(128), @cursor_source nvarchar(30)) returns int as
begin
-- missing source code
end
go

create or replace procedure sys.sp_describe_cursor_columns(@cursor_identity nvarchar(128), @cursor_source nvarchar(30)) returns int as
begin
-- missing source code
end
go

create or replace procedure sys.sp_describe_cursor_tables(@cursor_identity nvarchar(128), @cursor_source nvarchar(30)) returns int as
begin
-- missing source code
end
go

create or replace procedure sys.sp_describe_first_result_set() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_describe_undeclared_parameters() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_detach_db(@dbname sysname, @keepfulltextindexfile nvarchar(10), @skipchecks nvarchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_disableagentoffload(@agent_type sysname, @job_id varbinary(16), @offloadserver sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_distcounters() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_drop_agent_parameter(@parameter_name sysname, @profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_drop_agent_profile(@profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropalias(@loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropanonymousagent(@subid uniqueidentifier, @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropanonymoussubscription(@agent_id int, @type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropapprole(@rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droparticle(@article sysname, @force_invalidate_snapshot bit, @from_drop_publication bit, @ignore_distributor bit, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropdatatypemapping(@destination_dbms sysname, @destination_length bigint, @destination_nullable bit, @destination_precision bigint, @destination_scale int, @destination_type sysname, @destination_version sysname, @mapping_id int, @source_dbms sysname, @source_length_max bigint, @source_length_min bigint, @source_nullable bit, @source_precision_max bigint, @source_precision_min bigint, @source_scale_max int, @source_scale_min int, @source_type sysname, @source_version sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropdevice(@delfile varchar(7), @logicalname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropdistpublisher(@ignore_distributor bit, @no_checks bit, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropdistributiondb(@database sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropdistributor(@ignore_distributor bit, @no_checks bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropdynamicsnapshot_job(@dynamic_snapshot_jobid uniqueidentifier, @dynamic_snapshot_jobname sysname, @ignore_distributor bit, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropextendedproc(@functname nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropextendedproperty(@level0name sysname, @level0type varchar(128), @level1name sysname, @level1type varchar(128), @level2name sysname, @level2type varchar(128), @name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droplinkedsrvlogin(@locallogin sysname, @rmtsrvname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droplogin(@loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmergealternatepublisher(@alternate_publication sysname, @alternate_publisher sysname, @alternate_publisher_db sysname, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmergearticle(@article sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @ignore_distributor bit, @ignore_merge_metadata bit, @publication sysname, @reserved bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmergefilter(@article sysname, @filtername sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmergelogsettings(@publication sysname, @subscriber sysname, @subscriber_db sysname, @web_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmergepartition(@host_name sysname, @publication sysname, @suser_sname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmergepublication(@ignore_distributor bit, @ignore_merge_metadata bit, @publication sysname, @reserved bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmergepullsubscription(@publication sysname, @publisher sysname, @publisher_db sysname, @reserved bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmergesubscription(@ignore_distributor bit, @publication sysname, @reserved bit, @subscriber sysname, @subscriber_db sysname, @subscription_type nvarchar(15)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropmessage(@lang sysname, @msgnum int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droporphans() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droppublication(@from_backup bit, @ignore_distributor bit, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droppublisher(@publisher sysname, @type nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droppullsubscription(@from_backup bit, @publication sysname, @publisher sysname, @publisher_db sysname, @reserved bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropremotelogin(@loginame sysname, @remotename sysname, @remoteserver sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropreplsymmetrickey(@check_replication bit, @throw_error bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droprole(@rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droprolemember(@membername sysname, @rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropserver(@droplogins char(10), @server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropsrvrolemember(@loginame sysname, @rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropsubscriber(@ignore_distributor bit, @publisher sysname, @reserved nvarchar(50), @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropsubscription(@article sysname, @destination_db sysname, @ignore_distributor bit, @publication sysname, @publisher sysname, @reserved nvarchar(10), @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_droptype(@typename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dropuser(@name_in_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_dsninfo(@dsn varchar(128), @dso_type int, @infotype varchar(128), @login varchar(128), @password varchar(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enable_heterogeneous_subscription(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enable_sql_debug() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enableagentoffload(@agent_type sysname, @job_id varbinary(16), @offloadserver sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enum_oledb_providers() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enumcustomresolvers(@distributor sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enumdsn() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enumeratependingschemachanges(@publication sysname, @starting_schemaversion int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enumerrorlogs(@p1 int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enumfullsubscribers(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_enumoledbdatasources() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_estimate_data_compression_savings(@data_compression nvarchar(60), @index_id int, @object_name sysname, @partition_number int, @schema_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_estimated_rowsize_reduction_for_vardecimal(@table_name nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_execute() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_executesql() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_expired_subscription_cleanup(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_filestream_force_garbage_collection(@dbname sysname, @filename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_filestream_recalculate_container_size(@dbname sysname, @filename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_firstonly_bitmap(@inputbitmap1 varbinary(128), @inputbitmap2 varbinary(128), @resultbitmap3 varbinary(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fkeys(@fktable_name sysname, @fktable_owner sysname, @fktable_qualifier sysname, @pktable_name sysname, @pktable_owner sysname, @pktable_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_flush_commit_table(@cleanup_version bigint, @date_cleanedup datetime, @flush_ts bigint, @rowcount int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_flush_commit_table_on_demand(@numrows bigint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_foreign_keys_rowset(@foreignkey_tab_catalog sysname, @foreignkey_tab_name sysname, @foreignkey_tab_schema sysname, @pk_table_name sysname, @pk_table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_foreign_keys_rowset2(@foreignkey_tab_name sysname, @foreignkey_tab_schema sysname, @pk_table_catalog sysname, @pk_table_name sysname, @pk_table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_foreign_keys_rowset3(@foreignkey_tab_catalog sysname, @foreignkey_tab_schema sysname, @pk_table_catalog sysname, @pk_table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_foreign_keys_rowset_rmt(@foreignkey_tab_catalog sysname, @foreignkey_tab_name sysname, @foreignkey_tab_schema sysname, @pk_table_catalog sysname, @pk_table_name sysname, @pk_table_schema sysname, @server_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_foreignkeys(@fktab_catalog sysname, @fktab_name sysname, @fktab_schema sysname, @pktab_catalog sysname, @pktab_name sysname, @pktab_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_catalog(@action varchar(20), @ftcat sysname, @path nvarchar(101)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_column(@action varchar(20), @colname sysname, @language int, @tabname nvarchar(517), @type_colname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_database(@action varchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_getdata() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_keymappings() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_load_thesaurus_file(@lcid int, @loadOnlyIfNotLoaded bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_pendingchanges() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_recycle_crawl_log(@ftcat sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_semantic_register_language_statistics_db(@dbname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_semantic_unregister_language_statistics_db() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_service(@action nvarchar(100), @value sql_variant) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_fulltext_table(@action varchar(50), @ftcat sysname, @keyname sysname, @tabname nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_generate_agent_parameter(@profile_id int, @real_profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_generatefilters(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getProcessorUsage() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getVolumeFreeSpace(@database_name sysname, @file_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_get_Oracle_publisher_metadata(@database_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_get_distributor() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_get_job_status_mergesubscription_agent(@agent_name nvarchar(100), @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_get_mergepublishedarticleproperties(@source_object sysname, @source_owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_get_query_template() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_get_redirected_publisher(@bypass_publisher_validation bit, @original_publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getagentparameterlist(@agent_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getapplock(@DbPrincipal sysname, @LockMode varchar(32), @LockOwner varchar(32), @LockTimeout int, @Resource nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getbindtoken() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getdefaultdatatypemapping(@dataloss bit, @destination_dbms sysname, @destination_length bigint, @destination_nullable bit, @destination_precision int, @destination_scale int, @destination_type sysname, @destination_version varchar(10), @source_dbms sysname, @source_length bigint, @source_nullable bit, @source_precision int, @source_scale int, @source_type sysname, @source_version varchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getmergedeletetype(@delete_type int, @rowguid uniqueidentifier, @source_object nvarchar(386)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getpublisherlink(@connect_string nvarchar(300), @islocalpublisher bit, @trigger_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getqueuedarticlesynctraninfo(@artid int, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getqueuedrows(@owner sysname, @tablename sysname, @tranid nvarchar(70)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getschemalock() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getsqlqueueversion(@publication sysname, @publisher sysname, @publisher_db sysname, @version int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getsubscription_status_hsnapshot(@article sysname, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_getsubscriptiondtspackagename(@publication sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_gettopologyinfo(@request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_grant_publication_access(@login sysname, @publication sysname, @publisher sysname, @reserved nvarchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_grantdbaccess(@loginame sysname, @name_in_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_grantlogin(@loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help(@objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_agent_default(@agent_type int, @profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_agent_parameter(@profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_agent_profile(@agent_type int, @profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_datatype_mapping(@dbms_name sysname, @dbms_version sysname, @source_prec int, @sql_type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_fulltext_catalog_components() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_fulltext_catalogs(@fulltext_catalog_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_fulltext_catalogs_cursor(@fulltext_catalog_name sysname) returns int as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_fulltext_columns(@column_name sysname, @table_name nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_fulltext_columns_cursor(@column_name sysname, @table_name nvarchar(517)) returns int as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_fulltext_system_components(@component_type sysname, @param sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_fulltext_tables(@fulltext_catalog_name sysname, @table_name nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_fulltext_tables_cursor(@fulltext_catalog_name sysname, @table_name nvarchar(517)) returns int as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_log_shipping_alert_job() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_log_shipping_monitor(@verbose bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_log_shipping_monitor_primary(@primary_database sysname, @primary_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_log_shipping_monitor_secondary(@secondary_database sysname, @secondary_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_log_shipping_primary_database(@database sysname, @primary_id uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_log_shipping_primary_secondary(@primary_database sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_log_shipping_secondary_database(@secondary_database sysname, @secondary_id uniqueidentifier) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_log_shipping_secondary_primary(@primary_database sysname, @primary_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_peerconflictdetection(@publication sysname, @timeout int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_publication_access(@initial_list bit, @login sysname, @publication sysname, @publisher sysname, @return_granted bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_spatial_geography_histogram(@colname sysname, @resolution int, @sample float, @tabname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_spatial_geography_index(@indexname sysname, @query_sample geography, @tabname nvarchar(776), @verboseoutput tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_spatial_geography_index_xml(@indexname sysname, @query_sample geography, @tabname nvarchar(776), @verboseoutput tinyint, @xml_output xml) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_spatial_geometry_histogram(@colname sysname, @resolution int, @sample float, @tabname sysname, @xmax float, @xmin float, @ymax float, @ymin float) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_spatial_geometry_index(@indexname sysname, @query_sample geometry, @tabname nvarchar(776), @verboseoutput tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_help_spatial_geometry_index_xml(@indexname sysname, @query_sample geometry, @tabname nvarchar(776), @verboseoutput tinyint, @xml_output xml) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpallowmerge_publication() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helparticle(@article sysname, @found int, @publication sysname, @publisher sysname, @returnfilter bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helparticlecolumns(@article sysname, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helparticledts(@article sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpconstraint(@nomsg varchar(5), @objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdatatypemap(@defaults_only bit, @destination_dbms sysname, @destination_type sysname, @destination_version varchar(10), @source_dbms sysname, @source_type sysname, @source_version varchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdb(@dbname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdbfixedrole(@rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdevice(@devname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdistpublisher(@check_user bit, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdistributiondb(@database sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdistributor(@account nvarchar(255), @directory nvarchar(255), @distrib_cleanupagent nvarchar(100), @distribdb sysname, @distributor sysname, @history_cleanupagent nvarchar(100), @history_retention int, @local nvarchar(5), @max_distretention int, @min_distretention int, @publisher sysname, @publisher_type sysname, @rpcsrvname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdistributor_properties() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpdynamicsnapshot_job(@dynamic_snapshot_jobid uniqueidentifier, @dynamic_snapshot_jobname sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpextendedproc(@funcname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpfile(@filename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpfilegroup(@filegroupname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpindex(@objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helplanguage(@language sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helplinkedsrvlogin(@locallogin sysname, @rmtsrvname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helplogins(@LoginNamePattern sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helplogreader_agent(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergealternatepublisher(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergearticle(@article sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergearticlecolumn(@article sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergearticleconflicts(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergeconflictrows(@conflict_table sysname, @logical_record_conflicts int, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergedeleteconflictrows(@logical_record_conflicts int, @publication sysname, @publisher sysname, @publisher_db sysname, @source_object nvarchar(386)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergefilter(@article sysname, @filter_type_bm binary(1), @filtername sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergelogfiles(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @web_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergelogfileswithdata(@id int, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @web_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergelogsettings(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergepartition(@host_name sysname, @publication sysname, @suser_sname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergepublication(@found int, @publication sysname, @publication_id uniqueidentifier, @publisher sysname, @publisher_db sysname, @reserved nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergepullsubscription(@publication sysname, @publisher sysname, @publisher_db sysname, @subscription_type nvarchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpmergesubscription(@found int, @publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @subscription_type nvarchar(15)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpntgroup(@ntname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helppeerrequests(@description nvarchar(4000), @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helppeerresponses(@request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helppublication(@found int, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helppublication_snapshot(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helppublicationsync(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helppullsubscription(@publication sysname, @publisher sysname, @publisher_db sysname, @show_push nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpqreader_agent(@frompublisher bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpremotelogin(@remotename sysname, @remoteserver sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpreplfailovermode(@failover_mode nvarchar(10), @failover_mode_id tinyint, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpreplicationdb(@dbname sysname, @type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpreplicationdboption(@dbname sysname, @reserved bit, @type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpreplicationoption(@optname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helprole(@rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helprolemember(@rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helprotect(@grantorname sysname, @name nvarchar(776), @permissionarea varchar(10), @username sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpserver(@optname varchar(35), @server sysname, @show_topology varchar(1)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpsort() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpsrvrole(@srvrolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpsrvrolemember(@srvrolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpstats(@objname nvarchar(776), @results nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpsubscriberinfo(@publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpsubscription(@article sysname, @destination_db sysname, @found int, @publication sysname, @publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpsubscription_properties(@publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpsubscriptionerrors(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helptext(@columnname sysname, @objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helptracertokenhistory(@publication sysname, @publisher sysname, @publisher_db sysname, @tracer_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helptracertokens(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helptrigger(@tabname nvarchar(776), @triggertype char(6)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpuser(@name_in_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_helpxactsetjob(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_http_generate_wsdl_complex() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_http_generate_wsdl_defaultcomplexorsimple(@EndpointID int, @Host nvarchar(256), @IsSSL bit, @QueryString nvarchar(256), @UserAgent nvarchar(256)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_http_generate_wsdl_defaultsimpleorcomplex(@EndpointID int, @Host nvarchar(256), @IsSSL bit, @QueryString nvarchar(256), @UserAgent nvarchar(256)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_http_generate_wsdl_simple() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_identitycolumnforreplication(@object_id int, @value bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexcolumns_managed(@Catalog sysname, @Column sysname, @ConstraintName sysname, @Owner sysname, @Table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes(@index_name sysname, @is_unique bit, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_100_rowset(@index_name sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_100_rowset2(@index_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_90_rowset(@index_name sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_90_rowset2(@index_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_90_rowset_rmt(@index_name sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_managed(@Catalog sysname, @Name sysname, @Owner sysname, @Table sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_rowset(@index_name sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_rowset2(@index_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexes_rowset_rmt(@index_name sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_indexoption(@IndexNamePattern nvarchar(1035), @OptionName varchar(35), @OptionValue varchar(12)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_invalidate_textptr(@TextPtrValue varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_is_makegeneration_needed(@needed int, @wait int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_ivindexhasnullcols(@fhasnullcols bit, @viewname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_kill_filestream_non_transacted_handles(@handle_id int, @table_name nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_lightweightmergemetadataretentioncleanup(@num_rowtrack_rows int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_link_publication(@distributor sysname, @login sysname, @password sysname, @publication sysname, @publisher sysname, @publisher_db sysname, @security_mode int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_linkedservers() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_linkedservers_rowset(@srvname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_linkedservers_rowset2() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_lock(@spid1 int, @spid2 int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_logshippinginstallmetadata() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_lookupcustomresolver(@article_resolver nvarchar(255), @dotnet_assembly_name nvarchar(255), @dotnet_class_name nvarchar(255), @is_dotnet_assembly bit, @publisher sysname, @resolver_clsid nvarchar(50)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_mapdown_bitmap(@bm varbinary(128), @mapdownbm varbinary(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_markpendingschemachange(@publication sysname, @schemaversion int, @status nvarchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_marksubscriptionvalidation(@destination_db sysname, @publication sysname, @publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_mergearticlecolumn(@article sysname, @column sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @operation nvarchar(4), @publication sysname, @schema_replication nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_mergecleanupmetadata(@publication sysname, @reinitialize_subscriber nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_mergedummyupdate(@rowguid uniqueidentifier, @source_object nvarchar(386)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_mergemetadataretentioncleanup(@aggressive_cleanup_only bit, @num_contents_rows int, @num_genhistory_rows int, @num_tombstone_rows int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_mergesubscription_cleanup(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_mergesubscriptionsummary(@publication sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_migrate_user_to_contained() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_monitor() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_new_parallel_nested_tran_id() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_objectfilegroup(@objid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_oledb_database() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_oledb_defdb() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_oledb_deflang() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_oledb_language() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_oledb_ro_usrname() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_oledbinfo(@infotype nvarchar(128), @login nvarchar(128), @password nvarchar(128), @server nvarchar(128)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_password(@loginame sysname, @new sysname, @old sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_peerconflictdetection_tableaug(@artlist nvarchar(max), @enabling bit, @originator_id int, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_pkeys(@table_name sysname, @table_owner sysname, @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_posttracertoken(@publication sysname, @publisher sysname, @tracer_token_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_prepare() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_prepexec() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_prepexecrpc() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_primary_keys_rowset(@table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_primary_keys_rowset2(@table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_primary_keys_rowset_rmt(@table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_primarykeys(@table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedure_params_100_managed(@group_number int, @parameter_name sysname, @procedure_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedure_params_100_rowset(@group_number int, @parameter_name sysname, @procedure_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedure_params_100_rowset2(@parameter_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedure_params_90_rowset(@group_number int, @parameter_name sysname, @procedure_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedure_params_90_rowset2(@parameter_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedure_params_managed(@group_number int, @parameter_name sysname, @procedure_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedure_params_rowset(@group_number int, @parameter_name sysname, @procedure_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedure_params_rowset2(@parameter_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedures_rowset(@group_number int, @procedure_name sysname, @procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procedures_rowset2(@procedure_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_processlogshippingmonitorhistory(@agent_id uniqueidentifier, @agent_type tinyint, @database sysname, @log_time datetime, @log_time_utc datetime, @message nvarchar(4000), @mode tinyint, @monitor_server sysname, @monitor_server_security_mode bit, @session_id int, @session_status tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_processlogshippingmonitorprimary(@backup_threshold int, @history_retention_period int, @last_backup_date datetime, @last_backup_date_utc datetime, @last_backup_file nvarchar(500), @mode tinyint, @monitor_server sysname, @monitor_server_security_mode bit, @primary_database sysname, @primary_id uniqueidentifier, @primary_server sysname, @threshold_alert int, @threshold_alert_enabled bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_processlogshippingmonitorsecondary(@history_retention_period int, @last_copied_date datetime, @last_copied_date_utc datetime, @last_copied_file nvarchar(500), @last_restored_date datetime, @last_restored_date_utc datetime, @last_restored_file nvarchar(500), @last_restored_latency int, @mode tinyint, @monitor_server sysname, @monitor_server_security_mode bit, @primary_database sysname, @primary_server sysname, @restore_threshold int, @secondary_database sysname, @secondary_id uniqueidentifier, @secondary_server sysname, @threshold_alert int, @threshold_alert_enabled bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_processlogshippingretentioncleanup(@agent_id uniqueidentifier, @agent_type tinyint, @curdate_utc datetime, @history_retention_period int, @monitor_server sysname, @monitor_server_security_mode bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_procoption(@OptionName varchar(35), @OptionValue varchar(12), @ProcName nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_prop_oledb_provider(@p1 nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_provider_types_100_rowset(@best_match tinyint, @data_type smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_provider_types_90_rowset(@best_match tinyint, @data_type smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_provider_types_rowset(@best_match tinyint, @data_type smallint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_publication_validation(@full_or_fast tinyint, @publication sysname, @publisher sysname, @rowcount_only smallint, @shutdown_agent bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_publicationsummary(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_publishdb(@dbname sysname, @value nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_publisherproperty(@propertyname sysname, @propertyvalue sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_readerrorlog(@p1 int, @p2 int, @p3 nvarchar(4000), @p4 nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_recompile(@objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_redirect_publisher(@original_publisher sysname, @publisher_db sysname, @redirected_publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_refresh_heterogeneous_publisher(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_refresh_log_shipping_monitor(@agent_id uniqueidentifier, @agent_type tinyint, @database sysname, @mode tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_refreshsqlmodule(@name nvarchar(776), @namespace nvarchar(20)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_refreshsubscriptions(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_refreshview(@viewname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_register_custom_scripting(@article sysname, @publication sysname, @type varchar(16), @value nvarchar(2048)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_registercustomresolver(@article_resolver nvarchar(255), @dotnet_assembly_name nvarchar(255), @dotnet_class_name nvarchar(255), @is_dotnet_assembly nvarchar(10), @resolver_clsid nvarchar(50)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_reinitmergepullsubscription(@publication sysname, @publisher sysname, @publisher_db sysname, @upload_first nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_reinitmergesubscription(@publication sysname, @subscriber sysname, @subscriber_db sysname, @upload_first nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_reinitpullsubscription(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_reinitsubscription(@article sysname, @destination_db sysname, @for_schema_change bit, @ignore_distributor_failure bit, @invalidate_snapshot bit, @publication sysname, @publisher sysname, @subscriber sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_releaseapplock(@DbPrincipal sysname, @LockOwner varchar(32), @Resource nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_releaseschemalock() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_remoteoption(@loginame sysname, @optname varchar(35), @optvalue varchar(10), @remotename sysname, @remoteserver sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_removedbreplication(@dbname sysname, @type nvarchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_removedistpublisherdbreplication(@publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_removesrvreplication() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_rename(@newname sysname, @objname nvarchar(1035), @objtype varchar(13)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_renamedb(@dbname sysname, @newname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_repl_generateevent() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_repladdcolumn(@column sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @from_agent int, @publication_to_add nvarchar(4000), @schema_change_script nvarchar(4000), @source_object nvarchar(358), @typetext nvarchar(3000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replcleanupccsprocs(@publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replcmds() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replcounters() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replddlparser() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_repldeletequeuedtran(@orderkeyhigh bigint, @orderkeylow bigint, @publication sysname, @publisher sysname, @publisher_db sysname, @tranid sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_repldone() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_repldropcolumn(@column sysname, @force_invalidate_snapshot bit, @force_reinit_subscription bit, @from_agent int, @schema_change_script nvarchar(4000), @source_object nvarchar(270)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replflush() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replgetparsedddlcmd(@FirstToken sysname, @dbname sysname, @ddlcmd nvarchar(max), @objectType sysname, @objname sysname, @owner sysname, @targetobject nvarchar(512)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replhelp() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replica(@replicated nvarchar(5), @tabname nvarchar(92)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replication_agent_checkup(@heartbeat_interval int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replicationdboption(@dbname sysname, @from_scripting bit, @ignore_distributor bit, @optname sysname, @value sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replincrementlsn(@publisher sysname, @xact_seqno binary(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorchangepublicationthreshold(@metric_id int, @mode tinyint, @publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @shouldalert bit, @thresholdmetricname sysname, @value int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorhelpmergesession(@agent_name nvarchar(100), @hours int, @publication sysname, @publisher sysname, @publisher_db sysname, @session_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorhelpmergesessiondetail(@session_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorhelpmergesubscriptionmoreinfo(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorhelppublication(@publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @refreshpolicy tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorhelppublicationthresholds(@publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @thresholdmetricname sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorhelppublisher(@publisher sysname, @refreshpolicy tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorhelpsubscription(@exclude_anonymous bit, @mode int, @publication sysname, @publication_type int, @publisher sysname, @publisher_db sysname, @refreshpolicy tinyint, @topnum int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorrefreshjob(@iterations tinyint, @profile bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replmonitorsubscriptionpendingcmds(@publication sysname, @publisher sysname, @publisher_db sysname, @subscriber sysname, @subscriber_db sysname, @subscription_type int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replpostsyncstatus(@artid int, @pubid int, @syncstat int, @xact_seqno binary(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replqueuemonitor(@publication sysname, @publisher sysname, @publisherdb sysname, @queuetype tinyint, @tranid sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replrestart() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replrethrow() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replsendtoqueue() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replsetoriginator(@originator_db sysname, @originator_srv sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replsetsyncstatus() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replshowcmds(@maxtrans int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replsqlqgetrows(@batchsize int, @publication sysname, @publisher sysname, @publisherdb sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replsync(@article sysname, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_repltrans() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_replwritetovarbin() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_requestpeerresponse(@description nvarchar(4000), @publication sysname, @request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_requestpeertopologyinfo(@publication sysname, @request_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_reserve_http_namespace() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_reset_connection() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resetsnapshotdeliveryprogress(@drop_table nvarchar(5), @verbose_level int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resetstatus(@DBName sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resign_database(@fn nvarchar(512), @keytype sysname, @pwd sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resolve_logins(@dest_db sysname, @dest_path nvarchar(255), @filename nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_restoredbreplication(@db_orig sysname, @keep_replication int, @perform_upgrade bit, @recoveryforklsn varbinary(16), @srv_orig sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_restoremergeidentityrange(@article sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resyncexecute() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resyncexecutesql() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resyncmergesubscription(@publication sysname, @publisher sysname, @publisher_db sysname, @resync_date_str nvarchar(30), @resync_type int, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resyncprepare() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_resyncuniquetable() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_revoke_publication_access(@login sysname, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_revokedbaccess(@name_in_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_revokelogin(@loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_rollback_parallel_nested_tran() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_schemafilter(@operation nvarchar(4), @publisher sysname, @schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_schemata_rowset(@schema_name sysname, @schema_owner sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_script_reconciliation_delproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_script_reconciliation_insproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_script_reconciliation_sinsproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_script_reconciliation_vdelproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_script_reconciliation_xdelproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_script_synctran_commands(@article sysname, @publication sysname, @trig_only bit, @usesqlclr bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptdelproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptdynamicupdproc(@artid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptinsproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptmappedupdproc(@artid int, @mode tinyint, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptpublicationcustomprocs(@publication sysname, @publisher sysname, @usesqlclr bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptsinsproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptsubconflicttable(@alter bit, @article sysname, @publication sysname, @usesqlclr bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptsupdproc(@artid int, @mode tinyint, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptupdproc(@artid int, @mode tinyint, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptvdelproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptvupdproc(@artid int, @mode tinyint, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptxdelproc(@artid int, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_scriptxupdproc(@artid int, @mode tinyint, @publisher sysname, @publishertype tinyint) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_sequence_get_range(@range_cycle_count int, @range_first_value sql_variant, @range_last_value sql_variant, @range_size bigint, @sequence_increment sql_variant, @sequence_max_value sql_variant, @sequence_min_value sql_variant, @sequence_name nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_server_diagnostics() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_server_info(@attribute_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_serveroption(@optname varchar(35), @optvalue nvarchar(128), @server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_setOraclepackageversion(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_setapprole(@cookie varbinary(8000), @encrypt varchar(10), @fCreateCookie bit, @password sysname, @rolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_setdefaultdatatypemapping(@destination_dbms sysname, @destination_length bigint, @destination_nullable bit, @destination_precision bigint, @destination_scale int, @destination_type sysname, @destination_version varchar(10), @mapping_id int, @source_dbms sysname, @source_length_max bigint, @source_length_min bigint, @source_nullable bit, @source_precision_max bigint, @source_precision_min bigint, @source_scale_max int, @source_scale_min int, @source_type sysname, @source_version varchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_setnetname(@netname sysname, @server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_setreplfailovermode(@failover_mode nvarchar(10), @override tinyint, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_setsubscriptionxactseqno(@publication sysname, @publisher sysname, @publisher_db sysname, @xact_seqno varbinary(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_settriggerorder(@namespace varchar(10), @order varchar(10), @stmttype varchar(50), @triggername nvarchar(517)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_setuserbylogin() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_showcolv(@colv varbinary(2953)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_showlineage(@lineage varbinary(311)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_showmemo_xml() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_showpendingchanges(@article sysname, @destination_server sysname, @publication sysname, @show_rows int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_showrowreplicainfo(@ownername sysname, @rowguid uniqueidentifier, @show nvarchar(20), @tablename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_spaceused(@objname nvarchar(776), @updateusage varchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_sparse_columns_100_rowset(@column_name sysname, @schema_type int, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_special_columns(@ODBCVer int, @col_type char, @nullable char, @scope char, @table_name sysname, @table_owner sysname, @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_special_columns_100(@ODBCVer int, @col_type char, @nullable char, @scope char, @table_name sysname, @table_owner sysname, @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_special_columns_90(@ODBCVer int, @col_type char, @nullable char, @scope char, @table_name sysname, @table_owner sysname, @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_sproc_columns(@ODBCVer int, @column_name nvarchar(384), @fUsePattern bit, @procedure_name nvarchar(390), @procedure_owner nvarchar(384), @procedure_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_sproc_columns_100(@ODBCVer int, @column_name nvarchar(384), @fUsePattern bit, @procedure_name nvarchar(390), @procedure_owner nvarchar(384), @procedure_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_sproc_columns_90(@ODBCVer int, @column_name nvarchar(384), @fUsePattern bit, @procedure_name nvarchar(390), @procedure_owner nvarchar(384), @procedure_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_sqlexec(@p1 text) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_srvrolepermission(@srvrolename sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_start_user_instance() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_startmergepullsubscription_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_startmergepushsubscription_agent(@publication sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_startpublication_snapshot(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_startpullsubscription_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_startpushsubscription_agent(@publication sysname, @publisher sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_statistics(@accuracy char, @index_name sysname, @is_unique char, @table_name sysname, @table_owner sysname, @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_statistics_100(@accuracy char, @index_name sysname, @is_unique char, @table_name sysname, @table_owner sysname, @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_statistics_rowset(@table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_statistics_rowset2(@table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_stopmergepullsubscription_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_stopmergepushsubscription_agent(@publication sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_stoppublication_snapshot(@publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_stoppullsubscription_agent(@publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_stoppushsubscription_agent(@publication sysname, @publisher sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_stored_procedures(@fUsePattern bit, @sp_name nvarchar(390), @sp_owner nvarchar(384), @sp_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_subscribe(@article sysname, @destination_db sysname, @loopback_detection nvarchar(5), @publication sysname, @sync_type nvarchar(15)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_subscription_cleanup(@from_backup bit, @publication sysname, @publisher sysname, @publisher_db sysname, @reserved nvarchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_subscriptionsummary(@publication sysname, @publisher sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_syspolicy_execute_policy(@event_data xml, @policy_name sysname, @synchronous bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_syspolicy_subscribe_to_policy_category(@policy_category sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_syspolicy_unsubscribe_from_policy_category(@policy_category sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_syspolicy_update_ddl_trigger() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_syspolicy_update_event_notification() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_constraints_rowset(@constraint_catalog sysname, @constraint_name sysname, @constraint_schema sysname, @constraint_type nvarchar(255), @table_catalog sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_constraints_rowset2(@constraint_catalog sysname, @constraint_name sysname, @constraint_schema sysname, @constraint_type nvarchar(255), @table_catalog sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_privileges(@fUsePattern bit, @table_name nvarchar(384), @table_owner nvarchar(384), @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_privileges_ex(@fUsePattern bit, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_privileges_rowset(@grantee sysname, @grantor sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_privileges_rowset2(@grantee sysname, @grantor sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_privileges_rowset_rmt(@grantee sysname, @grantor sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_statistics2_rowset(@stat_catalog sysname, @stat_name sysname, @stat_schema sysname, @table_catalog sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_statistics_rowset(@table_name_dummy sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_type_columns_100(@ODBCVer int, @column_name nvarchar(384), @fUsePattern bit, @table_name nvarchar(384), @table_owner nvarchar(384), @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_type_columns_100_rowset(@column_name sysname, @table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_type_pkeys(@table_name sysname, @table_owner sysname, @table_qualifier sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_type_primary_keys_rowset(@table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_types(@fUsePattern bit, @table_name nvarchar(384), @table_owner nvarchar(384), @table_qualifier sysname, @table_type varchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_types_rowset(@table_name sysname, @table_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_table_validation(@column_list nvarchar(max), @expected_checksum numeric(18), @expected_rowcount bigint, @full_or_fast tinyint, @owner sysname, @rowcount_only smallint, @shutdown_agent bit, @table sysname, @table_name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tablecollations(@object nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tablecollations_100(@object nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tablecollations_90(@object nvarchar(4000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tableoption(@OptionName varchar(35), @OptionValue varchar(12), @TableNamePattern nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables(@fUsePattern bit, @table_name nvarchar(384), @table_owner nvarchar(384), @table_qualifier sysname, @table_type varchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_ex(@fUsePattern bit, @table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname, @table_type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_info_90_rowset(@table_name sysname, @table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_info_90_rowset2(@table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_info_90_rowset2_64(@table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_info_90_rowset_64(@table_name sysname, @table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_info_rowset(@table_name sysname, @table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_info_rowset2(@table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_info_rowset2_64(@table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_info_rowset_64(@table_name sysname, @table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_rowset(@table_name sysname, @table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_rowset2(@table_schema sysname, @table_type nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tables_rowset_rmt(@table_catalog sysname, @table_name sysname, @table_schema sysname, @table_server sysname, @table_type sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_tableswc(@fTableCreated bit, @fUsePattern bit, @table_name nvarchar(384), @table_owner nvarchar(384), @table_qualifier sysname, @table_type varchar(100)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_testlinkedserver() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_trace_create() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_trace_generateevent() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_trace_getdata(@records int, @traceid int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_trace_setevent() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_trace_setfilter() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_trace_setstatus() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_unbindefault(@futureonly varchar(15), @objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_unbindrule(@futureonly varchar(15), @objname nvarchar(776)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_unprepare() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_unregister_custom_scripting(@article sysname, @publication sysname, @type varchar(16)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_unregistercustomresolver(@article_resolver nvarchar(255)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_unsetapprole(@cookie varbinary(8000)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_unsubscribe(@article sysname, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_update_agent_profile(@agent_id int, @agent_type int, @profile_id int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_update_user_instance() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_updateextendedproperty(@level0name sysname, @level0type varchar(128), @level1name sysname, @level1type varchar(128), @level2name sysname, @level2type varchar(128), @name sysname, @value sql_variant) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_updatestats(@resample char(8)) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_upgrade_log_shipping() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter1(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter10(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter2(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter3(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter4(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter5(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter6(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter7(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter8(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_user_counter9(@newvalue int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_usertypes_rowset(@type_name sysname, @type_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_usertypes_rowset2(@type_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_usertypes_rowset_rmt(@assembly_id int, @type_catalog sysname, @type_name sysname, @type_schema sysname, @type_server sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validate_redirected_publisher(@original_publisher sysname, @publisher_db sysname, @redirected_publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validate_replica_hosts_as_publishers(@original_publisher sysname, @publisher_db sysname, @redirected_publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validatecache(@article sysname, @publication sysname, @publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validatelogins() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validatemergepublication(@level tinyint, @publication sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validatemergepullsubscription(@level tinyint, @publication sysname, @publisher sysname, @publisher_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validatemergesubscription(@level tinyint, @publication sysname, @subscriber sysname, @subscriber_db sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validlang(@name sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_validname(@name sysname, @raise_error bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_verifypublisher(@publisher sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_views_rowset(@view_name sysname, @view_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_views_rowset2(@view_schema sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_vupgrade_mergeobjects(@login sysname, @password sysname, @security_mode bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_vupgrade_mergetables(@remove_repl bit) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_vupgrade_replication(@force_remove tinyint, @login sysname, @password sysname, @security_mode bit, @ver_old int) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_vupgrade_replsecurity_metadata() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_who(@loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_who2(@loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_xml_preparedocument() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_xml_removedocument() as
begin
-- missing source code
end
go

create or replace procedure sys.sp_xml_schema_rowset(@collection_name sysname, @schema_name sysname, @target_namespace sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_xml_schema_rowset2(@schema_name sysname, @target_namespace sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.sp_xp_cmdshell_proxy_account() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_availablemedia() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_cmdshell() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_create_subdir() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_delete_file() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_dirtree() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_enum_oledb_providers() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_enumerrorlogs() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_enumgroups() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_fileexist() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_fixeddrives() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_get_script() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_get_tape_devices() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_getnetname() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_grantlogin(@loginame sysname, @logintype varchar(5)) as
begin
-- missing source code
end
go

create or replace procedure sys.xp_instance_regaddmultistring() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_instance_regdeletekey() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_instance_regdeletevalue() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_instance_regenumkeys() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_instance_regenumvalues() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_instance_regread() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_instance_regremovemultistring() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_instance_regwrite() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_logevent() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_loginconfig() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_logininfo(@acctname sysname, @option varchar(10), @privilege varchar(10)) as
begin
-- missing source code
end
go

create or replace procedure sys.xp_msver() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_msx_enlist() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_passAgentInfo() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_prop_oledb_provider() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_qv() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_readerrorlog() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_regaddmultistring() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_regdeletekey() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_regdeletevalue() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_regenumkeys() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_regenumvalues() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_regread() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_regremovemultistring() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_regwrite() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_repl_convert_encrypt_sysadmin_wrapper(@password nvarchar(524)) as
begin
-- missing source code
end
go

create or replace procedure sys.xp_replposteor() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_revokelogin(@loginame sysname) as
begin
-- missing source code
end
go

create or replace procedure sys.xp_servicecontrol() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sprintf() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sqlagent_enum_jobs() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sqlagent_is_starting() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sqlagent_monitor() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sqlagent_notify() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sqlagent_param() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sqlmaint() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sscanf() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_subdirs() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sysmail_activate() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sysmail_attachment_load() as
begin
-- missing source code
end
go

create or replace procedure sys.xp_sysmail_format_query() as
begin
-- missing source code
end
go

create proc [dbo].[xxxxx]
as


declare @RegionLetter nvarchar(5)='tr-TR'

DECLARE @AirWayName nvarchar(max)
DECLARE @AirWayId uniqueidentifier 

declare AirWayCursor cursor for 
select AirWayName,AirWayId from AirWays 
open AirWayCursor

FETCH  NEXT FROM AirWayCursor INTO @AirWayName,@AirWayId
 WHILE @@FETCH_STATUS = 0  
 BEGIN 
 insert into [dbo].[SystemAccounts] ([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[CreationDate]) values(5,@AirWayName,0,@RegionLetter,getdate())

 Declare @LastAgencyScopeId  bigint

 set @LastAgencyScopeId=(Select SCOPE_IDENTITY())

 update AirWays set AccountId=@LastAgencyScopeId where AirWayId=@AirWayId

			declare @CurrencyId int
			declare @CurrencyName nvarchar(3)
			declare CurrencyCursor cursor for select CurrencyId,CurrencyName from Currencies
			open CurrencyCursor
			FETCH  NEXT FROM CurrencyCursor INTO @CurrencyId,@CurrencyName
			 WHILE @@FETCH_STATUS = 0  
			 BEGIN   

			  INSERT INTO  [dbo].[SystemAccounts] ([ParentAccountId],[AccountName],[CurrencyId],[RegionLetter],[AccountCode],[CreationDate]) 
			  VALUES(@LastAgencyScopeId,(@AirWayName +' '+@CurrencyName),@CurrencyId,@RegionLetter,'',getdate())
			

		     FETCH  NEXT FROM CurrencyCursor INTO @CurrencyId,@CurrencyName
			 END
			 CLOSE CurrencyCursor   
			 DEALLOCATE CurrencyCursor 
 

FETCH  NEXT FROM AirWayCursor INTO @AirWayName,@AirWayId
 END
 CLOSE AirWayCursor   
DEALLOCATE AirWayCursor
go

