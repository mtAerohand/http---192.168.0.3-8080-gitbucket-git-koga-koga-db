-- SQL_SELECT
SELECT a.SeqNo ,b.受注番号 ,b.枝番 ,b.品番 ,b.設変番号 ,a.箱No ,a.入数 ,a.出荷数 ,a.印刷日 ,a.現品票バーコード番号 ,c.送信データ作成日 ,a.バージョン番号
-- SQL_SELECT_COUNT
SELECT CAST(COUNT(a.SeqNo) AS INT)
-- SQL_WHERE
FROM T_現品票 AS a INNER JOIN T_受注 AS b ON b.管理No = a.管理No LEFT OUTER JOIN ( SELECT データSeqNo ,MAX(送信データ作成日) AS 送信データ作成日 FROM T_SMC送信 WHERE データ分類コード = 1 GROUP BY データSeqNo ) AS c ON c.データSeqNo = a.SeqNo WHERE a.有効区分 = false AND a.印刷日 BETWEEN CAST(? as DATE) AND CAST(? as DATE)
-- SQL_WHERE_OPTION1
AND c.送信データ作成日 IS NULL
-- SQL_WHERE_OPTION2
AND b.受注番号 &@ ? AND LENGTH(b.受注番号) = LENGTH(?)
-- SQL_ORDER_BY
ORDER BY a.現品票バーコード番号
-- SQL_MULTIPLE
SELECT CAST(値 as INT) FROM M_パラメータ WHERE Key1 = CAST(? AS INT) AND Key2 = ? AND Key3 = ?
-- TMP_DIR
tmp

