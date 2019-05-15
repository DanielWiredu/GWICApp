<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="EventsDue.aspx.cs" Inherits="GWICApp.Main.EventsDue" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Events Due</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                             <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                
                            </ul>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
<%--                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>--%>
                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">

                                            </div>
                                        </div>
                                    </div>
                         <telerik:RadGrid ID="eventsGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="eventSource" GroupPanelPosition="Top">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                             <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="events_due" HideStructureColumns="true" >
                                <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Events Due" PageWidth="1180"></Pdf>
                              </ExportSettings>
                             <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="eventSource" CommandItemDisplay="Top">
                                 <CommandItemSettings ShowExportToPdfButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="false" />
                                 <Columns>
                                     <telerik:GridBoundColumn Display="false" DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id">
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="EventName" FilterControlAltText="Filter EventName column" HeaderText="Event Name" SortExpression="EventName" UniqueName="EventName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                     <HeaderStyle Width="250px" />
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="DateFrom" DataType="System.DateTime" FilterControlAltText="Filter DateFrom column" HeaderText="Start Date" SortExpression="DateFrom" UniqueName="DateFrom" AutoPostBackOnFilter="true" DataFormatString="{0:dd-MMM-yyyy}" FilterControlWidth="100px">
                                     <HeaderStyle Width="150px" />
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="DateTo" DataType="System.DateTime" FilterControlAltText="Filter DateTo column" HeaderText="End Date" SortExpression="DateTo" UniqueName="DateTo" AutoPostBackOnFilter="true" DataFormatString="{0:dd-MMM-yyyy}" FilterControlWidth="100px">
                                     <HeaderStyle Width="150px" />
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="RemindDate" DataType="System.DateTime" FilterControlAltText="Filter RemindDate column" HeaderText="Remind Date" SortExpression="RemindDate" UniqueName="RemindDate" AutoPostBackOnFilter="true" DataFormatString="{0:dd-MMM-yyyy}" FilterControlWidth="100px">
                                     <HeaderStyle Width="150px" />
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="Notes" FilterControlAltText="Filter Notes column" HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                     <HeaderStyle Width="300px" />
                                     </telerik:GridBoundColumn>
                                 </Columns>
                             </MasterTableView>
                        </telerik:RadGrid>
                         <asp:SqlDataSource ID="eventSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [EventName], [DateFrom], [DateTo], [RemindDate], [Notes] FROM [Events] where RemindDate <= getdate() and DateFrom >= getdate() ORDER BY [id]" > </asp:SqlDataSource>
              <%--      </ContentTemplate>
                </asp:UpdatePanel>--%>
                    </div>
                </div>
        </div>
</asp:Content>
