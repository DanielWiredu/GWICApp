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
    public partial class BankRegister : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dpDate.SelectedDate = DateTime.Now;
                txtPreparedBy.Text = Context.User.Identity.Name;
            }
        }

        protected void bankregisterGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["id"] = item["id"].Text;
                dpDate1.SelectedDate = Convert.ToDateTime(item["regdate"].Text);
                dlBank1.SelectedValue = item["bank"].Text;
                txtCash1.Text = item["cash_deposit"].Text;
                txtCheque1.Text = item["cheque_deposit"].Text;
                txtTotal1.Text = item["total_amount"].Text;
                txtRemarks1.Text = item["remarks"].Text;
                txtPreparedBy1.Text = item["prepared_by"].Text;
               
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void bankregisterGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
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

        protected void txtCash_TextChanged(object sender, EventArgs e)
        {
            if (txtCash.Value != 0 || txtCheque.Value != 0)
            {
                txtTotal.Value = txtCash.Value + txtCheque.Value;
            }
        }

        protected void txtCheque_TextChanged(object sender, EventArgs e)
        {
            if (txtCash.Value != 0 || txtCheque.Value != 0)
            {
                txtTotal.Value = txtCash.Value + txtCheque.Value;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string query = "INSERT INTO BankRegister (regdate,bank,cash_deposit,cheque_deposit,total_amount,remarks,prepared_by)"; 
                query += "VALUES (@regdate, @bank, @cash_deposit, @cheque_deposit, @total_amount, @remarks, @prepared_by)";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.Parameters.Add("@regdate", SqlDbType.Date).Value = dpDate.SelectedDate;
                command.Parameters.Add("@bank", SqlDbType.VarChar).Value = dlBank.SelectedValue;
                command.Parameters.Add("@cash_deposit", SqlDbType.Money).Value = txtCash.Text;
                command.Parameters.Add("@cheque_deposit", SqlDbType.Money).Value = txtCheque.Text;
                command.Parameters.Add("@total_amount", SqlDbType.Money).Value = txtTotal.Text;
                command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
                command.Parameters.Add("@prepared_by", SqlDbType.VarChar).Value = txtPreparedBy.Text;
                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Bank Register Saved Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                    bankregisterGrid.Rebind();
                    txtCash.Text = "0.0"; txtCheque.Text = "0.0"; txtTotal.Text = "0.0"; txtRemarks.Text = "";
                }
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }

        protected void txtCash1_TextChanged(object sender, EventArgs e)
        {
            if (txtCash1.Value != 0 || txtCheque1.Value != 0)
            {
                txtTotal1.Value = txtCash1.Value + txtCheque1.Value;
            }
        }

        protected void txtCheque1_TextChanged(object sender, EventArgs e)
        {
            if (txtCash1.Value != 0 || txtCheque1.Value != 0)
            {
                txtTotal1.Value = txtCash1.Value + txtCheque1.Value;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                string query = "UPDATE BankRegister SET regdate=@regdate, bank=@bank, cash_deposit=@cash_deposit, cheque_deposit=@cheque_deposit, ";
                query += "total_amount=@total_amount, remarks=@remarks, prepared_by=@prepared_by WHERE id = '" + ViewState["id"].ToString() + "'";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.Parameters.Add("@regdate", SqlDbType.Date).Value = dpDate1.SelectedDate;
                command.Parameters.Add("@bank", SqlDbType.VarChar).Value = dlBank1.SelectedValue;
                command.Parameters.Add("@cash_deposit", SqlDbType.Money).Value = txtCash1.Text;
                command.Parameters.Add("@cheque_deposit", SqlDbType.Money).Value = txtCheque1.Text;
                command.Parameters.Add("@total_amount", SqlDbType.Money).Value = txtTotal1.Text;
                command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks1.Text;
                command.Parameters.Add("@prepared_by", SqlDbType.VarChar).Value = Context.User.Identity.Name;
                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Bank Register Updated Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                    bankregisterGrid.Rebind();
                }
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }
    }
}