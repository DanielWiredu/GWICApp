using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GWICApp.Main
{
    public partial class NewAttendance : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "insert into Attendance(Regdate,Service,Speaker,Theme,Adults,Children,Cars,Remarks) ";
            query += "values(@regdate,@service,@speaker,@theme,@adults,@children,@cars,@remarks)";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@regdate", SqlDbType.Date).Value = dpDate.SelectedDate;
            command.Parameters.Add("@service", SqlDbType.VarChar).Value = dlService.SelectedText;
            command.Parameters.Add("@speaker", SqlDbType.VarChar).Value = txtSpeaker.Text;
            command.Parameters.Add("@theme", SqlDbType.VarChar).Value = txtTheme.Text;
            command.Parameters.Add("@adults", SqlDbType.VarChar).Value = txtAdults.Text;
            command.Parameters.Add("@children", SqlDbType.VarChar).Value = txtChildren.Text;
            command.Parameters.Add("@cars", SqlDbType.VarChar).Value = txtCars.Text;
            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
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