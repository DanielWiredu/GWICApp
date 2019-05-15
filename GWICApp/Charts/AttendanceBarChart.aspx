<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AttendanceBarChart.aspx.cs" Inherits="GWICApp.Charts.AttendanceBarChart" %>

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
        <asp:ScriptManager runat="server" ></asp:ScriptManager>
        <telerik:RadSkinManager ID="RadSkinManager1" runat="server" Skin="Office2010Blue"></telerik:RadSkinManager>
       <div class="animated fadeInRight">
                <div class="ibox float-e-margins">

                    <div class="ibox-content">
                        
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-4">
                            <label>Service</label>
                             <telerik:RadDropDownList ID="dlService" runat="server" Width="100%" DataSourceID="serviceSource" DataTextField="ServiceName" DataValueField="ServiceName"></telerik:RadDropDownList>
                             <asp:SqlDataSource ID="serviceSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ServiceName FROM [Services]"></asp:SqlDataSource>
                        </div>
                        <div class="col-md-2">
                            <label>Month</label>
                            <telerik:RadDropDownList ID="dlMnth" runat="server" Width="100%">
                                            <Items>
                                                <telerik:DropDownListItem Text="January" Value="01"/>
                                                <telerik:DropDownListItem Text="February" Value="02"/>
                                                <telerik:DropDownListItem Text="March" Value="03"/>
                                                <telerik:DropDownListItem Text="April" Value="04"/>
                                                <telerik:DropDownListItem Text="May" Value="05"/>
                                                <telerik:DropDownListItem Text="June" Value="06"/>
                                                <telerik:DropDownListItem Text="July" Value="07"/>
                                                <telerik:DropDownListItem Text="August" Value="08"/>
                                                <telerik:DropDownListItem Text="September" Value="09"/>
                                                <telerik:DropDownListItem Text="October" Value="10"/>
                                                <telerik:DropDownListItem Text="November" Value="11"/>
                                                <telerik:DropDownListItem Text="December" Value="12"/>
                                            </Items>
                              </telerik:RadDropDownList>
                        </div>
                        <div class="col-md-2">
                            <label>Year</label>
                            <telerik:RadDropDownList ID="dlYear" runat="server" Width="100%"> </telerik:RadDropDownList>
                        </div>
                        <div class="col-md-1">
                            <label>Run</label>
                             <asp:Button ID="btnRun" runat="server" Text="Run" CssClass="btn-success" Width="100%"  OnClick="btnRun_Click"/>
                        </div>
                    </div>
                </div>

                
            <telerik:RadHtmlChart runat="server" Width="100%" Height="600px" ID="RadHtmlChart2" DataSourceID="chartSource" Skin="Silk">
            <PlotArea>
                <Series>
                    <telerik:ColumnSeries DataFieldY="ADULTS" Name="ADULTS">
                         <LabelsAppearance Color="DarkRed" DataField="ADULTS" Position="OutsideEnd" DataFormatString="{0:#}">
                              <TextStyle Bold="true" FontSize="20" />
                         </LabelsAppearance>
                        <TooltipsAppearance Color="Yellow" DataFormatString="{0:#}"></TooltipsAppearance>
                    </telerik:ColumnSeries>
                    <telerik:ColumnSeries DataFieldY="CHILDREN" Name="CHILDREN">
                         <LabelsAppearance Color="DarkRed" DataField="CHILDREN" Position="OutsideEnd" DataFormatString="{0:#}">
                             <TextStyle Bold="true" FontSize="20" />
                         </LabelsAppearance>
                        <TooltipsAppearance Color="Yellow" DataFormatString="{0:#}"></TooltipsAppearance>
                    </telerik:ColumnSeries>
                    <telerik:ColumnSeries DataFieldY="CARS" Name="CARS">
                         <LabelsAppearance Color="DarkRed" DataField="CARS" Position="OutsideEnd" DataFormatString="{0:#}">
                              <TextStyle Bold="true" FontSize="20" />
                         </LabelsAppearance>
                        <TooltipsAppearance Color="Yellow" DataFormatString="{0:#}"></TooltipsAppearance>
                    </telerik:ColumnSeries>
                </Series>
                 <XAxis DataLabelsField="REGDATE" Type="Category">
                    <LabelsAppearance RotationAngle="0" DataFormatString="{0:dd-MMM-yyyy}">
                        <TextStyle FontSize="18" />
                    </LabelsAppearance>
                    <TitleAppearance Text="DAY OF SERVICE" Visible="false">
                    </TitleAppearance>
                </XAxis>
                <YAxis>
                    <TitleAppearance Text="Attendance">
                        <TextStyle Bold="true" FontSize="18" />
                    </TitleAppearance>
                </YAxis>
            </PlotArea>
            <Legend>
                <Appearance Visible="true" Position="Top" Orientation="Horizontal">
                    <TextStyle Bold="true" FontSize="16" />
                </Appearance>
            </Legend>
            <ChartTitle Text="">
                <Appearance><TextStyle Bold="true" FontSize="26" /></Appearance>
            </ChartTitle>
        </telerik:RadHtmlChart> 
                <asp:SqlDataSource ID="chartSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT REGDATE, ADULTS, CHILDREN, CARS FROM Attendance WHERE (SERVICE = @service) AND (YEAR(REGDATE) = @yr) AND (MONTH(REGDATE) = @mm) ORDER BY REGDATE">
                     <SelectParameters>
                        <asp:ControlParameter ControlID="dlService" Name="service" PropertyName="SelectedValue" />
                         <asp:ControlParameter ControlID="dlYear" Name="yr" PropertyName="SelectedText" />
                         <asp:ControlParameter ControlID="dlMnth" Name="mm" PropertyName="SelectedValue" />
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
