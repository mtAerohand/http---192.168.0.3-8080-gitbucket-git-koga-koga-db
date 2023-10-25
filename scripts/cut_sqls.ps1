param (
    [string]$originalSqlsPath = "C:\Users\本山武文\workspace\古河製作所\koga-db\honsha\sqls\original_sqls"
)

Write-Host "Dividing sql files..."
Get-ChildItem -Path $originalSqlPath -Directory | ForEach-Object {
    $baseName = $_.Name
    $filePath = "$originalSqlPath\$baseName\$baseName.sql"
    Write-Host "Dividing file: $filePath"

    $sections = Get-Content -Path $filePath -Delimiter "`r`n`r`n"

    for ($i = 0; $i -lt $sections.Count; $i++) {
        $section = $sections[$i]
        
        $fileName = "$originalSqlPath\$baseName\$basename" + "_" + "$i.sql"
        Write-Host "    to: $fileName"
        
        $section | Set-Content -Path $fileName -Encoding UTF8
    }
}
