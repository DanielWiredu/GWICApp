using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;

namespace GWICApp
{
    public partial class Home : System.Web.UI.MasterPage
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblUser.Text = Context.User.Identity.Name;
                //lblUser.Text = "Daniel Wiredu";
                //imglogo.Src = "/Content/img/user.png";

                int bdays = 0;
                string lowItems = "";
                string lowProducts = "";
                string dueEvents = "";
                string mm = "Today";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand("spGetNotifications", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@lowRawMaterials", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@lowProducts", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@bdays", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@dueEvents", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                        try
                        {
                            connection.Open();
                            command.ExecuteNonQuery();
                            int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                            if (retVal == 0)
                            {
                                lowItems = command.Parameters["@lowRawMaterials"].Value.ToString();
                                lowProducts = command.Parameters["@lowProducts"].Value.ToString();
                                bdays = Convert.ToInt16(command.Parameters["@bdays"].Value);
                                dueEvents = command.Parameters["@dueEvents"].Value.ToString();
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }

                //Display bday count
                if (bdays != 0)
                {
                    bgbdays.InnerText = bdays.ToString();
                    bgbdays.Visible = true;
                    //spbdays.InnerText = bdays.ToString();
                    //spbdays.Visible = true;
                    //lblbdays.InnerText = bdays + " Member(s) have birthday " + mm;
                }
                else
                {
                    bgbdays.Visible = false;
                    //spbdays.Visible = false;
                    //lblbdays.InnerText = "0 Member(s) have birthday " + mm;
                }

                //Display due events
                if (dueEvents != "0")
                {
                    bgEvents.InnerText = dueEvents;
                    bgEvents.Visible = true;
                    spEventsDue.InnerText = dueEvents;
                    spEventsDue.Visible = true;
                    lblEventsDue.InnerText = dueEvents + " Event(s) due";
                }
                else
                {
                    bgEvents.Visible = false;
                    spEventsDue.Visible = false;
                    lblEventsDue.InnerText = "0 Event(s) due";
                }

                //Items low in stock
                if (lowItems != "0")
                {
                    spStock.InnerText = lowItems;
                    spStock.Visible = true;
                    lblStock.InnerText = lowItems + " Item(s) low in stock";
                }
                else
                {
                    spStock.Visible = false;
                    lblStock.InnerText = "0 Item(s) low in stock";
                }

                //Products low in stock
                if (lowProducts != "0")
                {
                    spPdtStock.InnerText = lowProducts;
                    spPdtStock.Visible = true;
                    lblPdtStock.InnerText = lowProducts + " Product(s) low in stock";
                }
                else
                {
                    spPdtStock.Visible = false;
                    lblPdtStock.InnerText = "0 Product(s) low in stock";
                }

            }
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            //FormsAuthentication.SignOut();
            //Session.Abandon();

            ////clear authentication cookie
            //HttpCookie cookie1 = new HttpCookie(FormsAuthentication.FormsCookieName, "");
            //cookie1.Expires = DateTime.Now.AddYears(-1);
            //Response.Cookies.Add(cookie1);

            ////
            //HttpCookie cookie2 = new HttpCookie("ASP.NET_SessionId", "");
            //cookie2.Expires = DateTime.Now.AddYears(-1);
            //Response.Cookies.Add(cookie2);

            //Response.Redirect("/Login.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Context.User.Identity.Name != lblUser.Text)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.error('Error occured while changing password. Please login again and retry', 'Error');", true);
                return;
            }
            byte[] hashedPassword = GetSHA1(lblUser.Text, txtPassword.Text);
            string query = "update Users set UserPassword=@upass where UserName=@uname";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@upass", SqlDbType.VarBinary).Value = hashedPassword;
                    command.Parameters.Add("@uname", SqlDbType.VarChar).Value = lblUser.Text;
                    try
                    {
                        connection.Open();
                        int rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "", "toastr.success('Password Changed Successfully', 'Success');", true);
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "pop", "closepassmodal();", true);
                        }
                    }
                    catch (SqlException ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
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