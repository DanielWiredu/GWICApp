using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;


namespace GWICApp.Financials
{
    public partial class EditRecordSheet : System.Web.UI.Page
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
                ViewState["id"] = Session["rsID"].ToString();
                string query = "select * from RecordSheet where id = '" + ViewState["id"].ToString() + "'";
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
                        dpDate.SelectedDate = Convert.ToDateTime(reader["regdate"]);
                        txtSpeaker.Text = reader["Speaker"].ToString();
                        txtTheme.Text = reader["Theme"].ToString();
                        txtAdults.Text = reader["Adults"].ToString();
                        txtChildren.Text = reader["Children"].ToString();
                        txtCars.Text = reader["Cars"].ToString();
                        txtAltar.Text = reader["AltarSeed"].ToString();
                        txtProphetic.Text = reader["PropheticSeed"].ToString();
                        txtFirst.Text = reader["FirstOffering"].ToString();
                        txtSecond.Text = reader["SecondOffering"].ToString();
                        txtTithe.Text = reader["Tithe"].ToString();
                        txtThanksgiving.Text = reader["Thanksgiving"].ToString();
                        txtPledge.Text = reader["Pledge"].ToString();
                        txtProject.Text = reader["ProjectOffering"].ToString();
                        txtCash.Text = reader["Cash"].ToString();
                        txtCheque.Text = reader["Cheque"].ToString();
                        txtGrandTotal.Text = reader["GrandTotal"].ToString();
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
                    dpDate.Enabled = false;
                    txtAltar.ReadOnly = true;
                    txtProphetic.ReadOnly = true;
                    txtFirst.ReadOnly = true;
                    txtSecond.ReadOnly = true;
                    txtTithe.ReadOnly = true;
                    txtThanksgiving.ReadOnly = true;
                    txtPledge.ReadOnly = true;
                    txtProject.ReadOnly = true;
                    txtCash.ReadOnly = true;
                    txtCheque.ReadOnly = true;
                    txtGrandTotal.ReadOnly = true;
                }
            }
        }

        protected void txtAltar_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtProphetic_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtFirst_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtSecond_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtTithe_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtThanksgiving_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtPledge_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void txtProject_TextChanged(object sender, EventArgs e)
        {
            double total = Convert.ToDouble(txtAltar.Value + txtProphetic.Value + txtFirst.Value + txtSecond.Value + txtTithe.Value + txtThanksgiving.Value + txtPledge.Value + txtProject.Value);
            txtGrandTotal.Text = total.ToString();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

            string query = "update RecordSheet set Regdate=@regdate,Speaker=@speaker,Theme=@theme,Adults=@adults,Children=@children,Cars=@cars where id=@id";
            command = new SqlCommand();
            command.Parameters.Add("@regdate", SqlDbType.Date).Value = dpDate.SelectedDate;
            command.Parameters.Add("@speaker", SqlDbType.VarChar).Value = txtSpeaker.Text;
            command.Parameters.Add("@theme", SqlDbType.VarChar).Value = txtTheme.Text;
            command.Parameters.Add("@adults", SqlDbType.VarChar).Value = txtAdults.Text;
            command.Parameters.Add("@children", SqlDbType.VarChar).Value = txtChildren.Text;
            command.Parameters.Add("@cars", SqlDbType.VarChar).Value = txtCars.Text;
            command.Parameters.Add("@id", SqlDbType.VarChar).Value = ViewState["id"].ToString();

            if (ViewState["Approved"].ToString() == "0")
            {
                if ((txtCash.Value.Value + txtCheque.Value.Value) != txtGrandTotal.Value.Value)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('Cash and Cheque amount do not sum up to GrandTotal', 'Error');", true);
                    return;
                }
                query = "update RecordSheet set Regdate=@regdate,Speaker=@speaker,Theme=@theme,Adults=@adults,Children=@children,Cars=@cars,AltarSeed=@altar,PropheticSeed=@prophetic,FirstOffering=@firstoffering,SecondOffering=@secondoffering,";
                query += "Tithe=@tithe,Thanksgiving=@thanksgiving,Pledge=@pledge,ProjectOffering=@project,Cash=@cash,Cheque=@cheque,GrandTotal=@grandtotal where id=@id";
                command.Parameters.Add("@altar", SqlDbType.VarChar).Value = txtAltar.Text;
                command.Parameters.Add("@prophetic", SqlDbType.VarChar).Value = txtProphetic.Text;
                command.Parameters.Add("@firstoffering", SqlDbType.VarChar).Value = txtFirst.Text;
                command.Parameters.Add("@secondoffering", SqlDbType.VarChar).Value = txtSecond.Text;
                command.Parameters.Add("@tithe", SqlDbType.VarChar).Value = txtTithe.Text;
                command.Parameters.Add("@thanksgiving", SqlDbType.VarChar).Value = txtThanksgiving.Text;
                command.Parameters.Add("@pledge", SqlDbType.VarChar).Value = txtPledge.Text;
                command.Parameters.Add("@project", SqlDbType.VarChar).Value = txtProject.Text;
                command.Parameters.Add("@cash", SqlDbType.VarChar).Value = txtCash.Text;
                command.Parameters.Add("@cheque", SqlDbType.VarChar).Value = txtCheque.Text;
                command.Parameters.Add("@grandtotal", SqlDbType.VarChar).Value = txtGrandTotal.Text;
            }
            command.Connection = connection;
            command.CommandText = query;
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