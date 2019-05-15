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
    public partial class Honourarium : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void honorariumGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                Session["hrID"] = item["id"].Text;
                Response.Redirect("/Financials/EditHonorarium.aspx");
            }
            if (e.CommandName == "Approve")
            {
                GridDataItem item = e.Item as GridDataItem;
                DateTime paydate = Convert.ToDateTime(item["Paydate"].Text);
                string payname = item["GuestName"].Text;
                double hrAmount = Convert.ToDouble(item["hrAmount"].Text);
                string hrCurrency = item["hrCurrency"].Text;
                double lgAmount = Convert.ToDouble(item["lgAmount"].Text);
                string lgCurrency = item["lgCurrency"].Text;
                string remarks = item["Remarks"].Text;
                string query = "update Honorarium set Approved = '1' where id = '" + item["id"].Text + "'";
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
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Record Approved Successfully', 'Success');", true);
                        honorariumGrid.Rebind();
                        command.Dispose();
                        //save grandtotal as income in payments
                        if (hrAmount > 0.0)
                        {
                            query = "insert into Payments(paydate,payname,description,paytype,paymode,currency,amount,paybank,chequeno,valuedate,remarks,preparedby) ";
                            query += "values(@paydate,@payname,@description,@paytype,@paymode,@currency,@amount,@paybank,@chequeno,@valuedate,@remarks,@preparedby)";
                            command = new SqlCommand(query, connection);
                            command.Parameters.Add("@paydate", SqlDbType.Date).Value = paydate;
                            command.Parameters.Add("@payname", SqlDbType.VarChar).Value = payname;
                            command.Parameters.Add("@description", SqlDbType.VarChar).Value = "Honorarium";
                            command.Parameters.Add("@paytype", SqlDbType.VarChar).Value = "Expense";
                            command.Parameters.Add("@paymode", SqlDbType.VarChar).Value = "Cash";
                            command.Parameters.Add("@currency", SqlDbType.VarChar).Value = hrCurrency;
                            command.Parameters.Add("@amount", SqlDbType.VarChar).Value = hrAmount;
                            command.Parameters.Add("@paybank", SqlDbType.VarChar).Value = "";
                            command.Parameters.Add("@chequeno", SqlDbType.VarChar).Value = "";
                            command.Parameters.Add("@valuedate", SqlDbType.Date).Value = DateTime.Now;
                            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = remarks;
                            command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                            rows += command.ExecuteNonQuery();
                            command.Dispose();
                        }
                        if (lgAmount > 0.0)
                        {
                            //query = "insert into Payments(paydate,payname,description,paytype,paymode,amount,paybank,chequeno,valuedate,remarks,preparedby) ";
                            //query += "values(@paydate,@payname,@description,@paytype,@paymode,@amount,@paybank,@chequeno,@valuedate,@remarks,@preparedby)";
                            command = new SqlCommand(query, connection);
                            command.Parameters.Add("@paydate", SqlDbType.Date).Value = paydate;
                            command.Parameters.Add("@payname", SqlDbType.VarChar).Value = payname;
                            command.Parameters.Add("@description", SqlDbType.VarChar).Value = "Honorarium(Lodging)";
                            command.Parameters.Add("@paytype", SqlDbType.VarChar).Value = "Expense";
                            command.Parameters.Add("@paymode", SqlDbType.VarChar).Value = "Cash";
                            command.Parameters.Add("@currency", SqlDbType.VarChar).Value = lgCurrency;
                            command.Parameters.Add("@amount", SqlDbType.VarChar).Value = lgAmount;
                            command.Parameters.Add("@paybank", SqlDbType.VarChar).Value = "";
                            command.Parameters.Add("@chequeno", SqlDbType.VarChar).Value = "";
                            command.Parameters.Add("@valuedate", SqlDbType.Date).Value = DateTime.Now;
                            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = remarks;
                            command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                            rows += command.ExecuteNonQuery();
                            command.Dispose();
                        }
                        if (rows > 1)
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "paid", "toastr.success('Posted to Payments Successfully', 'Success');", true);
                    }
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

        protected void honorariumGrid_ItemDataBound(object sender, GridItemEventArgs e)
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

        protected void honorariumGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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