<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ProductStock.aspx.cs" Inherits="GWICApp.Products.ProductStock" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Product Stock Levels</h5>
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
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">

                                            </div>
                                        </div>
                                    </div>
                               <telerik:RadGrid ID="productStockGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="productStockSource" GroupPanelPosition="Top" OnItemDataBound="productStockGrid_ItemDataBound" PageSize="20">
                                   <ClientSettings>
                                       <Selecting AllowRowSelect="True" />
                                       <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="True" />
                                   </ClientSettings>
                                   <GroupingSettings CaseSensitive="false" />
                                   <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="stock_levels" HideStructureColumns="true" >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Stock Level" PageWidth="850"></Pdf>
                                    </ExportSettings>
                                   <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="productStockSource" CommandItemDisplay="Top">
                                        <CommandItemSettings ShowExportToPdfButton="true" ShowExportToExcelButton="true" ShowAddNewRecordButton="false" />
                                       <Columns>
                                           <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" Display="false">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Item Description" SortExpression="Description" UniqueName="Description" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                           <HeaderStyle Width="220px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="QuantityReceived" DataType="System.Int32" FilterControlAltText="Filter QuantityReceived column" HeaderText="Received" SortExpression="QuantityReceived" UniqueName="QuantityReceived" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                           <HeaderStyle Width="80px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="QuantitySold" DataType="System.Int32" FilterControlAltText="Filter QuantitySold column" HeaderText="Sold" SortExpression="QuantitySold" UniqueName="QuantitySold"  AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                           <HeaderStyle Width="80px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="Balance" DataType="System.Int32" FilterControlAltText="Filter Balance column" HeaderText="Balance" SortExpression="Balance" UniqueName="Balance" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="StockStatus" FilterControlAltText="Filter StockStatus column" HeaderText="Stock Level" SortExpression="StockStatus" UniqueName="StockStatus" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridDateTimeColumn DataField="LastUpdate" DataType="System.DateTime" FilterControlAltText="Filter LastUpdate column" HeaderText="Last Update" SortExpression="LastUpdate" UniqueName="LastUpdate" AutoPostBackOnFilter="true" ShowFilterIcon="true" FilterControlWidth="120px">
                                           <HeaderStyle Width="150px" />
                                           </telerik:GridDateTimeColumn>
                                       </Columns>
                                   </MasterTableView>
                               </telerik:RadGrid>
                               <asp:SqlDataSource ID="productStockSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwProductStock]"></asp:SqlDataSource>  
                    </div>
                </div>
        </div>
</asp:Content>
