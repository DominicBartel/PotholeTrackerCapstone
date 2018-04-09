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


        public List<Pothole> GetAllValidPotholes()
        {
            List<Pothole> allPotholes = new List<Pothole>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();


                    SqlCommand cmd = new SqlCommand("SELECT * FROM PotHole WHERE IsValidated = 1", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        Pothole p = new Pothole();

                        p.PotholeId = Convert.ToInt32(reader["PotHole_Id"]);
                        p.UserId = (Guid)reader["UserId"];
                        p.PotholeDesc = Convert.ToString(reader["PotHoleDesc"]);
                        p.Latitude = Convert.ToDouble(reader["Lat"]);
                        p.Longitude = Convert.ToDouble(reader["Long"]);
                        p.Severity = Convert.ToInt32(reader["Severity"]);
                        p.Street1 = Convert.ToString(reader["Street1"]);
                        p.Street2 = Convert.ToString(reader["Street2"]);
                        p.LocationDesc = Convert.ToString(reader["LocationDesc"]);
                        p.ReportedDate = Convert.ToDateTime(reader["DateReported"]);
                        p.InspectedDate = Convert.ToDateTime(reader["InspectedDate"]);
                        p.RepairedDate = Convert.ToDateTime(reader["RepairDate"]);
                        p.IsValidated = Convert.ToBoolean(reader["IsValidated"]);

                        allPotholes.Add(p);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return allPotholes;
        }
    }
}