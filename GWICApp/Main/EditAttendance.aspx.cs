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
    public partial class EditAttendance : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string query = "select * from Attendance where id='" + Session["attID"].ToString() + "'";
                command = new SqlCommand(query, connection);
                try
                {
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        ViewState["id"] = reader["id"].ToString();
                        dpDate.SelectedDate = Convert.ToDateTime(reader["regdate"]);
                        dlService.SelectedText = reader["service"].ToString();
                        txtSpeaker.Text = reader["speaker"].ToString();
                        txtAdults.Text = reader["adults"].ToString();
                        txtChildren.Text = reader["children"].ToString();
                        txtCars.Text = reader["cars"].ToString();
                        txtTheme.Text = reader["theme"].ToString();
                        txtRemarks.Text = reader["remarks"].ToString();
                    }
                    reader.Close();
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "Update Attendance set Regdate=@regdate,Service=@service,Speaker=@speaker,Theme=@theme,";
            query += "Adults=@adults,Children=@children,Cars=@cars,Remarks=@remarks where id=@id";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@regdate", SqlDbType.Date).Value = dpDate.SelectedDate;
            command.Parameters.Add("@service", SqlDbType.VarChar).Value = dlService.SelectedText;
            command.Parameters.Add("@speaker", SqlDbType.VarChar).Value = txtSpeaker.Text;
            command.Parameters.Add("@theme", SqlDbType.VarChar).Value = txtTheme.Text;
            command.Parameters.Add("@adults", SqlDbType.VarChar).Value = txtAdults.Text;
            command.Parameters.Add("@children", SqlDbType.VarChar).Value = txtChildren.Text;
            command.Parameters.Add("@cars", SqlDbType.VarChar).Value = txtCars.Text;
            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
            command.Parameters.Add("@id", SqlDbType.VarChar).Value = ViewState["id"].ToString();
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
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