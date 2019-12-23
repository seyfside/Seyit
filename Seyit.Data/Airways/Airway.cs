using System;
using System.ComponentModel.DataAnnotations.Schema;
using Seyit.Data.Suppliers;

namespace Seyit.Data
{
    public class Airway 
    {
        public Guid AirWayId { get; set; }
        public string AirWayName { get; set; }
        public string CarrierCode { get; set; }
        public string WebServicesUserName { get; set; }
        public string WebServisPassword { get; set; }
        public string WebServicesParamOne { get; set; }
        public string WebServicesParamTwo { get; set; }
        public decimal ServicesPrice { get; set; }
        public decimal DefaultAgencyCommissionsPrice { get; set; }
        public bool Status { get; set; }
        public string WebServicesUrl { get; set; }
        public bool CanCreateRezervation { get; set; }
        public Supplier Supplier { get; set; }
        public int AccountId { get; set; }
        public int SearchServiceTimeOutSecond { get; set; }
    }
}