using System;
using MediatR;

namespace Seyit.Business.Airways.Command
{
    public class CreateAirwayCommand:IRequest<Guid>
    {
        public string AirWayName { get; set; }
        public string CarrierCode { get; set; }
        public string WebServicesUrl { get; set; }
        public string WebServicesUserName { get; set; }
        public string WebServisPassword { get; set; }
        public string WebServicesParamOne { get; set; }
        public string WebServicesParamTwo { get; set; }
        public decimal ServicesPrice { get; set; }
        public decimal DefaultAgencyCommissionsPrice { get; set; }
        public bool Status { get; set; }
        public bool CanCreateRezervation { get; set; }
        public int SearchServiceTimeOutSecond { get; set; }
        public string RegionLetter { get; set; }
        public int SupplierId { get; set; }
    }
}