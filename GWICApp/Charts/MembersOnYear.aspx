<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MembersOnYear.aspx.cs" Inherits="GWICApp.Charts.MembersOnYear" %>

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
    <link href="/Content/font-awesome/css/font-awesome.css" rel="stylesheet"/></head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager runat="server"></asp:ScriptManager>
         <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Office2010Blue"></telerik:RadSkinManager>
           <div class="animated fadeInRight">
                <div>
                    <div class="ibox-content">
                                                   <div>
                    <telerik:RadDropDownList ID="dlGender" runat="server" Width="300px">
                             <Items>
                                 <telerik:DropDownListItem Text="Male" Value="Male"/>
                                 <telerik:DropDownListItem Text="Female" Value="Female"/>
                                 <telerik:DropDownListItem Text="All" Value="" Selected="true" />
                             </Items>
                         </telerik:RadDropDownList>
                    <telerik:RadDatePicker ID="dpSdate" runat="server" >
                    </telerik:RadDatePicker>
                    <telerik:RadDatePicker ID="dpEdate" runat="server" >
                    </telerik:RadDatePicker>
                    <asp:Button ID="btnRun" runat="server" Text="Run" CssClass="btn-success"  OnClick="btnRun_Click"/>
                    <asp:HiddenField runat="server" ID="hfSdate" />
                    <asp:HiddenField runat="server" ID="hfEdate" />
                </div>                
                     <telerik:RadHtmlChart runat="server" Width="100%" Height="600px" ID="RadHtmlChart2" DataSourceID="chartSource" Skin="Silk">
            <PlotArea>
                <Series>
                    <telerik:LineSeries DataFieldY="MEMBERS" Name="YEAR">
                        <LineAppearance Width="3" />
                         <LabelsAppearance Color="DarkRed" DataField="MEMBERS" Position="Above">
                             <TextStyle FontSize="16" Bold="true" />
                         </LabelsAppearance>
                        <TooltipsAppearance Color="Yellow" DataFormatString="{0:#}"></TooltipsAppearance>
                    </telerik:LineSeries>
                </Series>
                 <XAxis DataLabelsField="YYYY">
                    <LabelsAppearance RotationAngle="75">
                        <TextStyle FontSize="16" />
                    </LabelsAppearance>
                    <TitleAppearance Text="YEAR">
                        <TextStyle FontSize="16" Bold="true" />
                    </TitleAppearance>
                </XAxis>
                <YAxis>
                    <TitleAppearance Text="Members">
                        <TextStyle FontSize="18" Bold="true" />
                    </TitleAppearance>
                </YAxis>
            </PlotArea>
            <Legend>
                <Appearance Visible="false">
                </Appearance>
            </Legend>
            <ChartTitle Text="Members Chart (Yearly)">
                <Appearance>
                    <TextStyle FontSize="24" Bold="true" />
                </Appearance>
            </ChartTitle>
        </telerik:RadHtmlChart> 
                <asp:SqlDataSource ID="chartSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT year(regdate) as YYYY, count(memberid) as MEMBERS from Members where (Gender LIKE @GENDER + '%') AND (Regdate BETWEEN @SDATE AND @EDATE) AND Active = 1 GROUP BY year(regdate) order by YYYY">
                     <SelectParameters>
                        
                        <asp:ControlParameter ControlID="hfSdate" Name="SDATE" PropertyName="Value" />
                        <asp:ControlParameter ControlID="hfEdate" Name="EDATE" PropertyName="Value" />
                         <asp:ControlParameter ControlID="dlGender" ConvertEmptyStringToNull="False" DefaultValue="" Name="GENDER" PropertyName="SelectedValue" />
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
