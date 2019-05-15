using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GWICApp.Reports
{
    public partial class MemberReports : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnReport_Click(object sender, EventArgs e)
        {
            Session["sdate"] = dpSdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            Session["edate"] = dpEdate.SelectedDate.Value.ToString("dd-MMM-yyyy");
            if (rdAll.Checked == true)
            {
                if (dlType.SelectedValue == "All")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MemberList.aspx');", true);
                }
                else if (dlType.SelectedValue == "Gender")
                {
                    Session["gender"] = "";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByGender.aspx');", true);
                }
                else if (dlType.SelectedValue == "Occupation")
                {
                    Session["occupation"] = "";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByOccupation.aspx');", true);
                }
                else if (dlType.SelectedValue == "Department")
                {
                    Session["department"] = "";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByDepartment.aspx');", true);
                }
                else if (dlType.SelectedValue == "Profession")
                {
                    Session["profession"] = "";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByProfession.aspx');", true);
                }
                else if (dlType.SelectedValue == "Baptism")
                {
                    Session["baptism"] = "";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByBaptism.aspx');", true);
                }
            }
            else if (rdSpecific.Checked == true)
            {
                if (dlType.SelectedValue == "All")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MemberList.aspx');", true);
                }
                else if (dlType.SelectedValue == "Gender")
                {
                    Session["gender"] = dlGender.SelectedValue;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByGender.aspx');", true);
                }
                else if (dlType.SelectedValue == "Occupation")
                {
                    Session["occupation"] = dlOccupation.SelectedValue;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByOccupation.aspx');", true);
                }
                else if (dlType.SelectedValue == "Department")
                {
                    Session["department"] = dlDepartment.SelectedValue;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByDepartment.aspx');", true);
                }
                else if (dlType.SelectedValue == "Profession")
                {
                    Session["profession"] = dlProfession.SelectedValue;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByProfession.aspx');", true);
                }
                else if (dlType.SelectedValue == "Baptism")
                {
                    Session["baptism"] = dlBaptism.SelectedText;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "newTab", "window.open('/Reports/Members/MembersByBaptism.aspx');", true);
                }
            }
        }


        protected void rdAll_CheckedChanged(object sender, EventArgs e)
        {
            if (rdAll.Checked == true)
            {
                lblType.InnerText = "";
                dlGender.Visible = false;
                dlOccupation.Visible = false;
                dlDepartment.Visible = false;
                dlProfession.Visible = false;
                dlBaptism.Visible = false;
            }
        }

        protected void rdSpecific_CheckedChanged(object sender, EventArgs e)
        {
            if (rdSpecific.Checked == true)
            {
                reportOption();
            }
        }

        protected void dlType_ItemSelected(object sender, Telerik.Web.UI.DropDownListEventArgs e)
        {
            if (rdAll.Checked == true)
            {
                lblType.InnerText = "";
                dlGender.Visible = false;
                dlOccupation.Visible = false;
                dlDepartment.Visible = false;
                dlProfession.Visible = false;
                dlBaptism.Visible = false;
            }
            else if (rdSpecific.Checked == true)
            {
                reportOption();
            }
        }
        protected void reportOption()
        {
            if (dlType.SelectedValue == "All")
            {
                lblType.InnerText = "";
                dlGender.Visible = false;
                dlOccupation.Visible = false;
                dlDepartment.Visible = false;
                dlProfession.Visible = false;
                dlBaptism.Visible = false;
            }
            else if (dlType.SelectedValue == "Gender")
            {
                lblType.InnerText = "Gender";
                dlGender.Visible = true;
                dlOccupation.Visible = false;
                dlDepartment.Visible = false;
                dlProfession.Visible = false;
                dlBaptism.Visible = false;
            }
            else if (dlType.SelectedValue == "Occupation")
            {
                lblType.InnerText = "Occupation";
                dlGender.Visible = false;
                dlOccupation.Visible = true;
                dlDepartment.Visible = false;
                dlProfession.Visible = false;
                dlBaptism.Visible = false;
            }
            else if (dlType.SelectedValue == "Department")
            {
                lblType.InnerText = "Department";
                dlGender.Visible = false;
                dlOccupation.Visible = false;
                dlDepartment.Visible = true;
                dlProfession.Visible = false;
                dlBaptism.Visible = false;
            }
            else if (dlType.SelectedValue == "Profession")
            {
                lblType.InnerText = "Profession";
                dlGender.Visible = false;
                dlOccupation.Visible = false;
                dlDepartment.Visible = false;
                dlProfession.Visible = true;
                dlBaptism.Visible = false;
            }
            else if (dlType.SelectedValue == "Baptism")
            {
                lblType.InnerText = "Baptism";
                dlGender.Visible = false;
                dlOccupation.Visible = false;
                dlDepartment.Visible = false;
                dlProfession.Visible = false;
                dlBaptism.Visible = true;
            }
            
        }
    }
}