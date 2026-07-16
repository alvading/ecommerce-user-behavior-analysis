-- 淘宝母婴交易分析：匹配子样本的人口属性补充分析
-- Taobao maternal and infant analysis: matched-subsample demographic supplement
-- MySQL 9.7.1；已完成实际执行与结果验证。
-- MySQL 9.7.1; executed and validated.

USE mum_baby_analysis;

-- 1. 出生日期与交易日期关系审计。
-- 1. Audit the relationship between birth date and trade date.
WITH matched_sample AS (
    SELECT
        f.trade_row_id,
        f.user_id,
        f.trade_date,
        f.buy_amount,
        b.birthday,
        b.gender,
        TIMESTAMPDIFF(MONTH, b.birthday, f.trade_date) AS months_from_birth
    FROM fact_trade AS f
    INNER JOIN dim_baby AS b ON f.user_id = b.user_id
)
SELECT
    CASE
        WHEN months_from_birth < -10 THEN '01_before_plausible_prenatal'
        WHEN months_from_birth < 0 THEN '02_possible_prenatal'
        WHEN months_from_birth < 12 THEN '03_age_0_11_months'
        WHEN months_from_birth < 24 THEN '04_age_12_23_months'
        WHEN months_from_birth < 36 THEN '05_age_24_35_months'
        WHEN months_from_birth < 72 THEN '06_age_36_71_months'
        ELSE '07_age_72_plus_months'
    END AS purchase_stage,
    COUNT(*) AS trade_row_count,
    COUNT(DISTINCT user_id) AS user_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS trade_row_share_pct
FROM matched_sample
GROUP BY purchase_stage
ORDER BY purchase_stage;

-- 2. 合理分析窗口内的阶段分布。边界是敏感性假设，不是删除规则。
-- 2. Stage distribution within the plausible analytical window; no rows deleted.
WITH matched_sample AS (
    SELECT
        f.trade_row_id,
        f.user_id,
        f.buy_amount,
        TIMESTAMPDIFF(MONTH, b.birthday, f.trade_date) AS months_from_birth
    FROM fact_trade AS f
    INNER JOIN dim_baby AS b ON f.user_id = b.user_id
), plausible_age_sample AS (
    SELECT
        *,
        CASE
            WHEN months_from_birth < 0 THEN '01_possible_prenatal'
            WHEN months_from_birth < 12 THEN '02_age_0_11_months'
            WHEN months_from_birth < 24 THEN '03_age_12_23_months'
            WHEN months_from_birth < 36 THEN '04_age_24_35_months'
            ELSE '05_age_36_71_months'
        END AS purchase_stage
    FROM matched_sample
    WHERE months_from_birth >= -10
      AND months_from_birth < 72
), stage_summary AS (
    SELECT
        purchase_stage,
        COUNT(*) AS trade_row_count,
        COUNT(DISTINCT user_id) AS user_count,
        SUM(buy_amount) AS total_units,
        SUM(CASE WHEN buy_amount < 100 THEN buy_amount ELSE 0 END)
            AS units_lt_100
    FROM plausible_age_sample
    GROUP BY purchase_stage
)
SELECT
    *,
    ROUND(100.0 * trade_row_count / SUM(trade_row_count) OVER (), 2)
        AS trade_row_share_pct,
    ROUND(1.0 * units_lt_100 / NULLIF(trade_row_count, 0), 2)
        AS avg_sensitivity_units_per_trade_row
FROM stage_summary
ORDER BY purchase_stage;

-- 3. 性别概览：0=男孩、1=女孩、2=未知。
-- 3. Gender overview: 0=boy, 1=girl, 2=unknown.
WITH gender_summary AS (
    SELECT
        b.gender,
        COUNT(DISTINCT f.user_id) AS user_count,
        COUNT(*) AS trade_row_count,
        SUM(f.buy_amount) AS total_units,
        SUM(CASE WHEN f.buy_amount < 100 THEN f.buy_amount ELSE 0 END)
            AS units_lt_100,
        SUM(CASE WHEN f.buy_amount >= 100 THEN f.buy_amount ELSE 0 END)
            AS units_ge_100
    FROM fact_trade AS f
    INNER JOIN dim_baby AS b ON f.user_id = b.user_id
    GROUP BY b.gender
)
SELECT
    CASE gender WHEN 0 THEN 'Boy' WHEN 1 THEN 'Girl' ELSE 'Unknown' END
        AS baby_gender,
    *,
    ROUND(100.0 * user_count / SUM(user_count) OVER (), 2) AS user_share_pct,
    ROUND(1.0 * units_lt_100 / NULLIF(trade_row_count, 0), 2)
        AS avg_sensitivity_units_per_trade_row,
    ROUND(100.0 * units_ge_100 / NULLIF(total_units, 0), 2)
        AS high_quantity_unit_share_pct
FROM gender_summary
ORDER BY gender;

-- 4. 男女婴组内一级品类构成；使用组内占比控制样本量差异。
-- 4. Within-gender top-category mix, controlling for group-size differences.
WITH gender_category_summary AS (
    SELECT
        b.gender,
        f.cat1,
        COUNT(*) AS trade_row_count,
        SUM(CASE WHEN f.buy_amount < 100 THEN f.buy_amount ELSE 0 END)
            AS units_lt_100
    FROM fact_trade AS f
    INNER JOIN dim_baby AS b ON f.user_id = b.user_id
    WHERE b.gender IN (0, 1)
    GROUP BY b.gender, f.cat1
)
SELECT
    CASE gender WHEN 0 THEN 'Boy' ELSE 'Girl' END AS baby_gender,
    cat1,
    trade_row_count,
    units_lt_100,
    ROUND(100.0 * trade_row_count
        / SUM(trade_row_count) OVER (PARTITION BY gender), 2)
        AS trade_row_share_within_gender_pct,
    ROUND(100.0 * units_lt_100
        / SUM(units_lt_100) OVER (PARTITION BY gender), 2)
        AS sensitivity_unit_share_within_gender_pct
FROM gender_category_summary
ORDER BY gender, trade_row_count DESC;

