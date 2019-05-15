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

namespace GWICApp.Main
{
    public partial class InactiveMembers : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void memberGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Activate")
            {
               //Activate Member
                try
                {
                    GridDataItem item = e.Item as GridDataItem;
                    string memberid = item["MemberID"].Text;
                    string query = "update Members set Active = 1 where memberid = '" + memberid + "'";
                    command = new SqlCommand(query, connection);
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();
                    rows = command.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Member Activated Successfully','Success');", true);
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
            if (e.CommandName == "Delete")
            {
               //Delete Member and all related data
                GridDataItem item = e.Item as GridDataItem;
                string memberid = item["MemberID"].Text;
                string query = "select imagepath from Members where memberid = '" + memberid + "'";
                command = new SqlCommand(query, connection);
                try
                {
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();
                    reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        memberGrid.MasterTableView.PerformDelete(item);
                        if (!String.IsNullOrEmpty(reader["imagepath"].ToString()))
                        {
                            File.Delete(Server.MapPath(reader["imagepath"].ToString()));
                        }
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Member and related tithe records Deleted Successfully', 'Success');", true);
                    }
                    reader.Close();
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

    }
}