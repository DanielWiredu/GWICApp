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

namespace GWICApp.Products
{
    public partial class ProductsSold : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
              
            }
        }

        protected void pdtSoldGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["id"] = item["id"].Text;
                dpDate1.SelectedDate = Convert.ToDateTime(item["salesdate"].Text);
                dlProduct1.SelectedValue = item["ProductId"].Text;
                txtQuantity1.Text = item["Quantity"].Text;
                getPDTBalance1(dlProduct1.SelectedValue);
                txtUnitPrice1.Text = item["UnitPrice"].Text;
                txtAmount1.Text = item["Amount"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }


        protected void dlProduct_TextChanged(object sender, EventArgs e)
        {
            getPDTBalance(dlProduct.SelectedValue);
        }
        protected void getPDTBalance(string productId)
        {
            if (productId == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select a Product', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetPDTBalance", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@productId", SqlDbType.Int).Value = productId;
                    command.Parameters.Add("@pdtBalance", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@unitPrice", SqlDbType.Float).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        txtQtyRem.Value = Convert.ToDouble(command.Parameters["@pdtBalance"].Value);
                        txtQuantity.MaxValue = txtQtyRem.Value.Value;
                        txtUnitPrice.Value = Convert.ToDouble(command.Parameters["@unitPrice"].Value);
                        txtAmount.Value = 0;
                        txtQuantity.Text = "";
                        txtQuantity.Enabled = true;
                    }
                    catch (Exception ex)
                    {
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Product has no balance in stock', 'Error');", true);
                        txtQtyRem.Value = 0;
                        txtUnitPrice.Value = 0;
                        txtQuantity.Text = "";
                        txtAmount.Value = 0;
                        txtQuantity.Enabled = false;
                    }
                }
            }
        }

        protected void getPDTBalance1(string productId)
        {
            if (productId == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select a Product', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spGetPDTBalance", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@productId", SqlDbType.VarChar).Value = productId;
                    command.Parameters.Add("@pdtBalance", SqlDbType.Int).Direction = ParameterDirection.Output;
                    command.Parameters.Add("@unitPrice", SqlDbType.Float).Direction = ParameterDirection.Output;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        txtQtyRem1.Value = Convert.ToDouble(command.Parameters["@pdtBalance"].Value);
                        txtQuantity1.MaxValue = txtQtyRem1.Value.Value + txtQuantity1.Value.Value;
                        //txtUnitPrice1.Value = Convert.ToDouble(command.Parameters["@sellingPrice"].Value);
                        //txtAmount1.Value = 0;
                        //txtQuantity1.Text = "";
                        //txtQuantity1.Enabled = true;
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Product has no balance in stock', 'Error');", true);
                        txtQtyRem1.Value = 0;
                        txtUnitPrice1.Value = 0;
                        txtQuantity1.Text = "";
                        txtAmount1.Value = 0;
                        txtQuantity1.Enabled = false;
                    }
                }
            }
        }

        protected void txtQuantity_TextChanged(object sender, EventArgs e)
        {
            if (txtUnitPrice.Text != "")
            {
                txtAmount.Value = txtUnitPrice.Value * txtQuantity.Value;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Invalid Unit Price', 'Error');", true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (dlProduct.SelectedValue == "")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Select a Product', 'Error');", true);
                return;
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spAddProductSold", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@salesdate", SqlDbType.Date).Value = dpDate.SelectedDate;
                    command.Parameters.Add("@yyyymm", SqlDbType.VarChar).Value = dpDate.SelectedDate.Value.ToString("yyyyMM");
                    command.Parameters.Add("@productId", SqlDbType.VarChar).Value = dlProduct.SelectedValue;
                    command.Parameters.Add("@quantity", SqlDbType.Int).Value = txtQuantity.Text;
                    command.Parameters.Add("@unitprice", SqlDbType.Float).Value = txtUnitPrice.Text;
                    command.Parameters.Add("@amount", SqlDbType.Float).Value = txtAmount.Text;
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
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                            pdtSoldGrid.Rebind();
                            getPDTBalance(dlProduct.SelectedValue);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void txtQuantity1_TextChanged(object sender, EventArgs e)
        {
            if (txtUnitPrice1.Text != "")
            {
                txtAmount1.Value = txtUnitPrice1.Value * txtQuantity1.Value;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Invalid Unit Price', 'Error');", true);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spUpdateProductSold", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@salesdate", SqlDbType.Date).Value = dpDate1.SelectedDate;
                    command.Parameters.Add("@yyyymm", SqlDbType.VarChar).Value = dpDate1.SelectedDate.Value.ToString("yyyyMM");
                    command.Parameters.Add("@quantity", SqlDbType.Int).Value = txtQuantity1.Text;
                    command.Parameters.Add("@unitprice", SqlDbType.Float).Value = txtUnitPrice1.Text;
                    command.Parameters.Add("@amount", SqlDbType.Float).Value = txtAmount1.Text;
                    command.Parameters.Add("@salesId", SqlDbType.Int).Value = ViewState["id"].ToString();
                    command.Parameters.Add("@productId", SqlDbType.VarChar).Value = dlProduct1.SelectedValue;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                            pdtSoldGrid.Rebind();
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

        protected void pdtSoldGrid_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            GridDataItem item = e.Item as GridDataItem;
            string deleteid = item["id"].Text;
            string productId = item["ProductId"].Text;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand("spDeleteProductSold", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add("@salesId", SqlDbType.Int).Value = deleteid;
                    command.Parameters.Add("@productId", SqlDbType.VarChar).Value = productId;
                    command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                    try
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                        int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                        if (retVal == 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnExcelExport_Click(object sender, EventArgs e)
        {
            pdtSoldGrid.MasterTableView.ExportToExcel();
        }

        protected void btnPDFExport_Click(object sender, EventArgs e)
        {
            pdtSoldGrid.MasterTableView.ExportToPdf();
        }
    }
}