[Reflection.Assembly]::LoadWithPartialName("OSIsoft.AFSDK") | Out-Null  
[OSIsoft.AF.PI.PIServers] $PIServers = New-object OSIsoft.AF.PI.PIServers  
[OSIsoft.AF.PI.PIServer] $PIDA = $PIservers["PIDATAARCHIVE"]   
[string[]] $PIPointList = Get-Content -Path "Path To File with PI Point Nmaes" #PI Points must exist  
[OSIsoft.AF.Data.AFUpdateOption] $UpdateOption = "Insert"  
[OSIsoft.AF.Data.AFBufferOption] $Buffer = "Buffer"  
$PIPoints = [OSIsoft.AF.PI.PIPoint]::FindPIPoints($PIDA,$PIPointList)  
While($true){ #infinite loop  
{  
     $Time = Get-Date  
     [OSIsoft.AF.Time.AFTime] $Timestamp = New-Object OSIsoft.AF.Time.AFTime($Time)  
     ForEach($P in $PIPoints)  
     {  
          $RandomValue = Get-Random -Minimum 0 -Maximum 100 #Range of values  
          [OSIsoft.AF.Asset.AFValue] $Value = New-object OSIsoft.AF.Asset.AFValue($RandomValue,$Timestamp)  
          $P.UpdateValue($Value,$UpdateOption,$Buffer)  
     }  
     Start-Sleep -Seconds 30 #approximate frequency   
}  
