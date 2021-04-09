using System;
using System.Threading.Tasks;

namespace DotvvmApp.ViewModels
{
    public class DefaultViewModel : MasterPageViewModel
    {
        private readonly WebApiClient _webApiClient;

        public DefaultViewModel(WebApiClient webApiClient)
		{
            _webApiClient = webApiClient;
			Title = "Hello from DotVVM!";
            LocalCount = 1;
        }
		
		public string Title { get; set;}
		public string ServerName {get; set;}
        public int LocalCount {get; set;}
        public int Id {get; set;}
        public DateTime CreatedDateTimeUtc {get;set;}

        public override async Task Load()
        {
			ServerName = await _webApiClient.GetServerName();
        }

        public async Task RefreshFromSql()
        {
            LocalCount++;
            var fromSql = await _webApiClient.GetFromSql();
            Id = fromSql.Id;
            CreatedDateTimeUtc = fromSql.CreatedDateUtc;
        }
    }
}
