using System.Collections.Generic;
using System.Threading.Tasks;
using DotVVM.Framework.ViewModel;
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
		
		[Bind(Direction.ServerToClientFirstRequest)]
		public string ServerName {get; set;}

        public int LocalCount {get; set;}

        /*
        [Bind(Direction.ServerToClient)] can be used to note client doesn't need to send these to the server.
        This improves the performance a little bit, but the side effect is that the postback page will not show the other side.
        
        Alternatively,
        1. We can always populate entire view model, if that is cheaper than View Model travel.
        2. We can use REST API Bindings: https://www.dotvvm.com/docs/tutorials/basics-optimizing-postbacks/2.0
        */
        //[Bind(Direction.ServerToClient)]
        public LegacyTable1Record LegacyTable1Record {get; set;}

        //[Bind(Direction.ServerToClient)]
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
