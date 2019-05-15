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
    public partial class Statement1 : System.Web.UI.Page
    {
        rptDailyStatement rpt = new rptDailyStatement();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        DataSet ds = new DataSet();

        string sdate = "";
        string edate = "";
        string currency = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ReportDocument_Load(object sender, EventArgs e)
        {
            sdate = Session["sdate"].ToString();
            edate = Session["edate"].ToString();
            currency = Session["currency"].ToString();

            ParameterValues parameters = new ParameterValues();
            ParameterDiscreteValue startdate = new ParameterDiscreteValue();
            ParameterDiscreteValue enddate = new ParameterDiscreteValue();
            ParameterDiscreteValue paycur = new ParameterDiscreteValue();

            startdate.Value = sdate;
            enddate.Value = edate;
            paycur.Value = currency;

            adapter = new SqlDataAdapter("select paydate,payname,description,paytype,paymode,currency,amount from payments where currency = '" + currency + "' and paydate between '" + sdate + "' and '" + edate + "' order by paydate", connection);
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "payments");
            rpt.SetDataSource(ds);

            parameters.Add(startdate);
            rpt.DataDefinition.ParameterFields["sDate"].ApplyCurrentValues(parameters);
            parameters.Add(enddate);
            rpt.DataDefinition.ParameterFields["eDate"].ApplyCurrentValues(parameters);
            parameters.Add(paycur);
            rpt.DataDefinition.ParameterFields["paycurrency"].ApplyCurrentValues(parameters);

            FinancialReport.ReportSource = rpt;
        }
    }
}