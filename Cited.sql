SELECT
	*
FROM(
	SELECT
    	appln_id,
        docdb_family_id,
        inpadoc_family_id,
        docdb_family_size
	FROM	tls201_appln
)	a
JOIN tls202_appln_title t ON a.appln_id = t.appln_id
JOIN(
	SELECT
        cited_appln_id,
        pat_citn_seq_nr
    FROM tls212_citation
) c ON a.appln_id = c.cited_appln_id
JOIN tls203_appln_abstr ab ON ab.appln_id = c.cited_appln_id
WHERE ab.appln_abstract LIKE '%SLAM%';

SELECT DISTINCT
    a.appln_id,              -- この特許（TLS201）
    c.cited_appln_id,        -- 追加：被引用特許
    a.docdb_family_id,
    a.inpadoc_family_id,
    a.docdb_family_size,
    t.appln_title,
    ab.appln_abstract,
    c.pat_citn_seq_nr
FROM tls201_appln a
JOIN tls202_appln_title t 
    ON a.appln_id = t.appln_id
JOIN tls212_citation c 
    ON a.appln_id = c.cited_appln_id
JOIN tls203_appln_abstr ab 
    ON ab.appln_id = c.cited_appln_id
WHERE ab.appln_abstract LIKE '%SLAM%';
