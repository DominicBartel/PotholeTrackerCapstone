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




    }
}
