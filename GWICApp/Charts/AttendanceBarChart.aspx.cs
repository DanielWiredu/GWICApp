using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GWICApp.Charts
{
    public partial class AttendanceBarChart : Page
    {
        string service = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime nowdate = DateTime.Now;
                int year = nowdate.Year;
                for (int i = 2015; i <= year; i++)
                {
                    dlYear.Items.Add(i.ToString());
                }

                RadHtmlChart2.ChartTitle.Text = "Data On " + dlService.SelectedText + ", For " + dlMnth.SelectedText + " " + dlYear.SelectedText;
            }
        }

        protected void btnRun_Click(object sender, EventArgs e)
        {
            RadHtmlChart2.DataBind();
            RadHtmlChart2.ChartTitle.Text = "Data On " + dlService.SelectedText + ", For " + dlMnth.SelectedText + " " + dlYear.SelectedText;
        }
    }
}