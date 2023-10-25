koga-db
===============

# 構成

- /scripts: sql抽出・整理用に使用するスクリプト保存先
- honsha: 本社システム側の作業ディレクトリ
  - /sqls: sqlデータ保存先
    - /new_sqls: 新システム用に更新したsqlの保存先
    - /original_sqls: 旧システムのsqlの保存先
    - /sql_components: 旧システムのsqlを構成する部品の保存先

# generate_new_sql.ps1の使用方法

1. 抽出したsql文を一文ごとにファイルに分割し、抽出元ファイルごとにフォルダにまとめる

    ex\)

   ~~~txt
   /C10/0.sql
        1.sql
        ...    # C10.javaから抽出したsql
    C20/0.sql
        1.sql
        ...    # C20.javaから抽出したsql
    ...
   ~~~

2. 更新したsqlの保存先となるディレクトリを作成

   ex\)

   ~~~txt
    honsha/sqls/new_sqls/
   ~~~

3. PowerShell Core(Windows PowerShellは不可)で以下を実行する。inputDireは手順1のルート、outputDirは手順2で作成したディレクトリ、excelFilePathはローカルに保存したテーブル定義書へのパスを指定

    ~~~PowerShell
    PS C:\your\currentDir> path/to/generate_new_sql.ps1 -inputDir path/to/inputDir -outputDir path/to/outputDir -excelFilePath path/to/excelFile -Encoding UTF8
    ~~~