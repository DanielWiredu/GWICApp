using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GWICApp.Charts
{
    public partial class MembersOnMonth : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DateTime nowdate = DateTime.Now;
                int mn = nowdate.Month;
                int year = nowdate.Year;
                int days = DateTime.DaysInMonth(year, mn);
                hfSdate.Value = "2000-01-01";
                hfEdate.Value = year + "-" + mn + "-" + days;
                dpSdate.SelectedDate = Convert.ToDateTime(hfSdate.Value);
                dpEdate.SelectedDate = Convert.ToDateTime(hfEdate.Value);
                RadHtmlChart2.ChartTitle.Text = "Members Chart (Monthly) " + dpSdate.SelectedDate.Value.ToString("dd-MMM-yyyy") + " To " + dpEdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
                RadHtmlChart2.PlotArea.YAxis.TitleAppearance.Text = "Members (" + dlGender.SelectedText + ")";
            }
        }

        protected void btnRun_Click(object sender, EventArgs e)
        {
            hfSdate.Value = dpSdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            hfEdate.Value = dpEdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            RadHtmlChart2.DataBind();
            RadHtmlChart2.ChartTitle.Text = "Members Chart (Monthly) " + hfSdate.Value + " To " + hfEdate.Value;
            RadHtmlChart2.PlotArea.YAxis.TitleAppearance.Text = "Members (" + dlGender.SelectedText + ")";
        }
    }
}