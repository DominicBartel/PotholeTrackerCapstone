using Capstone.Web.Authentication;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Capstone.Web.Controllers;

namespace Capstone.Web.Models
{
    public class WorkOrderViewModel
    {
        public WorkOrder Order { get; set; }
        public List<User> Users { get; set; }
        public List<Pothole> Potholes { get; set; }
        public List<WorkOrder> WorkOrders { get; set; }
    }
   
}