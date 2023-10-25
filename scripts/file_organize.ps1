$productPath = "C:\Users\ñ{éRïêï∂\workspace\å√âÕêªçÏèä\koga-db\honsha\sqls\product"

Write-Host "Organizing sql files..."
Get-ChildItem -Path $productPath -Directory | ForEach-Object {
    Write-Host "Organizing dir: $_"
    $baseName = $_.Name
    $i = 0;
    Get-ChildItem -Path "$productPath\$baseName" | ForEach-Object {
        if ($_.Name -eq "$baseName.sql") {
            Remove-Item $_.FullName
        } else {
            Rename-Item -Path $_.FullName -NewName "$productpath\$basename\$i.sql"
            $i += 1;
        }
    }
}
