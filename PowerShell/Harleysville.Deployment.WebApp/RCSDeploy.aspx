<%@ Page Language="C#" 
AutoEventWireup="true" 
CodeBehind="RCSDeploy.aspx.cs" 
Inherits="Harleysville.Deployment.WebApp.RCSImagration" 
MasterPageFile="~/Hpp.Master" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server" >
    <div><br />
        Please enter in DBI number for Renewal Conversion Scripts mirgation
        <br />
        <b>DBI must have migration XML file(s) attached</b>
        <br />
        <br />
        <div>
            <asp:Label ID="Label1" runat="server" Text="DBI #:"></asp:Label>&nbsp;
            <asp:TextBox runat="server" ID="dbiNumber" EnableViewState="false"  />
            <input id="Submit1" type="submit" value="submit" runat="server" />
            <input id="Reset1" type="reset" value="reset" runat="server"/>
            <br />
            <br />
       </div>
   </div>
</asp:Content>
<asp:Content ID="R1" ContentPlaceHolderID="ResultContent" runat="server" >
     <asp:Label ID="Label2" runat="server" Text="" Visible="false"></asp:Label><br />
     <asp:TextBox runat="server" ID="ResultsBox" Visible="false" TextMode="MultiLine" Height="450" Width="600" />
</asp:Content>
    