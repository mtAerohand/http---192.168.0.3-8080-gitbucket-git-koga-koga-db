param(
  [String]$in = "C:\Users\本山武文\workspace\古河製作所\本番コード\honsha\SQL\servlet",
  [String]$out = "C:\Users\本山武文\workspace\古河製作所\koga-db\honsha\sqls\old_sql",
  [String]$from = "Shift-JIS",
  [String]$to = "UTF-8"
)

$enc_f = [Text.Encoding]::GetEncoding($from)
$enc_t = [Text.Encoding]::GetEncoding($to)
Get-ChildItem $in -recurse |
ForEach-Object {
  if($_.GetType().Name -eq "FileInfo"){
    $reader = New-Object IO.StreamReader($_.FullName, $enc_f)
    $o_path = $_.FullName.ToLower().Replace($in.ToLower(), $out)
    $o_folder = Split-Path $o_path -parent
    if(!(Test-Path $o_folder)){
      [Void][IO.Directory]::CreateDirectory($o_folder)
    }
    $writer = New-Object IO.StreamWriter($o_path, $false, $enc_t)
    while(!$reader.EndOfStream){$writer.WriteLine($reader.ReadLine())}
    $reader.Close()
    $writer.Close()
  }
}