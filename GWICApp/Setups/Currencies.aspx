<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Currencies.aspx.cs" Inherits="GWICApp.Setups.Currencies" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Currencies</h5>
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
                                                <asp:Button runat="server" ID="btnAddNew" CssClass="btn btn-success" Text="Add Currency" CausesValidation="false" OnClientClick="newModal()" />  
                                            </div>
                                        </div>
                                    </div>
                        <telerik:RadGrid ID="currencyGrid" runat="server" AutoGenerateColumns="False" DataSourceID="currencySource" GroupPanelPosition="Top" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" OnItemDeleted="currencyGrid_ItemDeleted" OnItemCommand="currencyGrid_ItemCommand">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView DataKeyNames="id" DataSourceID="currencySource" AllowAutomaticDeletes="true" CommandItemDisplay="None" CommandItemSettings-AddNewRecordText="Add New Currency">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="id" FilterControlAltText="Filter id column" HeaderText="ID" SortExpression="id" UniqueName="id" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="80px" Display="false" ReadOnly="true">
                                        <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="cur_code" FilterControlAltText="Filter cur_code column" HeaderText="Code" SortExpression="cur_code" UniqueName="cur_code" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px" MaxLength="10">
                                    <HeaderStyle Width="120px" />
                                         <ColumnValidationSettings EnableRequiredFieldValidation="True">
                                            <RequiredFieldValidator ForeColor="Red" ErrorMessage="Required Field" SetFocusOnError="true" Display="Dynamic"></RequiredFieldValidator>
                                        </ColumnValidationSettings>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="cur_name" FilterControlAltText="Filter cur_name column" HeaderText="Currency Name" SortExpression="cur_name" UniqueName="cur_name" FilterControlWidth="150px" AutoPostBackOnFilter="true" ShowFilterIcon="false" MaxLength="50" EmptyDataText="">
                                    <HeaderStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridNumericColumn DataField="cur_rate" FilterControlAltText="Filter cur_rate column" HeaderText="Rate" SortExpression="cur_rate" UniqueName="cur_rate" FilterControlWidth="100px" AutoPostBackOnFilter="true" ShowFilterIcon="false" EmptyDataText="0.0" DataFormatString="{0:0.00}" ShowSpinButtons="true" MinValue="0">
                                    <HeaderStyle Width="120px" />
                                    </telerik:GridNumericColumn>
                                    <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit">
                                        <HeaderStyle Width="40px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Record?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="currencySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Currencies] ORDER BY [id]" DeleteCommand="DELETE FROM Currencies WHERE (id = @id)" InsertCommand="INSERT INTO Currencies(cur_code, cur_name, cur_rate) VALUES (@cur_code, @cur_name, @cur_rate)" UpdateCommand="UPDATE [Currencies] SET [cur_code] = @cur_code, [cur_name] = @cur_name, [cur_rate] = @cur_rate WHERE [id] = @id" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>">
                            <DeleteParameters>
                                <asp:Parameter Name="id" Type="Int32" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:Parameter Name="cur_code" Type="String" />
                                <asp:Parameter Name="cur_name" Type="String" />
                                <asp:Parameter Name="cur_rate" Type="Single" />
                            </InsertParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="cur_code" Type="String" />
                                <asp:Parameter Name="cur_name" Type="String" />
                                <asp:Parameter Name="cur_rate" Type="Single" />
                                <asp:Parameter Name="id" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>


    
     <!-- new currency modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Currency</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                  <label>Code</label>
                                  <asp:TextBox runat="server" ID="txtCode" Width="100%" MaxLength="10"></asp:TextBox>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCode" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Name</label>
                                <asp:TextBox runat="server" ID="txtName" Width="100%" MaxLength="50"></asp:TextBox>
                            </div>
                            <div class="form-group">
                               <label>Rate</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtRate" NumberFormat-DecimalDigits="2" MinValue="0" ShowSpinButtons="true" Width="100%" Value="0"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtRate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
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

    <!-- edit currency modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Currency</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                  <label>Code</label>
                                  <asp:TextBox runat="server" ID="txtCode1" Width="100%" MaxLength="10"></asp:TextBox>
                                  <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtCode1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Name</label>
                                <asp:TextBox runat="server" ID="txtName1" Width="100%" MaxLength="50"></asp:TextBox>
                            </div>
                            <div class="form-group">
                               <label>Rate</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtRate1" NumberFormat-DecimalDigits="2" MinValue="0" ShowSpinButtons="true" Width="100%" Value="0"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtRate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
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
