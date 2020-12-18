foreach($line in [System.IO.File]::ReadLines("C:\Temp\Long_Log_File_Location.txt"))
{
  if($line -match ',"1",') 
  {
    Add-Content -Path "C:\Temp\Long_Log_File_Location_filtered.txt" -Value $line
  }
}
