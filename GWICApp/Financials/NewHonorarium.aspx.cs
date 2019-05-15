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
    public partial class NewHonorarium : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //protected void dl_hrBaseCur_ItemSelected(object sender, DropDownListEventArgs e)
        //{
        //    if (txt_hrBaseAmt.Text.Length != 0)
        //    {
        //        double rate = Convert.ToDouble(dl_hrBaseCur.SelectedValue);
        //        txt_hrAmount.Value = rate * txt_hrBaseAmt.Value;
        //    }
           
        //}

        //protected void dl_lgBaseCur_ItemSelected(object sender, DropDownListEventArgs e)
        //{
        //    if (txt_lgBaseAmt.Text.Length != 0)
        //    {
        //        double rate = Convert.ToDouble(dl_lgBaseCur.SelectedValue);
        //        txt_lgAmount.Value = rate * txt_lgBaseAmt.Value;
        //    }
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into Honorarium(paydate,guestname,programme,location,hrBaseamount,hrCurrency,hrAmount,lgBaseamount,lgCurrency,lgAmount,Remarks,Preparedby)";
            query += "values(@paydate,@guestname,@programme,@location,@hrBase,@hrCur,@hrAmount,@lgBase,@lgCur,@lgAmount,@remarks,@preparedby)";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@paydate", SqlDbType.Date).Value = dpPaydate.SelectedDate;
            command.Parameters.Add("@guestname", SqlDbType.VarChar).Value = txtGuestName.Text;
            command.Parameters.Add("@programme", SqlDbType.VarChar).Value = txtProgramme.Text;
            command.Parameters.Add("@location", SqlDbType.VarChar).Value = txtLocation.Text;
            command.Parameters.Add("@hrBase", SqlDbType.VarChar).Value = "";
            command.Parameters.Add("@hrCur", SqlDbType.VarChar).Value = dl_hrBaseCur.SelectedText;
            command.Parameters.Add("@hrAmount", SqlDbType.VarChar).Value = txt_hrAmount.Text;
            command.Parameters.Add("@lgBase", SqlDbType.VarChar).Value = "";
            command.Parameters.Add("@lgCur", SqlDbType.VarChar).Value = dl_lgBaseCur.SelectedText;
            command.Parameters.Add("@lgAmount", SqlDbType.VarChar).Value = txt_lgAmount.Text;
            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
            command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Saved Successfully', 'Success');", true);
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