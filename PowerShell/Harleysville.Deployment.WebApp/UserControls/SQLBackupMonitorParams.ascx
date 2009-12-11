<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SQLBackupMonitorParams.ascx.cs" Inherits="Harleysville.Deployment.WebApp.UserControls.SQLBackupMonitorParams" %>
<div>
   <asp:Panel ID="SBM_GetParamsPanel" runat="server" Visible="true">
        <table>
            <tr>
                <th>Database Server Name: </th>
                <td>
                    <input id="SBM_SName" type="text" runat="server"/>
                </td>
            </tr>
            <tr>
                 <th>Database Name: </th>
                <td>
                    <input id="SBM_DBName" type="text" runat="server"/>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <input id="SBM_ParamSubmit" type="submit" runat="server" />
                </td>
            </tr>
         </table>
     </asp:Panel>
</div>
<div>
     <asp:Panel id="SBM_ViewsPanel" runat="server" Visible="false">
         <table border="1">
         <tr><td>
             <table>
             <tr><td>
                <asp:Label ID="SBM_Title" runat="server" Font-Bold="true" Font-Size="Larger"></asp:Label>
                <table border="1">
                <tr><td>
                    <asp:GridView ID="SBM_InProgGV" runat="server" Caption="Backups in progress" CaptionAlign="Left" EmptyDataText="No Backups currently in progress">
                        <HeaderStyle BorderColor="Black" BorderStyle="Double" Font-Bold="True" />
                    </asp:GridView>
                </td></tr>
                </table>
                    
                <table border="1">
                <tr><td>
                    <asp:GridView ID="SBM_CompletedGV" runat="server" Caption="Backups completed today" CaptionAlign="Left" EmptyDataText="No backups created today">
                        <HeaderStyle BorderColor="Black" BorderStyle="Double" Font-Bold="True" />
                    </asp:GridView>
                </td></tr>
                </table>
            </td></tr>
            </table>
        </td></tr>
        </table>
    </asp:Panel>
</div>
