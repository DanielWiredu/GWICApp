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

namespace GWICApp.Setups
{
    public partial class Currencies : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void currencyGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Currency has related records...Cannot Delete', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }

        protected void currencyGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["id"] = item["id"].Text;
                txtCode1.Text = item["cur_code"].Text;
                txtName1.Text = item["cur_name"].Text;
                txtRate1.Text = item["cur_rate"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string query = "insert into Currencies(cur_code,cur_name,cur_rate) values(@ccode,@cname,@crate)";
                command = new SqlCommand(query, connection);
                command.Parameters.Add("@ccode", SqlDbType.VarChar).Value = txtCode.Text.ToUpper();
                command.Parameters.Add("@cname", SqlDbType.VarChar).Value = txtName.Text;
                command.Parameters.Add("@crate", SqlDbType.Float).Value = txtRate.Text;

                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Currency Saved Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                    currencyGrid.Rebind();
                    txtCode.Text = ""; txtName.Text = ""; txtRate.Text = "";
                }
                command.Dispose();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Currency already exist', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string query = "update Currencies set cur_code=@ccode,cur_name=@cname,cur_rate=@crate where id = '" + ViewState["id"].ToString() + "'";
                command = new SqlCommand(query, connection);
                command.Parameters.Add("@ccode", SqlDbType.VarChar).Value = txtCode1.Text.ToUpper();
                command.Parameters.Add("@cname", SqlDbType.VarChar).Value = txtName1.Text;
                command.Parameters.Add("@crate", SqlDbType.Float).Value = txtRate1.Text;

                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Currency Updated Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                    currencyGrid.Rebind();
                }
                command.Dispose();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Currency already exist', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }
    }
}