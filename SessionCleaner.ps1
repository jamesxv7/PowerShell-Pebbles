# Description: This script remove Idle and Disconected sessions from
# a remote terminal server.

# Terminal Servers
$servers = @("10.10.10.10", "11.11.11.11")

foreach($serverAddress in $servers){
    # Select the users logged on the remote session
    $users = query user /server:$serverAddress
        
    $userToLogoff = @()

    # Write-Output $users

    # Normalize format of the users data
    foreach($user in $users){
        $userToLogoff += $user -replace '\s+', ' '
    }

    # Write-Output $userToLogoff

    #Start index from 1 to skip the header
    for($index = 1; $index -le $userToLogoff.Length - 1; $index++) {
        $userData = $userToLogoff[$index].Split(" ")

        # Test case when SESSIONAME is empty 
        if($userData[2] -match '^\d+$') {
            $sessionId = $userData[2]
            $sessionState = $userData[3]
        } else {
            $sessionId = $userData[3]
            $sessionState = $userData[4]      
        }

        if(($sessionState -like "Disc") -or ($sessionState -like "Idle")) {
            # Logoff the user using the Session ID
            $userName = $userData[1]

            # Write-Output "$userName $sessionId $sessionState"

            logoff $sessionId /server:$serverAddress /V
        
            if(Test-Path 'C:\Users\Public\Documents\SessionsUsedLog.txt') {
                "$userData".Trim() | Out-File 'C:\Users\Public\Documents\SessionsUsedLog.txt' -Append
            } else {
                "USERNAME ID STATE IDLE-TIME LOGON-TIME" | Out-File 'C:\Users\Public\Documents\SessionsUsedLog.txt'
                "$userData".Trim() | Out-File 'C:\Users\Public\Documents\SessionsUsedLog.txt' -Append
            }
        }

        if(($userData[5] -like "*:*") -or ($userData[6] -like"*:*")) {
            # Write-Output $sessionId
            logoff $sessionId /server:$serverAddress /V
        }
    }
}

Exit
