<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetailReport1.aspx.cs" Inherits="GWICApp.Reports.Sales.DetailReport1" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="SalesReportDocument" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" OnLoad="SalesReportDocument_Load" />
    </div>
    </form>
</body>
</html>
