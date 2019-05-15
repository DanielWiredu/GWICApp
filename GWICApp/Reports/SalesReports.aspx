<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="SalesReports.aspx.cs" Inherits="GWICApp.Reports.SalesReports" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Sales Reports</h5>
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
                          <div class="bg-primary">Select duration for Report</div>
             
                       <div class="form-group">
                          <div class="row">
                              <div class="col-md-2">
                                  <label>Start Date</label>
                                  <telerik:RadDatePicker ID="dpSdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpSdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Start date required" ValidationGroup="detail"></asp:RequiredFieldValidator>
                              </div>
                                <div class="col-md-2">
                                  <label>End Date</label>
                                  <telerik:RadDatePicker ID="dpEdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="End date required" ValidationGroup="detail"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-2">
                                  <label>Type</label>
                                  <asp:RadioButtonList ID="rdType" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rdType_SelectedIndexChanged">
                                      <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                                      <asp:ListItem Text="Product" Value="Product"></asp:ListItem>
                                  </asp:RadioButtonList>
                              </div>
                              <div class="col-md-6">
                                           <label runat="server" id="lblProduct" visible="false">Product</label>
                                            <telerik:RadComboBox ID="dlProduct" runat="server" Width="100%" DataSourceID="productSource" DataTextField="Description" DataValueField="ProductId" Filter="Contains" MarkFirstMatch="true" MaxHeight="400px" Visible="false"></telerik:RadComboBox>
                                            <asp:SqlDataSource ID="productSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT ProductId,Description FROM Products"></asp:SqlDataSource>  
                                       </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnReport" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnReport_Click" ValidationGroup="detail"/>         
                </div>

                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
