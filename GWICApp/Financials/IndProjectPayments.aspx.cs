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
    public partial class IndProjectPayments : MasterPageChange
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
                txtPayerID.Text = Request.QueryString["payid"].ToString();
                hfProjectId.Value = Request.QueryString["prjid"].ToString();
                int payerType = 0;
                if (txtPayerID.Text.StartsWith("V"))
                {
                    btnReturn.PostBackUrl = "/Financials/ProjectVisitors.aspx?pid=" + hfProjectId.Value;
                    payerType = 2;
                }
                else
                {
                    btnReturn.PostBackUrl = "/Financials/ProjectMembers.aspx?pid=" + hfProjectId.Value;
                    payerType = 1;
                }
                    

                getIndProjectPaymtDetails(Convert.ToInt32(hfProjectId.Value), txtPayerID.Text, payerType);

                dpPaydate.SelectedDate = DateTime.Now;
            }
        }
        protected void getIndProjectPaymtDetails(int projectId, string payerid, int payertype)
        {
            command = new SqlCommand("spGetIndProjectPaymtDetails", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@projectId", SqlDbType.Int).Value = projectId;
            command.Parameters.Add("@payerId", SqlDbType.VarChar).Value = payerid;
            command.Parameters.Add("@payerType", SqlDbType.Int).Value = payertype;
            command.Parameters.Add("@payerName", SqlDbType.VarChar,100).Direction = ParameterDirection.Output;
            command.Parameters.Add("@payerPhone", SqlDbType.VarChar, 10).Direction = ParameterDirection.Output;
            command.Parameters.Add("@projectName", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;
            command.Parameters.Add("@projectBalance", SqlDbType.Float).Direction = ParameterDirection.Output;
            command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.ExecuteReader();
                int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                if (retVal == 0)
                {
                    lblProjectName.InnerText = command.Parameters["@projectName"].Value.ToString();
                    txtFullname.Text = command.Parameters["@payerName"].Value.ToString();
                    txtTelephone.Text = command.Parameters["@payerPhone"].Value.ToString();
                    txtBalance.Text = Convert.ToDouble(command.Parameters["@projectBalance"].Value).ToString("N02");
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
        protected void getIndProjectPaymtBalance(int projectId, string payerid)
        {
            command = new SqlCommand("spGetIndProjectPaymtBalance", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@projectId", SqlDbType.Int).Value = projectId;
            command.Parameters.Add("@payerId", SqlDbType.VarChar).Value = payerid;
            command.Parameters.Add("@projectBalance", SqlDbType.Float).Direction = ParameterDirection.Output;
            command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.ExecuteReader();
                int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                if (retVal == 0)
                {
                    txtBalance.Text = Convert.ToDouble(command.Parameters["@projectBalance"].Value).ToString("N02");
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

        protected void paymentGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["payid"] = item["id"].Text;
                dpPaydate1.SelectedDate = Convert.ToDateTime(item["paydate"].Text);
                txtAmount1.Text = item["payamt"].Text;
                txtReceiptNo1.Text = item["receiptno"].Text;
                if (item["paytype"].Text == "Contribution")
                    chkPledge1.Checked = false;
                else
                    chkPledge1.Checked = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string yyyymm = dpPaydate.SelectedDate.Value.ToString("yyyyMM");
            int paytype = 1;
            if (chkPledge.Checked)
                paytype = 2;
            command = new SqlCommand("spAddIndProjectPaymt", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@PayerId", SqlDbType.VarChar).Value = txtPayerID.Text;
            command.Parameters.Add("@Paydate", SqlDbType.DateTime).Value = dpPaydate.SelectedDate;
            command.Parameters.Add("@Payyyyymm", SqlDbType.VarChar).Value = yyyymm;
            command.Parameters.Add("@ProjectId", SqlDbType.Int).Value = hfProjectId.Value;
            command.Parameters.Add("@Paytype", SqlDbType.Int).Value = paytype;
            command.Parameters.Add("@Payamt", SqlDbType.VarChar).Value = txtAmount.Text;
            command.Parameters.Add("@Receiptno", SqlDbType.VarChar).Value = txtReceiptNo.Text;
            command.Parameters.Add("@CreatedBy", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            command.Parameters.Add("@projectBalance", SqlDbType.Float).Direction = ParameterDirection.Output;
            command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.ExecuteNonQuery();
                int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                if (retVal == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closenewModal();", true);
                    paymentGrid.Rebind();
                    txtBalance.Text = Convert.ToDouble(command.Parameters["@projectBalance"].Value).ToString("N02");
                    txtAmount.Text = "";
                    txtReceiptNo.Text = "";
                    chkPledge.Checked = false;
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
            int paytype = 1;
            if (chkPledge1.Checked)
                paytype = 2;
            command = new SqlCommand("spUpdateIndProjectPaymt", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@PayerId", SqlDbType.VarChar).Value = txtPayerID.Text;
            command.Parameters.Add("@Paydate", SqlDbType.DateTime).Value = dpPaydate1.SelectedDate;
            command.Parameters.Add("@Payyyyymm", SqlDbType.VarChar).Value = yyyymm;
            command.Parameters.Add("@ProjectId", SqlDbType.Int).Value = hfProjectId.Value;
            command.Parameters.Add("@Paytype", SqlDbType.Int).Value = paytype;
            command.Parameters.Add("@Payamt", SqlDbType.VarChar).Value = txtAmount1.Text;
            command.Parameters.Add("@Receiptno", SqlDbType.VarChar).Value = txtReceiptNo1.Text;
            command.Parameters.Add("@UpdatedBy", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            command.Parameters.Add("@projectBalance", SqlDbType.Float).Direction = ParameterDirection.Output;
            command.Parameters.Add("@editId", SqlDbType.Int).Value = ViewState["payid"].ToString();
            command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.ExecuteNonQuery();
                int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                if (retVal == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "closeeditModal();", true);
                    paymentGrid.Rebind();
                    txtBalance.Text = Convert.ToDouble(command.Parameters["@projectBalance"].Value).ToString("N02");
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

        protected void paymentGrid_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            GridDataItem item = e.Item as GridDataItem;
            command = new SqlCommand("spDeleteIndProjectPaymt", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@PayerId", SqlDbType.VarChar).Value = txtPayerID.Text;
            command.Parameters.Add("@ProjectId", SqlDbType.Int).Value = hfProjectId.Value;
            command.Parameters.Add("@projectBalance", SqlDbType.Float).Direction = ParameterDirection.Output;
            command.Parameters.Add("@deleteId", SqlDbType.Int).Value = item["id"].Text;
            command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
            try
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                command.ExecuteNonQuery();
                int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                if (retVal == 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
                    paymentGrid.Rebind();
                    txtBalance.Text = Convert.ToDouble(command.Parameters["@projectBalance"].Value).ToString("N02");
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