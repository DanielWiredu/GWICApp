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

namespace GWICApp.Reports.Financials
{
    public partial class SummarizedStatement : System.Web.UI.Page
    {
        rptFinReport rpt = new rptFinReport();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        DataSet ds = new DataSet();

        string yyyymm = "";
        string currency = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FinancialReport_Load(object sender, EventArgs e)
        {
            yyyymm = Session["yyyymm"].ToString();
            currency = Session["currency"].ToString();

            ParameterValues parameters = new ParameterValues();
            ParameterDiscreteValue payyyyymm = new ParameterDiscreteValue();
            ParameterDiscreteValue paycur = new ParameterDiscreteValue();

            payyyyymm.Value = yyyymm;
            paycur.Value = currency;

            adapter = new SqlDataAdapter("select * from MonthlyStatement where currency = '" + currency + "' and payyyyymm like '" + yyyymm + "%' order by payyyyymm", connection);
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "MonthlyStatement");
            rpt.SetDataSource(ds);

            parameters.Add(payyyyymm);
            rpt.DataDefinition.ParameterFields["payyyyymm"].ApplyCurrentValues(parameters);
            parameters.Add(paycur);
            rpt.DataDefinition.ParameterFields["paycurrency"].ApplyCurrentValues(parameters);

            FinancialReport.ReportSource = rpt;
        }
    }
}