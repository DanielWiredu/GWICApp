<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="NewAttendance.aspx.cs" Inherits="GWICApp.Main.NewAttendance" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New Attendance</h5>
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
                        <div class="bg-primary">Details</div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                       <label> Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpDate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                  </div>
                                <div class="col-md-4">
                                    <label>Service</label>
                                    <telerik:RadDropDownList ID="dlService" runat="server" Width="100%" DataSourceID="serviceSource" DataTextField="ServiceName" DataValueField="ServiceName" DefaultMessage="Select Service"></telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlService" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="serviceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ServiceName] FROM [Services]"></asp:SqlDataSource>
                                </div>
                                <div class="col-md-4">
                                       <label> Speaker</label>
                                    <asp:TextBox runat="server" ID="txtSpeaker" Width="100%"></asp:TextBox>
                                  </div>
                              
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                       <label> Adults</label>
                                    <asp:TextBox runat="server" ID="txtAdults" Width="100%" TextMode="Number" Text="0"></asp:TextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Children</label>
                                    <asp:TextBox runat="server" ID="txtChildren" Width="100%" TextMode="Number" Text="0"></asp:TextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Cars</label>
                                    <asp:TextBox runat="server" ID="txtCars" Width="100%" TextMode="Number" Text="0"></asp:TextBox>
                                  </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                  <div class="col-md-6">
                                       <label> Theme</label>
                                    <asp:TextBox runat="server" ID="txtTheme" Width="100%"></asp:TextBox>
                                  </div>
                                  <div class="col-md-6">
                                       <label> Remarks</label>
                                    <asp:TextBox runat="server" ID="txtRemarks" Width="100%"></asp:TextBox>
                                  </div>
                            </div>
                        </div>
                       <%--<div class="hr-line-dashed"></div>
                        <div class="col-md-4 col-md-offset-8">
                            <asp:Button runat="server" Text="New Save" CssClass="btn btn-primary" />
                             <asp:Button runat="server" Text="New Save" CssClass="btn btn-primary" />
                        <asp:Button runat="server" Text="New Return" CssClass="btn btn-warning" />
                        </div>--%>
                       

                        <div class="modal-footer">
                            <asp:Button runat="server" Text="Return" CssClass="btn btn-warning" PostBackUrl="~/Main/Attendance.aspx" CausesValidation="false" style="margin-bottom:0px" />
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
