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

namespace GWICApp.Reports.Sales
{
    public partial class DetailReport1 : System.Web.UI.Page
    {
        rptDetailReport1 rpt = new rptDetailReport1();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter;
        DataSet ds = new DataSet();

        string sdate = "";
        string edate = "";
        string product = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SalesReportDocument_Load(object sender, EventArgs e)
        {
            sdate = Session["sdate"].ToString();
            edate = Session["edate"].ToString();
            product = Session["rptProduct"].ToString();

            ParameterValues parameters = new ParameterValues();
            ParameterDiscreteValue startdate = new ParameterDiscreteValue();
            ParameterDiscreteValue enddate = new ParameterDiscreteValue();

            startdate.Value = sdate;
            enddate.Value = edate;

            adapter = new SqlDataAdapter("select * from vwProductsSold where productid like '%" + product + "%' and salesdate between '" + sdate + "' and '" + edate + "' order by salesdate", connection);
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "vwProductsSold");
            rpt.SetDataSource(ds);

            parameters.Add(startdate);
            rpt.DataDefinition.ParameterFields["sDate"].ApplyCurrentValues(parameters);
            parameters.Add(enddate);
            rpt.DataDefinition.ParameterFields["eDate"].ApplyCurrentValues(parameters);

            SalesReportDocument.ReportSource = rpt;
        }
    }
}