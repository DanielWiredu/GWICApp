<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="MemberCharts.aspx.cs" Inherits="GWICApp.Charts.MemberCharts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1" SelectedIndex="0" AutoPostBack="true">
                <Tabs>
                    <telerik:RadTab runat="server" Text="All Members" >
                    </telerik:RadTab>
                    <telerik:RadTab runat="server" Text="Members (Monthly)" >
                    </telerik:RadTab>
                     <telerik:RadTab runat="server" Text="Members (Yearly)" >
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" RenderSelectedPageOnly="true">
                <telerik:RadPageView runat="server" Height="610px" ContentUrl="/Charts/MembersByGender.aspx"></telerik:RadPageView>
                <telerik:RadPageView runat="server" Height="710px" ContentUrl="/Charts/MembersOnMonth.aspx"></telerik:RadPageView>
                 <telerik:RadPageView runat="server" Height="710px" ContentUrl="/Charts/MembersOnYear.aspx"></telerik:RadPageView>
                 </telerik:RadMultiPage>
</asp:Content>
