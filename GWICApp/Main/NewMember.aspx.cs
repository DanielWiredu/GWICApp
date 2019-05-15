using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace GWICApp.Main
{
    public partial class NewMember : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlCommand command;
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //string path = "~/Content/MemberPics/image6s.jpg";
                //Image1.ImageUrl = path;
                dpDateJoined.SelectedDate = DateTime.Now.Date;
                dpBaptismDate.SelectedDate = Convert.ToDateTime("01/01/2000");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int contentLength = avatarUpload.PostedFile.ContentLength;
                string contentType = String.Empty;
                contentType = avatarUpload.PostedFile.ContentType;
                string fileName = avatarUpload.PostedFile.FileName;
                if (fileName != "" && (contentLength / 1024) > 256) //greater than 256KB
                {
                    lblMsg.InnerText = "Picture size is too large...Please resize and try again";
                    lblMsg.Attributes["class"] = "alert alert-danger";
                    return;
                }
                string ext = Path.GetExtension(fileName);
                switch (ext)
                {
                    case ".jpg":
                        contentType = "image/jpg";
                        break;
                    case ".png":
                        contentType = "image/png";
                        break;
                    case ".gif":
                        contentType = "image/gif";
                        break;
                    default:
                        contentType = String.Empty;
                        break;
                }
                if (fileName != "" && contentType == String.Empty)
                {
                    lblMsg.InnerText = "Invalid File Selected";
                    lblMsg.Attributes["class"] = "alert alert-danger";
                    return;
                }

                string nowyear = DateTime.Now.Year.ToString().Substring(2, 2);
                string memberid = "";
                string query = "select max(memberid) as memberid from members where memberid like '%" + nowyear + "'";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                reader = command.ExecuteReader();
                if (reader.Read() && !String.IsNullOrEmpty(reader["memberid"].ToString()))
                {
                    memberid = reader["memberid"].ToString();
                    memberid = memberid.Substring(5, 4);
                    memberid = (int.Parse(memberid) + 1).ToString();
                }
                else
                {
                    memberid = "1";
                }
                reader.Close();

                switch (memberid.Length)
                {
                    case 1:
                        memberid = "000" + memberid;
                        break;
                    case 2:
                        memberid = "00" + memberid;
                        break;
                    case 3:
                        memberid = "0" + memberid;
                        break;
                    default:
                        lblMsg.InnerText = "Maximum MemberID has been reached...Cannot Continue";
                        lblMsg.Attributes["class"] = "alert alert-danger";
                        return;
                }
                memberid = "GIWC/" + memberid + "/" + nowyear;
                string path = "";
                if (fileName != "" && contentType != String.Empty)
                    path = "/Content/MemberPics/" + memberid.Replace("/", "") + ext;

                string agegroup = "";
                DateTime dob = dpDOB.SelectedDate.Value;
                DateTime nowdate = DateTime.Now;
                int age = nowdate.Year - dob.Year;
                if (nowdate.Month < dob.Month || (nowdate.Month == dob.Month && nowdate.Day < dob.Day))// Are we before the birth date this year? If so subtract one year from the mix
                {
                    age--;
                }
                if (age <= 10)
                    agegroup = "0 - 10";
                else if (age <= 20)
                    agegroup = "11 - 20";
                else if (age <= 30)
                    agegroup = "21 - 30";
                else if (age <= 50)
                    agegroup = "31 - 50";
                else if (age <= 70)
                    agegroup = "51 - 70";
                else if (age > 70)
                    agegroup = "71 +";

                query = "INSERT INTO members(memberid,surname,othername,gender,birthday,agegroup,maritalstatus,postaddress,resaddress,telephone,"; 
                query += "email,baptismtype,baptismdate,department,positionheld,nationality,nationalidtype,occupation,profession,economicstatus,"; 
                query += "previouschurch,datejoined,regdate,imagepath,active)";
                query += "VALUES(@memberid,@surname,@othername,@gender,@birthday,@agegroup,@marstatus,@postaddress,@resaddress,@telephone,";
                query += "@email,@baptismtype,@baptismdate,@department,@positionheld,@nationality,@nationalidtype,@occupation,@profession,@economicstatus,";
                query += "@previouschurch,@datejoined,@regdate,@imagepath,@active)";

                command = new SqlCommand(query, connection);

                command.Parameters.Add("@memberid", SqlDbType.VarChar).Value = memberid;
                command.Parameters.Add("@surname", SqlDbType.VarChar).Value = txtSurname.Text.ToUpper();
                command.Parameters.Add("@othername", SqlDbType.VarChar).Value = txtOthernames.Text.ToUpper();
                command.Parameters.Add("@gender", SqlDbType.VarChar).Value = dlGender.SelectedText;
                command.Parameters.Add("@birthday", SqlDbType.Date).Value = dob;
                command.Parameters.Add("@agegroup", SqlDbType.VarChar).Value = agegroup;
                command.Parameters.Add("@marstatus", SqlDbType.VarChar).Value = dlMaritalStatus.SelectedText;
                command.Parameters.Add("@postaddress", SqlDbType.VarChar).Value = txtPostAddress.Text;
                command.Parameters.Add("@resaddress", SqlDbType.VarChar).Value = txtResAddress.Text;
                command.Parameters.Add("@telephone", SqlDbType.VarChar).Value = txtTelephone.Text;
                command.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmail.Text;
                command.Parameters.Add("@baptismtype", SqlDbType.VarChar).Value = dlBaptism.SelectedText;
                command.Parameters.Add("@baptismdate", SqlDbType.VarChar).Value = dpBaptismDate.SelectedDate;
                command.Parameters.Add("@department", SqlDbType.VarChar).Value = dlDepartment.SelectedValue;
                command.Parameters.Add("@positionheld", SqlDbType.VarChar).Value = txtPosition.Text;
                command.Parameters.Add("@nationality", SqlDbType.VarChar).Value = dlNationality.SelectedValue;
                command.Parameters.Add("@nationalidtype", SqlDbType.VarChar).Value = dlIDType.SelectedText;
                command.Parameters.Add("@occupation", SqlDbType.VarChar).Value = dlOccupation.SelectedValue;
                command.Parameters.Add("@profession", SqlDbType.VarChar).Value = dlProfession.SelectedValue;
                command.Parameters.Add("@economicstatus", SqlDbType.VarChar).Value = dlEconomicStatus.SelectedText;
                command.Parameters.Add("@previouschurch", SqlDbType.VarChar).Value = txtPreviousChurch.Text;
                command.Parameters.Add("@datejoined", SqlDbType.Date).Value = dpDateJoined.SelectedDate;
                command.Parameters.Add("@regdate", SqlDbType.Date).Value = nowdate;
                command.Parameters.Add("@imagepath", SqlDbType.VarChar).Value = path;
                command.Parameters.Add("@active", SqlDbType.TinyInt).Value = 1;

                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    lblMsg.InnerText = "New Member Saved Successfully... MEMBER ID = " + memberid;
                    lblMsg.Attributes["class"] = "alert alert-success";
                    txtMemberID.Text = memberid;
                    if (path != "")
                        avatarUpload.PostedFile.SaveAs(Server.MapPath(path));
                    Image1.ImageUrl = "~" + path + "?" + DateTime.Now.Ticks.ToString();
                }
                command.Dispose();
            }
            catch (Exception ex)
            {
                lblMsg.InnerText = ex.Message.Replace("'", "").Replace("\r\n", "");
                lblMsg.Attributes["class"] = "alert alert-danger";
                return;
            }
            finally
            {
                connection.Close();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.Url.AbsoluteUri);
        }
        protected void test()
        {
            string memberid = "giwc/003/16";
            memberid = memberid.Replace("/", "");
            int contentLength = avatarUpload.PostedFile.ContentLength;//You may need it for validation
            string contentType = avatarUpload.PostedFile.ContentType;//You may need it for validation
            string fileName = avatarUpload.PostedFile.FileName;
            string ext = Path.GetExtension(fileName);
            string path = "/Content/MemberPics/" + memberid + ext;
            avatarUpload.PostedFile.SaveAs(Server.MapPath(path));  //Or code to save in the DataBase.
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Your Account is Deactivated...Please contact the Administrator','Login Failed');", true);
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "uniqueId" + Guid.NewGuid(), "toastr.success('Your Account is Deactivated','Login Failed');", false);
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "", "toastr.success('Your Account is Deactivated...Please contact the Administrator','Login Failed');", true);
            lblMsg.InnerText = "Saved Successfully";
            lblMsg.Attributes["class"] = "alert alert-success";
        }
    }
}