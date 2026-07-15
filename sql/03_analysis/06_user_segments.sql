-- 业务问题：哪个行为阶段最能描述每位活跃用户？
-- Business question: Which behavior stage best describes each active user?
-- 分群互斥，并使用完整的九天观察窗口。
-- Segments are mutually exclusive and use the complete nine-day window.

USE ecommerce_analysis;
SET time_zone = '+08:00';

DROP TEMPORARY TABLE IF EXISTS tmp_user_features;
CREATE TEMPORARY TABLE tmp_user_features AS
SELECT
    userid,
    COUNT(*) AS total_events,
    SUM(behavior_type = 'pv') AS pv_events,
    SUM(behavior_type = 'fav') AS fav_events,
    SUM(behavior_type = 'cart') AS cart_events,
    SUM(behavior_type = 'buy') AS buy_events,
    COUNT(DISTINCT behavior_date) AS active_days,
    MAX(CASE WHEN behavior_type = 'buy' THEN behavior_date END) AS last_buy_date
FROM user_behavior
GROUP BY userid;

ALTER TABLE tmp_user_features
    ADD PRIMARY KEY (userid),
    ADD INDEX idx_tmp_segment_events (buy_events, cart_events, fav_events);

-- 分群规则按购买参与度从高到低判断：复购用户 -> 单次购买用户 -> 加购未购买
-- -> 收藏但未加购/购买 -> 仅浏览用户。
-- Segment rules, evaluated from highest purchase engagement downward:
-- repeat buyer -> single buyer -> cart no buy -> fav no cart/buy -> browser only.
WITH segmented_users AS (
    SELECT
        *,
        CASE
            WHEN buy_events >= 2 THEN 'repeat_buyer'
            WHEN buy_events = 1 THEN 'single_buyer'
            WHEN cart_events >= 1 THEN 'cart_no_buy'
            WHEN fav_events >= 1 THEN 'fav_no_cart_or_buy'
            ELSE 'browser_only'
        END AS user_segment
    FROM tmp_user_features
), segment_summary AS (
    SELECT
        user_segment,
        COUNT(*) AS users,
        SUM(total_events) AS total_events,
        SUM(pv_events) AS pv_events,
        SUM(fav_events) AS fav_events,
        SUM(cart_events) AS cart_events,
        SUM(buy_events) AS buy_events,
        ROUND(AVG(active_days), 2) AS avg_active_days,
        ROUND(AVG(total_events), 2) AS avg_events_per_user
    FROM segmented_users
    GROUP BY user_segment
)
SELECT
    user_segment,
    users,
    ROUND(100.0 * users / SUM(users) OVER (), 2) AS user_share_pct,
    total_events,
    pv_events,
    fav_events,
    cart_events,
    buy_events,
    avg_active_days,
    avg_events_per_user
FROM segment_summary
ORDER BY FIELD(
    user_segment,
    'repeat_buyer',
    'single_buyer',
    'cart_no_buy',
    'fav_no_cart_or_buy',
    'browser_only'
);

-- 质量检查：每位活跃用户必须且只能属于一个分群。
-- QA: every active user must appear in exactly one segment.
WITH segmented_users AS (
    SELECT
        userid,
        CASE
            WHEN buy_events >= 2 THEN 'repeat_buyer'
            WHEN buy_events = 1 THEN 'single_buyer'
            WHEN cart_events >= 1 THEN 'cart_no_buy'
            WHEN fav_events >= 1 THEN 'fav_no_cart_or_buy'
            ELSE 'browser_only'
        END AS user_segment
    FROM tmp_user_features
)
SELECT
    (SELECT COUNT(DISTINCT userid) FROM user_behavior) AS source_active_users,
    COUNT(*) AS segmented_users,
    COUNT(DISTINCT userid) AS distinct_segmented_users,
    SUM(user_segment IS NULL) AS unclassified_users,
    CASE
        WHEN COUNT(*) = COUNT(DISTINCT userid)
         AND COUNT(*) = (SELECT COUNT(DISTINCT userid) FROM user_behavior)
         AND SUM(user_segment IS NULL) = 0
            THEN 'PASS'
        ELSE 'FAIL'
    END AS segmentation_reconciliation_status
FROM segmented_users;
