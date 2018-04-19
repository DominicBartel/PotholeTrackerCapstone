using Capstone.Web.DAL;
using Capstone.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Capstone.Web.Controllers
{
    public class HomeController : Controller
    {
        public List<Pothole> AllPotholes = new List<Pothole>();

        public PotholeViewModel PotHoleSearch = new PotholeViewModel();

        public IPotholeDAL potholeDAL;

        public HomeController(IPotholeDAL dal)
        {
            this.potholeDAL = dal;
        }

		public ActionResult RoleAssignment(RoleAssignModel viewModel)
		{
            if (!Request.IsAuthenticated || User.IsInRole("citizen") || User.IsInRole("crew_member") || User.IsInRole("crew_leader"))
            {
                return RedirectToAction("Index");
            }
            RoleAssignModel newModel = new RoleAssignModel();
			newModel.users = potholeDAL.GetAllUsers();
			return View(newModel);
		}

		[HttpPost]
		public ActionResult ChangeRole (Guid guid, string role)
		{
            if (!Request.IsAuthenticated || User.IsInRole("citizen") || User.IsInRole("crew_member") || User.IsInRole("crew_leader"))
            {
                return RedirectToAction("Index");
            }

            potholeDAL.UpdateUserRole(guid, role);
			return RedirectToAction("RoleAssignment");
		}

		public ActionResult Index(PotholeViewModel viewModel)
        {

            PotholeViewModel newModel = new PotholeViewModel();

            newModel.Roles = GetRoles();


            return View(newModel);
        }

        private string GetRoles()
        {
            string roles = "";

            if (User.IsInRole("citizen"))
            {
                roles = "citizen";
            }
            if (User.IsInRole("crew_member"))
            {
                roles = "crew_member";
            }
            if (User.IsInRole("crew_leader"))
            {
                roles = "crew_leader";
            }
            if (User.IsInRole("god"))
            {
                roles = "god";
            }
            if (User.IsInRole("supergod"))
            {
                roles = "supergod";
            }

            return roles;
        }

        [HttpGet]
        public ActionResult ReportPothole(PotholeViewModel viewModel)
        {
            if (!Request.IsAuthenticated)
            {
                return RedirectToAction("Index");
            }
            PotholeViewModel newModel = new PotholeViewModel();

            newModel.Roles = GetRoles();

            return View(newModel);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ReportPotholePost(PotholeViewModel viewModel)
        {
            if (!Request.IsAuthenticated)
            {
                return RedirectToAction("Index");
            }
            //Pothole pothole = new Pothole();
            //pothole.UserName = userName;

            Pothole p = new Pothole();
            p.UserName = viewModel.UserName;
            p.PotholeDesc = viewModel.PotholeDesc;
            p.Latitude = viewModel.Latitude;
            p.Longitude = viewModel.Longitude;
            p.Severity = viewModel.Severity;
            p.Street1 = viewModel.Street1;
            p.Street2 = viewModel.Street2;
            p.LocationDesc = viewModel.LocationDesc;
            p.ReportedDate = viewModel.ReportedDate;
            p.InspectedDate = viewModel.InspectedDate;
            p.RepairedDate = viewModel.RepairedDate;
            p.IsValidated = Convert.ToBoolean(viewModel.IsValidated);


            bool confirm = potholeDAL.ReportPothole(p);
            return RedirectToAction("Index", "Home");
        }

        public ActionResult AdminPotholeEdit(PotholeViewModel viewModel)
        {
            if (!Request.IsAuthenticated || User.IsInRole("citizen") || User.IsInRole("crew_member"))
            {
                return RedirectToAction("Index");
            }

            if (viewModel == null)
            {
                viewModel = new PotholeViewModel();
            }

            return View(viewModel);
        }

        [HttpPost]
        public ActionResult AdminPotholeEdit(Pothole pothole)
        {
            if (!Request.IsAuthenticated || User.IsInRole("citizen") || User.IsInRole("crew_member"))
            {
                return RedirectToAction("Index");
            }

            potholeDAL.UpdatePothole(pothole);
            //PotholeViewModel returnModel = new PotholeViewModel();
            //returnModel.PotholeList = new List<Pothole>();
            //returnModel.PotholeList.Add(pothole);
            return RedirectToAction("AdminPotholeEdit"/*, returnModel*/);
        }

        [HttpPost]
        public ActionResult DeletePothole(Pothole potholeDelete)
        {
            if (!Request.IsAuthenticated || User.IsInRole("citizen") || User.IsInRole("crew_member"))
            {
                return RedirectToAction("Index");
            }
            potholeDAL.DeletePothole(potholeDelete);
            return RedirectToAction("AdminPotholeEdit");
        }


        public ActionResult WorkOrder()
        {
            if (!Request.IsAuthenticated || User.IsInRole("citizen") || User.IsInRole("crew_member"))
            {
                return RedirectToAction("Index");
            }

            return View();
        }

        [HttpPost]
        public ActionResult SubmitWorkOrder(string PotHoles, string Users, WorkOrder order)
        {
            if (!Request.IsAuthenticated || User.IsInRole("citizen") || User.IsInRole("crew_member"))
            {
                return RedirectToAction("Index");
            }

            order.LeaderId = potholeDAL.GetUserId(User.Identity.Name);
            potholeDAL.ScheduleWorkOrder(order, Users, PotHoles);
            return RedirectToAction("WorkOrder");
        }


        [HttpGet]
        public ActionResult ReviewMyWorkOrders(WorkOrderViewModel viewModel)
        {

            WorkOrderViewModel newModel = new WorkOrderViewModel();

            if (!Request.IsAuthenticated)
            {
                return RedirectToAction("Index");
            }

            if (User.IsInRole("crew_leader"))
            {
                newModel.WorkOrders = potholeDAL.GetLeaderOrders(User.Identity.Name);
            }

            if (User.IsInRole("crew_member"))
            {
                newModel.WorkOrders = potholeDAL.GetMemberOrders(User.Identity.Name);
            }

            if(User.IsInRole("god") || User.IsInRole("supergod") || User.IsInRole("admin"))
            {
                newModel.WorkOrders = potholeDAL.GetAllWorkOrders();
            }


            return View(newModel);
        }

        [HttpPost]
        public ActionResult SubmitMyWorkOrders(WorkOrder workOrder)
        {
            if (!Request.IsAuthenticated || User.IsInRole("citizen"))
            {
                return RedirectToAction("Index");
            }


            potholeDAL.UpdateWorkOrder(workOrder);

            return RedirectToAction("ReviewMyWorkOrders");
        }


    }
}