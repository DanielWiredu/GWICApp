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

namespace GWICApp.Setups
{
    public partial class Items : MasterPageChange
    {
        static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int rows = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void itemGrid_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                GridDataItem item = e.Item as GridDataItem;
                ViewState["id"] = item["ItemId"].Text;
                txtDescription1.Text = item["Description"].Text;
                dlUnit1.SelectedValue = item["UnitOfIssue"].Text;
                txtMinValue1.Text = item["MinValue"].Text;
                //txtMaxValue1.Text = item["MaxValue"].Text;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "editModal();", true);
                e.Canceled = true;
            }
        }

        protected void itemGrid_ItemDeleted(object sender, GridDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + e.Exception.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Deleted Successfully', 'Success');", true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string query = "Insert Into Items(Description,UnitOfIssue,MinValue,MaxValue) Values(@Description,@UnitOfIssue,@MinValue,@MaxValue)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Description", SqlDbType.VarChar).Value = txtDescription.Text.ToUpper();
                    command.Parameters.Add("@UnitOfIssue", SqlDbType.VarChar).Value = dlUnit.SelectedValue;
                    command.Parameters.Add("@MinValue", SqlDbType.Int).Value = txtMinValue.Value;
                    command.Parameters.Add("@MaxValue", SqlDbType.Int).Value = 1000;
                    try
                    {
                        connection.Open();
                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Item Saved Successfully', 'Success');", true);
                            itemGrid.Rebind();
                            //ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closenewModal();", true);
                            txtDescription.Text = "";
                            dlUnit.ClearSelection();
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string query = "Update Items Set Description=@Description,UnitOfIssue=@UnitOfIssue,MinValue=@MinValue,MaxValue=@MaxValue Where ItemId=@ItemId";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.Add("@Description", SqlDbType.VarChar).Value = txtDescription1.Text.ToUpper();
                    command.Parameters.Add("@UnitOfIssue", SqlDbType.VarChar).Value = dlUnit1.SelectedValue;
                    command.Parameters.Add("@MinValue", SqlDbType.Int).Value = txtMinValue1.Value;
                    command.Parameters.Add("@MaxValue", SqlDbType.Int).Value = 1000;
                    command.Parameters.Add("@ItemId", SqlDbType.VarChar).Value = ViewState["id"].ToString();
                    try
                    {
                        connection.Open();

                        rows = command.ExecuteNonQuery();
                        if (rows == 1)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Item Updated Successfully', 'Success');", true);
                            itemGrid.Rebind();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "pop", "closeeditModal();", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.error('" + ex.Message.Replace("'", "").Replace("\r\n", "") + "', 'Error');", true);
                    }
                }
            }
        }

        //protected void txtMinValue_TextChanged(object sender, EventArgs e)
        //{
        //    txtMaxValue.MinValue = txtMinValue.Value.Value;
        //}

        //protected void txtMinValue1_TextChanged(object sender, EventArgs e)
        //{
        //    txtMaxValue1.MinValue = txtMinValue1.Value.Value;
        //}
    }
}