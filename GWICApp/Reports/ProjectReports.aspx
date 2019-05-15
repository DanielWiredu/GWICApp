<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ProjectReports.aspx.cs" Inherits="GWICApp.Reports.ProjectReports" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Project Reports</h5>
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
                          <div class="bg-primary">Payment Report - Member/Visitor</div>
             
                       <div class="form-group">
                          <div class="row">
                              <%--<div class="col-md-3">
                                  <label>Start Date</label>
                                  <telerik:RadDatePicker ID="dpSdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpSdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Start date required"></asp:RequiredFieldValidator>
                              </div>--%>
                              <%--<div class="col-md-3">
                                  <asp:RadioButtonList ID="rdPayType" runat="server">
                                      <asp:ListItem Text="Member" Value="Member" Selected="True"></asp:ListItem>
                                      <asp:ListItem Text="Visitor" Value="Visitor"></asp:ListItem>
                                  </asp:RadioButtonList>
                              </div>--%>
                              <div class="col-md-3">
                                  
                              </div>
                              <div class="col-md-6">
                                  <label>Payer ID</label>
                                  <asp:TextBox runat="server" ID="txtPayerID" Width="100%"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPayerID" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Enter Payer ID" ValidationGroup="mp"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-3">
                                  
                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnReport" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnReport_Click" ValidationGroup="mp"/>         
                </div>

                        <div class="bg-primary">Payment Report - Single Project</div>
             
                       <div class="form-group">
                          <div class="row">
                              <div class="col-md-3">
                                  
                              </div>
                              <div class="col-md-6">
                                <label>Project</label>
                                 <telerik:RadComboBox ID="dlProject" runat="server" Width="100%" DataSourceID="projectSource" DataTextField="ProjectName" DataValueField="Id" Filter="Contains" MarkFirstMatch="True" Text="Select Project"></telerik:RadComboBox>
                                 <asp:SqlDataSource ID="projectSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Id,ProjectName FROM [Projects]"></asp:SqlDataSource>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dlProject" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Project" ValidationGroup="indpp"></asp:RequiredFieldValidator>
                            </div>
                              <div class="col-md-3">
                                  
                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnIndProjectPayments" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnIndProjectPayments_Click" ValidationGroup="indpp"/>         
                </div>

                        <div class="bg-primary">Payment Reports</div>
             
                       <div class="form-group">
                          <div class="row">
                              <div class="col-md-3">
                                  
                              </div>
                              <div class="col-md-6">
                                  <label>Report Type</label>
                                  <telerik:RadDropDownList runat="server" ID="dlReportType" Width="100%">
                                      <Items>
                                          <telerik:DropDownListItem Text="Payment Summary" />
                                          <telerik:DropDownListItem Text="Payment Balance" />
                                      </Items>
                                  </telerik:RadDropDownList>
                              </div>
                              <div class="col-md-3">
                                  
                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="btnProjectSummary" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnProjectSummary_Click" />         
                </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
