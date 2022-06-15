# 
# KillRoblox.ps1
# Connor Hudson, 2022
# 
# Turn this into a Scheduled Task for ultimate annoyance
# 
$packagesInstalled = Get-AppxPackage -AllUsers

try{
    # Look for instances of Roblox installed through Microsoft Store, delete them
    foreach ($p in $packagesInstalled){
        if ($p.Name -eq "ROBLOXCORPORATION.ROBLOX"){
            Get-AppxPackage -AllUsers *ROBLOXCORPORATION.ROBLOX* | Remove-AppPackage
        }
    }
} catch {"An error occured, could not locate or delete a version of Roblox downloaded from Microsoft Store."}


# Get the current logged in user
$loggedInUser = $(Get-CimInstance -ClassName Win32_ComputerSystem | select username).username


#This step necessary if the device and user are AzureAD joined
if ($loggedInUser.Contains("AzureAD\")){
    echo "$loggedInUser is AzureAD Joined!"
    $loggedInUser = $loggedInUser.replace("AzureAD\","")
    $dir = "C:\Users\" + $loggedInUser + "\AppData\Local\roblox"
    

    
    #echo "C:\users\StudentTestingAccoun\AppData"
    echo $dir
    # Find any files accosiated with Roblox, delete them, -whatif the line to see results without deleting anything
    Get-ChildItem -Directory -Path $dir | Remove-Item -Force -Recurse
    #Get-ChildItem -directory -path  | where {$_name -like 'Roblox*'} | Remove-Item -Recurse -Force -whatif
} else {
    # This line works on devices that were manually joined to a domain
    Get-ChildItem -directory -Path $env:LOCALAPPDATA | where {$_name -like 'Roblox*'} | Remove-Item -Force -Recurse
}