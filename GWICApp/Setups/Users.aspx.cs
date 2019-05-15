using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Security.Cryptography;
using System.Drawing;

namespace GWICApp.Setups
{
    public partial class Users : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    bool isinrole = Page.User.IsInRole("User");
            //    if (isinrole)
            //    {
            //        Response.Redirect("~/UnauthorizedAccess.aspx");
            //    }
            //}
        }

        protected void usersGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["userid"] = item["UserID"].Text;
                txtUname.Text = item["UserName"].Text;
                txtUPass.Text = "password";
                dlLevel.SelectedText = item["AccessLevel"].Text;
                string active = item["Active"].Text;
                if (active == "1")
                    chkActive1.Checked = true;
                else
                    chkActive1.Checked = false;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
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

        protected void btnSave_Click(object sender, EventArgs e)
        {
            byte[] hashedPassword = GetSHA1(txtUsername.Text, txtPassword.Text);
            try
            {
                Int16 active = 0;
                if (chkActive.Checked == true)
                    active = 1;

                string query = "insert into Users(UserName,UserPassword,AccessLevel,Active,DateCreated) values(@uname,@upass,@ulevel,@active,@datecreated)";
                command = new SqlCommand(query, connection);
                command.Parameters.Add("@uname", SqlDbType.VarChar).Value = txtUsername.Text;
                command.Parameters.Add("@upass", SqlDbType.VarBinary).Value = hashedPassword;
                command.Parameters.Add("@ulevel", SqlDbType.VarChar).Value = dlAccessLevel.SelectedText;
                command.Parameters.Add("@active", SqlDbType.TinyInt).Value = active;
                command.Parameters.Add("@datecreated", SqlDbType.Date).Value = DateTime.Now.Date;

                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('User Saved Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                    usersGrid.Rebind();
                    txtUsername.Text = "";
                }
                command.Dispose();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('User already exist', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            byte[] hashedPassword = GetSHA1(txtUname.Text, txtUPass.Text);
            try
            {
                Int16 active = 0;
                if (chkActive1.Checked == true)
                    active = 1;

                string query = "update Users set UserName=@uname,UserPassword=@upass,AccessLevel=@ulevel,Active=@active where UserID=@userid";
                command = new SqlCommand(query, connection);
                command.Parameters.Add("@uname", SqlDbType.VarChar).Value = txtUname.Text;
                command.Parameters.Add("@upass", SqlDbType.VarBinary).Value = hashedPassword;
                command.Parameters.Add("@ulevel", SqlDbType.VarChar).Value = dlLevel.SelectedText;
                command.Parameters.Add("@active", SqlDbType.TinyInt).Value = active;
                command.Parameters.Add("@userid", SqlDbType.Int).Value = ViewState["userid"];
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('User Updated Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                    usersGrid.Rebind();
                }
                command.Dispose();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('User already exist', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }

        protected void usersGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Error occured during delete. Try again', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }

        protected void usersGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                TableCell status = item["Active"];
                TableCell userid = item["UserID"];
                if (status.Text == "1")
                {
                    userid.BackColor = Color.GreenYellow;
                }
                else if (status.Text == "0")
                {
                    userid.BackColor = Color.HotPink;
                }
            }
        }
    }
}