# DeleteFuckingRoblox.ps1
# Connor Hudson 2022
# 
# Turn this into a Scheduled Task for ultimate annoyance
# 

$packagesInstalled = Get-AppxPackage -AllUsers

# Look for instances of Roblox installed through Microsoft Store, delete them
foreach ($p in $packagesInstalled){
    if ($p.Name -eq "ROBLOXCORPORATION.ROBLOX"){
        Get-AppxPackage -AllUsers *ROBLOXCORPORATION.ROBLOX* | Remove-AppPackage
    }
}

# Get the current logged in user
$loggedInUser = $(Get-CimInstance -ClassName Win32_ComputerSystem | select username).username
$loggedInUser = $loggedInUser.replace("AzureAD\","")

# Find any files accosiated with Roblox, delete them, -whatif the line to see results without deleting anything
Get-ChildItem -directory -path "C:\Users\$loggedInUser\AppData\Local\" | where {$_name -like 'Roblox*'} | Remove-Item -force -recurse # -whatif

# This line works on non-domain joined users
# get-childitem -directory -path $env:LOCALAPPDATA | where {$_name -like 'Roblox*'} | remove-item -force -recurse
