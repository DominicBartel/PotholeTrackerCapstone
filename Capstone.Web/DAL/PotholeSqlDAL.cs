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


        public PotholeViewModel SearchValidPotHoles(PotholeViewModel viewModel)
        {
            List<Pothole> allPotholes = new List<Pothole>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    //string query = BuildSqlCommand(viewModel, conn);

                    SqlCommand cmd = BuildSqlCommand(viewModel, conn);




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

            viewModel.PotholeList = allPotholes;

            return viewModel;
        }


        private SqlCommand BuildSqlCommand(PotholeViewModel viewModel, SqlConnection conn)
        {

            SqlCommand cmd = new SqlCommand();


            string query = "SELECT PotHole.PotHole_Id, PotHole.UserId, Users.UserName, PotHole.PotHoleDesc, PotHole.Lat, PotHole.Long, PotHole.Severity, PotHole.Street1, PotHole.Street2, PotHole.LocationDesc, PotHole.DateReported, PotHole.InspectedDate, PotHole.RepairDate, PotHole.IsValidated FROM PotHole JOIN Users ON PotHole.UserId = Users.UserId WHERE 1=1";

            if (viewModel.PotholeId != null)
            {
                query += " AND PotHole_Id = @potholeId";
                cmd.Parameters.AddWithValue("@potholeId", viewModel.PotholeId);
            }

            if (viewModel.UserId != null)
            {
                query += " AND UserId = @userId";
                cmd.Parameters.AddWithValue("@userId", viewModel.UserId);
            }

            if (!String.IsNullOrEmpty(viewModel.UserName))
            {
                query += " AND UserName = @userName";
                cmd.Parameters.AddWithValue("@userName", viewModel.UserName);
            }

            if (!String.IsNullOrEmpty(viewModel.PotholeDesc))
            {
                query = " AND PotHoleDesc = @potholeDesc";
                cmd.Parameters.AddWithValue("@potholeDesc", viewModel.PotholeDesc);
            }

            if (viewModel.Latitude != null)
            {
                query += " AND Lat = @latitude";
                cmd.Parameters.AddWithValue("@latitude", viewModel.Latitude);

            }

            if (viewModel.Longitude != null)
            {
                query += " AND Long = @longitude";
                cmd.Parameters.AddWithValue("@longitude", viewModel.Longitude);
            }

            if (viewModel.Severity != null)
            {
                query += " AND Severity = @severity";
                cmd.Parameters.AddWithValue("@severity", viewModel.Severity);
            }

            if (!String.IsNullOrEmpty(viewModel.Street1))
            {
                query += " AND Street1 = @street1";
                cmd.Parameters.AddWithValue("@street1", viewModel.Street1);
            }

            if (!String.IsNullOrEmpty(viewModel.Street2))
            {
                query += " AND Street2 = @street2";
                cmd.Parameters.AddWithValue("@street2", viewModel.Street2);
            }

            if (!String.IsNullOrEmpty(viewModel.LocationDesc))
            {
                query += " AND LocationDesc = @locationDesc";
                cmd.Parameters.AddWithValue("@locationDesc", viewModel.LocationDesc);
            }

            if (viewModel.ReportedDate != null)
            {
                query += " AND DateReported = @reportedDate";
                cmd.Parameters.AddWithValue("@reportedDate", viewModel.ReportedDate);
            }

            if (viewModel.InspectedDate != null)
            {
                query += " AND InspectedDate = @inspectedDate";
                cmd.Parameters.AddWithValue("@inspectedDate", viewModel.InspectedDate);
            }

            if (viewModel.RepairedDate != null)
            {
                query += " AND RepairDate = @repairedDate";
                cmd.Parameters.AddWithValue("@repairedDate", viewModel.InspectedDate);
            }

            if (viewModel.IsValidated != null)
            {
                query += " AND IsValidated = @isValidated";
                cmd.Parameters.AddWithValue("@isValidated", viewModel.IsValidated);

            }

            query += ";";

            cmd.CommandText = query;
            cmd.Connection = conn;

            return cmd;
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