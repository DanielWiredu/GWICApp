<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Events_Calendar.aspx.cs" Inherits="GWICApp.Main.Events_Calendar" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Events</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                 <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">

                                            </div>
                                        </div>
                                    </div>
                            <div class="row">
                                        <telerik:RadScheduler ID="RadScheduler1" runat="server" SelectedView="MonthView" DataSourceID="eventSource" AllowInsert="true" AllowEdit="true" AllowDelete="true" DataKeyField="id" DataDescriptionField="Notes" DataEndField="DateTo" DataReminderField="Reminder" DataStartField="DateFrom" DataSubjectField="EventName" Height="600px"
                                              OnAppointmentInsert="RadScheduler1_AppointmentInsert" OnAppointmentUpdate="RadScheduler1_AppointmentUpdate" OnAppointmentDelete="RadScheduler1_AppointmentDelete"  OnAppointmentDataBound="RadScheduler1_AppointmentDataBound"
                                             StartInsertingInAdvancedForm="false" DataRecurrenceField="RecurrenceRule" DataRecurrenceParentKeyField="RecurrenceParentID"   >
                                            <Reminders Enabled="true" />
                                            <AdvancedForm  />
                                            
                                        </telerik:RadScheduler>
                                        <asp:SqlDataSource ID="eventSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Events] WHERE [id] = @id" InsertCommand="INSERT INTO [Events] ([EventName], [DateFrom], [DateTo], [Reminder], [Notes], [RecurrenceRule],[RecurrenceParentID]) VALUES (@EventName, @DateFrom, @DateTo, @Reminder, @Notes, @RecurrenceRule, @RecurrenceParentID)" SelectCommand="SELECT [id], [EventName], [DateFrom], [DateTo], [Reminder], [Notes], [RecurrenceRule],[RecurrenceParentID] FROM [Events]" UpdateCommand="UPDATE [Events] SET [EventName] = @EventName, [DateFrom] = @DateFrom, [DateTo] = @DateTo, [Reminder] = @Reminder, [Notes] = @Notes, [RecurrenceRule] = @RecurrenceRule, [RecurrenceParentID] = @RecurrenceParentID WHERE [id] = @id">
                                            <DeleteParameters>
                                                <asp:Parameter Name="id" Type="Int32" />
                                            </DeleteParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="EventName" Type="String" />
                                                <asp:Parameter DbType="DateTime" Name="DateFrom" />
                                                <asp:Parameter DbType="DateTime" Name="DateTo" />
                                                <asp:Parameter Name="Reminder" Type="String" />
                                                <asp:Parameter Name="Notes" Type="String" />
                                                <asp:Parameter Name="RecurrenceRule" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="RecurrenceParentID" Type="Int32"></asp:Parameter>
                                            </InsertParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="EventName" Type="String" />
                                                <asp:Parameter DbType="DateTime" Name="DateFrom" />
                                                <asp:Parameter DbType="DateTime" Name="DateTo" />
                                                <asp:Parameter Name="Reminder" Type="String" />
                                                <asp:Parameter Name="Notes" Type="String" />
                                                <asp:Parameter Name="RecurrenceRule" Type="String"></asp:Parameter>
                                                <asp:Parameter Name="RecurrenceParentID" Type="Int32"></asp:Parameter>
                                                <asp:Parameter Name="id" Type="Int32" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                    </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        
                    </div>
                </div>
        </div>
</asp:Content>
