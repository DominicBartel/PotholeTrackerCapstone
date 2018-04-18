using Capstone.Web.Authentication;
using Capstone.Web.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Capstone.Web.DAL
{
    public interface IPotholeDAL
    {
        List<Pothole> GetAllValidPotholes();

        PotholeViewModel SearchValidPotHoles(PotholeViewModel viewModel);

        bool ReportPothole(Pothole pothole);

        bool UpdatePothole(Pothole pothole);

        bool DeletePothole(Pothole pothole);

        bool ScheduleWorkOrder(WorkOrder workOrder, string userList, string potholeList);

        List<User> GetAllCrewMembers();

        List<User> GetAllCrewLeaders();

        List<WorkOrder> GetAllWorkOrders();

        List<User> GetAllUsers();

        bool UpdateUserRole(Guid userId, string role);

        bool UpdateWorkOrder(WorkOrder workOrder);

        List<WorkOrder> GetLeaderOrders(string userName);

        List<WorkOrder> GetMemberOrders(string userName);

        List<User> GetOrderCrewMembers(int orderId);

        List<Pothole> GetOrderPotholes(int orderId);

        Guid GetUserId(string userName);

    }
}
