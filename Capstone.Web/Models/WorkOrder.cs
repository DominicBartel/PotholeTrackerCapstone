using Capstone.Web.Authentication;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Capstone.Web.Controllers;
namespace Capstone.Web.Models
{
    public class WorkOrder
    {
        public int? WorkOrderId { get; set; }
        public DateTime? ToInspectDate { get; set; }
        public DateTime? ToRepairDate { get; set; }
        public bool? InspectionComplete { get; set; }
        public bool? RepairComplete { get; set; }
        public string TypeOfJob { get; set; }
        public string Notes { get; set; }
        public Guid? LeaderId { get; set; }

        public List<User> Crew { get; set; }
        public List<Pothole> Potholes { get; set; }
    }
}