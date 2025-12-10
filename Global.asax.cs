using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace ExamenProgra6FinalFront
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {

            // Código que se ejecuta al iniciar la aplicación
            /*    AreaRegistration.RegisterAllAreas();
                RouteConfig.RegisterRoutes(RouteTable.Routes);
            */

            // Código que se ejecuta al iniciar la aplicación
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            // Deshabilitar UnobtrusiveValidationMode para evitar dependencia de jQuery
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            // Si en el futuro quieres usar validación no intrusiva, descomenta estas líneas:
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.WebForms;
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-3.6.0.min.js",
                DebugPath = "~/Scripts/jquery-3.6.0.js",
                CdnPath = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js",
                CdnDebugPath = "https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.js",
                CdnSupportsSecureConnection = true,
                LoadSuccessExpression = "window.jQuery"
            });
        }
    }
}