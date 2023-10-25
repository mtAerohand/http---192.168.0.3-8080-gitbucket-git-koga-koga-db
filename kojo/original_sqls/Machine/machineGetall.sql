GET_ALL_LIST =
SELECT KI.作業区コード,KI.機械コード,KI.機械名,KI.担当コード,TA.担当名,KI.表示順,KI.有効開始日,KI.有効終了日 
FROM M_機械 AS KI 
LEFT OUTER JOIN M_担当 AS TA ON KI.作業区コード = TA.作業区コード AND KI.担当コード = TA.担当コード 
WHERE KI.作業区コード = ? 
ORDER BY KI.表示順,KI.機械コード;