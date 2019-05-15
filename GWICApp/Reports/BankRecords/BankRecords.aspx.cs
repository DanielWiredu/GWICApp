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

namespace GWICApp.Reports.BankRecords
{
    public partial class BankRecords : System.Web.UI.Page
    {
        rptBankRecords rpt = new rptBankRecords();
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

        protected void BankTransactionsReport_Load(object sender, EventArgs e)
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

            adapter = new SqlDataAdapter("select transdate,transname,transtype,transmode,currency,amount,transbank,transaccount from banktransactions where currency = '" + currency + "' and transdate between '" + sdate + "' and '" + edate + "' order by transdate", connection);
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "banktransactions");
            rpt.SetDataSource(ds);

            parameters.Add(startdate);
            rpt.DataDefinition.ParameterFields["sDate"].ApplyCurrentValues(parameters);
            parameters.Add(enddate);
            rpt.DataDefinition.ParameterFields["eDate"].ApplyCurrentValues(parameters);
            parameters.Add(paycur);
            rpt.DataDefinition.ParameterFields["paycurrency"].ApplyCurrentValues(parameters);

            BankTransactionsReport.ReportSource = rpt;
        }
    }
}