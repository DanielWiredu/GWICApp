using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GWICApp.Financials
{
    public partial class NewRecordSheet : System.Web.UI.Page
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtAltar_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble( txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtProphetic_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtFirst_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtSecond_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtTithe_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtThanksgiving_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtPledge_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtProject_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if ((txtCash.Value.Value + txtCheque.Value.Value) != txtGrandTotal.Value.Value)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cash and Cheque amount do not sum up to GrandTotal', 'Error');", true);
                return;
            }
            //string query = "insert into RecordSheet(Regdate,Speaker,Theme,Adults,Children,Cars,AltarSeed,PropheticSeed,FirstOffering,SecondOffering,Tithe,Thanksgiving,Pledge,ProjectOffering,Cash,Cheque,GrandTotal,PreparedBy) ";
            //query += "values(@regdate,@speaker,@theme,@adults,@children,@cars,@altar,@prophetic,@firstoffering,@secondoffering,@tithe,@thanksgiving,@pledge,@project,@cash,@cheque,@grandtotal,@preparedby)";
            command = new SqlCommand("AddRecordSheet", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.Add("@regdate", SqlDbType.Date).Value = dpDate.SelectedDate;
            command.Parameters.Add("@speaker", SqlDbType.VarChar).Value = txtSpeaker.Text;
            command.Parameters.Add("@theme", SqlDbType.VarChar).Value = txtTheme.Text;
            command.Parameters.Add("@adults", SqlDbType.VarChar).Value = txtAdults.Text;
            command.Parameters.Add("@children", SqlDbType.VarChar).Value = txtChildren.Text;
            command.Parameters.Add("@cars", SqlDbType.VarChar).Value = txtCars.Text;
            command.Parameters.Add("@altar", SqlDbType.VarChar).Value = txtAltar.Text;
            command.Parameters.Add("@prophetic", SqlDbType.VarChar).Value = txtProphetic.Text;
            command.Parameters.Add("@firstoffering", SqlDbType.VarChar).Value = txtFirst.Text;
            command.Parameters.Add("@secondoffering", SqlDbType.VarChar).Value = txtSecond.Text;
            command.Parameters.Add("@tithe", SqlDbType.VarChar).Value = txtTithe.Text;
            command.Parameters.Add("@thanksgiving", SqlDbType.VarChar).Value = txtThanksgiving.Text;
            command.Parameters.Add("@pledge", SqlDbType.VarChar).Value = txtPledge.Text;
            command.Parameters.Add("@project", SqlDbType.VarChar).Value = txtProject.Text;
            command.Parameters.Add("@cash", SqlDbType.VarChar).Value = txtCash.Text;
            command.Parameters.Add("@cheque", SqlDbType.VarChar).Value = txtCheque.Text;
            command.Parameters.Add("@grandtotal", SqlDbType.VarChar).Value = txtGrandTotal.Text;
            command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                object obj = command.ExecuteScalar();
                if (!String.IsNullOrEmpty(obj.ToString()))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('" + obj.ToString() + " Saved Successfully', 'Success');", true);
                    dpDate.Clear();
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