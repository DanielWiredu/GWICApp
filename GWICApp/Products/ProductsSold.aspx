<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ProductsSold.aspx.cs" Inherits="GWICApp.Products.ProductsSold" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5> Sales</h5>
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
                       
                        <div runat="server" id="lblInvoiceDetails" class="alert alert-info" hidden="hidden"></div>

                          <asp:UpdatePanel runat="server">
                           <ContentTemplate>
                                <div class="row">
                                        <div class="col-sm-4 pull-right" style="width:inherit">
                                           <asp:Button runat="server" ID="btnExcelExport" CssClass="btn btn-primary" Text="Excel" CausesValidation="false" OnClick="btnExcelExport_Click"/>
                                            <asp:Button runat="server" ID="btnPDFExport" CssClass="btn btn-warning" Text="PDF" CausesValidation="false" OnClick="btnPDFExport_Click"/>
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddProduct" CssClass="btn btn-success" Text="Add Sale" CausesValidation="false" OnClientClick="newModal()" />
                                            </div>
                                        </div>
                                    </div>

                               <telerik:RadGrid ID="pdtSoldGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="pdtSoldSource" GroupPanelPosition="Top" OnItemCommand="pdtSoldGrid_ItemCommand" OnDeleteCommand="pdtSoldGrid_DeleteCommand">
                                   <ClientSettings>
                                       <Selecting AllowRowSelect="True" />
                                       <Scrolling AllowScroll="true" ScrollHeight="400px" UseStaticHeaders="True" />
                                   </ClientSettings>
                                   <GroupingSettings CaseSensitive="false" />
                                   <ExportSettings IgnorePaging="true" ExportOnlyData="true" OpenInNewWindow="true" FileName="product_sales" HideStructureColumns="true" >
                                        <Pdf AllowPrinting="true" AllowCopy="true" PaperSize="Letter" PageTitle="Product Sales" PageWidth="850"></Pdf>
                                    </ExportSettings>
                                   <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="pdtSoldSource" CommandItemDisplay="None">
                                       <CommandItemSettings ShowExportToExcelButton="true" ShowExportToPdfButton="true" ShowAddNewRecordButton="false" />
                                       <Columns>
                                           <telerik:GridBoundColumn DataField="id" DataType="System.Int32" SortExpression="id" UniqueName="id" Display="false">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridDateTimeColumn DataField="SalesDate" DataType="System.DateTime" FilterControlAltText="Filter SalesDate column" HeaderText="SalesDate" SortExpression="SalesDate" UniqueName="SalesDate" AutoPostBackOnFilter="true" ShowFilterIcon="true" FilterControlWidth="120px" DataFormatString="{0:dd-MMM-yyyy}">
                                           <HeaderStyle Width="150px" />
                                           </telerik:GridDateTimeColumn>
                                           <telerik:GridBoundColumn Display="false" DataField="ProductId" FilterControlAltText="Filter ProductId column"  SortExpression="ProductId" UniqueName="ProductId">
                                           </telerik:GridBoundColumn>
                                           <telerik:GridBoundColumn DataField="Description" FilterControlAltText="Filter Description column" HeaderText="Product Description" SortExpression="Description" UniqueName="Description" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="200px">
                                           <HeaderStyle Width="300px" />
                                           </telerik:GridBoundColumn>
                                           <telerik:GridNumericColumn DataField="UnitPrice" DataType="System.Double" FilterControlAltText="Filter UnitPrice column" HeaderText="UnitPrice" SortExpression="UnitPrice" UniqueName="UnitPrice" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px" DataFormatString="{0:N02}">
                                           <HeaderStyle Width="80px" />
                                           </telerik:GridNumericColumn>
                                           <telerik:GridNumericColumn DataField="Quantity" FilterControlAltText="Filter Quantity column" HeaderText="Quantity" SortExpression="Quantity" UniqueName="Quantity" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="60px">
                                           <HeaderStyle Width="80px" />
                                           </telerik:GridNumericColumn>
                                           <telerik:GridNumericColumn DataField="Amount" DataType="System.Double" FilterControlAltText="Filter Amount column" HeaderText="Amount" SortExpression="Amount" UniqueName="Amount" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" DataFormatString="{0:N02}">
                                           <HeaderStyle Width="100px" />
                                           </telerik:GridNumericColumn>
                                           <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit" UniqueName="Edit" Exportable="false">
                                            <HeaderStyle Width="50px" />
                                            </telerik:GridButtonColumn>
                                            <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger" Exportable="false">
                                            <HeaderStyle Width="50px" />
                                            </telerik:GridButtonColumn>
                                       </Columns>
                                   </MasterTableView>
                               </telerik:RadGrid>
                                <asp:SqlDataSource ID="pdtSoldSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vwProductsSold]"></asp:SqlDataSource>
                           </ContentTemplate>
                              <Triggers>
                                  <asp:PostBackTrigger ControlID="btnExcelExport" />
                                  <asp:PostBackTrigger ControlID="btnPDFExport" />
                              </Triggers>
                       </asp:UpdatePanel>   
                    </div>
                </div>
        </div>

    <!-- new invoice modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Add Product </h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Date</label>
                                <telerik:RadDatePicker runat="server" ID="dpDate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                           <label>Product</label>
                                            <telerik:RadComboBox ID="dlProduct" runat="server" Width="100%" DataSourceID="productSource" DataTextField="Description" DataValueField="ProductId" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" Text="Select Product" OnTextChanged="dlProduct_TextChanged" AutoPostBack="true" MaxHeight="400px" CausesValidation="false"></telerik:RadComboBox>
                                            <asp:SqlDataSource ID="productSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"  SelectCommand="SELECT ProductId,Description FROM Products"></asp:SqlDataSource>  
                                            <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlProduct" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new" ></asp:RequiredFieldValidator>
                                       </div>
                            <div class="form-group">
                                <label>Quantity Remaining</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtQtyRem" Width="100%" ShowSpinButtons="true" Height="24px" NumberFormat-DecimalDigits="0" Enabled="false"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtQtyRem" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Unit Price</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtUnitPrice" Width="100%" MinValue="0" ShowSpinButtons="true" Height="24px" Enabled="false"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUnitPrice" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Quantity</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtQuantity" Width="100%" MinValue="1" NumberFormat-DecimalDigits="0" ShowSpinButtons="true" Height="24px" AutoPostBack="true" OnTextChanged="txtQuantity_TextChanged" CausesValidation="true" Enabled="false"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtQuantity" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Amount</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtAmount" Width="100%" MinValue="0" Value="0" ShowSpinButtons="true" Height="24px" Enabled="false"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtAmount" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" ValidationGroup="new" OnClick="btnSave_Click" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
         </div>

    <!-- edit invoice modal -->
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
                                <label>Date</label>
                                <telerik:RadDatePicker runat="server" ID="dpDate1" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                           <label>Product</label>
                                            <telerik:RadComboBox ID="dlProduct1" runat="server" Width="100%" DataSourceID="productSource" DataTextField="Description" DataValueField="ProductId" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" Text="Select Product" MaxHeight="400px" Enabled="false"></telerik:RadComboBox>
                                            <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dlProduct1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit" ></asp:RequiredFieldValidator>
                                       </div>
                            <div class="form-group">
                                <label>Quantity Remaining</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtQtyRem1" Width="100%" ShowSpinButtons="true" Height="24px" NumberFormat-DecimalDigits="0" Enabled="false"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtQtyRem1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Unit Price</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtUnitPrice1" Width="100%" MinValue="0" ShowSpinButtons="true" Height="24px" Enabled="false"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtUnitPrice1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Quantity</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtQuantity1" Width="100%" MinValue="1" NumberFormat-DecimalDigits="0" ShowSpinButtons="true" Height="24px" AutoPostBack="true" OnTextChanged="txtQuantity1_TextChanged" CausesValidation="true"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtQuantity1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Amount</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtAmount1" Width="100%" MinValue="0" Value="0" ShowSpinButtons="true" Height="24px" Enabled="false"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtAmount1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
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
