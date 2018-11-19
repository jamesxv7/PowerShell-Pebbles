$fso = Get-ChildItem -Recurse -path "C:\fso"
$fsoBU = Get-ChildItem -Recurse -path "C:\fso_BackUp"
Compare-Object -ReferenceObject $fso -DifferenceObject $fsoBU
