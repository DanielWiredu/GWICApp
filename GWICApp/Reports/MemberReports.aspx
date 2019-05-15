<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="MemberReports.aspx.cs" Inherits="GWICApp.Reports.MemberReports" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Member Reports</h5>
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
                              <div class="col-md-3">

                              </div>
                              <div class="col-md-3">
                                  <label>Option</label><br />
                                  <asp:RadioButton ID="rdAll" runat="server" Text="All" Checked="true" GroupName="opt" AutoPostBack="true" OnCheckedChanged="rdAll_CheckedChanged" />
                                  <asp:RadioButton ID="rdSpecific" runat="server" Text="Specific" GroupName="opt" AutoPostBack="true" OnCheckedChanged="rdSpecific_CheckedChanged" />
                              </div>
                              <div class="col-md-3">
                                  <label>Select Type</label>
                                  <telerik:RadDropDownList ID="dlType" runat="server" Width="100%" AutoPostBack="true" CausesValidation="false" DefaultMessage="Select Report Type" OnItemSelected="dlType_ItemSelected">
                                      <Items>
                                          <%--<telerik:DropDownListItem Text="Member Listing" Value="All" Visible="false" />--%>
                                          <telerik:DropDownListItem Text="Member List - Group by Occupation" Value="Occupation" />
                                          <telerik:DropDownListItem Text="Member List - Group by Gender" Value="Gender" />
                                          <telerik:DropDownListItem Text="Member List - Group by Department" Value="Department" />
                                          <telerik:DropDownListItem Text="Member List - Group by Profession" Value="Profession" />
                                          <telerik:DropDownListItem Text="Member List - Group by Baptism Type" Value="Baptism" />
                                      </Items>
                                  </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dlType" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Report Type"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-3">

                              </div>
                          </div>
                      </div>
                       <div class="form-group">
                          <div class="row">
                              <div class="col-md-1">

                              </div>
                              <div class="col-md-3">
                                  <label>Start Date</label>
                                  <telerik:RadDatePicker ID="dpSdate" runat="server" Width="100%"  DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpSdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Start date required"></asp:RequiredFieldValidator>
                              </div>
                                <div class="col-md-3">
                                  <label>End Date</label>
                                  <telerik:RadDatePicker ID="dpEdate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dpEdate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="End date required"></asp:RequiredFieldValidator>
                              </div>
                              <div class="col-md-4">
                                  <label runat="server" id="lblType"></label>
                                  <telerik:RadDropDownList ID="dlGender" runat="server" Width="100%" Visible="false">
                             <Items>
                                 <telerik:DropDownListItem Text="Male" Value="Male"/>
                                 <telerik:DropDownListItem Text="Female" Value="Female" Selected="true" />
                             </Items>
                         </telerik:RadDropDownList>

                                 <telerik:RadComboBox ID="dlOccupation" runat="server" Width="100%" DataSourceID="occupationSource" DataTextField="Occupation" DataValueField="Occupation" Filter="Contains" MarkFirstMatch="True" Text="Select Occupation" Visible="false"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="occupationSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Occupation]"></asp:SqlDataSource>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="dlOccupation" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Occupation"></asp:RequiredFieldValidator>

                                  <telerik:RadComboBox ID="dlProfession" runat="server" Width="100%" DataSourceID="professionSource" DataTextField="Profession" DataValueField="Profession" Filter="Contains" MarkFirstMatch="True" Text="Select Profession" Visible="false"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="professionSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Profession FROM [Profession]"></asp:SqlDataSource>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dlProfession" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Profession"></asp:RequiredFieldValidator>

                                  <telerik:RadComboBox ID="dlDepartment" runat="server" Width="100%" DataSourceID="deptSource" DataTextField="DeptName" DataValueField="DeptName" Filter="Contains" MarkFirstMatch="True" Text="Select Department" Visible="false"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="deptSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DeptName FROM [Department]"></asp:SqlDataSource>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="dlDepartment" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Department"></asp:RequiredFieldValidator> 

                                 <telerik:RadDropDownList ID="dlBaptism" runat="server" Width="100%" Visible="false" >
                             <Items>
                                 <telerik:DropDownListItem Text="Holy Ghost"/>
                                 <telerik:DropDownListItem Text="Water Baptism" />
                                 <telerik:DropDownListItem Text="Not Baptized" />
                             </Items>
                         </telerik:RadDropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="dlBaptism" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Baptism"></asp:RequiredFieldValidator> 

                              </div>
                              <div class="col-md-1">

                              </div>
                          </div>
                      </div>

                     <div class="modal-footer">
                    <asp:Button ID="Button1" CssClass="btn btn-primary" runat="server" Text="Generate Report" OnClick="btnReport_Click"/>         
                </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
