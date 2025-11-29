-- 後方引用
SELECT
		*
FROM(
		SELECT
        		pat_publn_id,
        		cited_appln_id        
		FROM tls212_citation
) c
JOIN(
		SELECT
        		pat_publn_id,
                appln_id
        FROM tls211_pat_publn
) pp ON pp.pat_publn_id = c.pat_publn_id
JOIN(
		SELECT
        		appln_id,
                appln_abstract
        FROM tls203_appln_abstr
) ab ON ab.appln_id = c.cited_appln_id
WHERE ab.appln_abstract LIKE '%SLAM%';

-- 前方引用
SELECT
		*
FROM(
		SELECT
        	cited_appln_id,	
			pat_publn_id        		        
		FROM tls212_citation
) c
JOIN(
		SELECT
        		pat_publn_id,
                appln_id
        FROM tls211_pat_publn
) pp ON pp.pat_publn_id = c.pat_publn_id
JOIN(
		SELECT
        		appln_id,
                appln_abstract
        FROM tls203_appln_abstr
) ab ON ab.appln_id = pp.appln_id
WHERE ab.appln_abstract LIKE '%SLAM%';

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
