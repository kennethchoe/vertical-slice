using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Mvc;

namespace web_api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HeavyProcessController : ControllerBase
    {
        private readonly IDbConnection _conn;

        public HeavyProcessController(IDbConnection conn)
        {
            _conn = conn;
        }

        [HttpGet("WorkHardCpu")]
        public async Task<int> WorkHardCpu(int milliSeconds)
        {
            return await WorkHard(milliSeconds, async () => { });
        }

        [HttpGet("WorkHardSql")]
        public async Task<int> WorkHardSql(int milliSeconds)
        {
            return await WorkHard(milliSeconds, async () => {
                await _conn.ExecuteAsync("select getdate()");
            });
        }

        private async Task<int> WorkHard(int milliSeconds, Func<Task> action)
        {
            var endTime = DateTime.Now.AddMilliseconds(milliSeconds);
            var result = 0;
            while (DateTime.Now < endTime) { 
                await action.Invoke();
                result++;
            };
            return result;
        }
    }
}
