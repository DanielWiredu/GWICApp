﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Items.aspx.cs" Inherits="GWICApp.Setups.Items" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Items</h5>
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
                               <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddItem" CssClass="btn btn-success" Text="Add Item" CausesValidation="false" OnClientClick="newModal()" />  
                                            </div>
                                        </div>
                                    </div>

                               <telerik:RadGrid ID="itemGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="itemSource" GroupPanelPosition="Top" OnItemCommand="itemGrid_ItemCommand" OnItemDeleted="itemGrid_ItemDeleted">
                                   <ClientSettings>
                                       <Selecting AllowRowSelect="True" />
                                       <Scrolling AllowScroll="true" ScrollHeight="400px" />
                                   </ClientSettings>
                                   <GroupingSettings CaseSensitive="false" />
                                   <MasterTableView AutoGenerateColumns="False" DataKeyNames="ItemId" DataSourceID="itemSource" AllowAutomaticDeletes="true">
                                       <Columns>
                                           <telerik:GridBoundColumn DataField="ItemId" FilterControlAltText="Filter ItemId column" HeaderText="ID" SortExpression="ItemId" UniqueName="ItemId" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="50px">
                                           <HeaderStyle Width="70px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="200px">
                                           <HeaderStyle Width="250px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="UnitOfIssue" FilterControlAltText="Filter UnitOfIssue column" HeaderText="Unit" SortExpression="UnitOfIssue" UniqueName="UnitOfIssue" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                           <HeaderStyle Width="80px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridNumericColumn DataField="MinValue" FilterControlAltText="Filter MinValue column" HeaderText="Min. Value" SortExpression="MinValue" UniqueName="MinValue" EmptyDataText="0" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridNumericColumn>
                                           <telerik:GridNumericColumn Visible="false" DataField="MaxValue" FilterControlAltText="Filter MaxValue column" HeaderText="Max. Value" SortExpression="MaxValue" UniqueName="MaxValue" EmptyDataText="0" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridNumericColumn>
                                           <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit">
                                            <HeaderStyle Width="40px" />
                                            </telerik:GridButtonColumn>
                                            <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                            <HeaderStyle Width="50px" />
                                            </telerik:GridButtonColumn>
                                       </Columns>
                                   </MasterTableView>
                               </telerik:RadGrid>
                               <asp:SqlDataSource ID="itemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Items]" DeleteCommand="DELETE FROM [Items] WHERE [ItemId] = @ItemId">
                                   <DeleteParameters>
                                       <asp:Parameter Type="Int32" Name="ItemId" />
                                   </DeleteParameters>
                               </asp:SqlDataSource>
                           </ContentTemplate>
                       </asp:UpdatePanel>   
                    </div>
                </div>
        </div>

     <!-- new item modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Item</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>Description</label>
                                       <asp:TextBox runat="server" ID="txtDescription" Width="100%" MaxLength="100"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtDescription" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Unit</label>
                                <telerik:RadDropDownList ID="dlUnit" runat="server" Width="100%" DataSourceID="unitSource" DataTextField="UnitCode" DataValueField="UnitCode" DefaultMessage="Select Unit"></telerik:RadDropDownList>
                                <asp:SqlDataSource ID="unitSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT UnitCode FROM Units"></asp:SqlDataSource>  
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlUnit" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Minimum Value</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtMinValue" Width="100%" MinValue="0" Value="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" Height="24px"></telerik:RadNumericTextBox>
                            </div>
                            <div class="form-group" hidden="hidden">
                                <label>Maximum Value</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtMaxValue" Width="100%" MinValue="0" Value="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" Height="24px"></telerik:RadNumericTextBox>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="new" OnClick="btnSave_Click"/>
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <!-- edit item modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Item</h4>
                </div>
                     <div class="modal-body">
                             <div class="form-group">
                                        <label>Description</label>
                                       <asp:TextBox runat="server" ID="txtDescription1" Width="100%" MaxLength="100"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtDescription1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                        <label>Unit</label>
                                        <telerik:RadDropDownList ID="dlUnit1" runat="server" Width="100%" DataSourceID="unitSource" DataTextField="UnitCode" DataValueField="UnitCode" DefaultMessage="Select Unit"></telerik:RadDropDownList>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlUnit1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                         <div class="form-group">
                                <label>Minimum Value</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtMinValue1" Width="100%" MinValue="0" Value="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" Height="24px"></telerik:RadNumericTextBox>
                            </div>
                            <div class="form-group" hidden="hidden">
                                <label>Maximum Value</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtMaxValue1" Width="100%" MinValue="0" Value="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" Height="24px"></telerik:RadNumericTextBox>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="edit" OnClick="btnUpdate_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

        <script type="text/javascript">
            function newModal() {
                $('#newmodal').modal('show');
                $('#newmodal').appendTo($("form:first"));
            }
            function closenewModal() {
                $('#newmodal').modal('hide');
            }
            function editModal() {
                $('#editmodal').modal('show');
                $('#editmodal').appendTo($("form:first"));
            }
            function closeeditModal() {
                $('#editmodal').modal('hide');
            }
    </script>
</asp:Content>
