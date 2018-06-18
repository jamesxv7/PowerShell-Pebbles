# Logoff users remotely
# First search the User ID
query user /server:$serverAddress
# Use the User ID to kill the session
logoff $sessionId /server:$serverAddress /V 
# --
