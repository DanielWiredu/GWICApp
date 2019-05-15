<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="GWICApp.Main.Events" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Events</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                             <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                <i class="fa fa-wrench"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                
                            </ul>
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
                                                <asp:Button runat="server" Text="Add Event" CssClass="btn btn-success" OnClientClick="newModal()"/>
                                            </div>
                                        </div>
                                    </div>
                         <telerik:RadGrid ID="eventsGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" DataSourceID="eventSource" GroupPanelPosition="Top" OnItemCommand="eventsGrid_ItemCommand" OnItemDeleted="eventsGrid_ItemDeleted">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                             <MasterTableView AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="eventSource" AllowAutomaticDeletes="true">
                                 <Columns>
                                     <telerik:GridBoundColumn Display="false" DataField="id" DataType="System.Int32" FilterControlAltText="Filter id column" HeaderText="id" ReadOnly="True" SortExpression="id" UniqueName="id">
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="EventName" FilterControlAltText="Filter EventName column" HeaderText="Event Name" SortExpression="EventName" UniqueName="EventName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="160px">
                                     <HeaderStyle Width="250px" />
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="DateFrom" DataType="System.DateTime" FilterControlAltText="Filter DateFrom column" HeaderText="Start Date" SortExpression="DateFrom" UniqueName="DateFrom" AutoPostBackOnFilter="true" DataFormatString="{0:dd-MMM-yyyy}" FilterControlWidth="100px">
                                     <HeaderStyle Width="150px" />
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="DateTo" DataType="System.DateTime" FilterControlAltText="Filter DateTo column" HeaderText="End Date" SortExpression="DateTo" UniqueName="DateTo" AutoPostBackOnFilter="true" DataFormatString="{0:dd-MMM-yyyy}" FilterControlWidth="100px">
                                     <HeaderStyle Width="150px" />
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="RemindDate" DataType="System.DateTime" FilterControlAltText="Filter RemindDate column" HeaderText="Remind Date" SortExpression="RemindDate" UniqueName="RemindDate" AutoPostBackOnFilter="true" DataFormatString="{0:dd-MMM-yyyy}" FilterControlWidth="100px">
                                     <HeaderStyle Width="150px" />
                                     </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="Notes" SortExpression="Notes" UniqueName="Notes" Display="false">
                                     </telerik:GridBoundColumn>
                                     <telerik:GridButtonColumn ButtonType="PushButton" CommandName="Edit" ButtonCssClass="btn-info" Text="Edit">
                                        <HeaderStyle Width="50px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" UniqueName="Delete" ConfirmText="Delete Event?" ButtonType="PushButton" ButtonCssClass="btn-danger">
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridButtonColumn>
                                 </Columns>
                             </MasterTableView>
                        </telerik:RadGrid>
                         <asp:SqlDataSource ID="eventSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [id], [EventName], [DateFrom], [DateTo], [RemindDate], [Notes] FROM [Events] ORDER BY [id]" DeleteCommand="DELETE FROM [Events] WHERE [id] = @id">
                             <DeleteParameters>
                                 <asp:Parameter Name="id" Type="Int32" />
                             </DeleteParameters>
                         </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

     <!-- new event modal -->
         <div class="modal fade" id="newmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Add Event </h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Event Name</label>
                                <asp:TextBox runat="server" ID="txtEventName" Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtEventName" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Start Date</label>
                                <telerik:RadDatePicker runat="server" ID="dpStartDate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpStartDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>End Date</label>
                                <telerik:RadDatePicker runat="server" ID="dpEndDate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpEndDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Reminder Date</label>
                                <telerik:RadDatePicker runat="server" ID="dpRemindDate" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpRemindDate" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="new"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Notes</label>
                                <asp:TextBox runat="server" ID="txtNotes" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
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

    <!-- edit event modal -->
         <div class="modal fade" id="editmodal">
    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit Event </h4>
                </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Event Name</label>
                                <asp:TextBox runat="server" ID="txtEventName1" Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="txtEventName1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Start Date</label>
                                <telerik:RadDatePicker runat="server" ID="dpStartDate1" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpStartDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>End Date</label>
                                <telerik:RadDatePicker runat="server" ID="dpEndDate1" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpEndDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Reminder Date</label>
                                <telerik:RadDatePicker runat="server" ID="dpRemindDate1" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                                <asp:RequiredFieldValidator runat="server" ErrorMessage="Required Field" ControlToValidate="dpRemindDate1" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="edit"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                <label>Notes</label>
                                <asp:TextBox runat="server" ID="txtNotes1" Width="100%" TextMode="MultiLine" Rows="3"></asp:TextBox>
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
