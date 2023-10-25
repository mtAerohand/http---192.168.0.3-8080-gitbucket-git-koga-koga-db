-- SQL_REPORT
SELECT a.SeqNo, a.図面種類, a.品番, COALESCE(c.品名,'') AS 品名, a.設変番号, a.新設変番号, a.返却希望日, a.備考, b.作業区コード, COALESCE(d.作業区名,'') AS 作業区名 FROM T_図面 AS a INNER JOIN T_図面詳細 AS b ON b.SeqNo = a.SeqNo AND b.返却日 IS NULL LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 LEFT OUTER JOIN M_作業区仕入先 AS d ON d.作業区コード = b.作業区コード WHERE a.SeqNo = ? AND a.出力有無 = true ORDER BY b.工程順序No


