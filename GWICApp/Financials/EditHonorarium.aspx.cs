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

namespace GWICApp.Financials
{
    public partial class EditHonorarium : MasterPageChange
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
                ViewState["id"] = Session["hrID"].ToString();
                string query = "select * from honorarium where id='" + ViewState["id"].ToString() + "'";
                command = new SqlCommand(query, connection);
                try
                {
                    if (connection.State == ConnectionState.Closed)
                    {
                        connection.Open();
                    }
                    reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        dpPaydate.SelectedDate = Convert.ToDateTime(reader["paydate"]);
                        txtGuestName.Text = reader["guestname"].ToString();
                        txtProgramme.Text = reader["programme"].ToString();
                        txtLocation.Text = reader["location"].ToString();
                        //txt_hrBaseAmt.Text = reader["hrBaseAmount"].ToString();
                        dl_hrBaseCur.SelectedText = reader["hrCurrency"].ToString();
                        txt_hrAmount.Text = reader["hrAmount"].ToString();
                        //txt_lgBaseAmt.Text = reader["lgBaseAmount"].ToString();
                        dl_lgBaseCur.SelectedText = reader["lgCurrency"].ToString();
                        txt_lgAmount.Text = reader["lgAmount"].ToString();
                        txtRemarks.Text = reader["remarks"].ToString();
                        ViewState["Approved"] = reader["Approved"].ToString();
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                }
                finally
                {
                    connection.Close();
                }
                if (ViewState["Approved"].ToString() == "1")
                {
                    dpPaydate.Enabled = false;
                    txtGuestName.ReadOnly = true;
                    //txt_hrBaseAmt.ReadOnly = true;
                    dl_hrBaseCur.Enabled = false;
                    txt_hrAmount.ReadOnly = true;
                    //txt_lgBaseAmt.ReadOnly = true;
                    dl_lgBaseCur.Enabled = false;
                    txt_lgAmount.ReadOnly = true;
                }
            }
        }

        //protected void dl_hrBaseCur_ItemSelected(object sender, DropDownListEventArgs e)
        //{
        //    if (txt_hrBaseAmt.Text.Length != 0)
        //    {
        //        double rate = Convert.ToDouble(dl_hrBaseCur.SelectedValue);
        //        txt_hrAmount.Value = rate * txt_hrBaseAmt.Value;
        //    }

        //}

        //protected void dl_lgBaseCur_ItemSelected(object sender, DropDownListEventArgs e)
        //{
        //    if (txt_lgBaseAmt.Text.Length != 0)
        //    {
        //        double rate = Convert.ToDouble(dl_lgBaseCur.SelectedValue);
        //        txt_lgAmount.Value = rate * txt_lgBaseAmt.Value;
        //    }
        //}

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "update Honorarium set paydate=@paydate,guestname=@guestname,programme=@programme,location=@location,hrBaseamount=@hrBase,hrCurrency=@hrCur,";
            query += "hrAmount=@hrAmount,lgBaseamount=@lgBase,lgCurrency=@lgCur,lgAmount=@lgAmount,Remarks=@remarks,Preparedby=@preparedby where id=@id";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@paydate", SqlDbType.Date).Value = dpPaydate.SelectedDate;
            command.Parameters.Add("@guestname", SqlDbType.VarChar).Value = txtGuestName.Text;
            command.Parameters.Add("@programme", SqlDbType.VarChar).Value = txtProgramme.Text;
            command.Parameters.Add("@location", SqlDbType.VarChar).Value = txtLocation.Text;
            command.Parameters.Add("@hrBase", SqlDbType.VarChar).Value = "";
            command.Parameters.Add("@hrCur", SqlDbType.VarChar).Value = dl_hrBaseCur.SelectedText;
            command.Parameters.Add("@hrAmount", SqlDbType.VarChar).Value = txt_hrAmount.Text;
            command.Parameters.Add("@lgBase", SqlDbType.VarChar).Value = "";
            command.Parameters.Add("@lgCur", SqlDbType.VarChar).Value = dl_lgBaseCur.SelectedText;
            command.Parameters.Add("@lgAmount", SqlDbType.VarChar).Value = txt_lgAmount.Text;
            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks.Text;
            command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            command.Parameters.Add("@id", SqlDbType.VarChar).Value = ViewState["id"].ToString();
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows == 1)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Updated Successfully', 'Success');", true);
                }
                command.Dispose();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            finally
            {
                connection.Close();
            }
        }
    }
}