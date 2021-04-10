using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using DotvvmApp.VerticalSlice.Api.Client;

namespace DotvvmApp.ViewModels
{
    public class DefaultViewModel : MasterPageViewModel
    {
        private readonly VerticalSliceClient _webApiClient;

        public DefaultViewModel(VerticalSliceClient webApiClient)
		{
            _webApiClient = webApiClient;
            LocalCount = 1;
        }
		
		public string Title { get; set;}
		public string ServerName {get; set;}
        public int LocalCount {get; set;}
        public LegacyTable1Record LegacyTable1Record {get; set;}
        public IEnumerable<WeatherForecast> WeatherForecast {get; set;}

        public override async Task Load()
        {
			ServerName = await _webApiClient.GetServerName();
        }

        public void IncreaseLocalCount()
        {
            LocalCount++;
        }

        public async Task RefreshFromWeatherCast()
        {
            WeatherForecast = await _webApiClient.GetWeatherForecast();
        }

        public async Task RefreshFromSql()
        {
            LegacyTable1Record = await _webApiClient.GetFromSql();
        }
    }
}
