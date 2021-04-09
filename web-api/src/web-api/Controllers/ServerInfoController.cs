using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace web_api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ServerInfoController : ControllerBase
    {
        [HttpGet]
        public string Get()
        {
            return Environment.MachineName;
        }
    }
}
