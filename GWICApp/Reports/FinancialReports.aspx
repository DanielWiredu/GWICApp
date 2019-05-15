<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="FinancialReports.aspx.cs" Inherits="GWICApp.Reports.FinancialReports" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Financial Reports</h5>
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
                              <div class="col-md-1">

                              </div>
                              <div class="col-md-3">
                                  <label>Start Date</label>
                                  <telerik:RadDatePicker ID="dpSdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpSdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Start date required" ValidationGroup="detail"></asp:RequiredFieldValidator>
                              </div>
                                <div class="col-md-3">
                                  <label>End Date</label>
                                  <telerik:RadDatePicker ID="dpEdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="End date required" ValidationGroup="detail"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-4">
                                  <label>Currency</label>
                                 <telerik:RadComboBox ID="dlCurrency" runat="server" Width="100%" DataSourceID="currencySource" DataTextField="cur_code" DataValueField="cur_code" Filter="Contains" MarkFirstMatch="True" Text="Select Currency"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="currencySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT cur_code FROM [Currencies]"></asp:SqlDataSource>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCurrency" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Currency" ValidationGroup="detail"></asp:RequiredFieldValidator>

                              </div>
                              <div class="col-md-1">

                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnReport" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnReport_Click" ValidationGroup="detail"/>         
                </div>

                        <div class="divider"></div>
                        <div>&nbsp;</div>
                         <div class="bg-primary">Select Period for Report</div>
                       <div class="form-group">
                          <div class="row">
                              <div class="col-md-1">

                              </div>
                              <div class="col-md-3">
                                  <label>Type</label>
                                  <asp:RadioButtonList ID="rdType" runat="server" RepeatDirection="Horizontal">
                                      <asp:ListItem Text="Monthly" Value="Monthly" Selected="True"></asp:ListItem>
                                      <asp:ListItem Text="Yearly" Value="Yearly"></asp:ListItem>
                                  </asp:RadioButtonList>
                              </div>
                              <div class="col-md-3">
                                  <label>Month/Year</label>
                                  <telerik:RadMonthYearPicker ID="dpPeriod" runat="server" DateInput-ReadOnly="true" Width="100%"></telerik:RadMonthYearPicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpPeriod" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Report Period required" ValidationGroup="summary"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-4">
                                  <label>Currency</label>
                                 <telerik:RadComboBox ID="dlCur" runat="server" Width="100%" DataSourceID="currencySource" DataTextField="cur_code" DataValueField="cur_code" Filter="Contains" MarkFirstMatch="True" Text="Select Currency"></telerik:RadComboBox>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="dlCur" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Currency" ValidationGroup="summary"></asp:RequiredFieldValidator>

                              </div>
                              <div class="col-md-1">

                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnReportSummary" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnReportSummary_Click" ValidationGroup="summary"/>         
                </div>

                        <hr />

                        <div class="bg-primary">Select duration for Report - HONORARIUM</div>
             
                       <div class="form-group">
                          <div class="row">
                              <div class="col-md-1">

                              </div>
                              <div class="col-md-3">
                                  <label>Start Date</label>
                                  <telerik:RadDatePicker ID="dpHnStartdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpHnStartdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Start date required" ValidationGroup="honorarium"></asp:RequiredFieldValidator>
                              </div>
                                <div class="col-md-3">
                                  <label>End Date</label>
                                  <telerik:RadDatePicker ID="dpHnEnddate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpHnEnddate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="End date required" ValidationGroup="honorarium"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-4">
                                  <label>Currency</label>
                                 <telerik:RadComboBox ID="dlHnCurrency" runat="server" Width="100%" DataSourceID="currencySource" DataTextField="cur_code" DataValueField="cur_code" Filter="Contains" MarkFirstMatch="True" Text="Select Currency"></telerik:RadComboBox>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="dlHnCurrency" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Currency" ValidationGroup="honorarium"></asp:RequiredFieldValidator>

                              </div>
                              <div class="col-md-1">

                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnHonoriumReport" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnHonoriumReport_Click" ValidationGroup="honorarium"/>         
                </div>

                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
    
</asp:Content>
