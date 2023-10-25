param (
    [string]$dirPath
)

$homePath = "./sqls"
$javaPath = "./sqls/java"
$classPath = "./sqls/class"
$sqlPath = "./sqls/sql"
$productPath = "./sqls/product"

new-item -Path $homePath -ItemType Directory -Force
new-item -Path $javaPath -ItemType Directory -Force
new-item -Path $classPath -ItemType Directory -Force
new-item -Path $sqlPath -ItemType Directory -Force
new-item -Path $productPath -ItemType Directory -Force

function Generate-Java-File {
    param (
        [string]$filePath
    )

    $javaCode = Get-Content -Encoding UTF8 $filePath -Raw
    # Write-Host $javaCode
    $pattern = '(?ms)(\s?private.*?)(public|@Context|@Path)'
    $match = [regex]::Match($javaCode, $pattern)

    if ($match.Success) {
        Write-Host "Matched!"
        $fileName = [System.IO.Path]::GetFileNameWithoutExtension($filePath)
        $sqlString = $match.Groups[1].Value -replace '\\"', ''

        "import java.lang.reflect.Field;
        public class $filename { 
            $sqlString
            public static String concatenatePrivateStringFields(Object instance) {
                Class<?> clazz = instance.getClass();
                Field[] fields = clazz.getDeclaredFields();
                StringBuilder concatenatedString = new StringBuilder();

                for (Field field : fields) {
                    if (field.getType().equals(String.class) && (field.getModifiers() & java.lang.reflect.Modifier.PRIVATE) != 0) {
                        try {
                            field.setAccessible(true);
                            String fieldValue = ((String) field.get(instance)).trim().replaceAll(`"\\s+`", `" `");
                            if (fieldValue != null) {
                                concatenatedString.append(`"-- `" + field.getName() + '\n' + fieldValue + '\n');
                            }
                        } catch (IllegalAccessException e) {
                            e.printStackTrace();
                        }
                    }
                }

                return concatenatedString.toString();
            }

            public static void main(String[] args) {
                $fileName instance = new $fileName();
                String concatenated = concatenatePrivateStringFields(instance);
                System.out.println(concatenated); 
            }
        }" | ForEach-Object{ [Text.Encoding]::UTF8.GetBytes($_) } | Set-Content -Encoding Byte -Path "$javaPath/$fileName.java"
    }
}

Write-Host "Generating java Files..."
Get-ChildItem -Path $dirPath | ForEach-Object {
    $fileName = $_.FullName
    Write-Host "Processing file: $fileName"
    Generate-Java-File -filePath $fileName
}

Write-Host "Generating class Files..."
Get-ChildItem -Path $javaPath | ForEach-Object {
    $fileName = $_.FullName
    Write-Host "Compiling file: $fileName"
    javac -d $classPath $fileName -encoding UTF-8
}

Write-Host "Generating sql Files..." 
Get-ChildItem -Path $classPath | ForEach-Object {
    $fileName = $_.FullName
    $className = [System.IO.Path]::GetFileNameWithoutExtension($_)
    Write-Host "Executing file: $fileName"
    java -classpath $classPath $className | Set-Content -Encoding UTF8 -Path "$sqlPath/$className.sql"
}

Write-Host "Generating production Dir and Files..."
Get-ChildItem -Path $sqlPath | ForEach-Object {
    $fileName = $_.FullName
    $className = [System.IO.Path]::GetFileNameWithoutExtension($_)
    Write-Host "Generating Dir and Files: $className"
    new-item -Path "$productPath/$className" -ItemType Directory -Force
    Copy-Item -Path $filename -Destination "$productPath/$className" -Force
}