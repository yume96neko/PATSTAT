-- 後方引用
SELECT
    -- SLAM 特許（引用した側）
    pp_slam.appln_id AS slam_appln_id,
    t_slam.appln_title AS slam_title,
    a_slam.appln_filing_year AS slam_filing_year,
    pp_slam.pat_publn_id AS slam_publn_id,

    -- 引用された特許（引用先）
    pp_cited.appln_id AS cited_appln_id,
    t_cited.appln_title AS cited_title,
    a_cited.appln_auth AS cited_auth,
    a_cited.appln_filing_year AS cited_filing_year,
    pp_cited.pat_publn_id AS cited_publn_id

FROM tls203_appln_abstr ab
JOIN tls211_pat_publn pp_slam
    ON pp_slam.appln_id = ab.appln_id                    -- SLAM appln → publn

JOIN tls212_citation c
    ON c.pat_publn_id = pp_slam.pat_publn_id             -- SLAM が引用した citation

JOIN tls211_pat_publn pp_cited
    ON pp_cited.pat_publn_id = c.cited_pat_publn_id      -- 引用された側 pub → appln

-- タイトル・基本情報（SLAM側）
JOIN tls202_appln_title t_slam
    ON t_slam.appln_id = pp_slam.appln_id
JOIN tls201_appln a_slam
    ON a_slam.appln_id = pp_slam.appln_id

-- タイトル・基本情報（引用された側）
JOIN tls202_appln_title t_cited
    ON t_cited.appln_id = pp_cited.appln_id
JOIN tls201_appln a_cited
    ON a_cited.appln_id = pp_cited.appln_id

WHERE ab.appln_abstract LIKE '%SLAM%';


-- 前方引用
SELECT
    pp_slam.appln_id AS slam_appln_id,              -- SLAM特許 appln_id
    t_slam.appln_title AS slam_title,
    a_slam.appln_filing_year AS slam_filing_year,
    pp_slam.pat_publn_id AS slam_publn_id,

    pp_citing.appln_id AS citing_appln_id,          -- 引用した特許 appln_id
    t_citing.appln_title AS citing_title,
    a_citing.appln_auth AS citing_auth,
    a_citing.appln_filing_year AS citing_filing_year,
    pp_citing.pat_publn_id AS citing_publn_id

FROM tls203_appln_abstr ab
JOIN tls211_pat_publn pp_slam
    ON pp_slam.appln_id = ab.appln_id               -- SLAM appln → publn

JOIN tls212_citation c
    ON c.cited_pat_publn_id = pp_slam.pat_publn_id  -- 他特許が SLAM pub を引用

JOIN tls211_pat_publn pp_citing
    ON pp_citing.pat_publn_id = c.pat_publn_id      -- citing側 pub → appln

-- SLAM 側 基本情報・タイトル
JOIN tls201_appln a_slam
    ON a_slam.appln_id = pp_slam.appln_id
JOIN tls202_appln_title t_slam
    ON t_slam.appln_id = pp_slam.appln_id

-- 引用した側 基本情報・タイトル
JOIN tls201_appln a_citing
    ON a_citing.appln_id = pp_citing.appln_id
JOIN tls202_appln_title t_citing
    ON t_citing.appln_id = pp_citing.appln_id

WHERE ab.appln_abstract LIKE '%SLAM%';
