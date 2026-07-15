-- 业务问题：有效观察窗口内的用户活跃与购买行为规模如何？
-- Business question: What is the scale of user activity and purchase behavior
-- during the valid observation window?
-- 粒度：整个 2017-11-25 至 2017-12-03 窗口一行。
-- Grain: one row for the full 2017-11-25 to 2017-12-03 window.

USE ecommerce_analysis;
SET time_zone = '+08:00';

WITH kpi AS (
    SELECT
        COUNT(*) AS total_events,
        COUNT(DISTINCT userid) AS active_users,
        COUNT(DISTINCT itemid) AS active_items,
        COUNT(DISTINCT categoryid) AS active_categories,
        SUM(behavior_type = 'pv') AS pv_events,
        SUM(behavior_type = 'fav') AS fav_events,
        SUM(behavior_type = 'cart') AS cart_events,
        SUM(behavior_type = 'buy') AS buy_events,
        COUNT(DISTINCT CASE WHEN behavior_type = 'pv' THEN userid END)
            AS pv_users,
        COUNT(DISTINCT CASE WHEN behavior_type = 'fav' THEN userid END)
            AS fav_users,
        COUNT(DISTINCT CASE WHEN behavior_type = 'cart' THEN userid END)
            AS cart_users,
        COUNT(DISTINCT CASE WHEN behavior_type = 'buy' THEN userid END)
            AS purchasing_users
    FROM user_behavior
)
SELECT
    total_events,
    active_users,
    active_items,
    active_categories,
    pv_events,
    fav_events,
    cart_events,
    buy_events,
    pv_users,
    fav_users,
    cart_users,
    purchasing_users,
    ROUND(total_events / NULLIF(active_users, 0), 2)
        AS avg_events_per_active_user,
    ROUND(buy_events / NULLIF(purchasing_users, 0), 2)
        AS buy_events_per_purchasing_user,
    ROUND(100.0 * buy_events / NULLIF(pv_events, 0), 4)
        AS buy_to_pv_event_ratio_pct,
    ROUND(100.0 * purchasing_users / NULLIF(active_users, 0), 2)
        AS purchasing_user_share_pct
FROM kpi;

-- 质量检查：各行为总量必须与分析表总行数对账一致。
-- QA: behavior totals must reconcile to the analytical table.
SELECT
    COUNT(*) AS analytical_rows,
    SUM(behavior_type = 'pv')
      + SUM(behavior_type = 'fav')
      + SUM(behavior_type = 'cart')
      + SUM(behavior_type = 'buy') AS classified_rows,
    CASE
        WHEN COUNT(*) = SUM(behavior_type IN ('pv', 'fav', 'cart', 'buy'))
            THEN 'PASS'
        ELSE 'FAIL'
    END AS behavior_reconciliation_status
FROM user_behavior;
