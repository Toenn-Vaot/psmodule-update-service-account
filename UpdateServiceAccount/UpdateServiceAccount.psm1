Function Update-ServiceAccount {
	<#
	.SYNOPSIS
	Update-ServiceAccount allows to set service account
	.DESCRIPTION
	Author: yblossier
	Project support: https://github.com/toenn-vaot/psmodule-update-service-account
    
	.EXAMPLE
	Update-ServiceAccount 'TestService', $env:COMPUTERNAME, $env:USERDOMAIN\$env:USERNAME, 'Password'
    #>
    param(
        [alias ("svc")] [string][parameter(mandatory=$true, Valuefrompipeline = $true)]$serviceName,
        [alias ("cn")] [string]$computerName = $env:COMPUTERNAME,
        [alias ("usr")] [string]$username = "NT AUTHORITY\LocalService",
        [alias ("pwd")] [string]$password = ""
    )

    $service = Get-WmiObject -ComputerName $computerName -Query "SELECT * FROM Win32_Service WHERE Name = '$serviceName'"
    $service.Change($null,$null,$null,$null,$null,$null,"$username","$password") | Out-Null
}

Export-ModuleMember -Function 'Update-ServiceAccount'