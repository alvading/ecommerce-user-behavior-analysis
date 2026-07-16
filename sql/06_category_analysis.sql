-- 淘宝母婴交易分析：一级与细分类目结构
-- Taobao maternal and infant analysis: top-level and detailed categories
-- MySQL 9.7.1；已完成实际执行与结果验证。
-- MySQL 9.7.1; executed and validated.

USE mum_baby_analysis;

-- 1. 一级品类规模、全局占比和品类内部敏感性。
-- 1. Top-category scale, portfolio share, and within-category sensitivity.
WITH category_summary AS (
    SELECT
        cat1,
        COUNT(*) AS trade_row_count,
        COUNT(DISTINCT user_id) AS purchasing_user_count,
        COUNT(DISTINCT auction_id) AS auction_count,
        COUNT(DISTINCT cat_id) AS detailed_category_count,
        SUM(buy_amount) AS total_units,
        SUM(CASE WHEN buy_amount < 100 THEN buy_amount ELSE 0 END)
            AS units_lt_100,
        SUM(CASE WHEN buy_amount >= 100 THEN buy_amount ELSE 0 END)
            AS units_ge_100,
        SUM(CASE WHEN buy_amount >= 100 THEN 1 ELSE 0 END)
            AS high_quantity_row_count
    FROM fact_trade
    GROUP BY cat1
)
SELECT
    *,
    ROUND(100.0 * trade_row_count / SUM(trade_row_count) OVER (), 2)
        AS trade_row_share_pct,
    ROUND(100.0 * total_units / SUM(total_units) OVER (), 2)
        AS total_unit_share_pct,
    ROUND(100.0 * units_lt_100 / SUM(units_lt_100) OVER (), 2)
        AS units_lt_100_share_pct,
    ROUND(100.0 * units_ge_100 / NULLIF(total_units, 0), 2)
        AS high_quantity_unit_share_within_category_pct
FROM category_summary
ORDER BY trade_row_count DESC;

-- 2. 2013→2014 一级品类增长及对整体交易行增长的贡献。
-- 2. Top-category growth and contribution to overall row growth, 2013–2014.
WITH category_yearly_summary AS (
    SELECT
        YEAR(trade_date) AS trade_year,
        cat1,
        COUNT(*) AS trade_row_count,
        SUM(buy_amount) AS total_units,
        SUM(CASE WHEN buy_amount < 100 THEN buy_amount ELSE 0 END)
            AS units_lt_100
    FROM fact_trade
    WHERE YEAR(trade_date) IN (2013, 2014)
    GROUP BY YEAR(trade_date), cat1
), category_comparison AS (
    SELECT
        cat1,
        MAX(CASE WHEN trade_year = 2013 THEN trade_row_count END)
            AS trade_rows_2013,
        MAX(CASE WHEN trade_year = 2014 THEN trade_row_count END)
            AS trade_rows_2014,
        MAX(CASE WHEN trade_year = 2013 THEN total_units END)
            AS total_units_2013,
        MAX(CASE WHEN trade_year = 2014 THEN total_units END)
            AS total_units_2014,
        MAX(CASE WHEN trade_year = 2013 THEN units_lt_100 END)
            AS units_lt_100_2013,
        MAX(CASE WHEN trade_year = 2014 THEN units_lt_100 END)
            AS units_lt_100_2014
    FROM category_yearly_summary
    GROUP BY cat1
)
SELECT
    *,
    trade_rows_2014 - trade_rows_2013 AS trade_row_increase,
    ROUND(100.0 * (trade_rows_2014 - trade_rows_2013)
        / NULLIF(trade_rows_2013, 0), 2) AS trade_row_growth_pct,
    ROUND(100.0 * (trade_rows_2014 - trade_rows_2013)
        / NULLIF(SUM(trade_rows_2014 - trade_rows_2013) OVER (), 0), 2)
        AS contribution_to_trade_row_growth_pct,
    ROUND(100.0 * (total_units_2014 - total_units_2013)
        / NULLIF(total_units_2013, 0), 2) AS total_unit_growth_pct,
    ROUND(100.0 * (units_lt_100_2014 - units_lt_100_2013)
        / NULLIF(units_lt_100_2013, 0), 2) AS units_lt_100_growth_pct
FROM category_comparison
ORDER BY trade_row_increase DESC;

-- 3. 细分类目 Top 10。cat_id 与 cat1 的映射已验证为一对一。
-- 3. Detailed-category Top 10. cat_id-to-cat1 mapping is validated one-to-one.
WITH detailed_category_summary AS (
    SELECT
        cat1,
        cat_id,
        COUNT(*) AS trade_row_count,
        COUNT(DISTINCT user_id) AS purchasing_user_count,
        COUNT(DISTINCT auction_id) AS auction_count,
        SUM(buy_amount) AS total_units,
        SUM(CASE WHEN buy_amount < 100 THEN buy_amount ELSE 0 END)
            AS units_lt_100,
        SUM(CASE WHEN buy_amount >= 100 THEN buy_amount ELSE 0 END)
            AS units_ge_100,
        SUM(CASE WHEN buy_amount >= 100 THEN 1 ELSE 0 END)
            AS high_quantity_row_count
    FROM fact_trade
    GROUP BY cat1, cat_id
)
SELECT
    *,
    ROUND(100.0 * trade_row_count / SUM(trade_row_count) OVER (), 2)
        AS trade_row_share_pct,
    ROUND(100.0 * units_ge_100 / NULLIF(total_units, 0), 2)
        AS high_quantity_unit_share_pct
FROM detailed_category_summary
ORDER BY trade_row_count DESC
LIMIT 10;

-- 4. 累计80%贡献所需的细分类目数（Pareto/长尾检验）。
-- 4. Number of detailed categories required for 80% cumulative contribution.
WITH detailed_category_summary AS (
    SELECT
        cat1,
        cat_id,
        COUNT(*) AS trade_row_count,
        SUM(CASE WHEN buy_amount < 100 THEN buy_amount ELSE 0 END)
            AS units_lt_100
    FROM fact_trade
    GROUP BY cat1, cat_id
), category_ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY trade_row_count DESC, cat1, cat_id)
            AS trade_row_rank,
        SUM(trade_row_count) OVER (
            ORDER BY trade_row_count DESC, cat1, cat_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_trade_rows,
        SUM(trade_row_count) OVER () AS all_trade_rows,
        ROW_NUMBER() OVER (ORDER BY units_lt_100 DESC, cat1, cat_id)
            AS sensitivity_unit_rank,
        SUM(units_lt_100) OVER (
            ORDER BY units_lt_100 DESC, cat1, cat_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_sensitivity_units,
        SUM(units_lt_100) OVER () AS all_sensitivity_units
    FROM detailed_category_summary
)
SELECT
    COUNT(*) AS detailed_category_count,
    MIN(CASE WHEN cumulative_trade_rows / all_trade_rows >= 0.80
        THEN trade_row_rank END) AS categories_for_80pct_trade_rows,
    MIN(CASE WHEN cumulative_sensitivity_units / all_sensitivity_units >= 0.80
        THEN sensitivity_unit_rank END)
        AS categories_for_80pct_sensitivity_units
FROM category_ranked;

