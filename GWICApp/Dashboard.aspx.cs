using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace GWICApp
{
    public partial class Dashboard : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand("spGetAdminDash", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@activemembers", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@visitors", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@inactivemembers", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@services", SqlDbType.Int).Direction = ParameterDirection.Output;
                        command.Parameters.Add("@return_value", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                        try
                        {
                            connection.Open();
                            command.ExecuteNonQuery();
                            int retVal = Convert.ToInt16(command.Parameters["@return_value"].Value);
                            if (retVal == 0)
                            {
                                lblActiveMembers.InnerText = command.Parameters["@activemembers"].Value.ToString();
                                lblVisitors.InnerText = command.Parameters["@visitors"].Value.ToString();
                                lblInactiveMembers.InnerText = command.Parameters["@inactivemembers"].Value.ToString();
                                lblServices.InnerText = command.Parameters["@services"].Value.ToString();
                            }
                        }
                        catch (Exception ex)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                        }
                    }
                }
            }
        }

    }
}