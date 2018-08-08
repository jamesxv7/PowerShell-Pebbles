# Append string to top of a text file
$Path = 'C:\Users\IronMan\Documents\Data\Sample'

# Filter files to get only CSV
$FilesCollection = Get-ChildItem $Path -recurse -Filter *.csv

$Output = 'C:\Users\IronMan\Documents\Data\Sample\Updated\'

foreach($File in $FilesCollection) {
  Write-Output $file.FullName
  $Content = Get-Content $file.FullName
  $Output = $Output+'Updated_'+$file.Name
  Set-Content $Output -Value "Header Example or Data Description Here", $content
}
