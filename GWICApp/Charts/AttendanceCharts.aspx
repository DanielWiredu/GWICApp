<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="AttendanceCharts.aspx.cs" Inherits="GWICApp.Charts.AttendanceCharts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0" AutoPostBack="true">
                <Tabs>
                    <telerik:RadTab runat="server" Text="Attendance Chart" >
                    </telerik:RadTab>

                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" RenderSelectedPageOnly="true">
                <telerik:RadPageView runat="server" Height="710px" ContentUrl="/Charts/AttendanceBarChart.aspx"></telerik:RadPageView>
                 </telerik:RadMultiPage>
</asp:Content>
