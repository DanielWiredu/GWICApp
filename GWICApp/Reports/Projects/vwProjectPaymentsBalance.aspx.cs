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
    public partial class vwProjectPaymentsBalance : System.Web.UI.Page
    {
        rptProjectPaymentBalance rpt = new rptProjectPaymentBalance();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            //    ViewState["projectId"] = Request.QueryString["pid"].ToString();
            //}
        }

        protected void ProjectBalanceReport_Load(object sender, EventArgs e)
        {
            adapter = new SqlDataAdapter("SELECT * FROM [dbo].[rptProjectPaymentBalance]()", connection);
            //adapter.SelectCommand.Parameters.Add("@projectId", SqlDbType.Int).Value = ViewState["projectId"].ToString();
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "Command");
            rpt.SetDataSource(ds);

            ProjectBalanceReport.ReportSource = rpt;
        }
    }
}