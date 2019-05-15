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
    public partial class Events : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into Events(eventname,datefrom,dateto,reminddate,notes,createdby,createddate) ";
            query += "values(@eventname,@datefrom,@dateto,@reminddate,@notes,@createdby,@createddate)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@eventname", SqlDbType.VarChar).Value = txtEventName.Text;
                    command.Parameters.Add("@datefrom", SqlDbType.Date).Value = dpStartDate.SelectedDate;
                    command.Parameters.Add("@dateto", SqlDbType.Date).Value = dpEndDate.SelectedDate;
                    command.Parameters.Add("@reminddate", SqlDbType.Date).Value = dpRemindDate.SelectedDate;
                    command.Parameters.Add("@notes", SqlDbType.VarChar).Value = txtNotes.Text;
                    command.Parameters.Add("@createdby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    command.Parameters.Add("@createddate", SqlDbType.VarChar).Value = DateTime.Now;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Event Saved Successfully', 'Success');", true);
                            eventsGrid.Rebind();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closenewModal();", true);
                            txtEventName.Text = "";
                            dpRemindDate.Clear();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void eventsGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["id"] = item["id"].Text;
                txtEventName1.Text = item["eventname"].Text;
                dpStartDate1.SelectedDate = Convert.ToDateTime(item["datefrom"].Text);
                dpEndDate1.SelectedDate = Convert.ToDateTime(item["dateto"].Text);
                dpRemindDate1.SelectedDate = Convert.ToDateTime(item["reminddate"].Text);
                txtNotes1.Text = item["notes"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "update Events set eventname=@eventname,datefrom=@datefrom,dateto=@dateto,";
            query += "reminddate=@reminddate,notes=@notes where id = @id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@eventname", SqlDbType.VarChar).Value = txtEventName1.Text;
                    command.Parameters.Add("@datefrom", SqlDbType.Date).Value = dpStartDate1.SelectedDate;
                    command.Parameters.Add("@dateto", SqlDbType.Date).Value = dpEndDate1.SelectedDate;
                    command.Parameters.Add("@reminddate", SqlDbType.Date).Value = dpRemindDate1.SelectedDate;
                    command.Parameters.Add("@notes", SqlDbType.VarChar).Value = txtNotes1.Text;
                    command.Parameters.Add("@id", SqlDbType.Int).Value = ViewState["id"].ToString();
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Event Updated Successfully', 'Success');", true);
                            eventsGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeeditModal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }


        protected void eventsGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }
    }
}