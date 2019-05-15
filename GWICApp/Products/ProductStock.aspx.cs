using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;

namespace GWICApp.Products
{
    public partial class ProductStock : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void productStockGrid_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;
                TableCell stockstatus = item["StockStatus"];
                if (stockstatus.Text == "Low")
                    stockstatus.BackColor = Color.HotPink;
                else if (stockstatus.Text == "Normal")
                    stockstatus.BackColor = Color.GreenYellow;
                else if (stockstatus.Text == "High")
                    stockstatus.BackColor = Color.Aqua;
            }
        }
    }
}