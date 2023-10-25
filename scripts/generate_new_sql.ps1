# $inputDir内で一文ごとに分割されたsqlファイルに対して、テーブル名、カラム名を新規のものに更新してoutputDirに保存する

param (
    [string]$inputDir = "C:\Users\本山武文\workspace\古河製作所\koga-db\honsha\sqls\original_sqls",
    [string]$outputDir = "C:\Users\本山武文\workspace\古河製作所\koga-db\honsha\sqls\new_sqls",
    [string]$excelFilePath = "C:\Users\本山武文\workspace\古河製作所\koga-db\scripts\テーブル定義書.xlsx"
)

Install-Module -Name ImportExcel

$tableNamesData = Import-Excel -Path $excelFilePath -WorksheetName "カラム一覧（本社・工場）" -StartRow 1 -EndRow 62 -StartColumn 9 -EndColumn 10 
$tableNamesData | ForEach-Object {
    $_ | Add-Member -Name "length" -Value $_.テーブル名.Length -MemberType NoteProperty
}
$tableNamesData = $tableNamesData | Sort-Object -Property {$_.length} -Descending

$columnNamesData = Import-Excel -Path $excelFilePath -WorksheetName "カラム一覧（本社・工場）" -StartRow 1 -EndRow 366 -StartColumn 14 -EndColumn 15 
$columnNamesData | ForEach-Object {
    $_ | Add-Member -Name "length" -Value $_.カラム物理名.Length -MemberType NoteProperty
}
$columnNamesData = $columnNamesData | Sort-Object -Property {$_.length} -Descending

$dataTypesData = Import-Excel -Path $excelFilePath -WorksheetName "カラム一覧（本社・工場）" -StartRow 1 -EndRow 51 -StartColumn 19 -EndColumn 20 
$dataTypesData | ForEach-Object {
    $_ | Add-Member -Name "length" -Value $_.データ型.Length -MemberType NoteProperty
}
$dataTypesData = $dataTypesData | Sort-Object -Property {$_.length} -Descending

Get-ChildItem -Path $inputDir -Directory | ForEach-Object {
    $dirName = $_.Name
    Write-Host "Processing Dir: $inputDir\$dirName"
    New-Item -Path "$outputDir\$dirName" -ItemType Directory -Force
    Get-ChildItem -Path "$inputDir\$dirName" | ForEach-Object {
        $fileName = $_.Name
        $filePath = $_.FullName;
        $file_content = Get-Content -Path $filePath
        foreach ($row in $tableNamesData) {
            $wordToReplace = $row."テーブル名"
            $replacementWord = $row."MySQL移行後"
            $file_content = $file_content -replace $wordToReplace, $replacementWord
        }
        foreach ($row in $columnNamesData) {
            $wordToReplace = $row."カラム物理名"
            $replacementWord = $row."MySQL移行後"
            $file_content = $file_content -replace $wordToReplace, $replacementWord
        }
        foreach ($row in $dataTypesData) {
            $wordToReplace = $row."データ型"
            $replacementWord = $row."MySQL移行後"
            $file_content = $file_content -replace $wordToReplace, $replacementWord
        }
        $file_content | Out-File -FilePath "$outputDir\$dirName\$fileName" -Encoding utf8NoBOM
        Write-Host "Generated file: $outputDir\$dirName\$fileName"
    }
}