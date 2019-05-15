using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Security.Cryptography;

namespace GWICApp
{
    public partial class Login : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                    // This is an unauthorized, authenticated request...
                    Response.Redirect("~/Errors/UnauthorizedAccess.aspx");

                FormsAuthentication.SignOut();
                Session.Abandon();

                //clear authentication cookie
                HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
                cookie1.Expires = DateTime.Now.AddYears(-1);
                Response.Cookies.Add(cookie1);

                //
                HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
                cookie2.Expires = DateTime.Now.AddYears(-1);
                Response.Cookies.Add(cookie2);
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //Response.Redirect("/Dashboard.aspx");
            try
            {
                string query = "select * from Users where UserName = '" + txtUsername.Text.Trim() + "'";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    if (Convert.ToInt16(reader["Active"]) == 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.warning('Your Account is Deactivated...Please contact the Administrator','Login Failed');", true);
                        return;
                    }
                    byte[] hashedPassword = reader["UserPassword"] as byte[];
                    if (MatchSHA1(hashedPassword, GetSHA1(txtUsername.Text.Trim(), txtPassword.Text.Trim())))
                    {
                        string userrole = reader["AccessLevel"].ToString();
                        Session["userrole"] = userrole;

                        FormsAuthentication.SetAuthCookie(txtUsername.Text.Trim(), false);

                        FormsAuthenticationTicket ticket1 = new FormsAuthenticationTicket(
                                   1,                                   // version
                                this.txtUsername.Text.Trim(),   // get username  from the form
                                DateTime.Now,                        // issue time is now
                                DateTime.Now.AddMinutes(25),         // expires in 10 minutes
                                false,      // cookie is not persistent
                                userrole                            // role assignment is stored in userData
                                );

                        HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket1));
                        Response.Cookies.Add(cookie1);

                        // 4. Do the redirect. 
                        String returnUrl1 = "/Dashboard.aspx";
                        // the login is successful
                        //if (Request.QueryString["ReturnUrl"] == null || Request.QueryString["ReturnUrl"] == "/")
                        //{
                        //    returnUrl1 = "/Dashboard.aspx";
                        //}

                        ////login not unsuccessful 
                        //else
                        //{
                        //    returnUrl1 = Request.QueryString["ReturnUrl"];
                        //}
                        Response.Redirect(returnUrl1);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Wrong Password','Login Failed');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('User does not exist','Login Failed');", true);
                }
                reader.Close();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error(''" + ex.Message.Replace("'", "").Replace("\r\n", "") + "'','Login Failed');", true);
            }
            finally
            {
                connection.Close();
            }
        }
        private static bool MatchSHA1(byte[] p1, byte[] p2)
        {
            bool result = false;
            if (p1 != null && p2 != null)
            {
                if (p1.Length == p2.Length)
                {
                    result = true;
                    for (int i = 0; i < p1.Length; i++)
                    {
                        if (p1[i] != p2[i])
                        {
                            result = false;
                            break;
                        }
                    }
                }
            }
            return result;
        }
        /// <summary>
        /// Returns the SHA1 hash of the combined userID and password.
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        private static byte[] GetSHA1(string userID, string password)
        {
            SHA1CryptoServiceProvider sha = new SHA1CryptoServiceProvider();
            return sha.ComputeHash(System.Text.Encoding.ASCII.GetBytes(userID + password));
        }
    }
}