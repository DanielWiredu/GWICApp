using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;

namespace GWICApp.Main
{
    public partial class Events_Calendar : MasterPageChange
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void RadScheduler1_AppointmentDataBound(object sender, SchedulerEventArgs e)
        {
            e.Appointment.BackColor = Color.GreenYellow;
            e.Appointment.BorderColor = Color.HotPink;
        }

        protected void RadScheduler1_AppointmentInsert(object sender, AppointmentInsertEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Event Saved', 'Success');", true);
        }

        protected void RadScheduler1_AppointmentUpdate(object sender, AppointmentUpdateEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Event Updated', 'Success');", true);
        }

        protected void RadScheduler1_AppointmentDelete(object sender, AppointmentDeleteEventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "toastr.success('Event Deleted', 'Success');", true);
        }
    }
}