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
    public partial class EditItemIssued : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = "select * from ItemsIssued where id=@id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@id", SqlDbType.Int).Value = int.Parse(Session["itemIssuedID"].ToString());
                        try
                        {
                            connection.Open();
                            using (SqlDataReader reader = command.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    ViewState["id"] = Convert.ToInt32(reader["id"]);
                                    dpDate.SelectedDate = Convert.ToDateTime(reader["issuedate"]);
                                    dlDepartment.SelectedValue = reader["department"].ToString();
                                    dlItem.SelectedValue = reader["itemId"].ToString();
                                    txtQuantityIssued.Text = reader["quantityissued"].ToString();
                                    ViewState["quantityissued"] = Convert.ToInt32(reader["quantityissued"]);
                                    txtReceiver.Text = reader["receivedby"].ToString();
                                    txtRemarks.Text = reader["remarks"].ToString();
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }
                getItemBalance();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int UpdateStock = 0;
            if (txtQuantityIssued.Text != ViewState["quantityissued"].ToString())
            {
                //quantity changed...Update Stock
                UpdateStock = 1;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spUpdateItemIssued", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@issuedate", SqlDbType.Date).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@department", SqlDbType.VarChar).Value = dlDepartment.SelectedValue;
                    command.Parameters.Add("@quantityissued", SqlDbType.Int).Value = txtQuantityIssued.Text;
                    command.Parameters.Add("@receivedby", SqlDbType.VarChar).Value = txtReceiver.Text;
                    command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
                    command.Parameters.Add("@itemId", SqlDbType.Int).Value = dlItem.SelectedValue;
                    command.Parameters.Add("@issueid", SqlDbType.Int).Value = ViewState["id"].ToString();
                    command.Parameters.Add("@updateStock", SqlDbType.Int).Value = UpdateStock;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
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
        protected void getItemBalance()
        {
            string item = dlItem.SelectedValue;
            if (item == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select an Item', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetItemBalance", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@itemId", SqlDbType.VarChar).Value = item;
                    command.Parameters.Add("@itemBalance", SqlDbType.Int).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        txtItemBalance.Value = Convert.ToDouble(command.Parameters["@itemBalance"].Value);
                        txtQuantityIssued.MaxValue = txtItemBalance.Value.Value + txtQuantityIssued.Value.Value;
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }
    }
}