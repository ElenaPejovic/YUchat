﻿using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(YUchat.Startup))]
namespace YUchat
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            //ConfigureAuth(app);
            app.MapSignalR();
        }
    }
}
