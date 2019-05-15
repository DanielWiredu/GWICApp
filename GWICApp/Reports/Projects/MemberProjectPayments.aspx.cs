using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CrystalDecisions.Shared;

namespace GWICApp.Reports.Projects
{
    public partial class MemberProjectPayments : System.Web.UI.Page
    {
        rptMemberProjectPayments rpt = new rptMemberProjectPayments();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["payerId"] = Request.QueryString["pid"].ToString();
            }
        }

        protected void MemberProjectPaymentsReport_Load(object sender, EventArgs e)
        {
            adapter = new SqlDataAdapter("SELECT * FROM [dbo].[rptMemberProjectPayments](@payerId)", connection);
            adapter.SelectCommand.Parameters.Add("@payerId", SqlDbType.VarChar).Value = ViewState["payerId"].ToString();
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "Command");
            rpt.SetDataSource(ds);

            MemberProjectPaymentsReport.ReportSource = rpt;
        }
    }
}