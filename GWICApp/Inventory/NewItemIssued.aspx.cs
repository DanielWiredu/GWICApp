using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GWICApp.Inventory
{
    public partial class NewItemIssued : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (dlItem.SelectedValue == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select an Item', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spAddItemIssued", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@issuedate", SqlDbType.Date).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@department", SqlDbType.VarChar).Value = dlDepartment.SelectedValue;
                    command.Parameters.Add("@itemId", SqlDbType.Int).Value = dlItem.SelectedValue;
                    command.Parameters.Add("@quantityissued", SqlDbType.Int).Value = txtQuantityIssued.Text;
                    command.Parameters.Add("@receivedby", SqlDbType.VarChar).Value = txtReceiver.Text;
                    command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
                    command.Parameters.Add("@createdby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                    command.Parameters.Add("@createddate", SqlDbType.Date).Value = DateTime.Now;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Item Issued Successfully', 'Success');", true);
                            getItemBalance();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void dlItem_TextChanged(object sender, EventArgs e)
        {
            getItemBalance();
        }

        protected void getItemBalance()
        {
            string itemId = dlItem.SelectedValue;
            if (itemId == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select an Item', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetItemBalance", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@itemId", SqlDbType.Int).Value = itemId;
                    command.Parameters.Add("@itemBalance", SqlDbType.Int).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        txtItemBalance.Value = Convert.ToDouble(command.Parameters["@itemBalance"].Value);
                        txtQuantityIssued.MaxValue = txtItemBalance.Value.Value;
                        txtQuantityIssued.Enabled = true;
                    }
                    catch (Exception ex)
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Item has no balance in stock', 'Error');", true);
                        txtItemBalance.Value = 0;
                        txtQuantityIssued.Text = "";
                        txtQuantityIssued.Enabled = false;
                    }
                }
            }
        }
    }
}