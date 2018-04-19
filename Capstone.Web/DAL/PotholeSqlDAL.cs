using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Capstone.Web.Authentication;
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

                    string query = "SELECT PotHole.PotHole_Id, PotHole.UserId, Users.UserName, PotHole.PotHoleDesc, PotHole.Lat, PotHole.Long, PotHole.Severity, PotHole.Street1, PotHole.Street2, PotHole.LocationDesc, PotHole.DateReported, PotHole.InspectedDate, PotHole.RepairDate, PotHole.IsValidated FROM PotHole JOIN Users ON PotHole.UserId = Users.UserId WHERE IsValidated = 1";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        //Pothole p = new Pothole();

                        //p.PotholeId = Convert.ToInt32(reader["PotHole_Id"]);
                        //p.UserId = (Guid)reader["UserId"];
                        //p.PotholeDesc = Convert.ToString(reader["PotHoleDesc"]);
                        //p.Latitude = Convert.ToDouble(reader["Lat"]);
                        //p.Longitude = Convert.ToDouble(reader["Long"]);
                        //p.Severity = Convert.ToInt32(reader["Severity"]);
                        //p.Street1 = Convert.ToString(reader["Street1"]);
                        //p.Street2 = Convert.ToString(reader["Street2"]);
                        //p.LocationDesc = Convert.ToString(reader["LocationDesc"]);
                        //p.ReportedDate = Convert.ToDateTime(reader["DateReported"]);
                        //p.InspectedDate = Convert.ToDateTime(reader["InspectedDate"]);
                        //p.RepairedDate = Convert.ToDateTime(reader["RepairDate"]);
                        //p.IsValidated = Convert.ToBoolean(reader["IsValidated"]);

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


        public bool ReportPothole(Pothole pothole)
        {



            bool confirm = false;


            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT UserId FROM Users WHERE UserName = @userName", conn);
                    cmd.Parameters.AddWithValue("@userName", pothole.UserName);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        pothole.UserId = (Guid)reader["UserId"];
                    }
                    conn.Close();

                    conn.Open();

                    cmd = new SqlCommand("INSERT INTO PotHole(UserId, PotHoleDesc, Lat, Long, Severity, Street1, Street2, LocationDesc, DateReported, InspectedDate, RepairDate, IsValidated) VALUES(@userId, @potholeDesc, @latitude, @longitude, @severity, @street1, @street2, @locationDesc, @reportedDate, @inspectedDate, @repairedDate, @isValidated)", conn);

                    cmd.Parameters.AddWithValue("@userId", pothole.UserId);

                    if (String.IsNullOrEmpty(pothole.PotholeDesc))
                    {
                        cmd.Parameters.AddWithValue("@potholeDesc", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@potholeDesc", pothole.PotholeDesc);
                    }

                    if (pothole.Latitude == null)
                    {
                        cmd.Parameters.AddWithValue("@latitude", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@latitude", pothole.Latitude);
                    }

                    if (pothole.Longitude == null)
                    {
                        cmd.Parameters.AddWithValue("@longitude", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@longitude", pothole.Longitude);
                    }

                    if (pothole.Severity == null)
                    {
                        cmd.Parameters.AddWithValue("@severity", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@severity", pothole.Severity);
                    }

                    if (String.IsNullOrEmpty(pothole.Street1))
                    {
                        cmd.Parameters.AddWithValue("@street1", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@street1", pothole.Street1);
                    }

                    if (String.IsNullOrEmpty(pothole.Street2))
                    {
                        cmd.Parameters.AddWithValue("@street2", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@street2", pothole.Street2);
                    }

                    if (String.IsNullOrEmpty(pothole.LocationDesc))
                    {
                        cmd.Parameters.AddWithValue("@locationDesc", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@locationDesc", pothole.LocationDesc);
                    }

                    if (pothole.ReportedDate == null)
                    {
                        cmd.Parameters.AddWithValue("@reportedDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@reportedDate", pothole.ReportedDate);
                    }

                    if (pothole.InspectedDate == null)
                    {
                        cmd.Parameters.AddWithValue("@inspectedDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@inspectedDate", pothole.InspectedDate);
                    }

                    if (pothole.RepairedDate == null)
                    {
                        cmd.Parameters.AddWithValue("@repairedDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@repairedDate", pothole.RepairedDate);
                    }

                    cmd.Parameters.AddWithValue("@isValidated", pothole.IsValidated);

                    cmd.ExecuteNonQuery();
                }


            }
            catch (SqlException ex)
            {
                confirm = false;
                throw;
            }


            return confirm;
        }

        public bool UpdatePothole(Pothole pothole)
        {
            bool confirm = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {

                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT UserId FROM Users WHERE UserName = @userName", conn);
                    cmd.Parameters.AddWithValue("@userName", pothole.UserName);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        pothole.UserId = (Guid)reader["UserId"];
                    }
                    conn.Close();

                    conn.Open();

                    cmd = new SqlCommand("Update PotHole Set UserId = @userId, PotHoleDesc = @potholeDesc, Lat = @latitude, Long = @longitude, Severity = @severity, Street1 = @street1, Street2 = @street2, LocationDesc = @locationDesc, DateReported = @reportedDate, InspectedDate = @inspectedDate, RepairDate = @repairedDate, IsValidated = @isValidated WHERE PotHole_Id = @potholeId", conn);

                    cmd.Parameters.AddWithValue("@userId", pothole.UserId);
                    cmd.Parameters.AddWithValue("@potholeId", pothole.PotholeId);

                    if (String.IsNullOrEmpty(pothole.PotholeDesc))
                    {
                        cmd.Parameters.AddWithValue("@potholeDesc", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@potholeDesc", pothole.PotholeDesc);
                    }

                    if (pothole.Latitude == null)
                    {
                        cmd.Parameters.AddWithValue("@latitude", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@latitude", pothole.Latitude);
                    }

                    if (pothole.Longitude == null)
                    {
                        cmd.Parameters.AddWithValue("@longitude", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@longitude", pothole.Longitude);
                    }

                    if (pothole.Severity == null)
                    {
                        cmd.Parameters.AddWithValue("@severity", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@severity", pothole.Severity);
                    }

                    if (String.IsNullOrEmpty(pothole.Street1))
                    {
                        cmd.Parameters.AddWithValue("@street1", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@street1", pothole.Street1);
                    }

                    if (String.IsNullOrEmpty(pothole.Street2))
                    {
                        cmd.Parameters.AddWithValue("@street2", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@street2", pothole.Street2);
                    }

                    if (String.IsNullOrEmpty(pothole.LocationDesc))
                    {
                        cmd.Parameters.AddWithValue("@locationDesc", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@locationDesc", pothole.LocationDesc);
                    }

                    if (pothole.ReportedDate == null)
                    {
                        cmd.Parameters.AddWithValue("@reportedDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@reportedDate", pothole.ReportedDate);
                    }

                    if (pothole.InspectedDate == null)
                    {
                        cmd.Parameters.AddWithValue("@inspectedDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@inspectedDate", pothole.InspectedDate);
                    }

                    if (pothole.RepairedDate == null)
                    {
                        cmd.Parameters.AddWithValue("@repairedDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@repairedDate", pothole.RepairedDate);
                    }

                    cmd.Parameters.AddWithValue("@isValidated", pothole.IsValidated);

                    cmd.ExecuteNonQuery();

                    confirm = true;
                }


            }
            catch (SqlException ex)
            {
                confirm = false;
                throw;
            }

            return confirm;
        }

        public bool DeletePothole(Pothole pothole)
        {
            bool confirm = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("Delete FROM PotHole WHERE PotHole_Id = @potholeId", conn);
                    cmd.Parameters.AddWithValue("@potholeId", pothole.PotholeId);

                    cmd.ExecuteNonQuery();
                    confirm = true;
                }
            }
            catch (SqlException ex)
            {
                throw;
            }
            return confirm;
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
                viewModel.UserName = "%" + viewModel.UserName + "%";
                query += " AND users.UserName LIKE @userName";
                cmd.Parameters.AddWithValue("@userName", viewModel.UserName);
            }

            //-------------------------------------------
            if (!String.IsNullOrEmpty(viewModel.PotholeDesc))
            {
                viewModel.PotholeDesc = "%" + viewModel.PotholeDesc + "%";
                query += " AND PotHoleDesc LIKE @potholeDesc";
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

            if (viewModel.Severity != null && viewModel.Severity != -1)
            {
                query += " AND Severity = @severity";
                cmd.Parameters.AddWithValue("@severity", viewModel.Severity);
            }

            if (!String.IsNullOrEmpty(viewModel.Street1))
            {
                viewModel.Street1 = "%" + viewModel.Street1 + "%";
                query += " AND Street1 LIKE @street1";
                cmd.Parameters.AddWithValue("@street1", viewModel.Street1);
            }

            if (!String.IsNullOrEmpty(viewModel.Street2))
            {
                viewModel.Street2 = "%" + viewModel.Street2 + "%";
                query += " AND Street2 LIKE @street2";
                cmd.Parameters.AddWithValue("@street2", viewModel.Street2);
            }
            //----------------------------------------------
            if (!String.IsNullOrEmpty(viewModel.LocationDesc))
            {
                viewModel.LocationDesc = "%" + viewModel.LocationDesc + "%";
                query += " AND LocationDesc LIKE @locationDesc";
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
                cmd.Parameters.AddWithValue("@repairedDate", viewModel.RepairedDate);
            }
            else if (viewModel.RepairedDate == null)
            {
                query += " AND RepairDate IS NULL";
            }

            if (viewModel.IsValidated != null)
            {
                query += " AND IsValidated = @isValidated";
                cmd.Parameters.AddWithValue("@isValidated", viewModel.IsValidated);
            }

            query += " ORDER BY Severity DESC;";

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


        public List<User> GetAllCrewMembers()
        {
            List<User> crew = new List<User>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT * FROM Users JOIN UserRoles ON UserRoles.UserId = Users.UserId WHERE UserRoles.Role = 'crew_member';", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        User u = new User();
                        u.UserId = (Guid)reader["UserId"];
                        u.UserName = Convert.ToString(reader["UserName"]);
                        u.PasswordHash = Convert.ToString(reader["PasswordHash"]);
                        u.SecurityStamp = Convert.ToString(reader["SecurityStamp"]);
                        u.Roles.Add(Convert.ToString(reader["Role"]));

                        crew.Add(u);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return crew;
        }

        public List<User> GetAllCrewLeaders()
        {
            List<User> crew = new List<User>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT * FROM Users JOIN UserRoles ON UserRoles.UserId = Users.UserId WHERE UserRoles.Role = 'crew_leader';", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        User u = new User();
                        u.UserId = (Guid)reader["UserId"];
                        u.UserName = Convert.ToString(reader["UserName"]);
                        u.PasswordHash = Convert.ToString(reader["PasswordHash"]);
                        u.SecurityStamp = Convert.ToString(reader["SecurityStamp"]);
                        u.Roles.Add(Convert.ToString(reader["Role"]));

                        crew.Add(u);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return crew;
        }

        public bool ScheduleWorkOrder(WorkOrder workOrder, string userList, string potholeList)
        {
            bool confirm = false;
            List<string> userListSplit = userList.Split(',').ToList<string>();
            List<Guid> userIdList = new List<Guid>();

            foreach (var userId in userListSplit)
            {
                userIdList.Add(Guid.Parse(userId));
            }

            List<string> potholeListSplit = potholeList.Split(',').ToList<string>();
            List<int> potholeIdList = new List<int>();

            foreach (var potholeId in potholeListSplit)
            {
                potholeIdList.Add(Convert.ToInt32(potholeId));
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("INSERT INTO WorkOrder VALUES (@toInspectDate, @toRepairDate, @inspectionComplete, @repairComplete, @typeOfJob, @notes, @leaderId);", conn);

                    if (workOrder.ToInspectDate == null)
                    {
                        cmd.Parameters.AddWithValue("@toInspectDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@toInspectDate", workOrder.ToInspectDate);
                    }

                    if (workOrder.ToRepairDate == null)
                    {
                        cmd.Parameters.AddWithValue("@toRepairDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@toRepairDate", workOrder.ToRepairDate);
                    }

                    if (workOrder.InspectionComplete == null)
                    {
                        cmd.Parameters.AddWithValue("@inspectionComplete", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@inspectionComplete", workOrder.InspectionComplete);
                    }

                    if (workOrder.RepairComplete == null)
                    {
                        cmd.Parameters.AddWithValue("@repairComplete", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@repairComplete", workOrder.RepairComplete);
                    }

                    if (String.IsNullOrEmpty(workOrder.TypeOfJob))
                    {
                        cmd.Parameters.AddWithValue("@typeOfJob", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@typeOfJob", workOrder.TypeOfJob);
                    }

                    if (String.IsNullOrEmpty(workOrder.Notes))
                    {
                        cmd.Parameters.AddWithValue("@notes", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@notes", workOrder.Notes);
                    }


                    cmd.Parameters.AddWithValue("@leaderId", workOrder.LeaderId);

                    cmd.ExecuteNonQuery();
                    conn.Close();

                    cmd = new SqlCommand("SELECT TOP 1 * FROM WorkOrder Order By WorkOrderId DESC;", conn);
                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        workOrder.WorkOrderId = Convert.ToInt32(reader["WorkOrderId"]);
                    }

                    conn.Close();

                    conn.Open();

                    foreach (int potholeId in potholeIdList)
                    {
                        foreach (Guid userId in userIdList)
                        {
                            cmd = new SqlCommand("INSERT INTO WorkOrderPotholeUser VALUES (@workOrderId, @potholeId, @userId)", conn);
                            cmd.Parameters.AddWithValue("@workOrderId", workOrder.WorkOrderId);
                            cmd.Parameters.AddWithValue("@potholeId", potholeId);
                            cmd.Parameters.AddWithValue("@userId", userId);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return confirm;
        }

        public List<User> GetAllUsers()
        {
            List<User> users = new List<User>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("select users.UserId, users.UserName, UserRoles.Role from users join UserRoles on users.UserId = UserRoles.UserId;", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        User u = new User();

                        u.UserId = (Guid)reader["UserId"];
                        u.UserName = Convert.ToString(reader["UserName"]);
                        u.Roles.Add(Convert.ToString(reader["Role"]));

                        users.Add(u);
                    }
                }
            }
            catch(SqlException ex)
            {
                throw;
            }

            return users;
        }

        public bool UpdateUserRole(Guid userId, string role)
        {
            bool result = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("update UserRoles set Role = @role where UserId = @userId", conn);
                    cmd.Parameters.AddWithValue("@role", role);
                    cmd.Parameters.AddWithValue("@userId", userId);

                    cmd.ExecuteNonQuery();
                    result = true;
                }
            }
            catch(SqlException ex)
            {
                throw;
            }


            return result;
        }

        public bool UpdateWorkOrder(WorkOrder workOrder)
        {
            bool result = false;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("UPDATE WorkOrder SET ToInspectDate = @toInspectDate, ToRepairDate = @toRepairDate, InspectionComplete = @inspectionComplete, RepairComplete = @repairComplete, TypeOfJob = @typeOfJob, Notes = @notes, LeaderId = @leaderId WHERE WorkOrderId = @WorkOrderId;", conn);

                    cmd.Parameters.AddWithValue("@workOrderId", workOrder.WorkOrderId);

                    if (workOrder.ToInspectDate == null)
                    {
                        cmd.Parameters.AddWithValue("@toInspectDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@toInspectDate", workOrder.ToInspectDate);
                    }

                    if (workOrder.ToRepairDate == null)
                    {
                        cmd.Parameters.AddWithValue("@toRepairDate", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@toRepairDate", workOrder.ToRepairDate);
                    }

                    if (workOrder.InspectionComplete == null)
                    {
                        cmd.Parameters.AddWithValue("@inspectionComplete", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@inspectionComplete", workOrder.InspectionComplete);
                    }

                    if (workOrder.RepairComplete == null)
                    {
                        cmd.Parameters.AddWithValue("@repairComplete", DBNull.Value);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@repairComplete", workOrder.RepairComplete);
                    }

                    if (String.IsNullOrEmpty(workOrder.TypeOfJob))
                    {
                        cmd.Parameters.AddWithValue("@typeOfJob", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@typeOfJob", workOrder.TypeOfJob);
                    }

                    if (String.IsNullOrEmpty(workOrder.Notes))
                    {
                        cmd.Parameters.AddWithValue("@notes", "");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@notes", workOrder.Notes);
                    }

                    cmd.Parameters.AddWithValue("@leaderId", workOrder.LeaderId);

                    cmd.ExecuteNonQuery();

                }
                    result = true;
            }
            catch(SqlException ex)
            {

            }


            return result;

        }

        public List<WorkOrder> GetLeaderOrders(string userName)
        {
            List<WorkOrder> result = new List<WorkOrder>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT * FROM WorkOrder WHERE WorkOrder.LeaderId = (SELECT Users.UserId from Users where users.UserName = @leaderUserName) ORDER BY WorkOrder.WorkOrderId DESC;", conn);
                    cmd.Parameters.AddWithValue("@leaderUserName", userName);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        WorkOrder w = new WorkOrder();

                        w.WorkOrderId = Convert.ToInt32(reader["WorkOrderId"]);

                        if(reader["ToInspectDate"] == DBNull.Value)
                        {
                            w.ToInspectDate = null;
                        }
                        else
                        {
                            w.ToInspectDate = Convert.ToDateTime(reader["ToInspectDate"]);
                        }

                        if(reader["ToRepairDate"] == DBNull.Value)
                        {
                            w.ToRepairDate = null;
                        }
                        else
                        {
                            w.ToRepairDate = Convert.ToDateTime(reader["ToRepairDate"]);
                        }

                        if(reader["InspectionComplete"] == DBNull.Value)
                        {
                            w.InspectionComplete = null;
                        }
                        else
                        {
                            w.InspectionComplete = Convert.ToBoolean(reader["InspectionComplete"]);
                        }

                        if (reader["RepairComplete"] == DBNull.Value)
                        {
                            w.RepairComplete = null;
                        }
                        else
                        {
                            w.RepairComplete = Convert.ToBoolean(reader["RepairComplete"]);
                        }

                        if(String.IsNullOrEmpty(Convert.ToString(reader["TypeOfJob"])))
                        {
                            w.TypeOfJob = "";
                        }
                        else
                        {
                            w.TypeOfJob = Convert.ToString(reader["TypeOfJob"]);
                        }

                        if (String.IsNullOrEmpty(Convert.ToString(reader["Notes"])))
                        {
                            w.Notes = "";
                        }
                        else
                        {
                            w.Notes = Convert.ToString(reader["Notes"]);
                        }

                        if(reader["LeaderId"] == DBNull.Value)
                        {
                            w.LeaderId = null;
                        }
                        else
                        {
                            w.LeaderId = (Guid)reader["LeaderId"];
                        }

                        w.Crew = GetOrderCrewMembers(Convert.ToInt32(w.WorkOrderId));
                        w.Potholes = GetOrderPotholes(Convert.ToInt32(w.WorkOrderId));


                        result.Add(w);
                    }

                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return result;
        }

        public List<WorkOrder> GetMemberOrders(string userName)
        {
            List<WorkOrder> result = new List<WorkOrder>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT WorkOrder.WorkOrderId, WorkOrder.ToInspectDate, WorkOrder.ToRepairDate, WorkOrder.InspectionComplete, WorkOrder.RepairComplete, WorkOrder.TypeOfJob, WorkOrder.Notes, WorkOrder.LeaderId FROM WorkOrder JOIN WorkOrderPotholeUser ON WorkOrder.WorkOrderId = WorkOrderPotholeUser.WorkOrderId WHERE WorkOrderPotholeUser.UserId = @userId GROUP BY WorkOrder.WorkOrderId, WorkOrder.ToInspectDate, WorkOrder.ToRepairDate, WorkOrder.InspectionComplete, WorkOrder.RepairComplete, WorkOrder.TypeOfJob, WorkOrder.Notes, WorkOrder.LeaderId ORDER BY WorkOrder.WorkOrderId DESC;", conn);
                    cmd.Parameters.AddWithValue("@userId", GetUserId(userName));

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        WorkOrder w = new WorkOrder();

                        w.WorkOrderId = Convert.ToInt32(reader["WorkOrderId"]);

                        if (reader["ToInspectDate"] == DBNull.Value)
                        {
                            w.ToInspectDate = null;
                        }
                        else
                        {
                            w.ToInspectDate = Convert.ToDateTime(reader["ToInspectDate"]);
                        }

                        if (reader["ToRepairDate"] == DBNull.Value)
                        {
                            w.ToRepairDate = null;
                        }
                        else
                        {
                            w.ToRepairDate = Convert.ToDateTime(reader["ToRepairDate"]);
                        }

                        if (reader["InspectionComplete"] == DBNull.Value)
                        {
                            w.InspectionComplete = null;
                        }
                        else
                        {
                            w.InspectionComplete = Convert.ToBoolean(reader["InspectionComplete"]);
                        }

                        if (reader["RepairComplete"] == DBNull.Value)
                        {
                            w.RepairComplete = null;
                        }
                        else
                        {
                            w.RepairComplete = Convert.ToBoolean(reader["RepairComplete"]);
                        }

                        if (String.IsNullOrEmpty(Convert.ToString(reader["TypeOfJob"])))
                        {
                            w.TypeOfJob = "";
                        }
                        else
                        {
                            w.TypeOfJob = Convert.ToString(reader["TypeOfJob"]);
                        }

                        if (String.IsNullOrEmpty(Convert.ToString(reader["Notes"])))
                        {
                            w.Notes = "";
                        }
                        else
                        {
                            w.Notes = Convert.ToString(reader["Notes"]);
                        }

                        if (reader["LeaderId"] == DBNull.Value)
                        {
                            w.LeaderId = null;
                        }
                        else
                        {
                            w.LeaderId = (Guid)reader["LeaderId"];
                        }

                        w.Crew = GetOrderCrewMembers(Convert.ToInt32(w.WorkOrderId));
                        w.Potholes = GetOrderPotholes(Convert.ToInt32(w.WorkOrderId));

                        result.Add(w);
                    }

                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return result;
        }

        public List<WorkOrder> GetAllWorkOrders()
        {
            List<WorkOrder> workOrders = new List<WorkOrder>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT * FROM WorkOrder ORDER BY WorkOrder.WorkOrderId DESC", conn);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        WorkOrder w = new WorkOrder();

                        if (reader["WorkOrderId"] == DBNull.Value)
                        {
                            w.WorkOrderId = null;
                        }
                        else
                        {
                            w.WorkOrderId = Convert.ToInt32(reader["WorkOrderId"]);
                        }

                        if (reader["ToInspectDate"] == DBNull.Value)
                        {
                            w.ToInspectDate = null;
                        }
                        else
                        {
                            w.ToInspectDate = Convert.ToDateTime(reader["ToInspectDate"]);
                        }

                        if (reader["ToRepairDate"] == DBNull.Value)
                        {
                            w.ToRepairDate = null;
                        }
                        else
                        {
                            w.ToRepairDate = Convert.ToDateTime(reader["ToRepairDate"]);
                        }

                        if (reader["InspectionComplete"] == DBNull.Value)
                        {
                            w.InspectionComplete = null;
                        }
                        else
                        {
                            w.InspectionComplete = Convert.ToBoolean(reader["InspectionComplete"]);
                        }

                        if (reader["RepairComplete"] == DBNull.Value)
                        {
                            w.RepairComplete = null;
                        }
                        else
                        {
                            w.RepairComplete = Convert.ToBoolean(reader["RepairComplete"]);
                        }

                        if (reader["TypeOfJob"] == DBNull.Value)
                        {
                            w.TypeOfJob = "";
                        }
                        else
                        {
                            w.TypeOfJob = Convert.ToString(reader["TypeOfJob"]);
                        }

                        if (reader["Notes"] == DBNull.Value)
                        {
                            w.Notes = "";
                        }
                        else
                        {
                            w.Notes = Convert.ToString(reader["Notes"]);
                        }

                        if (reader["LeaderId"] == DBNull.Value)
                        {
                            w.LeaderId = null;
                        }
                        else
                        {
                            w.LeaderId = (Guid)reader["LeaderId"];
                        }

                        w.Crew = GetOrderCrewMembers(Convert.ToInt32(w.WorkOrderId));
                        w.Potholes = GetOrderPotholes(Convert.ToInt32(w.WorkOrderId));

                        workOrders.Add(w);
                    }

                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return workOrders;
        }


        public Guid GetUserId(string userName)
        {
            Guid userId = new Guid();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("Select Users.UserId from users where Users.UserName = @userName;", conn);
                    cmd.Parameters.AddWithValue("@userName", userName);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        userId = (Guid)reader["UserId"];
                    }
                }
            }
            catch(SqlException ex)
            {
                throw;
            }

            return userId;

        }

        public List<User> GetOrderCrewMembers(int orderId)
        {
            List<User> crew = new List<User>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT Users.UserId, Users.UserName FROM Users JOIN WorkOrderPotholeUser ON USERS.UserId = WorkOrderPotholeUser.UserId WHERE WorkOrderPotholeUser.WorkOrderId = @workOrderId GROUP BY Users.UserId, Users.UserName;", conn);
                    cmd.Parameters.AddWithValue("@workOrderId", orderId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        User u = new User();
                        u.UserId = (Guid)reader["UserId"];
                        u.UserName = Convert.ToString(reader["UserName"]);

                        crew.Add(u);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return crew;
        }

        public List<Pothole> GetOrderPotholes(int orderId)
        {
            List<Pothole> orderPotholes = new List<Pothole>();

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    string query = "SELECT PotHole.PotHole_Id, PotHole.UserId, Users.UserName, PotHole.PotHoleDesc, PotHole.Lat, PotHole.Long, PotHole.Severity, PotHole.Street1, PotHole.Street2, PotHole.LocationDesc, PotHole.DateReported, PotHole.InspectedDate, PotHole.RepairDate, PotHole.IsValidated FROM PotHole JOIN Users on Users.UserId = PotHole.UserId JOIN WorkOrderPotholeUser ON PotHole.PotHole_Id = WorkOrderPotholeUser.PotHole_Id WHERE WorkOrderPotholeUser.WorkOrderId = @workOrderId GROUP BY PotHole.PotHole_Id, PotHole.UserId, Users.UserName, PotHole.PotHoleDesc, PotHole.Lat, PotHole.Long, PotHole.Severity, PotHole.Street1, PotHole.Street2, PotHole.LocationDesc, PotHole.DateReported, PotHole.InspectedDate, PotHole.RepairDate, PotHole.IsValidated;";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@workOrderId", orderId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Pothole p = MapRows(reader);

                        orderPotholes.Add(p);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw;
            }

            return orderPotholes;
        }
    }
}