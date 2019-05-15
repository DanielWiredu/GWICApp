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
    public partial class NewBankTransaction : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
          if (!IsPostBack)
            {
                dpValueDate.SelectedDate = DateTime.Now;
            }
        }
        protected void dlTransmode_ItemSelected(object sender, DropDownListEventArgs e)
        {
            if (dlTransmode.SelectedText == "Cash")
            {
                //dlBank.ClearSelection();
                //dlBank.Enabled = false;
                txtChequeno.Text = "";
                txtChequeno.Enabled = false;
                dpValueDate.SelectedDate = DateTime.Now;
                dpValueDate.Enabled = false;
            }
            else if (dlTransmode.SelectedText == "Cheque")
            {
                //dlBank.Enabled = true;
                txtChequeno.Enabled = true;
                dpValueDate.Enabled = true;
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string Payyyyymm = dpTransdate.SelectedDate.Value.ToString("yyyyMM");
            string query = "insert into BankTransactions(transdate,transname,transtype,transmode,currency,amount,transbank,transaccount,chequeno,valuedate,remarks,preparedby,payyyyymm) ";
            query += "values(@transdate,@transname,@transtype,@transmode,@currency,@amount,@transbank,@transaccount,@chequeno,@valuedate,@remarks,@preparedby,@payyyyymm)";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@transdate", SqlDbType.Date).Value = dpTransdate.SelectedDate;
            command.Parameters.Add("@transname", SqlDbType.VarChar).Value = txtName.Text;
            command.Parameters.Add("@transtype", SqlDbType.VarChar).Value = dlTranstype.SelectedText;
            command.Parameters.Add("@transmode", SqlDbType.VarChar).Value = dlTransmode.SelectedText;
            command.Parameters.Add("@currency", SqlDbType.VarChar).Value = dlCurrency.SelectedText;
            command.Parameters.Add("@amount", SqlDbType.VarChar).Value = txtAmount.Text;
            command.Parameters.Add("@transbank", SqlDbType.VarChar).Value = dlBank.SelectedValue;
            command.Parameters.Add("@transaccount", SqlDbType.VarChar).Value = dlBankAccount.SelectedText;
            command.Parameters.Add("@chequeno", SqlDbType.VarChar).Value = txtChequeno.Text;
            command.Parameters.Add("@valuedate", SqlDbType.Date).Value = dpValueDate.SelectedDate;
            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
            command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            command.Parameters.Add("@payyyyymm", SqlDbType.VarChar).Value = Payyyyymm;
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
                    dpTransdate.Clear();
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