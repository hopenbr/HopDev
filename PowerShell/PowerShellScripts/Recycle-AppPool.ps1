param(
    [string] $_serverName = $(throw 'The IIS server name is required'),
    [string] $_appPoolName = $(throw 'The appPool Name is required')
)

#here we add my snapin that will create the workspace and add items to tfvc
Add-PSSnapIn Harleysville.Deployment.SnapIn -ea silentlycontinue
Clear-AppPool $_serverName $_appPoolName | out-null
$message = "IIS://$_serverName/W3SVC/AppPools/$_appPoolName was recycled"
return $message


