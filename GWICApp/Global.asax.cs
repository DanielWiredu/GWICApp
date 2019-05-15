using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Security.Principal;
using System.Net.Mail;


namespace GWICApp
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {

        }
        protected void Application_AuthenticateRequest(Object sender, EventArgs e)
        {
            if (HttpContext.Current.User != null)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    if (HttpContext.Current.User.Identity is FormsIdentity)
                    {
                        FormsIdentity id = (FormsIdentity)HttpContext.Current.User.Identity;
                        FormsAuthenticationTicket ticket = id.Ticket;
                        string userData = ticket.UserData;
                        string[] roles = userData.Split(',');
                        HttpContext.Current.User = new GenericPrincipal(id, roles);
                    }
                }
            }
        }
        void Application_Error(object sender, EventArgs e)
        {
            if (HttpContext.Current.Server.GetLastError() != null)
            {
                //Exception myException =
                //HttpContext.Current.Server.GetLastError().GetBaseException();
                //string mailSubject = "Error in page " + Request.Url.ToString();
                //string message = string.Empty;
                //message += "<strong>Message</strong><br />" + myException.Message + "<br />";
                //message += "<strong>Stack Trace</strong><br />" + myException.StackTrace +
                //"<br />";
                //message += "<strong>Query String</strong><br />" +
                //Request.QueryString.ToString() + "<br />";
                //MailMessage myMessage = new MailMessage("danielwiredu@gmail.com",
                //"barimah100@yahoo.com", mailSubject, message);
                //myMessage.IsBodyHtml = true;
                //SmtpClient mySmtpClient = new SmtpClient();
                //mySmtpClient.Send(myMessage);
            }
        }
    }
}