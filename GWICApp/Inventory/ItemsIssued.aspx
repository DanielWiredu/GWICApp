<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ItemsIssued.aspx.cs" Inherits="GWICApp.Inventory.ItemsIssued" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Items Issued</h5>
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
                        <div class="row">
                                        <div class="col-sm-4 pull-right" style="width:inherit">
                                           <asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click"/>
                                            <asp:Button runat="server" ID="btnPDFExport" CssClass="btn btn-warning" Text="PDF" CausesValidation="false" OnClick="btnPDFExport_Click"/>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddIssue" CssClass="btn btn-success" Text="Add Issue" CausesValidation="false" PostBackUrl="~/Inventory/NewItemIssued.aspx" />  
                                            </div>
                                        </div>
                                    </div>

                          <asp:UpdatePanel runat="server">
                           <ContentTemplate>
                               <telerik:RadGrid ID="itemIssuedGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="itemIssuedSource" GroupPanelPosition="Top" OnItemCommand="itemIssuedGrid_ItemCommand" OnDeleteCommand="itemIssuedGrid_DeleteCommand">
                                   <ClientSettings>
                                       <Selecting AllowRowSelect="True" />
                                       <Scrolling AllowScroll="true" ScrollHeight="400px" />
                                   </ClientSettings>
                                   <GroupingSettings CaseSensitive="false" />
                                   <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="items_issued" HideStructureColumns="true" >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Items Issued" PageWidth="800"></Pdf>
                                    </ExportSettings>
                                   <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="itemIssuedSource">
                                       <Columns>
                                           <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" Display="false">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridDateTimeColumn DataField="IssueDate" DataType="System.DateTime" FilterControlAltText="Filter IssueDate column" HeaderText="Issue Date" SortExpression="IssueDate" UniqueName="IssueDate" AutoPostBackOnFilter="true" FilterControlWidth="120px" DataFormatString="{0:dd-MMM-yyyy}">
                                           <HeaderStyle Width="140px" />
                                           </telerik:GridDateTimeColumn>
                                           <telerik:GridBoundColumn DataField="Department" FilterControlAltText="Filter Department column" HeaderText="Department" SortExpression="Department" UniqueName="Department" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px">
                                           <HeaderStyle Width="120px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn Display="false" DataField="ItemId" SortExpression="ItemId" UniqueName="ItemId">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description"  AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                           <HeaderStyle Width="200px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="QuantityIssued" DataType="System.Int32" FilterControlAltText="Filter QuantityIssued column" HeaderText="Quantity" SortExpression="QuantityIssued" UniqueName="QuantityIssued" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                           <HeaderStyle Width="80px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="ReceivedBy" FilterControlAltText="Filter ReceivedBy column" HeaderText="ReceivedBy" SortExpression="ReceivedBy" UniqueName="ReceivedBy" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px">
                                           <HeaderStyle Width="120px" />
                                           </telerik:GridBoundColumn>
                                            <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" Exportable="false">
                                            <HeaderStyle Width="40px" />
                                            </telerik:GridButtonColumn>
                                            <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                            <HeaderStyle Width="50px" />
                                            </telerik:GridButtonColumn>
                                       </Columns>
                                   </MasterTableView>
                               </telerik:RadGrid>
                               <asp:SqlDataSource ID="itemIssuedSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwItemsIssued]"></asp:SqlDataSource>
                           </ContentTemplate>
                              <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcelExport" />
                                  <asp:PostBackTrigger ControlID="btnPDFExport" />
                              </Triggers>
                       </asp:UpdatePanel>   
                    </div>
                </div>
        </div>
</asp:Content>
