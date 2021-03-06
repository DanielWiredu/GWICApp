﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using CrystalDecisions.Shared;

namespace GWICApp.Reports.Members
{
    public partial class MembersByDepartment : System.Web.UI.Page
    {
        rptMembersByDepartment rpt = new rptMembersByDepartment();
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        DataSet ds = new DataSet();

        string sdate = "";
        string edate = "";
        string department = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ReportDocument_Load(object sender, EventArgs e)
        {
            sdate = Session["sdate"].ToString();
            edate = Session["edate"].ToString();
            department = Session["department"].ToString();

            ParameterValues parameters = new ParameterValues();
            ParameterDiscreteValue startdate = new ParameterDiscreteValue();
            ParameterDiscreteValue enddate = new ParameterDiscreteValue();

            startdate.Value = sdate;
            enddate.Value = edate;

            adapter = new SqlDataAdapter("select department, memberid, surname, Othername, telephone, regdate from members where department like '" + department + "%' and regdate between '" + sdate + "' and '" + edate + "' and active = 1", connection);
            if (connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
            adapter.Fill(ds, "members");
            rpt.SetDataSource(ds);

            parameters.Add(startdate);
            rpt.DataDefinition.ParameterFields["sDate"].ApplyCurrentValues(parameters);
            parameters.Add(enddate);
            rpt.DataDefinition.ParameterFields["eDate"].ApplyCurrentValues(parameters);

            ReportDocument.ReportSource = rpt;
        }
    }
}