param(
    [string] $_localPath = $(throw 'local path is required'),
    [string] $_serverPath = $(throw 'server Path is required')
)

#here we add my snapin that will create the workspace and add items to tfvc
Add-PSSnapIn Harleysville.Deployment.SnapIn -ea SilentlyContinue

$wasAdded2TFVC = Add-TFVC $_localPath $_serverPath

return $wasAdded2TFVC

