using System;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace DotvvmApp.ViewModels
{
    public class WebApiClient
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
    }
}