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
                roles="god";
            }
            if (User.IsInRole("supergod"))
            {
                roles="supergod";
            }

            return roles;
        }

        [HttpGet]
        public ActionResult ReportPothole(PotholeViewModel viewModel)
        {

            PotholeViewModel newModel = new PotholeViewModel();

            newModel.Roles = GetRoles();

            return View(newModel);
        }


        [HttpPost]
        public ActionResult ReportPotholePost(PotholeViewModel viewModel)
        {
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
            if(viewModel == null)
            {
                viewModel = new PotholeViewModel();
            }

            return View(viewModel);
        }

        [HttpPost]
        public ActionResult AdminPotholeEdit(Pothole pothole)
        {
            potholeDAL.UpdatePothole(pothole); 
            PotholeViewModel returnModel = new PotholeViewModel();
            returnModel.PotholeList = new List<Pothole>();
            returnModel.PotholeList.Add(pothole);
            return RedirectToAction("AdminPotholeEdit", returnModel);
        }

    }
}