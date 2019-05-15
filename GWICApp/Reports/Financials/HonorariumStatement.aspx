<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HonorariumStatement.aspx.cs" Inherits="GWICApp.Reports.Financials.HonorariumStatement" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
    <div>
    <CR:CrystalReportViewer ID="HonorariumStatementReport" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" OnLoad="HonorariumStatement_Load"/>
    </div>
    </form>
</body>
</html>
