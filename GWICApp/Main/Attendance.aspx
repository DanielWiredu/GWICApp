<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="GWICApp.Main.Attendance" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Attendance</h5>
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
                        <asp:Button runat="server" Text="Add Attendance" CssClass="btn btn-success" PostBackUrl="~/Main/NewAttendance.aspx" />

                         <asp:UpdatePanel runat="server" >
                    <ContentTemplate>
                        <telerik:RadGrid ID="attendanceGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="attendanceSource" GroupPanelPosition="Top" OnItemCommand="attendanceGrid_ItemCommand" OnItemDeleted="attendanceGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="attendanceSource" CommandItemDisplay="None" AllowAutomaticDeletes="true">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" Display="false">
                                    <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridDateTimeColumn DataField="Regdate" DataType="System.DateTime" FilterControlAltText="Filter Regdate column" HeaderText="Regdate" SortExpression="Regdate" UniqueName="Regdate" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="110px" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="Service" FilterControlAltText="Filter Service column" HeaderText="Service" SortExpression="Service" UniqueName="Service" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Speaker" FilterControlAltText="Filter Speaker column" HeaderText="Speaker" SortExpression="Speaker" UniqueName="Speaker" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                    <HeaderStyle Width="180px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Theme" FilterControlAltText="Filter Theme column" HeaderText="Theme" SortExpression="Theme" UniqueName="Theme" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                    <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Adults"  FilterControlAltText="Filter Adults column" HeaderText="Adults" SortExpression="Adults" UniqueName="Adults" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                    <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Children" FilterControlAltText="Filter Children column" HeaderText="Children" SortExpression="Children" UniqueName="Children" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                    <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Cars" FilterControlAltText="Filter Cars column" HeaderText="Cars" SortExpression="Cars" UniqueName="Cars" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="50px">
                                    <HeaderStyle Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="attendanceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Attendance] WHERE [id] = @id" SelectCommand="SELECT [id], [Regdate], [Service], [Speaker], [Theme], [Adults], [Children], [Cars] FROM [Attendance] ORDER BY [Regdate] DESC">
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
