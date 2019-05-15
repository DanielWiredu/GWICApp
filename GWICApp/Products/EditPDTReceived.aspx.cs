using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GWICApp.Products
{
    public partial class EditPDTReceived : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = "select * from ProductsReceived where id=@id";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.Add("@id", SqlDbType.Int).Value = int.Parse(Session["pdtReceivedID"].ToString());
                        try
                        {
                            connection.Open();
                            using (SqlDataReader reader = command.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    ViewState["id"] = Convert.ToInt32(reader["id"]);
                                    dpDate.SelectedDate = Convert.ToDateTime(reader["receiveddate"]);
                                    dlDepartment.SelectedValue = reader["department"].ToString();
                                    txtQuantity.Text = reader["quantity"].ToString();
                                    ViewState["quantity"] = Convert.ToInt32(reader["quantity"]);
                                    dlProduct.SelectedValue = reader["productId"].ToString();
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
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int quantity = Math.Abs(int.Parse(txtQuantity.Text));
            int updateStock = 0;
            if (txtQuantity.Text != ViewState["quantity"].ToString())
            {
                updateStock = 1;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spUpdateProductReceived", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@receiveddate", SqlDbType.Date).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@department", SqlDbType.VarChar).Value = dlDepartment.SelectedValue;
                    command.Parameters.Add("@quantity", SqlDbType.Int).Value = txtQuantity.Text;
                    command.Parameters.Add("@receivedby", SqlDbType.VarChar).Value = txtReceiver.Text;
                    command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
                    command.Parameters.Add("@productId", SqlDbType.Int).Value = dlProduct.SelectedValue;
                    command.Parameters.Add("@receiveid", SqlDbType.Int).Value = ViewState["id"].ToString();
                    command.Parameters.Add("@updateStock", SqlDbType.Int).Value = updateStock;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                        }
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