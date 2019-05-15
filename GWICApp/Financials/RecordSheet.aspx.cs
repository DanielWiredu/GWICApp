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

namespace GWICApp.Financials
{
    public partial class RecordSheet : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void recordSheetGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "InitInsert")
            {
                Response.Redirect("/Financials/NewRecordSheet.aspx");
            }
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Session["rsID"] = item["id"].Text;
                Response.Redirect("/Financials/EditRecordSheet.aspx");
            }
            if (e.CommandName == "Approve")
            {
                GridDataItem item = e.Item as GridDataItem;
                DateTime paydate = Convert.ToDateTime(item["Regdate"].Text);
                string amount = item["GrandTotal"].Text;
                string query = "update RecordSheet set Approved = '1' where id = '" + item["id"].Text + "'";
                command = new SqlCommand(query, connection);
                try
                {
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    rows = command.ExecuteNonQuery();
                    if (rows == 1)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Record Sheet Approved Successfully', 'Success');", true);
                        recordSheetGrid.Rebind();
                        command.Dispose();
                        //save grandtotal as income in payments
                        query = "insert into Payments(paydate,payname,description,paytype,paymode,amount,paybank,chequeno,valuedate,remarks,preparedby) ";
                        query += "values(@paydate,@payname,@description,@paytype,@paymode,@amount,@paybank,@chequeno,@valuedate,@remarks,@preparedby)";
                        command = new SqlCommand(query, connection);
                        command.Parameters.Add("@paydate", SqlDbType.Date).Value = paydate;
                        command.Parameters.Add("@payname", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                        command.Parameters.Add("@description", SqlDbType.VarChar).Value = "Offerings";
                        command.Parameters.Add("@paytype", SqlDbType.VarChar).Value = "Income";
                        command.Parameters.Add("@paymode", SqlDbType.VarChar).Value = "Cash";
                        command.Parameters.Add("@amount", SqlDbType.VarChar).Value = amount;
                        command.Parameters.Add("@paybank", SqlDbType.VarChar).Value = "";
                        command.Parameters.Add("@chequeno", SqlDbType.VarChar).Value = "";
                        command.Parameters.Add("@valuedate", SqlDbType.Date).Value = DateTime.Now;
                        command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = "Record Sheet";
                        command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "paid", "toastr.success('Posted to Payments Successfully', 'Success');", true);
                    }
                    command.Dispose();
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                }
                finally
                {
                    connection.Close();
                }
            }
        }

        protected void recordSheetGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                if (item["Approved"].Text == "1")
                {
                    item["Approve"].Enabled = false;
                    item["Delete"].Enabled = false;
                }
            }
        }

        protected void recordSheetGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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