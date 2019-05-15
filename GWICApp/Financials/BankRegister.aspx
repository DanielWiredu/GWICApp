<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="BankRegister.aspx.cs" Inherits="GWICApp.Financials.BankRegister" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Bank Register</h5>
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
                            <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add New" CausesValidation="false" OnClientClick="newModal()"/>  
                                            </div>
                                        </div>
                                    </div>

                        <telerik:RadGrid ID="bankregisterGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="bankregisterSource" GroupPanelPosition="Top" OnItemCommand="bankregisterGrid_ItemCommand" OnItemDeleted="bankregisterGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="bankregisterSource" CommandItemDisplay="None" AllowAutomaticDeletes="true">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridDateTimeColumn DataField="regdate" DataType="System.DateTime" FilterControlAltText="Filter regdate column" HeaderText="Date" SortExpression="regdate" UniqueName="regdate" DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="110px">
                                    <HeaderStyle Width="130px" />
                                    </telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="bank" FilterControlAltText="Filter bank column" HeaderText="Bank" SortExpression="bank" UniqueName="bank" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px">
                                     <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridNumericColumn DataField="cash_deposit" DataType="System.Decimal" FilterControlAltText="Filter cash_deposit column" HeaderText="Cash Deposit (GHC)" SortExpression="cash_deposit" UniqueName="cash_deposit" DataFormatString="{0:0.00}" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px" ShowSpinButtons="true">
                                     <HeaderStyle Width="120px" />
                                    </telerik:GridNumericColumn>
                                    <telerik:GridNumericColumn DataField="cheque_deposit" DataType="System.Decimal" FilterControlAltText="Filter cheque_deposit column" HeaderText="Cheque Deposit (GHC)" SortExpression="cheque_deposit" UniqueName="cheque_deposit" DataFormatString="{0:0.00}" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px" ShowSpinButtons="true">
                                     <HeaderStyle Width="120px" />
                                    </telerik:GridNumericColumn>
                                    <telerik:GridNumericColumn DataField="total_amount" DataType="System.Decimal" FilterControlAltText="Filter total_amount column" HeaderText="Total Amount" SortExpression="total_amount" UniqueName="total_amount" DataFormatString="{0:0.00}" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px" ShowSpinButtons="true">
                                     <HeaderStyle Width="130px" />
                                    </telerik:GridNumericColumn>
                                    <telerik:GridBoundColumn DataField="remarks" FilterControlAltText="Filter remarks column" HeaderText="Remarks" SortExpression="remarks" UniqueName="remarks" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px" EmptyDataText="">
                                     <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="prepared_by" FilterControlAltText="Filter prepared_by column" HeaderText="prepared_by" SortExpression="prepared_by" UniqueName="prepared_by" Display="false" EmptyDataText="">
                                    </telerik:GridBoundColumn>
                                      <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="bankregisterSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [BankRegister] WHERE [id] = @id" InsertCommand="INSERT INTO [BankRegister] ([regdate], [bank], [cash_deposit], [cheque_deposit], [total_amount], [prepared_by], [checked_by]) VALUES (@regdate, @bank, @cash_deposit, @cheque_deposit, @total_amount, @prepared_by, @checked_by)" SelectCommand="SELECT [id], [regdate], [bank], [cash_deposit], [cheque_deposit], [total_amount], [remarks], [prepared_by], [checked_by] FROM [BankRegister]" UpdateCommand="UPDATE [BankRegister] SET [regdate] = @regdate, [bank] = @bank, [cash_deposit] = @cash_deposit, [cheque_deposit] = @cheque_deposit, [total_amount] = @total_amount, [prepared_by] = @prepared_by, [checked_by] = @checked_by WHERE [id] = @id">
                            <DeleteParameters>
                                <asp:Parameter Name="id" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

    <!-- new bankRegister modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:70%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Bank Register</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                                <label> Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpDate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                                        </div>
                                         <div class="col-md-4">
                                        <label>Bank</label>
                                           <telerik:RadComboBox ID="dlBank" runat="server" Width="100%" DataSourceID="bankSource" DataTextField="Bankname" DataValueField="Bankname" Filter="Contains" MarkFirstMatch="True" Text="Select Bank"></telerik:RadComboBox>
                                            <asp:SqlDataSource ID="bankSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Bankname FROM [Banks]"></asp:SqlDataSource> 
                                    </div>
                                    <div class="col-md-4">
                                        <label>Prepared By</label>
                                        <asp:TextBox runat="server" ID="txtPreparedBy" Width="100%" Enabled="false"></asp:TextBox>
                                    </div>
                                
                                    </div>
                             </div>
                            <div class="form-group">
                                <div class="row">
                                     <div class="col-md-4">
                               <label>Cash Deposit [GHC]</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtCash" NumberFormat-DecimalDigits="2" MinValue="0" ShowSpinButtons="true" Width="100%" Value="0" OnTextChanged="txtCash_TextChanged" AutoPostBack="true"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCash" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                                 <div class="col-md-4">
                               <label>Cheque Deposit [GHC]</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtCheque" NumberFormat-DecimalDigits="2" MinValue="0" ShowSpinButtons="true" Width="100%" Value="0" OnTextChanged="txtCheque_TextChanged" AutoPostBack="true"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCheque" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                             <div class="col-md-4">
                               <label>Total Amount</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtTotal" NumberFormat-DecimalDigits="2" MinValue="0" ShowSpinButtons="true" Width="100%" Value="0" ReadOnly="true"></telerik:RadNumericTextBox>
                            </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Remarks</label>
                                <asp:TextBox runat="server" ID="txtRemarks" Width="100%"></asp:TextBox>
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

     <!-- edit bankRegister modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:70%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Bank Register</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-4">
                                                <label> Date</label>
                                       <telerik:RadDatePicker runat="server" ID="dpDate1" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                                        </div>
                                         <div class="col-md-4">
                                        <label>Bank</label>
                                           <telerik:RadComboBox ID="dlBank1" runat="server" Width="100%" DataSourceID="bankSource" DataTextField="Bankname" DataValueField="Bankname" Filter="Contains" MarkFirstMatch="True" Text="Select Bank"></telerik:RadComboBox>
                                    </div>
                                    <div class="col-md-4">
                                        <label>Prepared By</label>
                                        <asp:TextBox runat="server" ID="txtPreparedBy1" Width="100%" Enabled="false"></asp:TextBox>
                                    </div>
                                
                                    </div>
                             </div>
                            <div class="form-group">
                                <div class="row">
                                     <div class="col-md-4">
                               <label>Cash Deposit [GHC]</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtCash1" NumberFormat-DecimalDigits="2" MinValue="0" ShowSpinButtons="true" Width="100%" Value="0" OnTextChanged="txtCash1_TextChanged" AutoPostBack="true"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCash1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                                 <div class="col-md-4">
                               <label>Cheque Deposit [GHC]</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtCheque1" NumberFormat-DecimalDigits="2" MinValue="0" ShowSpinButtons="true" Width="100%" Value="0" OnTextChanged="txtCheque1_TextChanged" AutoPostBack="true"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCheque1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                             <div class="col-md-4">
                               <label>Total Amount</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtTotal1" NumberFormat-DecimalDigits="2" MinValue="0" ShowSpinButtons="true" Width="100%" Value="0" ReadOnly="true"></telerik:RadNumericTextBox>
                            </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Remarks</label>
                                <asp:TextBox runat="server" ID="txtRemarks1" Width="100%"></asp:TextBox>
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
