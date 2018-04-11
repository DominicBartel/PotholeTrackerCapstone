using Capstone.Web.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Capstone.Web.Models;

namespace Capstone.Web.Controllers
{
    public class PotholesController : ApiController
    {

        public IPotholeDAL potholeDAL;

        
        public PotholesController(IPotholeDAL dal)
        {
            this.potholeDAL = dal;
        }
        // GET api/<controller>
        [HttpGet]
        [Route("api/potholes")]
        public IHttpActionResult GetAllPotholes()
        {
            var pothole = potholeDAL.GetAllValidPotholes();

            return Ok(pothole);
        }

        [HttpGet]
        [Route("api/potholessearch")]
        public IHttpActionResult SearchValidPotHoles(bool isvalidated, string userName, string street1, string street2, string locationDesc, string potholeDesc, int? severity)
        {

            PotholeViewModel tempModel = new PotholeViewModel();

            tempModel.IsValidated = isvalidated;
            tempModel.UserName = userName;
            tempModel.Street1 = street1;
            tempModel.Street2 = street2;
            tempModel.LocationDesc = locationDesc;
            tempModel.PotholeDesc = potholeDesc;
            tempModel.Severity = severity;

            

            var pothole = potholeDAL.SearchValidPotHoles(tempModel).PotholeList;

            return Ok(pothole);
        }


        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}