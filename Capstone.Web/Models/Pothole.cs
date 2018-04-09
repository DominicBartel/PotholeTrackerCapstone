using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class Pothole
    {
        public int potholeId { get; set; }
        public Guid userId { get; set; }
        public string LocationDesc { get; set; }
        public string PotholeDesc { get; set; }
        public double Latitude { get; set; }
        public int Severity { get; set; }
        public string Street1 { get; set; }
        public string Street2 { get; set; }
        public DateTime ReportedDate { get; set; }
        public DateTime InspectedDate { get; set; }
        public DateTime RepairedDate { get; set; }
        public bool IsValidated { get; set; }


    }
}