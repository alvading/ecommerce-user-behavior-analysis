-- 目的：从保留的暂存层重建分析表。
-- Purpose: rebuild the analytical table from the preserved staging layer.
-- MySQL 8.x。确认目标数据库后可安全重复执行。
-- MySQL 8.x. Safe to rerun after confirming the target database.

USE ecommerce_analysis;
SET time_zone = '+08:00';

-- 采用重建而非追加，防止重复执行产生重复分析记录。
-- Rebuild instead of appending so a rerun cannot duplicate analytical rows.
TRUNCATE TABLE user_behavior;

INSERT INTO user_behavior (
    userid,
    itemid,
    categoryid,
    behavior_type,
    behavior_timestamp,
    behavior_datetime,
    behavior_date,
    behavior_hour
)
SELECT
    userid,
    itemid,
    categoryid,
    behavior_type,
    behavior_timestamp,
    FROM_UNIXTIME(behavior_timestamp) AS behavior_datetime,
    DATE(FROM_UNIXTIME(behavior_timestamp)) AS behavior_date,
    HOUR(FROM_UNIXTIME(behavior_timestamp)) AS behavior_hour
FROM stg_user_behavior
WHERE behavior_timestamp >= 1511539200
  AND behavior_timestamp <  1512316800
  AND behavior_type IN ('pv', 'fav', 'cart', 'buy');

-- 验证 | Validation
SELECT
    COUNT(*) AS analytical_rows,
    MIN(behavior_datetime) AS min_behavior_datetime,
    MAX(behavior_datetime) AS max_behavior_datetime
FROM user_behavior;
