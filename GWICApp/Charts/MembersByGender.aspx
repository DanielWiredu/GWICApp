<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MembersByGender.aspx.cs" Inherits="GWICApp.Charts.MembersByGender" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

    <title>GIWC Management System</title>
     <script src="/Content/js/jquery-2.1.1.js"></script>
    <link href="/Content/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="/Content/css/plugins/toastr/toastr.min.css" rel="stylesheet"/>
    <link href="/Content/js/plugins/gritter/jquery.gritter.css" rel="stylesheet"/>
    <link href="/Content/css/animate.css" rel="stylesheet"/>
    <link href="/Content/css/style.css" rel="stylesheet"/>
    <link href="/Content/css/commot.min.css" rel="stylesheet" />
    <link href="/Content/css/comm.blueopal.min.css" rel="stylesheet" />
    <link href="/Content/font-awesome/css/font-awesome.css" rel="stylesheet"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
            <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Office2010Blue"></telerik:RadSkinManager>

           <div class="animated fadeInRight">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                  
                <div>
                    <telerik:RadDatePicker ID="dpSdate" runat="server" >
                    </telerik:RadDatePicker>
                    <telerik:RadDatePicker ID="dpEdate" runat="server" >
                    </telerik:RadDatePicker>
                    <asp:Button ID="btnRun" runat="server" Text="Run" CssClass="btn-success"  OnClick="btnRun_Click"/>
                    <asp:HiddenField runat="server" ID="hfSdate" />
                    <asp:HiddenField runat="server" ID="hfEdate" />
                </div>

                
                     <telerik:RadHtmlChart runat="server" Width="100%" Height="500px" ID="RadHtmlChart2" DataSourceID="chartSource" Skin="Silk">
            <PlotArea>
                <Series>
                    <telerik:PieSeries DataFieldY="MEMBERS" Name="GENDER" NameField="GENDER" StartAngle="90">
                        <LabelsAppearance Position="OutsideEnd" DataField="MEMBERS" DataFormatString="{0}%">
                            <TextStyle FontSize="18" />
                        </LabelsAppearance>
                    </telerik:PieSeries>

                </Series>
            </PlotArea>
            <Legend>
                <Appearance Visible="true" Height="100">
                    <TextStyle FontSize="24" Bold="true"/>
                </Appearance>
            </Legend>
            <ChartTitle Text="All Members Chart">
                <Appearance>
                    <TextStyle FontSize="24" Bold="true" />
                </Appearance>
            </ChartTitle>
        </telerik:RadHtmlChart> 
                <asp:SqlDataSource ID="chartSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT GENDER, count(memberid) as MEMBERS from Members WHERE (REGDATE BETWEEN @SDATE AND @EDATE) AND ACTIVE = 1 group by GENDER">
                     <SelectParameters>
                        <asp:ControlParameter ControlID="hfSdate" Name="SDATE" PropertyName="Value" />
                        <asp:ControlParameter ControlID="hfEdate" Name="EDATE" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>

                  <telerik:RadButton ID="btnExport" Text="Export to PDF" runat="server" OnClientClicked="exportRadHtmlChart" UseSubmitBehavior="false" AutoPostBack="false"></telerik:RadButton>
                    <telerik:RadClientExportManager ID="RadClientExportManager1" runat="server"></telerik:RadClientExportManager>
           
                    </div>
                </div>
        </div>
    </div>


              <script>
                  var $ = $telerik.$;

                  function exportRadHtmlChart() {
                      $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".RadHtmlChart"));
                  }

    </script>
    </form>
</body>
</html>
