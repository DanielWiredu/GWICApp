﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GWICApp.Errors
{
    public partial class Error404 : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Status = "404 Not Found";
            Response.StatusCode = 404;
            Response.TrySkipIisCustomErrors = true;
        }
    }
}