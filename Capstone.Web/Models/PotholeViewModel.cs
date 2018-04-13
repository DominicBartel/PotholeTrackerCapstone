using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class PotholeViewModel
    {

        public int? PotholeId { get; set; }
        public Guid? UserId { get; set; }
        public string UserName { get; set; }
        public string PotholeDesc { get; set; }
        public double? Latitude { get; set; }
        public double? Longitude { get; set; }
        public int? Severity { get; set; }
        public string Street1 { get; set; }
        public string Street2 { get; set; }
        public string LocationDesc { get; set; }
        public DateTime? ReportedDate { get; set; }
        public DateTime? InspectedDate { get; set; }
        public DateTime? RepairedDate { get; set; }
        public bool? IsValidated { get; set; }
        public string Roles { get; set; }

        public List<Pothole> PotholeList { get; set; }

        public PotholeViewModel()
        {
            PotholeId = null;
            UserId = null;
            UserName = "";
            PotholeDesc = "";
            Latitude = null;
            Longitude = null;
            Severity = null;
            Street1 = "";
            Street2 = "";
            LocationDesc = "";
            ReportedDate = null;
            InspectedDate = null;
            RepairedDate = null;
            this.IsValidated = false;
            Roles = "";
        }

    }
}