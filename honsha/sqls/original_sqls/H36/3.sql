-- SQL_GET_SELECT
SELECT a.SeqNo ,a.図面種類 ,a.得意先コード ,COALESCE(b.得意先名,'') AS 得意先名 ,a.通知日 ,a.設変管理No ,a.品番 ,a.設変番号 ,COALESCE(c.品名,'') AS 品名 ,a.新設変番号 ,a.作業指示区分 ,a.仕掛品対処区分 ,a.備考 ,a.出力有無 ,a.返却希望日 ,a.バージョン番号 ,d.工程順序No ,d.作業区コード ,COALESCE(e.作業区略称,'') AS 作業区名 ,d.返却日 ,d.バージョン番号 AS 詳細バージョン番号 FROM T_図面 AS a LEFT OUTER JOIN M_得意先 AS b ON b.得意先コード = a.得意先コード LEFT OUTER JOIN M_部品 AS c ON c.品番 = a.品番 LEFT OUTER JOIN T_図面詳細 AS d ON d.SeqNo = a.SeqNo LEFT OUTER JOIN M_作業区仕入先 AS e ON e.作業区コード = d.作業区コード WHERE a.SeqNo = CAST(? as INT) ORDER BY d.工程順序No


