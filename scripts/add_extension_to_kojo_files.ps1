$kojoPath = "C:\Users\本山武文\workspace\古河製作所\koga-db\kojo"

function Add-Extension {
    param ([string]$dirPath)

    Get-ChildItem -Path $dirPath | ForEach-Object {
        if ($_.PSIsContainer) {
            Add-Extension -dirPath $_
        } else {
            Rename-Item -Path $_ -NewName "$_.sql"
        }
    }
}

Add-Extension -dirPath $kojoPath