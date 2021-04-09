using System.Collections.Generic;
using System.Threading.Tasks;
using DotVVM.Framework.ViewModel;
using System.Net.Http;
using DotVVM.Framework.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;

namespace DotvvmApp.ViewModels
{
    public class DefaultViewModel : MasterPageViewModel
    {
        private readonly WebApiClient _webApiClient;

		[ActivatorUtilitiesConstructor]
        public DefaultViewModel(WebApiClient webApiClient)
		{
            _webApiClient = webApiClient;
        }
		
		public string Title { get; set;}
		public string ServerName {get; set;}

        public DefaultViewModel()
		{
			Title = "Hello from DotVVM!";
		}

        public override async Task Load()
        {
			ServerName = await _webApiClient.GetServerName();
        }
    }
}
