<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="GWICApp.Dashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <script type="text/javascript">
             //var $ = $telerik.$;
             function exportRadHtmlChart() {
                 $find('<%=RadClientExportManager1.ClientID%>').exportPDF($(".RadHtmlChart"));
          }
    </script>
  
    <div class="wrapper wrapper-content animated fadeInRight">

       



            <div class="row">
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                       <p>Dashboard</p>

                         <div class="row">
           <%-- <div class="col-lg-3">
                <div class="widget style1 blue-bg">
                        <div class="row">
                            <div class="col-xs-4 text-center">
                                <i class="fa fa-trophy fa-5x"></i>
                            </div>
                            <div class="col-xs-8 text-right">
                                <span> Today income </span>
                                <h2 class="font-bold">$ 4,232</h2>
                            </div>
                        </div>
                </div>
            </div>--%>
            <div class="col-lg-3">
                <div class="widget style1 navy-bg">
                    <div class="row">
                        <%--<div class="col-xs-4">
                            <i class="fa fa-cloud fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Active Members </span>
                            <h2 class="font-bold" runat="server" id="lblActiveMembers"> </h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="widget style1 lazur-bg">
                    <div class="row">
                        <%--<div class="col-xs-4">
                            <i class="fa fa-envelope-o fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Visitors </span>
                            <h2 class="font-bold" runat="server" id="lblVisitors"> </h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="widget style1 yellow-bg">
                    <div class="row">
                       <%-- <div class="col-xs-4">
                            <i class="fa fa-music fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span>Inactive Members</span>
                            <h2 class="font-bold" runat="server" id="lblInactiveMembers"> </h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3">
                <div class="widget style1 red-bg">
                    <div class="row">
                       <%-- <div class="col-xs-4">
                            <i class="fa fa-music fa-5x"></i>
                        </div>--%>
                        <div class="col-xs-12 text-right">
                            <span> Services </span>
                            <h2 class="font-bold" runat="server" id="lblServices">  </h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>

                          <div class="row">
                    <div class="col-md-6">
                   <telerik:RadHtmlChart runat="server" Width="100%" Height="500px" ID="chtAgeDistribution" Skin="Silk" DataSourceID="agedistSource">
            <PlotArea>
                <Series>
                    <telerik:ColumnSeries Name="Total Members" DataFieldY="MEMBERS">
                        <TooltipsAppearance Color="White"  />
                    </telerik:ColumnSeries>
                </Series>
                <XAxis  DataLabelsField="AGEGROUP">
                    <LabelsAppearance RotationAngle="75">
                    </LabelsAppearance>
                    <TitleAppearance Text="Age band">
                    </TitleAppearance>
                </XAxis>
                <YAxis>
                    <TitleAppearance Text="Total Members">
                    </TitleAppearance>
                </YAxis>
            </PlotArea>
            <Legend>
                <Appearance Visible="false">
                </Appearance>
            </Legend>
            <ChartTitle Text="Membership Age Distribution">
            </ChartTitle>
        </telerik:RadHtmlChart>

                    <asp:SqlDataSource ID="agedistSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT AGEGROUP, COUNT(MEMBERID) AS MEMBERS FROM MEMBERS WHERE ACTIVE = 1 GROUP BY AGEGROUP ORDER BY AGEGROUP"></asp:SqlDataSource>
                
                    <telerik:RadButton ID="btnExport" Text="Export to PDF" runat="server" OnClientClicked="exportRadHtmlChart" UseSubmitBehavior="false" AutoPostBack="false"></telerik:RadButton>
                    <telerik:RadClientExportManager ID="RadClientExportManager1" runat="server"></telerik:RadClientExportManager>

                    </div>
                            <div class="col-md-6">
                         <asp:SqlDataSource ID="baptismSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT BAPTISMTYPE, COUNT(MEMBERID) AS TOTAL FROM MEMBERS WHERE ACTIVE = 1 GROUP BY BAPTISMTYPE"></asp:SqlDataSource>

                     <telerik:RadHtmlChart runat="server" Width="100%" Height="500px" ID="RadHtmlChart2"
            DataSourceID="baptismSource" Skin="Silk">
            <PlotArea>
                <Series>
                    <telerik:DonutSeries DataFieldY="TOTAL" Name="Status" NameField="BAPTISMTYPE" StartAngle="45">
                        <LabelsAppearance DataField="BAPTISMTYPE" Position="OutsideEnd" Visible="false"></LabelsAppearance>
                    </telerik:DonutSeries>
                </Series>
            </PlotArea>
            <Legend>
                <Appearance Visible="true" Position="Bottom">
                </Appearance>
            </Legend>
            <ChartTitle Text="Membership Baptism Type">
            </ChartTitle>
        </telerik:RadHtmlChart> 
                        </div>
                </div>
                    </div>
                </div>
            </div>


                </div>
        </div>

</asp:Content>
