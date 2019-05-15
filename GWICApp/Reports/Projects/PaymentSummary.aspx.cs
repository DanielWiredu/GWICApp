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
    public partial class PaymentSummary : System.Web.UI.Page
    {
        rptPaymentSummary rpt = new rptPaymentSummary();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void PaymentSummaryReport_Load(object sender, EventArgs e)
        {
            adapter = new SqlDataAdapter("SELECT * FROM [dbo].[rptProjectPaymentSummary]() order by projectname", connection);
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "Command");
            rpt.SetDataSource(ds);

            PaymentSummaryReport.ReportSource = rpt;
        }
    }
}