using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;

namespace DotvvmApp.VerticalSlice.Api.Client
{
    public class VerticalSliceClient
    {
        static readonly HttpClient client = new HttpClient();
        private readonly VerticalSliceConfig _config;

        public VerticalSliceClient(VerticalSliceConfig apiEndpointConfig)
        {
            _config = apiEndpointConfig;
        }

        internal async Task<string> GetServerName()
        {
            var result = await client.GetStringAsync(_config.ApiEndpoint + "/api/serverInfo");
            return result;
        }

        internal async Task<LegacyTable1Record> GetFromSql()
        {
            var result = await client.GetAsync(_config.ApiEndpoint + "/api/fromsql");
            return result.Content.ReadAsAsync<IEnumerable<LegacyTable1Record>>().Result.Single();
        }

        internal async Task<IEnumerable<WeatherForecast>> GetWeatherForecast()
        {
            var result = await client.GetAsync(_config.ApiEndpoint + "/api/weatherforecast");
            return result.Content.ReadAsAsync<IEnumerable<WeatherForecast>>().Result;
        }
    }
}