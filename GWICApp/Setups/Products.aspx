<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="GWICApp.Setups.Products" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Products</h5>
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
                                                <asp:Button runat="server" ID="btnAddProduct" CssClass="btn btn-success" Text="Add Product" CausesValidation="false" OnClientClick="newModal()" />  
                                            </div>
                                        </div>
                                    </div>

                               <telerik:RadGrid ID="productGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="productSource" GroupPanelPosition="Top" OnItemCommand="productGrid_ItemCommand" OnItemDeleted="productGrid_ItemDeleted">
                                   <ClientSettings>
                                       <Selecting AllowRowSelect="True" />
                                       <Scrolling AllowScroll="true" ScrollHeight="400px" />
                                   </ClientSettings>
                                   <GroupingSettings CaseSensitive="false" />
                                   <MasterTableView AutoGenerateColumns="False" DataKeyNames="ProductId" DataSourceID="productSource" AllowAutomaticDeletes="true">
                                       <Columns>
                                           <telerik:GridBoundColumn DataField="ProductId" FilterControlAltText="Filter ProductId column" HeaderText="ID" SortExpression="ProductId" UniqueName="ProductId" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="50px">
                                           <HeaderStyle Width="70px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Description" SortExpression="Description" UniqueName="Description" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="200px">
                                           <HeaderStyle Width="250px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="UnitOfIssue" FilterControlAltText="Filter UnitOfIssue column" HeaderText="Unit" SortExpression="UnitOfIssue" UniqueName="UnitOfIssue" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                           <HeaderStyle Width="80px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridNumericColumn DataField="UnitPrice" FilterControlAltText="Filter UnitPrice column" HeaderText="Unit Price" SortExpression="UnitPrice" UniqueName="UnitPrice" EmptyDataText="0" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" DataFormatString="{0:N02}">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridNumericColumn>
                                           <telerik:GridNumericColumn DataField="MinValue" FilterControlAltText="Filter MinValue column" HeaderText="Min. Value" SortExpression="MinValue" UniqueName="MinValue" EmptyDataText="0" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px">
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
                               <asp:SqlDataSource ID="productSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Products]" DeleteCommand="DELETE FROM [Products] WHERE [ProductId] = @ProductId">
                                   <DeleteParameters>
                                       <asp:Parameter Type="Int32" Name="ProductId" />
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
                    <h4 class="modal-title">New Product</h4>
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
                                 <label>Unit Price</label>
                                 <telerik:RadNumericTextBox ID="txtUnitPrice" runat="server" Width="100%" Value="0" MinValue="0" ShowSpinButtons="true"></telerik:RadNumericTextBox>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUnitPrice" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Minimum Value</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtMinValue" Width="100%" MinValue="0" Value="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" Height="24px"></telerik:RadNumericTextBox>
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
                    <h4 class="modal-title">Edit Product</h4>
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
                                 <label>Unit Price</label>
                                 <telerik:RadNumericTextBox ID="txtUnitPrice1" runat="server" Width="100%" Value="0" MinValue="0" ShowSpinButtons="true"></telerik:RadNumericTextBox>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUnitPrice1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                         <div class="form-group">
                                <label>Minimum Value</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtMinValue1" Width="100%" MinValue="0" Value="0" ShowSpinButtons="true" NumberFormat-DecimalDigits="0" Height="24px"></telerik:RadNumericTextBox>
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
