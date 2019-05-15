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
    public partial class NewVisitor : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string nowyear = DateTime.Now.Year.ToString().Substring(2, 2);
                string visitorid = "";
                string query = "select max(visitorid) as visitorid from Visitors where visitorid like '%" + nowyear + "'";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                reader = command.ExecuteReader();
                if (reader.Read() && !String.IsNullOrEmpty(reader["visitorid"].ToString()))
                {
                    visitorid = reader["visitorid"].ToString();
                    visitorid = visitorid.Substring(6, 4);
                    visitorid = (int.Parse(visitorid) + 1).ToString();
                }
                else
                {
                    visitorid = "1";
                }
                reader.Close();

                switch (visitorid.Length)
                {
                    case 1:
                        visitorid = "000" + visitorid;
                        break;
                    case 2:
                        visitorid = "00" + visitorid;
                        break;
                    case 3:
                        visitorid = "0" + visitorid;
                        break;
                    default:
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "toastr.error('Maximum MemberID has been reached...Cannot Continue', 'Error')", true);
                        return;
                }
                visitorid = "VGIWC/" + visitorid + "/" + nowyear;

                query = "INSERT INTO Visitors(visitorid,surname,othername,gender,resaddress,telephone,email,visitreason,visitdate,regdate) ";
                query += "VALUES(@visitorid,@surname,@othername,@gender,@resaddress,@telephone,@email,@visitreason,@visitdate,@regdate)";

                command = new SqlCommand(query, connection);

                command.Parameters.Add("@visitorid", SqlDbType.VarChar).Value = visitorid;
                command.Parameters.Add("@surname", SqlDbType.VarChar).Value = txtSurname.Text.ToUpper();
                command.Parameters.Add("@othername", SqlDbType.VarChar).Value = txtOthernames.Text.ToUpper();
                command.Parameters.Add("@gender", SqlDbType.VarChar).Value = dlGender.SelectedText;
                command.Parameters.Add("@resaddress", SqlDbType.VarChar).Value = txtResAddress.Text;
                command.Parameters.Add("@telephone", SqlDbType.VarChar).Value = txtTelephone.Text;
                command.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text;
                command.Parameters.Add("@visitreason", SqlDbType.VarChar).Value = txtReason.Text;
                command.Parameters.Add("@visitdate", SqlDbType.Date).Value = dpVisitDate.SelectedDate;
                command.Parameters.Add("@regdate", SqlDbType.Date).Value = DateTime.Now;

                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('New Visitor Saved Successfully', 'Success')", true);
                    txtVisitorID.Text = visitorid;
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