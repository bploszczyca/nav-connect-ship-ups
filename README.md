Basis Entwicklungsumgebung in "Business Central 14" als Docker Image unter Windows 10

----- beötigte PowerShell Module (PShell "Run as Administrator"!) -----
Install-Module -Name BcContainerHelper
Update-Module -Name BcContainerHelper


----- Docker muss unter Win10 für "Windows Container" umgeschaltet werden -----
$artifactUrl =  Get-BCArtifactUrl -type onprem -version 14.0 -country de
New-BcContainer -accept_eula -licenseFile "https://www.usus-augere.de/nextcloud/s/ES2N9dpZxQBZENA/download" -artifactUrl $artifactUrl -containerName BC14-BS -includeAL -includeCSide -isolation hyperv