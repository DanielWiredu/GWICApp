<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="RecordSheet.aspx.cs" Inherits="GWICApp.Financials.RecordSheet" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Record Sheet</h5>
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
                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <telerik:RadGrid ID="recordSheetGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="recordSheetSource" GroupPanelPosition="Top" OnItemCommand="recordSheetGrid_ItemCommand" OnItemDataBound="recordSheetGrid_ItemDataBound" OnItemDeleted="recordSheetGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="recordSheetSource" CommandItemDisplay="Top" AllowAutomaticDeletes="true">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Regdate" DataType="System.DateTime" FilterControlAltText="Filter Regdate column" HeaderText="Regdate" SortExpression="Regdate" UniqueName="Regdate" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Speaker" FilterControlAltText="Filter Speaker column" HeaderText="Speaker" SortExpression="Speaker" UniqueName="Speaker" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Theme" FilterControlAltText="Filter Theme column" HeaderText="Theme" SortExpression="Theme" UniqueName="Theme" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Cash" DataType="System.Double" FilterControlAltText="Filter Cash column" HeaderText="Cash" SortExpression="Cash" UniqueName="Cash" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Cheque" DataType="System.Double" FilterControlAltText="Filter Cheque column" HeaderText="Cheque" SortExpression="Cheque" UniqueName="Cheque" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="GrandTotal" DataType="System.Double" FilterControlAltText="Filter GrandTotal column" HeaderText="GrandTotal" SortExpression="GrandTotal" UniqueName="GrandTotal" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Approved" DataType="System.Int32" FilterControlAltText="Filter Approved column" HeaderText="Approved" ReadOnly="True" SortExpression="Approved" UniqueName="Approved" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" Display="false">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn Text="Approve" CommandName="Approve" UniqueName="Approve" ConfirmText="Approve this Record Sheet?" ButtonType="PushButton" ButtonCssClass="btn-primary">
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
                        <asp:SqlDataSource ID="recordSheetSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [RecordSheet] WHERE [id] = @id" SelectCommand="SELECT [id], [Regdate], [Speaker], [Theme], [Cash], [Cheque], [GrandTotal], [Approved] FROM [RecordSheet]">
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
