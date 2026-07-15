-- 目的：证明分析层与已记录的过滤规则一致。
-- Purpose: prove that the analytical layer matches the documented filters.

USE ecommerce_analysis;
SET time_zone = '+08:00';

WITH staging_counts AS (
    SELECT
        COUNT(*) AS raw_rows,
        SUM(behavior_timestamp >= 1511539200
            AND behavior_timestamp < 1512316800
            AND behavior_type IN ('pv', 'fav', 'cart', 'buy'))
            AS expected_analytical_rows,
        SUM(NOT (
            behavior_timestamp >= 1511539200
            AND behavior_timestamp < 1512316800
            AND behavior_type IN ('pv', 'fav', 'cart', 'buy')
        )) AS excluded_rows
    FROM stg_user_behavior
), analytical_counts AS (
    SELECT COUNT(*) AS actual_analytical_rows
    FROM user_behavior
)
SELECT
    raw_rows,
    expected_analytical_rows,
    actual_analytical_rows,
    excluded_rows,
    expected_analytical_rows - actual_analytical_rows AS row_difference,
    CASE
        WHEN expected_analytical_rows = actual_analytical_rows THEN 'PASS'
        ELSE 'FAIL'
    END AS reconciliation_status
FROM staging_counts
CROSS JOIN analytical_counts;

-- 确认派生时间字段与 UTC+8 下的 epoch 一致。
-- Confirm derived time columns agree with the epoch in UTC+8.
SELECT
    SUM(behavior_datetime <> FROM_UNIXTIME(behavior_timestamp))
        AS mismatched_datetime_rows,
    SUM(behavior_date <> DATE(behavior_datetime)) AS mismatched_date_rows,
    SUM(behavior_hour <> HOUR(behavior_datetime)) AS mismatched_hour_rows,
    SUM(behavior_type NOT IN ('pv', 'fav', 'cart', 'buy'))
        AS invalid_behavior_rows,
    SUM(behavior_timestamp < 1511539200
        OR behavior_timestamp >= 1512316800) AS out_of_window_rows
FROM user_behavior;
