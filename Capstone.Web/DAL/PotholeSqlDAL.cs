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

                    while (reader.Read())
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

        public List<Pothole> SearchValidPotHoles(PotholeViewModel viewModel)
        {
            List<Pothole> allPotholes = new List<Pothole>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    string query = BuildSqlQuery(viewModel);

                    SqlCommand cmd = new SqlCommand("SELECT * FROM PotHole WHERE IsValidated = 1 AND Street1 = @street1", conn);

                    cmd.Parameters.AddWithValue("@street1", viewModel);


                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Pothole p = MapRows(reader);

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

        private string BuildSqlQuery(PotholeViewModel viewModel)
        {
            string result = "";


            return result;
        }

        public Pothole MapRows(SqlDataReader reader)
        {

            Pothole p = new Pothole();



            p.PotholeId = Convert.ToInt32(reader["PotHole_Id"]);
            p.UserId = (Guid)reader["UserId"];
            p.UserName = Convert.ToString(reader["UserName"]);

            // Nullable values in database

            if (reader["PotHoleDesc"] == DBNull.Value)
            {
                p.PotholeDesc = "";
            }
            else
            {
                p.PotholeDesc = Convert.ToString(reader["PotHoleDesc"]);
            }

            if (reader["Lat"] == DBNull.Value)
            {
                p.Latitude = null;
            }
            else
            {
                p.Latitude = Convert.ToDouble(reader["Lat"]);
            }

            if (reader["Long"] == DBNull.Value)
            {
                p.Longitude = null;
            }
            else
            {
                p.Longitude = Convert.ToDouble(reader["Long"]);
            }

            if (reader["Severity"] == DBNull.Value)
            {
                p.Severity = null;
            }
            else
            {
                p.Severity = Convert.ToInt32(reader["Severity"]);

            }

            if (reader["Street1"] == DBNull.Value)
            {
                p.Street1 = "";
            }
            else
            {
                p.Street1 = Convert.ToString(reader["Street1"]);

            }

            if (reader["Street2"] == DBNull.Value)
            {
                p.Street2 = "";
            }
            else
            {
                p.Street2 = Convert.ToString(reader["Street2"]);
            }


            if (reader["LocationDesc"] == DBNull.Value)
            {
                p.LocationDesc = "";
            }
            else
            {
                p.LocationDesc = Convert.ToString(reader["LocationDesc"]);
            }


            if (reader["DateReported"] == DBNull.Value)
            {
                p.ReportedDate = null;
            }
            else
            {
                p.ReportedDate = Convert.ToDateTime(reader["DateReported"]);
            }


            if (reader["InspectedDate"] == DBNull.Value)
            {
                p.InspectedDate = null;
            }
            else
            {
            p.InspectedDate = Convert.ToDateTime(reader["InspectedDate"]);
            }


            if (reader["RepairDate"] == DBNull.Value)
            {
                p.RepairedDate = null;
            }
            else
            {
                p.RepairedDate = Convert.ToDateTime(reader["RepairDate"]);
            }

            // End Nullable vales in database


            p.IsValidated = Convert.ToBoolean(reader["IsValidated"]);

            return p;

        }
    }
}