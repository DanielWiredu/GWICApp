<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="GWICApp.Setups.Users" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>Users</h5>
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
                                                <asp:Button runat="server" ID="btnAddUser" CssClass="btn btn-success" Text="Add User" CausesValidation="false" OnClientClick="newModal()" />  
                                            </div>
                                        </div>
                                    </div>

                             <telerik:RadGrid ID="usersGrid" runat="server" AutoGenerateColumns="False" DataSourceID="userSource" GroupPanelPosition="Top" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" OnItemCommand="usersGrid_ItemCommand" OnItemDeleted="usersGrid_ItemDeleted" OnItemDataBound="usersGrid_ItemDataBound">
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                                <Selecting AllowRowSelect="true" />
                            </ClientSettings>
                            <GroupingSettings CaseSensitive="false" />
                            <MasterTableView DataKeyNames="UserID" DataSourceID="userSource" AllowAutomaticDeletes="true" CommandItemDisplay="None" CommandItemSettings-AddNewRecordText="Add New User">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="UserID" FilterControlAltText="Filter UserID column" HeaderText="User ID" SortExpression="UserID" UniqueName="UserID" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="100px" MaxLength="20">
                                        <HeaderStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UserName" FilterControlAltText="Filter UserName column" HeaderText="User Name" SortExpression="UserName" UniqueName="UserName" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="240px" MaxLength="50">
                                    <HeaderStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AccessLevel" FilterControlAltText="Filter AccessLevel column" HeaderText="Access Level" SortExpression="AccessLevel" UniqueName="AccessLevel" AutoPostBackOnFilter="true" ShowFilterIcon="false" FilterControlWidth="120px" MaxLength="50">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Active" FilterControlAltText="Filter Active column" SortExpression="Active" UniqueName="Active" Display="false">
                                    <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
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
                        <asp:SqlDataSource ID="userSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Users] where username not like 'pascal' ORDER BY [UserID]" DeleteCommand="DELETE FROM [Users] WHERE [UserID] = @UserID">
                            <DeleteParameters>
                                <asp:Parameter Name="UserID" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>

    
     <div class="modal fade" id="newusermodal">

    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                 <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">New User</h4>
                </div>
                        <div class="modal-body">
                             <div class="form-group">
                                        <label>User Name</label>
                                       <asp:TextBox runat="server" ID="txtUsername" Width="100%" MaxLength="20"></asp:TextBox>
                                   <asp:RequiredFieldValidator runat="server" ErrorMessage="Username is required" ControlToValidate="txtUsername" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="newuser"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                             <label>Password</label>
                                       <asp:TextBox runat="server" ID="txtPassword" Width="100%" TextMode="Password"></asp:TextBox>
                                           <asp:RequiredFieldValidator runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" SetFocusOnError="true" ValidationGroup="newuser"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                        <label>Access Level</label>
                                          <telerik:RadDropDownList ID="dlAccessLevel" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="User"/>
                                                <telerik:DropDownListItem Text="Admin"/>
                                                <telerik:DropDownListItem Text="Projects"/>
                                            </Items>
                                        </telerik:RadDropDownList>
                            </div>
                   <div class="form-group">
                                        <label>Active</label>
                                        <asp:CheckBox runat="server" ID="chkActive" Text="" />
                            </div>  
                             
                       </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" ValidationGroup="newuser" />
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        </div>
         </div>


  <div class="modal fade" id="editusermodal">

    <div class="modal-dialog" style="width:50%">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                  <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">Edit User</h4>
                </div>
                        <div class="modal-body">
                                 <div class="form-group">
                                        <label>User Name</label>
                                       <asp:TextBox runat="server" ID="txtUname" Width="100%" MaxLength="20"></asp:TextBox>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUname" Display="Dynamic" ForeColor="Red" ErrorMessage="Username is required" SetFocusOnError="true" ValidationGroup="edituser"></asp:RequiredFieldValidator>
                             </div>
                            <div class="form-group">
                                             <label>Password</label>
                                       <asp:TextBox runat="server" ID="txtUPass" Width="100%" TextMode="Password"></asp:TextBox>
                                           <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUPass" Display="Dynamic" ForeColor="Red" ErrorMessage="Password is required" SetFocusOnError="true" ValidationGroup="edituser"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group">
                                        <label>Access Level</label>
                                          <telerik:RadDropDownList ID="dlLevel" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="User" />
                                                <telerik:DropDownListItem Text="Admin"/>
                                                <telerik:DropDownListItem Text="Projects"/>
                                            </Items>
                                        </telerik:RadDropDownList>
                            </div>
                             <div class="form-group">
                                        <label>Active</label>
                                        <asp:CheckBox runat="server" ID="chkActive1" Text="" />
                            </div> 
                       </div>

                <div class="modal-footer">
                     <button type="button" class="btn btn-warning" data-dismiss="modal">Close</button>
                    <asp:Button runat="server" ID="btnUpdate" CssClass="btn btn-primary" Text="Update" OnClick="btnUpdate_Click" ValidationGroup="edituser"/>
                </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        </div>
    </div>
    <script type="text/javascript">
        function newModal() {
            $('#newusermodal').modal('show');
            $('#newusermodal').appendTo($("form:first"));
        }
        function closenewModal() {
            $('#newusermodal').modal('hide');
        }
        function editModal() {
            $('#editusermodal').modal('show');
            $('#editusermodal').appendTo($("form:first"));
        }
        function closeeditModal() {
            $('#editusermodal').modal('hide');
        }
    </script>
</asp:Content>
