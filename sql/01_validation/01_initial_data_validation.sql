-- 目的：应用清洗规则前，对原始暂存表进行数据画像。
-- Purpose: profile the raw staging table before applying cleaning rules.
-- MySQL 8.x。导入 stg_user_behavior 后执行。
-- MySQL 8.x. Run after importing stg_user_behavior.

USE ecommerce_analysis;
SET time_zone = '+08:00';

-- 1. 数据量、键基数与原始时间戳边界 | Volume, key cardinality, and raw timestamp boundaries
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT userid) AS distinct_users,
    COUNT(DISTINCT itemid) AS distinct_items,
    COUNT(DISTINCT categoryid) AS distinct_categories,
    MIN(behavior_timestamp) AS min_timestamp,
    MAX(behavior_timestamp) AS max_timestamp
FROM stg_user_behavior;

-- 2. 行为值域检查。四种预期类型之外的值均视为无效，必须调查。
-- Behavior-domain check. Any value outside the four expected types is invalid
-- and must be investigated.
SELECT
    behavior_type,
    COUNT(*) AS event_rows,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 4) AS event_share_pct
FROM stg_user_behavior
GROUP BY behavior_type
ORDER BY event_rows DESC;

-- 3. 空值检查。当前表结构拒绝空值，因此此查询也用于验证表结构约束。
-- Null check. The current table definition rejects nulls, so this also serves
-- as a schema assertion.
SELECT
    SUM(userid IS NULL) AS null_userid,
    SUM(itemid IS NULL) AS null_itemid,
    SUM(categoryid IS NULL) AS null_categoryid,
    SUM(behavior_type IS NULL) AS null_behavior_type,
    SUM(behavior_timestamp IS NULL) AS null_behavior_timestamp
FROM stg_user_behavior;

-- 4. 完全重复画像。duplicate_rows_to_remove 表示首条记录之外的多余副本；
-- 本查询不会自动删除任何记录。
-- Exact duplicate profile. duplicate_rows_to_remove reports excess copies
-- beyond the first occurrence; no rows are removed automatically.
SELECT
    COUNT(*) AS duplicated_event_groups,
    COALESCE(SUM(event_copies - 1), 0) AS duplicate_rows_to_remove
FROM (
    SELECT COUNT(*) AS event_copies
    FROM stg_user_behavior
    GROUP BY userid, itemid, categoryid, behavior_type, behavior_timestamp
    HAVING COUNT(*) > 1
) AS duplicates;

-- 5. 使用固定 epoch 边界核对观察窗口 | Observation-window reconciliation using fixed epoch boundaries
-- 1511539200 = 2017-11-25 00:00:00 UTC+8
-- 1512316800 = 2017-12-04 00:00:00 UTC+8
SELECT
    SUM(behavior_timestamp < 1511539200) AS rows_before_window,
    SUM(behavior_timestamp >= 1511539200
        AND behavior_timestamp < 1512316800) AS rows_in_window,
    SUM(behavior_timestamp >= 1512316800) AS rows_after_window,
    COUNT(*) AS total_rows
FROM stg_user_behavior;

-- 6. 声明窗口附近的每日分布。先限制 epoch 范围，避免极端异常值转换为 NULL
-- 或依赖平台的日期。
-- Daily distribution near the declared window. Guard the conversion so
-- extreme anomalous epochs do not become NULL or platform-dependent dates.
SELECT
    DATE(FROM_UNIXTIME(behavior_timestamp)) AS behavior_date,
    COUNT(*) AS event_rows
FROM stg_user_behavior
WHERE behavior_timestamp >= 1511280000  -- 2017-11-22 00:00:00 UTC+8
  AND behavior_timestamp <  1512576000  -- 2017-12-07 00:00:00 UTC+8
GROUP BY DATE(FROM_UNIXTIME(behavior_timestamp))
ORDER BY behavior_date;
