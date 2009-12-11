param(
    [string] $_teamProject = $(throw 'team project is required'),
    [string] $_buildNumber = $(throw 'Build number is required')
)

Add-PSSnapIn Harleysville.Deployment.SnapIn -ea silentlycontinue
$_topLevelDir = Get-TFVC $_teamProject $_buildNumber
return $_topLevelDir
