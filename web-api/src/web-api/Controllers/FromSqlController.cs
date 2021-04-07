using System.Collections.Generic;
using System.Data;
using Dapper;
using Microsoft.AspNetCore.Mvc;

namespace web_api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FromSqlController : ControllerBase
    {
        private readonly IDbConnection _conn;

        public FromSqlController(IDbConnection conn)
        {
            _conn = conn;
        }

        [HttpGet]
        public IEnumerable<LegacyTable1Record> Get()
        {
            var recs = _conn.Query<LegacyTable1Record>(@"
insert into LegacyTable1(CreatedDateUtc) values(getutcdate());
select Id, CreatedDateUtc from LegacyTable1 where Id = scope_identity()
");
            return recs;
        }
    }
}
