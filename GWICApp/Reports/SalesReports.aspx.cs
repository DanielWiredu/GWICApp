using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GWICApp.Reports
{
    public partial class SalesReports : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnReport_Click(object sender, EventArgs e)
        {
            Session["sdate"] = dpSdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            Session["edate"] = dpEdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            if (rdType.SelectedValue == "All")
            {
                Session["rptProduct"] = "";
            }
            else if (rdType.SelectedValue == "Product")
            {
                Session["rptProduct"] = dlProduct.SelectedValue;
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Sales/DetailReport1.aspx');", true);
        }

        protected void rdType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdType.SelectedValue == "All")
            {
                dlProduct.Visible = false;
                lblProduct.Visible = false;
            }
            else if (rdType.SelectedValue == "Product")
            {
                dlProduct.Visible = true;
                lblProduct.Visible = true;
            }
        }
    }
}