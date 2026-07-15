-- 业务问题：事件量、活跃用户数和购买用户数如何随日期与小时变化？
-- Business question: How do event volume, active users, and purchasing users
-- vary across days and hours?
-- 粒度：行为类型、日期和小时；采用 UTC+8。
-- Grains: behavior type, date, and hour. UTC+8.

USE ecommerce_analysis;
SET time_zone = '+08:00';

-- 行为构成：有意区分事件量与触达用户数。
-- Behavior mix: event volume and user reach are intentionally separate.
SELECT
    behavior_type,
    COUNT(*) AS event_rows,
    COUNT(DISTINCT userid) AS reached_users,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 4)
        AS event_share_pct,
    ROUND(1.0 * COUNT(*) / NULLIF(COUNT(DISTINCT userid), 0), 2)
        AS events_per_reached_user
FROM user_behavior
GROUP BY behavior_type
ORDER BY event_rows DESC;

-- 供看板趋势图使用的每日活跃数据。
-- Daily activity for dashboard trend charts.
SELECT
    behavior_date,
    COUNT(*) AS total_events,
    COUNT(DISTINCT userid) AS active_users,
    SUM(behavior_type = 'pv') AS pv_events,
    SUM(behavior_type = 'fav') AS fav_events,
    SUM(behavior_type = 'cart') AS cart_events,
    SUM(behavior_type = 'buy') AS buy_events,
    COUNT(DISTINCT CASE WHEN behavior_type = 'buy' THEN userid END)
        AS purchasing_users,
    ROUND(100.0 * SUM(behavior_type = 'buy')
        / NULLIF(SUM(behavior_type = 'pv'), 0), 4)
        AS buy_to_pv_event_ratio_pct
FROM user_behavior
GROUP BY behavior_date
ORDER BY behavior_date;

-- 汇总九天数据得到的小时分布。
-- Hour-of-day pattern aggregated across all nine dates.
SELECT
    behavior_hour,
    COUNT(*) AS total_events,
    COUNT(DISTINCT userid) AS active_users,
    SUM(behavior_type = 'pv') AS pv_events,
    SUM(behavior_type = 'fav') AS fav_events,
    SUM(behavior_type = 'cart') AS cart_events,
    SUM(behavior_type = 'buy') AS buy_events,
    COUNT(DISTINCT CASE WHEN behavior_type = 'buy' THEN userid END)
        AS purchasing_users
FROM user_behavior
GROUP BY behavior_hour
ORDER BY behavior_hour;

-- 质量检查：日期范围必须正好包含九天，小时必须覆盖 0–23。
-- QA: the date range must contain exactly nine dates and hours must be 0–23.
SELECT
    COUNT(DISTINCT behavior_date) AS observed_dates,
    MIN(behavior_date) AS min_date,
    MAX(behavior_date) AS max_date,
    MIN(behavior_hour) AS min_hour,
    MAX(behavior_hour) AS max_hour,
    CASE
        WHEN COUNT(DISTINCT behavior_date) = 9
         AND MIN(behavior_date) = '2017-11-25'
         AND MAX(behavior_date) = '2017-12-03'
         AND MIN(behavior_hour) = 0
         AND MAX(behavior_hour) = 23
            THEN 'PASS'
        ELSE 'REVIEW'
    END AS time_coverage_status
FROM user_behavior;
