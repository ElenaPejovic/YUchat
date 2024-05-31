using Microsoft.Owin;
using Owin;
using System.IO;
using Microsoft.Owin.Cors;
using Microsoft.Owin.FileSystems;
using Microsoft.Owin.StaticFiles;
using System;

[assembly: OwinStartup(typeof(YUchat.Startup))]

namespace YUchat
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.UseCors(CorsOptions.AllowAll);
            var frontendPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "frontend");
            var physicalFileSystem = new PhysicalFileSystem(frontendPath);
            var options = new Microsoft.Owin.StaticFiles.FileServerOptions
            {
                EnableDefaultFiles = true,
                FileSystem = physicalFileSystem
            };
            options.StaticFileOptions.FileSystem = physicalFileSystem;
            options.StaticFileOptions.ServeUnknownFileTypes = true;
            options.DefaultFilesOptions.DefaultFileNames = new[] { "index.html" };

            app.UseFileServer(options);
            app.MapSignalR();
        }
    }
}
