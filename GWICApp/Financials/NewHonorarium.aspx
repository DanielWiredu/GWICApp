<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="NewHonorarium.aspx.cs" Inherits="GWICApp.Financials.NewHonorarium" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New Payment</h5>
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
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                    <label>Payment Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpPaydate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpPaydate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                 </div>
                                  <div class="col-md-4">
                                    <label>Name of Guest</label>
                                    <asp:TextBox runat="server" ID="txtGuestName" Width="100%"></asp:TextBox>
                                  </div>
                                 <div class="col-md-4">
                                    <label>Purpose/Programme</label>
                                    <asp:TextBox runat="server" ID="txtProgramme" Width="100%"></asp:TextBox>
                                  </div>
                            </div>
                        </div>
                         <div class="form-group">
                            <div class="row">
                                 <div class="col-md-6">
                                    <label>Guest's Location </label>
                                    <asp:TextBox runat="server" ID="txtLocation" Width="100%"></asp:TextBox>
                                  </div>
                                 <div class="col-md-6">
                                    <label>Remarks</label>
                                    <asp:TextBox runat="server" ID="txtRemarks" Width="100%"></asp:TextBox>
                                  </div>
                            </div>
                        </div>
                        <div class="bg-primary">Honorarium</div>
                        <div class="form-group">
                            <div class="row">
                               <%-- <div class="col-md-4">
                                    <label>Amount</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txt_hrBaseAmt" Width="100%" MinValue="0" Value="0" ></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txt_hrBaseAmt" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </div>--%>
                                <div class="col-md-4">
                                    <label>Currency</label>
                                    <telerik:RadDropDownList ID="dl_hrBaseCur" runat="server" Width="100%" DataSourceID="currencySource" DataTextField="cur_code" DataValueField="cur_rate" DefaultMessage="Select Currency"></telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dl_hrBaseCur" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                    <asp:SqlDataSource ID="currencySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [cur_code], [cur_rate] FROM [Currencies]"></asp:SqlDataSource>
                                </div>
                                <div class="col-md-4">
                                    <label>Amount</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txt_hrAmount" Width="100%" MinValue="0" Value="0" ></telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                         <div class="bg-primary">Cost of Lodging</div>
                        <div class="form-group">
                            <div class="row">
                                <%--<div class="col-md-4">
                                    <label>Amount</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txt_lgBaseAmt" Width="100%" MinValue="0" Value="0" ></telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txt_lgBaseAmt" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </div>--%>
                                <div class="col-md-4">
                                    <label>Currency</label>
                                    <telerik:RadDropDownList ID="dl_lgBaseCur" runat="server" Width="100%" DataSourceID="currencySource" DataTextField="cur_code" DataValueField="cur_rate" DefaultMessage="Select Currency"></telerik:RadDropDownList>
                                    <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dl_lgBaseCur" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-4">
                                    <label>Amount </label>
                                    <telerik:RadNumericTextBox runat="server" ID="txt_lgAmount" Width="100%" MinValue="0" Value="0" ></telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                       <div class="modal-footer">
                           <asp:Button runat="server" Text="Return" CssClass="btn btn-warning" CausesValidation="false" PostBackUrl="~/Financials/Honorarium.aspx" style="margin-bottom:0px"  />
                           <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                       </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
