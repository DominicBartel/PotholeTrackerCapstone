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

        public IPotholeDAL potholeDAL;

        public HomeController(IPotholeDAL dal)
        {
            this.potholeDAL = dal;
        }


        public ActionResult Index()
        {
            var list = potholeDAL.GetAllValidPotholes();
            return View(list);
        }

    }
}