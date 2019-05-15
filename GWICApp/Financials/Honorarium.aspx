<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Honorarium.aspx.cs" Inherits="GWICApp.Financials.Honourarium" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Visiting Ministers' Honorarium</h5>
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
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add New" CausesValidation="false" PostBackUrl="~/Financials/NewHonorarium.aspx" />  
                                            </div>
                                        </div>
                                    </div>

                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <telerik:RadGrid ID="honorariumGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="honorariumSource" GroupPanelPosition="Top" OnItemCommand="honorariumGrid_ItemCommand" OnItemDataBound="honorariumGrid_ItemDataBound" OnItemDeleted="honorariumGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="honorariumSource" CommandItemDisplay="None" AllowAutomaticDeletes="true">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px" Display="false">
                                    <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Paydate" DataType="System.DateTime" FilterControlAltText="Filter Paydate column" HeaderText="Paydate" SortExpression="Paydate" UniqueName="Paydate" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="GuestName" FilterControlAltText="Filter GuestName column" HeaderText="GuestName" SortExpression="GuestName" UniqueName="GuestName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Programme" FilterControlAltText="Filter Programme column" HeaderText="Programme" SortExpression="Programme" UniqueName="Programme" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="hrCurrency" FilterControlAltText="Filter hrCurrency column" SortExpression="hrCurrency" UniqueName="hrCurrency" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridNumericColumn DataField="hrAmount" FilterControlAltText="Filter hrAmount column" HeaderText="Honorarium" SortExpression="hrAmount" UniqueName="hrAmount" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px" DataFormatString="{0:0.00}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridNumericColumn>
                                    <telerik:GridNumericColumn DataField="lgAmount" FilterControlAltText="Filter lgAmount column" HeaderText="Logging" SortExpression="lgAmount" UniqueName="lgAmount" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" DataFormatString="{0:0.00}">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridNumericColumn>
                                    <telerik:GridBoundColumn DataField="lgCurrency" FilterControlAltText="Filter lgCurrency column" SortExpression="lgCurrency" UniqueName="lgCurrency" Display="false">
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter Remarks column" SortExpression="Remarks" UniqueName="Remarks" Display="false">
                                    </telerik:GridBoundColumn>
                                  <%--  <telerik:GridCalculatedColumn HeaderText="Total Cost" UniqueName="TotalCost" DataType="System.Double" DataFields="hrAmount, lgAmount" Expression="{0}+{1}" DataFormatString="{0:0.00}" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                     <HeaderStyle Width="100px" />
                                    </telerik:GridCalculatedColumn>--%>
                                    <telerik:GridBoundColumn DataField="Approved" DataType="System.Int32" FilterControlAltText="Filter Approved column" HeaderText="Approved" ReadOnly="True" SortExpression="Approved" UniqueName="Approved" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" Display="false">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn Text="Approve" CommandName="Approve" UniqueName="Approve" ConfirmText="Approve this honorarium and post to Payments?" ButtonType="PushButton" ButtonCssClass="btn-primary">
                                        <HeaderStyle Width="70px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="honorariumSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Honorarium] WHERE [id] = @id" SelectCommand="SELECT [id], [Paydate], [GuestName], [Programme], [hrCurrency], [hrAmount], [lgCurrency], [lgAmount], [Remarks], [Approved] FROM [Honorarium]">
                            <DeleteParameters>
                                <asp:Parameter Name="id" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
    
</asp:Content>
