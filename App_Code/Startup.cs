using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BMW_Survey.Startup))]
namespace BMW_Survey
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
