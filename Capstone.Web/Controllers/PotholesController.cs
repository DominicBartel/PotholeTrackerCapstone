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