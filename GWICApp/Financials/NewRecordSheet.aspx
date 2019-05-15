<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="NewRecordSheet.aspx.cs" Inherits="GWICApp.Financials.NewRecordSheet" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New Record Sheet</h5>
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
                                       <telerik:RadDatePicker runat="server" ID="dpDate" Width="100%"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                  </div>
                                <div class="col-md-4">
                                       <label> Speaker</label>
                                    <asp:TextBox runat="server" ID="txtSpeaker" Width="100%"></asp:TextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Theme</label>
                                    <asp:TextBox runat="server" ID="txtTheme" Width="100%"></asp:TextBox>
                                  </div>
                            </div>
                        </div>
                        <div class="bg-primary">
                            Attendance
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                       <label> Adults</label>
                                    <asp:TextBox runat="server" ID="txtAdults" Width="100%" TextMode="Number"></asp:TextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Children</label>
                                    <asp:TextBox runat="server" ID="txtChildren" Width="100%" TextMode="Number"></asp:TextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Cars</label>
                                    <asp:TextBox runat="server" ID="txtCars" Width="100%" TextMode="Number"></asp:TextBox>
                                  </div>
                            </div>
                        </div>
                        <div class="bg-primary">Seeds and Offerings</div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                       <label> Altar Seed</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtAltar" Width="100%" Value="0" MinValue="0" AutoPostBack="true" OnTextChanged="txtAltar_TextChanged" ></telerik:RadNumericTextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Prophetic Seed</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtProphetic" Width="100%" Value="0" MinValue="0" AutoPostBack="true" OnTextChanged="txtProphetic_TextChanged" ></telerik:RadNumericTextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> 1st Offering </label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtFirst" Width="100%" Value="0" MinValue="0" AutoPostBack="true" OnTextChanged="txtFirst_TextChanged" ></telerik:RadNumericTextBox>
                                  </div>
                              
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                  <div class="col-md-4">
                                       <label> 2nd Offering</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtSecond" Width="100%" Value="0" MinValue="0" AutoPostBack="true" OnTextChanged="txtSecond_TextChanged" ></telerik:RadNumericTextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Tithe</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtTithe" Width="100%" Value="0" MinValue="0" AutoPostBack="true" OnTextChanged="txtTithe_TextChanged" ></telerik:RadNumericTextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label>Thanksgiving</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtThanksgiving" Width="100%" Value="0" MinValue="0" AutoPostBack="true" OnTextChanged="txtThanksgiving_TextChanged"></telerik:RadNumericTextBox>
                                  </div>
                              
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                  <div class="col-md-4">
                                       <label> Pledge</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtPledge" Width="100%" Value="0" MinValue="0" AutoPostBack="true" OnTextChanged="txtPledge_TextChanged" ></telerik:RadNumericTextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Project Offering</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtProject" Width="100%" Value="0" MinValue="0" AutoPostBack="true" OnTextChanged="txtProject_TextChanged" ></telerik:RadNumericTextBox>
                                  </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4">
                                       <label> Cash</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtCash" Width="100%" Value="0" MinValue="0" Font-Size="Large" ></telerik:RadNumericTextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Cheque</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtCheque" Width="100%" Value="0" MinValue="0" Font-Size="Large" ></telerik:RadNumericTextBox>
                                  </div>
                                <div class="col-md-4">
                                       <label> Grand Total</label>
                                    <telerik:RadNumericTextBox runat="server" ID="txtGrandTotal" Width="100%" Value="0" MinValue="0" Enabled="false" ForeColor="Red" Font-Size="Large"></telerik:RadNumericTextBox>
                                  </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button runat="server" Text="Return" CssClass="btn btn-warning" PostBackUrl="~/Financials/RecordSheet.aspx" CausesValidation="false" />
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSave_Click" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
