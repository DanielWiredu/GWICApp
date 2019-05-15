using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GWICApp.Reports
{
    public partial class ProjectReports : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnReport_Click(object sender, EventArgs e)
        {
            //Session["sdate"] = dpSdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            //Session["edate"] = dpEdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            //if (rdPayType.SelectedValue == "Member")
            //{
            //    Session["rptMemberID"] = txtPayerID.Text;
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Projects/MemberPayments.aspx');", true);
            //}
            //else if (rdPayType.SelectedValue == "Visitor")
            //{
            //    Session["rptVisitorID"] = txtPayerID.Text;
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Projects/VisitorPayments.aspx');", true);
            //}

            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Projects/MemberProjectPayments.aspx?pid=" + txtPayerID.Text + "');", true);
        }

        protected void btnIndProjectPayments_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Projects/IndProjectPayments.aspx?pid=" + dlProject.SelectedValue + "');", true);
        }

        protected void btnProjectSummary_Click(object sender, EventArgs e)
        {
            if (dlReportType.SelectedText == "Payment Summary")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Projects/PaymentSummary.aspx');", true);
            }
            else if (dlReportType.SelectedText == "Payment Balance")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Projects/vwProjectPaymentsBalance.aspx');", true);
            }
            
        }
    }
}