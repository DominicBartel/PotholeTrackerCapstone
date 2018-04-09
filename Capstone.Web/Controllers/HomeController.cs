using Capstone.Web.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Capstone.Web.Controllers
{
    public class HomeController : Controller
    {

        public IPotholeDAL potholeDAL;

        public HomeController(IPotholeDAL dal)
        {
            this.potholeDAL = dal;
        }


        public ActionResult Index()
        {
            return View();
        }


    }
}