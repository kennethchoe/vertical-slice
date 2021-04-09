using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace DotvvmApp.ViewModels
{
    public partial class WebApiClient
    {
		static readonly HttpClient client = new HttpClient();
        private readonly ApiEndpointConfig _apiEndpointConfig;

        public WebApiClient(ApiEndpointConfig apiEndpointConfig)
        {
            _apiEndpointConfig = apiEndpointConfig;
        }

        internal async Task<string> GetServerName()
        {
            var result = await client.GetStringAsync(_apiEndpointConfig.VerticalSlice + "/api/serverInfo");
            return result;
        }

        internal async Task<LegacyTable1Record> GetFromSql()
        {
            var result = await client.GetAsync(_apiEndpointConfig.VerticalSlice + "/api/fromsql");
            return result.Content.ReadAsAsync<IEnumerable<LegacyTable1Record>>().Result.Single();
        }
    }
}