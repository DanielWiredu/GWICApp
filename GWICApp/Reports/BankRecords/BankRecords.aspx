<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankRecords.aspx.cs" Inherits="GWICApp.Reports.BankRecords.BankRecords" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="BankTransactionsReport" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="false" OnLoad="BankTransactionsReport_Load" />
    </div>
    </form>
</body>
</html>
