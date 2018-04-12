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

            if(viewModel == null)
            {
                viewModel = new PotholeViewModel();
            }

            newModel.Roles = GetRoles();

            
            return View(newModel);
        }

        private List<string> GetRoles()
        {
            List<string> roles = new List<string>();

            if (User.IsInRole("citizen"))
            {
                roles.Add("citizen");
            }
            if (User.IsInRole("crew_member"))
            {
                roles.Add("crew_member");
            }
            if (User.IsInRole("crew_leader"))
            {
                roles.Add("crew_leader");
            }
            if (User.IsInRole("god"))
            {
                roles.Add("god");
            }
            if (User.IsInRole("supergod"))
            {
                roles.Add("supergod");
            }

            return roles;
        }

        [HttpPost]
        public ActionResult ReportPothole(Pothole pothole)
        {

            bool confirm = potholeDAL.ReportPothole(pothole);
            //User.
            return RedirectToAction("Index");
        }

    }
}