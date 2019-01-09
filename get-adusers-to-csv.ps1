$today = Get-Date

$AllADUsers = Get-ADUser -server "DOMAIN-NAME-HERE" -Filter * -Properties * |
Where-Object { $_.memberof -like ("*CN=*") } | Select-Object @{Label = "First Name";Expression = {$_.GivenName}},
@{Label = "Last Name";Expression = {$_.Surname}},
@{Label = "Display Name";Expression = {$_.DisplayName}},
@{Label = "Logon Name";Expression = {$_.sAMAccountName}},
@{Label = "Description";Expression = {$_.Description}},
@{Label = "Password Expired";Expression = {$_.PasswordExpired}},
@{Label = "Password Last Set";Expression = {$_.PasswordLastSet}},
@{Label = "Password Never Expires";Expression = {$_.PasswordNeverExpires}},
@{Label = "Password Not Required";Expression = {$_.PasswordNotRequired}},
@{Label = "Account Status";Expression = {if (($_.Enabled -eq 'TRUE')  ) {'Enabled'} Else {'Disabled'}}}, # the 'if statement# replaces $_.Enabled
@{Label = "Last LogOn Date";Expression = {$_.lastlogondate}},
# @{Label = "Member of"; Expression = { $_.memberof}},
@{Label = "Created On"; Expression = { $_.whenCreated}} | Export-csv -path C:\temp\domain_users_$($today.Millisecond).csv -NoTypeInformation 

# Where-Object { $_.memberof -like ("*CN=*") } | Select-Object @{Label = "First Name";Expression = {$_.GivenName}},
# Change "*CN=*" to filter by Users Groups
