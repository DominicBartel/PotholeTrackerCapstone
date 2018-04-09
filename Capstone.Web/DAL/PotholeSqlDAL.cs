using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Capstone.Web.Models;


namespace Capstone.Web.DAL
{
    public class PotholeSqlDAL : IPotholeDAL
    {


        public string ConnectionString { get; set; }

        public PotholeSqlDAL(string connectionString)
        {
            this.ConnectionString = connectionString;
        }


        public List<Pothole> GetAllPotholes()
        {
            List<Pothole> allPotholes = new List<Pothole>();

            //try
            //{
            //    using(SqlConnection)
            //}
            //catch (S)
            //{

            //}


            return allPotholes;
        }
    }
}