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

namespace GWICApp.Main
{
    public partial class Members : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void memberGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "InitInsert")
            {
                Response.Redirect("/Main/NewMember.aspx");
            }
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Session["memberid"] = item["MemberID"].Text;
                Response.Redirect("/Main/EditMember.aspx");
            }
            if (e.CommandName == "Deactivate")
            {
                try
                {
                    GridDataItem item = e.Item as GridDataItem;
                    string memberid = item["MemberID"].Text;
                    string query = "update Members set Active = 0 where memberid = '" + memberid + "'";
                    command = new SqlCommand(query, connection);
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();
                    rows = command.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Member Deactivated Successfully','Success');", true);
                        memberGrid.Rebind();
                    }
                    command.Dispose();
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error(''" + ex.Message.Replace("'", "").Replace("\r\n", "") + "'','Error');", true);
                }
                finally
                {
                    connection.Close();
                }
            }
        }

        protected void memberGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Member and related tithe records Deleted Successfully', 'Success');", true);
            }
        }
    }
}