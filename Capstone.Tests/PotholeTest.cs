using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.SqlClient;
using System.Transactions;

namespace Capstone.Tests.Pothole_Tests
{
	[TestClass]
	public class PotholeTest
	{
		const string connectionString = @"Server=.\SQLEXPRESS;Database=PotHoleDB;Trusted_Connection=True;";

		[TestMethod]
		public void SearchPotholeByStreet()
		{
			using (TransactionScope transaction = new TransactionScope())
			{
				//Arrange
				
			}
		}

		//helper method to create fake pothole
		public static string InsertFakePothole(int userId, string holeDesc, double lat, double Long, int severity, string Street1, string Street2, string locDesc, bool isValidated )
		{
			using (SqlConnection conn = new SqlConnection(connectionString))
			{
				conn.Open();

				SqlCommand cmd = new SqlCommand("INSERT INTO PotHole VALUES(@userId,@holeDesc,@lat,@Long,@severity,@Street1,@Street2,'2018-03-03',@locDesc,@isValidated)", conn);
				cmd.Parameters.AddWithValue("@userId", userId);


			}
				return ($"({lat}, {Long})");
		}
	}
}
