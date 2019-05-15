<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="NewItemReceived.aspx.cs" Inherits="GWICApp.Inventory.NewItemReceived" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New Item Received</h5>
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
                        
                          <asp:UpdatePanel runat="server">
                           <ContentTemplate>
                             <div class="form-group">
                                 <div class="row">
                                     <div class="col-md-4">
                                          <label>Date</label>
                                          <telerik:RadDatePicker ID="dpDate" runat="server" DateInput-ReadOnly="true" Width="100%"></telerik:RadDatePicker>
                                          <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                                     </div>
                                     <div class="col-md-4">
                                           <label>Department</label>
                                            <telerik:RadComboBox ID="dlDepartment" runat="server" Width="100%" DataSourceID="departmentSource" DataTextField="DeptName" DataValueField="DeptName" Filter="Contains" MarkFirstMatch="true" Text="Select Department"></telerik:RadComboBox>
                                            <asp:SqlDataSource ID="departmentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT DeptName FROM Department"></asp:SqlDataSource>  
                                            <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlDepartment" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                                       </div>
                                     <div class="col-md-4">
                                           <label>Item</label>
                                            <telerik:RadComboBox ID="dlItem" runat="server" Width="100%" DataSourceID="itemSource" DataTextField="Description" DataValueField="ItemId" Filter="Contains" MarkFirstMatch="true" Text="Select Item"></telerik:RadComboBox>
                                            <asp:SqlDataSource ID="itemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT ItemId,Description FROM Items"></asp:SqlDataSource>  
                                            <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlItem" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                                       </div>
                                 </div>
                             </div>
                               <div class="form-group">
                                   <div class="row">
                                       <div class="col-md-4">
                                         <label>Quantity</label>
                                         <asp:TextBox runat="server" ID="txtQuantity" Width="100%" TextMode="Number" Text="0"></asp:TextBox>
                                           <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Quantity cannot be less than 1" ControlToValidate="txtQuantity" Type="Integer" MinimumValue="1" MaximumValue="2147483647" Display="Dynamic" SetFocusOnError="true" ForeColor="Red"></asp:RangeValidator>
                                            <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtQuantity" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                                     </div>
                                       <div class="col-md-4">
                                           <label>Supplier</label>
                                            <telerik:RadComboBox ID="dlSupplier" runat="server" Width="100%" DataSourceID="supplierSource" DataTextField="SupplierName" DataValueField="SupplierName" Filter="Contains" MarkFirstMatch="true" Text="Select Supplier"></telerik:RadComboBox>
                                            <asp:SqlDataSource ID="supplierSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT SupplierName FROM Suppliers"></asp:SqlDataSource>  
                                            <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlSupplier" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                                       </div>
                                       <div class="col-md-4">
                                           <label>Receiver</label>
                                           <asp:TextBox runat="server" ID="txtReceiver" Width="100%"></asp:TextBox>
                                       </div>
                                   </div>
                               </div>
                               <div class="form-group">
                                   <div class="row">
                                       <div class="col-md-12">
                                           <label>Remarks</label>
                                           <asp:TextBox runat="server" ID="txtRemarks" Width="100%"></asp:TextBox>
                                       </div>
                                   </div>
                               </div>
                               <div class="modal-footer">
                                   <asp:Button runat="server" Text="Return" CausesValidation="false" CssClass="btn btn-warning" PostBackUrl="~/Inventory/ItemsReceived.aspx" style="margin-bottom:0px" />
                                   <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                               </div>
                           </ContentTemplate>
                       </asp:UpdatePanel>   
                    </div>
                </div>
        </div>
</asp:Content>
