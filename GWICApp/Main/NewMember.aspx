<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="NewMember.aspx.cs" Inherits="GWICApp.Main.NewMember" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <script type="text/javascript">
          function previewFile() {
              var preview = document.querySelector('#<%=Image1.ClientID %>');
            var file = document.querySelector('#<%=avatarUpload.ClientID %>').files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;
            }

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = "";
            }
          }
    </script>
     <div class="wrapper wrapper-content animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>New Member</h5>
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
                            <%--<div class="bg-primary">Member Details</div>--%>
                        <div runat="server" id="lblMsg"></div>
                 <div>
                  <div class="form-group">
                 <div class="row">
                      <div class="col-md-3">
                         <label>MemberID</label>
                         <asp:TextBox ID="txtMemberID" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                     </div>
                     <div class="col-md-3">
                         <label>Surname</label>
                         <asp:TextBox ID="txtSurname" runat="server" Width="100%"></asp:TextBox>
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSurname" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                     </div>
                     <div class="col-md-3">
                         <label>OtherName(s)</label>
                         <asp:TextBox ID="txtOthernames" runat="server" Width="100%"></asp:TextBox>
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOthernames" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                     </div>
                    <div class="col-md-3">
                         <label>Gender</label>
                         <telerik:RadDropDownList ID="dlGender" runat="server" Width="100%">
                             <Items>
                                 <telerik:DropDownListItem Text="Male" />
                                 <telerik:DropDownListItem Text="Female"/>
                             </Items>
                         </telerik:RadDropDownList>
                     </div>
                    
                 </div>
             </div>
                      <div class="form-group">
                 <div class="row">
                      <div class="col-md-3">
                         <label>Date of Birth</label>
                         <telerik:RadDatePicker ID="dpDOB" runat="server" Width="100%" DateInput-ReadOnly="true" MinDate="1/1/1850"></telerik:RadDatePicker>
                           <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDOB" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                     </div>
                   
                     <div class="col-md-3">
                         <label>Marital Status</label>
                         <telerik:RadDropDownList ID="dlMaritalStatus" runat="server" Width="100%" >
                             <Items>
                                 <telerik:DropDownListItem Text="Single" Value="Single" Selected="true"/>
                                 <telerik:DropDownListItem Text="Married" Value="Married" />
                                 <telerik:DropDownListItem Text="Separated" Value="Separated" />
                                 <telerik:DropDownListItem Text="Divorced" Value="Divorced" />
                                 <telerik:DropDownListItem Text="Widowed" Value="Widowed"/>
                             </Items>
                         </telerik:RadDropDownList>
                     </div>
                    <div class="col-md-3">
                         <label>Telephone</label>
                         <asp:TextBox ID="txtTelephone" runat="server" Width="100%" TextMode="Number"></asp:TextBox>
                       </div>
                       <div class="col-md-3">
                         <label>Email</label>
                         <asp:TextBox ID="txtEmail" runat="server" Width="100%" TextMode="Email"></asp:TextBox>
                       </div>
                 </div>
             </div>
                       <div class="form-group">
                         <div class="row">
                             <div class="col-md-6">
                                 <label>Residential Address</label>
                                 <asp:TextBox ID="txtResAddress" runat="server" Width="100%"></asp:TextBox>
                             </div>
                             <div class="col-md-6">
                                 <label>Postal Address</label>
                                 <asp:TextBox ID="txtPostAddress" runat="server" Width="100%" ></asp:TextBox>
                             </div>
                         </div>
                     </div>
                     <div class="form-group">
                         <div class="row">
                             <div class="col-md-3">
                         <label>Baptism Type</label>
                          <telerik:RadDropDownList ID="dlBaptism" runat="server" Width="100%" >
                             <Items>
                                 <telerik:DropDownListItem Text="Holy Ghost"/>
                                 <telerik:DropDownListItem Text="Water Baptism" />
                                 <telerik:DropDownListItem Text="Not Baptized" />
                             </Items>
                         </telerik:RadDropDownList>
                     </div>
                           <div class="col-md-3">
                         <label>Date of Baptism</label>
                         <telerik:RadDatePicker ID="dpBaptismDate" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                           <asp:RequiredFieldValidator runat="server" ControlToValidate="dpBaptismDate" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                     </div> 
                              <div class="col-md-3">
                               <label>Department</label>
                               <telerik:RadComboBox ID="dlDepartment" runat="server" Width="100%" DataSourceID="deptSource" DataTextField="DeptName" DataValueField="DeptName" Filter="Contains" MarkFirstMatch="True" Text="Select Department"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="deptSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DeptName FROM [Department]"></asp:SqlDataSource>                               
                         </div>
                        <div class="col-md-3">
                                 <label>Position Held</label>
                                 <asp:TextBox ID="txtPosition" runat="server" Width="100%" ></asp:TextBox>
                             </div>      
                         </div>
                     </div>
                   
                      <div class="form-group">
                 <div class="row">
                       <div class="col-md-3">
                               <label>Nationality</label>
                               <telerik:RadComboBox ID="dlNationality" runat="server" Width="100%" DataSourceID="nationalitySource" DataTextField="Nationality" DataValueField="Nationality" Filter="Contains" MarkFirstMatch="True" Text="Select Nationality"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="nationalitySource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Nationality FROM [Nationality]"></asp:SqlDataSource>   
                         </div>
                     <div class="col-md-3">
                         <label>National ID Type</label>
                         <telerik:RadDropDownList ID="dlIDType" runat="server" Width="100%" >
                             <Items>
                                 <telerik:DropDownListItem Text="Voter"/>
                                 <telerik:DropDownListItem Text="NHIS" />
                                 <telerik:DropDownListItem Text="Passport" />
                                 <telerik:DropDownListItem Text="National ID" />
                                 <telerik:DropDownListItem Text="None" />
                             </Items>
                         </telerik:RadDropDownList>
                     </div>
                               <div class="col-md-3">
                               <label>Occupation</label>
                               <telerik:RadComboBox ID="dlOccupation" runat="server" Width="100%" DataSourceID="occupationSource" DataTextField="Occupation" DataValueField="Occupation" Filter="Contains" MarkFirstMatch="True" Text="Select Occupation"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="occupationSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Occupation]"></asp:SqlDataSource>                               
                         </div>
                      <div class="col-md-3">
                               <label>Profession</label>
                               <telerik:RadComboBox ID="dlProfession" runat="server" Width="100%" DataSourceID="professionSource" DataTextField="Profession" DataValueField="Profession" Filter="Contains" MarkFirstMatch="True" Text="Select Profession"></telerik:RadComboBox>
                            <asp:SqlDataSource ID="professionSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Profession FROM [Profession]"></asp:SqlDataSource>                               
                         </div>   
                 </div>
             </div>
                 <div class="form-group">
                     <div class="row">
                         <div class="col-md-3">
                             <label>Economic Status</label>
                         <telerik:RadDropDownList ID="dlEconomicStatus" runat="server" Width="100%" >
                             <Items>
                                 <telerik:DropDownListItem Text="Employed"/>
                                 <telerik:DropDownListItem Text="Unemployed" />
                                 <telerik:DropDownListItem Text="Retired" />
                             </Items>
                         </telerik:RadDropDownList>
                         </div>
                       <div class="col-md-3">
                         <label>Date Joined</label>
                         <telerik:RadDatePicker ID="dpDateJoined" runat="server" Width="100%" DateInput-ReadOnly="true"></telerik:RadDatePicker>
                           <asp:RequiredFieldValidator runat="server" ControlToValidate="dpDateJoined" Display="Dynamic" ErrorMessage="Required Field" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
                     </div> 
                    <div class="col-md-6">
                                 <label>Previous Church</label>
                                 <asp:TextBox ID="txtPreviousChurch" runat="server" Width="100%" ></asp:TextBox>
                             </div> 
                     </div>
                 </div>
                     <div class="form-group">
                         <div class="row">
                        <div class="col-md-3">
                            <label>Image</label>
                            <asp:Image ID="Image1" runat="server" Width="100%" Height="160px" BackColor="#cccccc" />
                            <input id="avatarUpload" type="file" name="file" onchange="previewFile()"  runat="server" />
                            <%--<asp:FileUpload ID="FileUpload1" runat="server" />--%>
                        </div>
                         </div>
                     </div>
                            </div>
                                  <div class="modal-footer"> 
                    <asp:Button runat="server" CssClass="btn btn-danger" ID="btnClose" Text="Exit" CausesValidation="false" PostBackUrl="/Main/Members.aspx" style="margin-bottom:0px" />  
                     <asp:Button runat="server"  CssClass="btn btn-warning" ID="btnClear" Text="Clear" OnClick="btnClear_Click" CausesValidation="false" />           
                    <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" Text="Save" OnClick="btnSave_Click" CausesValidation="true" />         
                </div>
                    </ContentTemplate>
                             <Triggers>
                                 <asp:PostBackTrigger ControlID="btnSave" />
                             </Triggers>
                </asp:UpdatePanel>
                    </div>
                </div>
        </div>
</asp:Content>
