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
    public partial class EditPayment : MasterPageChange
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
                string query = "select * from Payments where id='" + Session["payid"].ToString() + "'";
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
                        ViewState["id"] = reader["id"].ToString();
                        dpPaydate1.SelectedDate = Convert.ToDateTime(reader["paydate"]);
                        txtName1.Text = reader["payname"].ToString();
                        dlDescription1.SelectedText = reader["description"].ToString();
                        Session["epType"] = reader["paytype"].ToString();
                        dlPaymode1.SelectedText = reader["paymode"].ToString();
                        dlCurrency1.SelectedText = reader["currency"].ToString();
                        txtAmount1.Text = reader["amount"].ToString();
                        dlBank1.SelectedValue = reader["paybank"].ToString();
                        txtChequeno1.Text = reader["chequeno"].ToString();
                        dpValueDate1.SelectedDate = Convert.ToDateTime(reader["valuedate"]);
                        txtRemarks1.Text = reader["remarks"].ToString();
                        if (dlPaymode1.SelectedText == "Cash")
                        {
                            dlBank1.ClearSelection();
                            dlBank1.Enabled = false;
                            txtChequeno1.Enabled = false;
                            dpValueDate1.Enabled = false;
                        }
                        else
                        {
                            dlBank1.Enabled = true;
                            txtChequeno1.Enabled = true;
                            dpValueDate1.Enabled = true;
                        }
                    }
                    reader.Close();

                    //dlDescription1.DataBind();
                    if (Session["epType"].ToString() == "Income")
                        btnReturn.PostBackUrl = "/Financials/IncomeList.aspx";
                    else
                        btnReturn.PostBackUrl = "/Financials/ExpenseList.aspx";

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
        protected void dlPaymode1_ItemSelected(object sender, DropDownListEventArgs e)
        {
            if (dlPaymode1.SelectedText == "Cash")
            {
                dlBank1.ClearSelection();
                dlBank1.Enabled = false;
                txtChequeno1.Text = "";
                txtChequeno1.Enabled = false;
                dpValueDate1.SelectedDate = DateTime.Now;
                dpValueDate1.Enabled = false;
            }
            else if (dlPaymode1.SelectedText == "Cheque")
            {
                dlBank1.Enabled = true;
                txtChequeno1.Enabled = true;
                dpValueDate1.Enabled = true;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string Payyyyymm = dpPaydate1.SelectedDate.Value.ToString("yyyyMM");
            string query = "update Payments set paydate=@paydate,payname=@payname,description=@description,paytype=@paytype,paymode=@paymode,currency=@currency,";
            query += "amount=@amount,paybank=@paybank,chequeno=@chequeno,valuedate=@valuedate,remarks=@remarks,preparedby=@preparedby,payyyyymm=@payyyyymm where id=@id";
            command = new SqlCommand(query, connection);
            command.Parameters.Add("@paydate", SqlDbType.Date).Value = dpPaydate1.SelectedDate;
            command.Parameters.Add("@payname", SqlDbType.VarChar).Value = txtName1.Text;
            command.Parameters.Add("@description", SqlDbType.VarChar).Value = dlDescription1.SelectedText;
            command.Parameters.Add("@paytype", SqlDbType.VarChar).Value = dlDescription1.SelectedValue;
            command.Parameters.Add("@paymode", SqlDbType.VarChar).Value = dlPaymode1.SelectedText;
            command.Parameters.Add("@currency", SqlDbType.VarChar).Value = dlCurrency1.SelectedText;
            command.Parameters.Add("@amount", SqlDbType.VarChar).Value = txtAmount1.Text;
            command.Parameters.Add("@paybank", SqlDbType.VarChar).Value = dlBank1.SelectedValue;
            command.Parameters.Add("@chequeno", SqlDbType.VarChar).Value = txtChequeno1.Text;
            command.Parameters.Add("@valuedate", SqlDbType.Date).Value = dpValueDate1.SelectedDate;
            command.Parameters.Add("@remarks", SqlDbType.VarChar).Value = txtRemarks1.Text;
            command.Parameters.Add("@preparedby", SqlDbType.VarChar).Value = Context.User.Identity.Name;
            command.Parameters.Add("@payyyyymm", SqlDbType.VarChar).Value = Payyyyymm;
            command.Parameters.Add("@id", SqlDbType.VarChar).Value = ViewState["id"].ToString();
            try
            {
                if (connection.State == ConnectionState.Closed)
                {
                    connection.Open();
                }
                rows = command.ExecuteNonQuery();
                if (rows > 0)
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