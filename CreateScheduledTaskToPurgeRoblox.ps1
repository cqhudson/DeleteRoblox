$trigger = New-ScheduledTaskTrigger -Daily -At 8:30am
$settings = New-ScheduledTaskSettingsSet -Hidden -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable
$action = New-ScheduledTaskAction -Execute 'Powershell.exe' -Argument '$packagesInstalled = Get-AppxPackage -AllUsers; foreach ($p in $packagesInstalled){if ($p.Name -eq "ROBLOXCORPORATION.ROBLOX"){Get-AppxPackage -AllUsers *ROBLOXCORPORATION.ROBLOX* | Remove-AppPackage;}} ;$loggedInUser = $(Get-CimInstance -ClassName Win32_ComputerSystem | select username).username; if ($loggedInUser.Contains("AzureAD\")){$loggedInUser = $loggedInUser.replace("AzureAD\",""); $dir = "C:\Users\" + $loggedInUser + "\AppData\Local\Roblox"; Get-ChildItem -Directory -Path $dir | Remove-Item -Force -Recurse;}'
$task = Register-ScheduledTask -TaskName 'Delete Roblox' -Action $action -Trigger $trigger -Settings $settings -Description 'Deletes Roblox in the most annoying way possible >:)' -RunLevel Highest -Force


