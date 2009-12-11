<%@ Page Language="C#" 
AutoEventWireup="true" 
CodeBehind="NewWMBuildPackage.aspx.cs" 
Inherits="Harleysville.Deployment.WebApp.NewWMBuildPackage" 
MasterPageFile="~/Hpp.Master" %>

<asp:Content ID="C1" ContentPlaceHolderID="MainContent" runat="server" >
    <div><br />
        This control will create a new wM Build Package<br />
        Place holders will added into TFVC for source package and configs<br />
        The team build type will be create and built
        for the first time to seed the correct build number.
        <br />
        <br />
        <table border="0" >
        <tr><td>
        <table>
        <tr>
            <th align="left" style="height: 26px">
                <asp:Label ID="Label1" runat="server" Text="wM Package Name:"></asp:Label>
            </th>
            <td style="height: 26px">
                <asp:TextBox ID="wMpackName" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <th align="left">
                <asp:Label ID="Label2" runat="server" Text="wM Project:"></asp:Label>
            </th>
            <td>
                    <asp:DropDownList ID="wMprojType" runat="server">
                    <asp:ListItem Value="CL"></asp:ListItem>
                    <asp:ListItem Value="PL"></asp:ListItem>
                    <asp:ListItem Value="Common"></asp:ListItem>
                    </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <th align="left">
                <asp:Label ID="Label3" runat="server" Text="Config File Name:"></asp:Label>
            </th>
            <td>
                <input id="wMConfigFileName" type="text" value="Service.cnf" runat="server" />
            </td>
         </tr>
         <tr>
            <td colspan="2" align="right">
                <input id="Submit1" type="submit" value="submit" runat="server"/>
            </td>
         </tr>
      </table>
      </td></tr>
      </table>
    </div>
</asp:Content>
<asp:Content ID="R1" ContentPlaceHolderID="ResultContent" runat="server">
     <br />
        Upon seccsussful completion the build type will be ready for use, no further action
        is required
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="" Visible="false"></asp:Label><br />
       <asp:TextBox runat="server" ID="wMResults" Visible="false" TextMode="MultiLine" Height="200" Width="600" />
</asp:Content>