using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace GWICApp.Financials
{
    public partial class Project_Payments : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void projectsGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Members")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Financials/ProjectMembers.aspx?pid=" + item["ID"].Text);
            }
            else if (e.CommandName == "Visitors")
            {
                GridDataItem item = e.Item as GridDataItem;
                Response.Redirect("/Financials/ProjectVisitors.aspx?pid=" + item["ID"].Text);
            }
        }
    }
}