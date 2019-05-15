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
    public partial class EditMember : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter();
        SqlCommand command = new SqlCommand();
        SqlDataReader reader;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string query = "select * from Members where memberid = '" + Session["memberid"].ToString() + "'";
                    command = new SqlCommand(query, connection);
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();
                    reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        txtMemberID.Text = reader["memberid"].ToString();
                        txtSurname.Text = reader["surname"].ToString();
                        txtOthernames.Text = reader["othername"].ToString();
                        dlGender.SelectedText = reader["gender"].ToString();
                        dpDOB.SelectedDate = Convert.ToDateTime(reader["birthday"]);
                        dlMaritalStatus.SelectedText = reader["maritalstatus"].ToString();
                        txtTelephone.Text = reader["telephone"].ToString();
                        txtEmail.Text = reader["email"].ToString();
                        txtResAddress.Text = reader["resaddress"].ToString();
                        txtPostAddress.Text = reader["postaddress"].ToString();
                        dlBaptism.SelectedText = reader["baptismtype"].ToString();
                        dpBaptismDate.SelectedDate = Convert.ToDateTime(reader["baptismdate"]);
                        dlDepartment.SelectedValue = reader["department"].ToString();
                        txtPosition.Text = reader["positionheld"].ToString();
                        dlNationality.SelectedValue = reader["nationality"].ToString();
                        dlIDType.SelectedValue = reader["nationalidtype"].ToString();
                        dlOccupation.SelectedValue = reader["occupation"].ToString();
                        dlProfession.SelectedValue = reader["profession"].ToString();
                        dlEconomicStatus.SelectedText = reader["economicstatus"].ToString();
                        dpDateJoined.SelectedDate = Convert.ToDateTime(reader["datejoined"]);
                        txtPreviousChurch.Text = reader["previouschurch"].ToString();
                        ViewState["imagepath"] = reader["imagepath"].ToString();
                        Image1.ImageUrl = "~" + ViewState["imagepath"].ToString() + "?" + DateTime.Now.Ticks.ToString();
                    }
                    reader.Close();
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
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Main/Members.aspx");
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

                string memberid = txtMemberID.Text.Trim();

                string path = ViewState["imagepath"].ToString();
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

                string query = "UPDATE Members set surname=@surname,othername=@othername,gender=@gender,birthday=@birthday,agegroup=@agegroup,maritalstatus=@marstatus,postaddress=@postaddress,resaddress=@resaddress,telephone=@telephone,";
                query += "email=@email,baptismtype=@baptismtype,baptismdate=@baptismdate,department=@department,positionheld=@positionheld,nationality=@nationality,nationalidtype=@nationalidtype,occupation=@occupation,profession=@profession,economicstatus=@economicstatus,";
                query += "previouschurch=@previouschurch,datejoined=@datejoined,imagepath=@imagepath where memberid=@memberid";

                command = new SqlCommand(query, connection); 
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
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
                command.Parameters.Add("@baptismdate", SqlDbType.Date).Value = dpBaptismDate.SelectedDate.Value;
                command.Parameters.Add("@department", SqlDbType.VarChar).Value = dlDepartment.SelectedValue;
                command.Parameters.Add("@positionheld", SqlDbType.VarChar).Value = txtPosition.Text;
                command.Parameters.Add("@nationality", SqlDbType.VarChar).Value = dlNationality.SelectedValue;
                command.Parameters.Add("@nationalidtype", SqlDbType.VarChar).Value = dlIDType.SelectedText;
                command.Parameters.Add("@occupation", SqlDbType.VarChar).Value = dlOccupation.SelectedValue;
                command.Parameters.Add("@profession", SqlDbType.VarChar).Value = dlProfession.SelectedValue;
                command.Parameters.Add("@economicstatus", SqlDbType.VarChar).Value = dlEconomicStatus.SelectedText;
                command.Parameters.Add("@previouschurch", SqlDbType.VarChar).Value = txtPreviousChurch.Text;
                command.Parameters.Add("@datejoined", SqlDbType.Date).Value = dpDateJoined.SelectedDate.Value;
                command.Parameters.Add("@imagepath", SqlDbType.VarChar).Value = path;
                command.Parameters.Add("@memberid", SqlDbType.VarChar).Value = memberid;

                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    lblMsg.InnerText = "Member Details Updated Successfully";
                    lblMsg.Attributes["class"] = "alert alert-success";
                    if (path != "" && fileName != "") //you selected an image
                        avatarUpload.PostedFile.SaveAs(Server.MapPath(path));
                    ViewState["imagepath"] = path;
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

        protected void deleteImage()
        {
            try
            {
                if (String.IsNullOrEmpty(ViewState["imagepath"].ToString()))
                {
                    lblMsg.InnerText = "No image found";
                    lblMsg.Attributes["class"] = "alert alert-danger";
                    return;
                }
                string query = "update Members set imagepath = '' where memberid = '" + txtMemberID.Text + "'";
                command = new SqlCommand(query, connection);
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                rows = command.ExecuteNonQuery();
                if (rows > 0)
                {
                    File.Delete(Server.MapPath(ViewState["imagepath"].ToString()));
                    lblMsg.InnerText = "Picture Deleted Successfully";
                    lblMsg.Attributes["class"] = "alert alert-success";
                }
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
    }
}