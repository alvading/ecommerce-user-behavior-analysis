-- 业务问题：购买用户产生 buy 事件的频率如何？重复购买用户贡献了多少活动？
-- Business question: How frequently do purchasing users generate buy events,
-- and how much activity comes from repeat purchasers?
-- 注意：buy 行只是事件代理，不是经过验证的独立订单。
-- Caveat: buy rows are event proxies, not verified distinct orders.

USE ecommerce_analysis;
SET time_zone = '+08:00';

DROP TEMPORARY TABLE IF EXISTS tmp_user_purchase_summary;
CREATE TEMPORARY TABLE tmp_user_purchase_summary AS
SELECT
    userid,
    COUNT(*) AS buy_events,
    COUNT(DISTINCT behavior_date) AS purchase_days,
    COUNT(DISTINCT itemid) AS purchased_items,
    COUNT(DISTINCT categoryid) AS purchased_categories,
    MIN(behavior_datetime) AS first_buy_datetime,
    MAX(behavior_datetime) AS last_buy_datetime
FROM user_behavior
WHERE behavior_type = 'buy'
GROUP BY userid;

ALTER TABLE tmp_user_purchase_summary
    ADD PRIMARY KEY (userid),
    ADD INDEX idx_tmp_buy_events (buy_events);

-- 整体复购代理指标 | Overall repeat-purchase proxies
SELECT
    COUNT(*) AS purchasing_users,
    SUM(buy_events) AS buy_events,
    SUM(buy_events >= 2) AS repeat_purchasing_users,
    ROUND(100.0 * SUM(buy_events >= 2) / NULLIF(COUNT(*), 0), 2)
        AS repeat_purchaser_rate_pct,
    ROUND(1.0 * SUM(buy_events) / NULLIF(COUNT(*), 0), 2)
        AS buy_events_per_purchasing_user,
    ROUND(1.0 * SUM(purchase_days) / NULLIF(COUNT(*), 0), 2)
        AS purchase_days_per_purchasing_user
FROM tmp_user_purchase_summary;

-- 供看板直方图使用的分布 | Distribution for a dashboard histogram
SELECT
    CASE
        WHEN buy_events = 1 THEN '1'
        WHEN buy_events = 2 THEN '2'
        WHEN buy_events BETWEEN 3 AND 5 THEN '3-5'
        WHEN buy_events BETWEEN 6 AND 10 THEN '6-10'
        ELSE '11+'
    END AS buy_event_bucket,
    CASE
        WHEN buy_events = 1 THEN 1
        WHEN buy_events = 2 THEN 2
        WHEN buy_events BETWEEN 3 AND 5 THEN 3
        WHEN buy_events BETWEEN 6 AND 10 THEN 4
        ELSE 5
    END AS bucket_order,
    COUNT(*) AS users,
    SUM(buy_events) AS buy_events,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS user_share_pct
FROM tmp_user_purchase_summary
GROUP BY buy_event_bucket, bucket_order
ORDER BY bucket_order;

-- 质量检查：购买汇总必须与原始 buy 事件数和用户数对账一致。
-- QA: purchase summary must reconcile to raw buy event/user counts.
WITH source AS (
    SELECT
        COUNT(*) AS source_buy_events,
        COUNT(DISTINCT userid) AS source_purchasing_users
    FROM user_behavior
    WHERE behavior_type = 'buy'
), summary AS (
    SELECT
        SUM(buy_events) AS summary_buy_events,
        COUNT(*) AS summary_purchasing_users
    FROM tmp_user_purchase_summary
)
SELECT
    source_buy_events,
    summary_buy_events,
    source_purchasing_users,
    summary_purchasing_users,
    CASE
        WHEN source_buy_events = summary_buy_events
         AND source_purchasing_users = summary_purchasing_users
            THEN 'PASS'
        ELSE 'FAIL'
    END AS repeat_purchase_reconciliation_status
FROM source
CROSS JOIN summary;
