<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="ProjectPayments.aspx.cs" Inherits="GWICApp.Financials.ProjectPayments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Project Payments</h5>
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
                      <div class="col-md-3">
                         <label>Payer ID</label>
                         <asp:TextBox ID="txtPayerID" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                     <div class="col-md-4">
                         <label>Name</label>
                         <asp:TextBox ID="txtFullname" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                     <div class="col-md-2">
                         <label>Telephone</label>
                         <asp:TextBox ID="txtTelephone" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                    <div class="col-md-3">
                         <label>Total [GHC]</label>
                        <asp:TextBox ID="txtTotalAmt" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                 </div>
             </div>
                        <div class="row">
                                        <div class="col-sm-4 pull-right">
                                           
                                        </div>
                                        <div class="col-sm-8 pull-left">
                                            <div class="toolbar-btn-action">
                                                <asp:Button ID="btnNewPayment" runat="server" Text="Add Payment" CssClass="btn btn-success" OnClientClick="newModal()"/>
                                                <asp:LinkButton ID="btnReturn" runat="server" Text="Back" CssClass="btn btn-warning"></asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>

                        <telerik:RadGrid ID="paymentGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="paymentSource" GroupPanelPosition="Top" OnItemCommand="paymentGrid_ItemCommand" OnItemDeleted="paymentGrid_ItemDeleted">
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                            </ClientSettings>
                            <MasterTableView AllowAutomaticDeletes="True" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="paymentSource" CommandItemDisplay="Top" PageSize="12">
                                <CommandItemSettings ShowAddNewRecordButton="false" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id" Display="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridDateTimeColumn DataField="paydate" DataType="System.DateTime" FilterControlAltText="Filter paydate column" HeaderText="Date" SortExpression="paydate" UniqueName="paydate" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px" DataFormatString="{0:dd-MMM-yyyy}">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridDateTimeColumn>
                                    <telerik:GridBoundColumn DataField="paymsg" FilterControlAltText="Filter paymsg column" HeaderText="Description" SortExpression="paymsg" UniqueName="paymsg" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="180px">
                                    <HeaderStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="payamt" DataType="System.Decimal" FilterControlAltText="Filter payamt column" HeaderText="Amount" SortExpression="payamt" UniqueName="payamt" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px" DataFormatString="{0:N02}">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="signedby" FilterControlAltText="Filter signedby column" HeaderText="Sign" SortExpression="signedby" UniqueName="signedby" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px">
                                    <HeaderStyle Width="150px" />
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
                        <asp:SqlDataSource ID="paymentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [ProjectPayments] WHERE [id] = @id" SelectCommand="SELECT id, paydate, paymsg, payamt, signedby FROM ProjectPayments WHERE (payerid = @payerid) ORDER BY paydate DESC">
                            <DeleteParameters>
                                <asp:Parameter Name="id" Type="Int32" />
                            </DeleteParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtPayerID" DefaultValue=" " Name="payerid" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>


      <!-- new modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New Payment</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                   <label>Payment Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpPaydate" Width="100%"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpPaydate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Payment For</label>
                                 <telerik:RadComboBox ID="dlProject" runat="server" Width="100%" DataSourceID="projectSource" DataTextField="ProjectName" DataValueField="ProjectName" Filter="Contains" MarkFirstMatch="True" Text="Select Project"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="projectSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ProjectName FROM [Projects]"></asp:SqlDataSource>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="dlProject" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Project" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                              <div class="form-group">
                               <label>Amount [GHC]</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtAmount" MinValue="0" Width="100%" Value="0" ShowSpinButtons="true"></telerik:RadNumericTextBox>
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

    <!-- edit modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Payment</h4>
                </div>
                     <div class="modal-body">
                             <div class="form-group">
                                   <label>Payment Date</label>
                                    <telerik:RadDatePicker runat="server" ID="dpPaydate1" Width="100%"></telerik:RadDatePicker>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpPaydate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                <label>Payment For</label>
                                 <telerik:RadComboBox ID="dlProject1" runat="server" Width="100%" DataSourceID="projectSource" DataTextField="ProjectName" DataValueField="ProjectName" Filter="Contains" MarkFirstMatch="True" Text="Select Project"></telerik:RadComboBox>
                                   <asp:RequiredFieldValidator runat="server" ControlToValidate="dlProject1" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ErrorMessage="Select Project" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                              <div class="form-group">
                               <label>Amount [GHC]</label>
                                <telerik:RadNumericTextBox runat="server" ID="txtAmount1" MinValue="0" Width="100%" Value="0" ShowSpinButtons="true"></telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtAmount1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                       </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" ValidationGroup="edit" OnClick="btnUpdate_Click"/>
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
