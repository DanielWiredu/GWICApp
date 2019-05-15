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
    public partial class ProjectPayments : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtPayerID.Text = Session["payerid"].ToString();
                txtFullname.Text = Session["surname"].ToString() + " " + Session["othernames"].ToString();
                txtTelephone.Text = Session["telephone"].ToString();
                if (txtPayerID.Text.StartsWith("V"))
                    btnReturn.PostBackUrl = "/Financials/ProjectVisitors.aspx";
                else
                    btnReturn.PostBackUrl = "/Financials/ProjectMembers.aspx";

                txtTotalAmt.Text = getTotalPayments(txtPayerID.Text);

                dpPaydate.SelectedDate = DateTime.Now;
            }
        }
        protected string getTotalPayments(string payerid)
        {
            double totalamt = 0.0;
            string query = "select isnull(sum(payamt),0) as totalpaid from ProjectPayments where payerid = '" + payerid + "'";
            command = new SqlCommand(query, connection);
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    totalamt = Convert.ToDouble(reader["totalpaid"]);
                }
                reader.Close();
            }
            catch (SqlException ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
            return String.Format("{0:0.00}", totalamt);
        }

        protected void paymentGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["payid"] = item["id"].Text;
                dpPaydate1.SelectedDate = Convert.ToDateTime(item["paydate"].Text);
                dlProject1.SelectedValue = item["paymsg"].Text;
                txtAmount1.Text = item["payamt"].Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void paymentGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                txtTotalAmt.Text = getTotalPayments(txtPayerID.Text);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string yyyymm = dpPaydate.SelectedDate.Value.ToString("yyyyMM");
            string query = "insert into ProjectPayments(payerid,paydate,payyearmm,paymsg,payamt,signedby) values(@payerid,@paydate,@payyearmm,@paymsg,@payamt,@signedby)";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@payerid", SqlDbType.VarChar).Value = txtPayerID.Text;
            command.Parameters.Add("@paydate", SqlDbType.Date).Value = dpPaydate.SelectedDate;
            command.Parameters.Add("@payyearmm", SqlDbType.VarChar).Value = yyyymm;
            command.Parameters.Add("@paymsg", SqlDbType.VarChar).Value = dlProject.SelectedValue;
            command.Parameters.Add("@payamt", SqlDbType.VarChar).Value = txtAmount.Text;
            command.Parameters.Add("@signedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Payment Saved Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                    paymentGrid.Rebind();
                    txtTotalAmt.Text = getTotalPayments(txtPayerID.Text);
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string yyyymm = dpPaydate1.SelectedDate.Value.ToString("yyyyMM");
            string query = "update ProjectPayments set paydate=@paydate,payyearmm=@payyearmm,paymsg=@paymsg,payamt=@payamt,signedby=@signedby WHERE id=@id";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@paydate", SqlDbType.Date).Value = dpPaydate1.SelectedDate;
            command.Parameters.Add("@payyearmm", SqlDbType.VarChar).Value = yyyymm;
            command.Parameters.Add("@paymsg", SqlDbType.VarChar).Value = dlProject1.SelectedValue;
            command.Parameters.Add("@payamt", SqlDbType.VarChar).Value = txtAmount1.Text;
            command.Parameters.Add("@signedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            command.Parameters.Add("@id", SqlDbType.VarChar).Value = ViewState["payid"].ToString();
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Payment Updated Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                    paymentGrid.Rebind();
                    txtTotalAmt.Text = getTotalPayments(txtPayerID.Text);
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
}