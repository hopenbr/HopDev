<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SQLBackupMonitor.aspx.cs" Inherits="Harleysville.Deployment.WebApp._SQLBackupMonitor" MasterPageFile="~/Hpp.Master" %>
<%@ Register Tagprefix="Hpp" Tagname="SQLBackupMonitor" Src=".\UserControls\SQLBackupMonitorParams.ascx" %>
<asp:Content ID="c1" ContentPlaceHolderID="mainContent" runat="server" >
<br />Please enter in Database infomation:<br />
<br />
    <Hpp:SQLBackupMonitor runat="server" ID="GetParams" />
</asp:Content>
