-- 业务问题：有多少用户触达各类行为？又有多少用户针对同一商品完成有序的
-- pv -> cart -> buy 或 pv -> fav -> buy 路径？
-- Business question: How many users reach each behavior, and how many complete
-- ordered pv -> cart -> buy or pv -> fav -> buy paths for the same item?
-- 重要：触达漏斗不代表顺序；严格路径使用时间戳判定顺序。
-- Important: reach funnel is not sequential; strict paths use timestamps.

USE ecommerce_analysis;
SET time_zone = '+08:00';

-- A. 宽口径用户触达漏斗。阶段可以重叠，并不代表先后顺序。
-- Broad user-reach funnel. Stages overlap and are not sequential.
WITH user_reach AS (
    SELECT
        userid,
        MAX(behavior_type = 'pv') AS reached_pv,
        MAX(behavior_type = 'fav') AS reached_fav,
        MAX(behavior_type = 'cart') AS reached_cart,
        MAX(behavior_type = 'buy') AS reached_buy
    FROM user_behavior
    GROUP BY userid
), stage_counts AS (
    SELECT 1 AS stage_order, 'active' AS stage, COUNT(*) AS reached_users
    FROM user_reach
    UNION ALL
    SELECT 2, 'pv', SUM(reached_pv) FROM user_reach
    UNION ALL
    SELECT 3, 'fav', SUM(reached_fav) FROM user_reach
    UNION ALL
    SELECT 4, 'cart', SUM(reached_cart) FROM user_reach
    UNION ALL
    SELECT 5, 'buy', SUM(reached_buy) FROM user_reach
)
SELECT
    stage_order,
    stage,
    reached_users,
    ROUND(100.0 * reached_users
        / NULLIF(MAX(CASE WHEN stage = 'active' THEN reached_users END)
            OVER (), 0), 2) AS share_of_active_users_pct
FROM stage_counts
ORDER BY stage_order;

-- B. 按用户与商品聚合首次时间戳，以降低路径计算量。
-- Aggregate first timestamps per user and item to reduce path computation.
DROP TEMPORARY TABLE IF EXISTS tmp_user_item_first_behavior;
CREATE TEMPORARY TABLE tmp_user_item_first_behavior AS
SELECT
    userid,
    itemid,
    MIN(CASE WHEN behavior_type = 'pv' THEN behavior_timestamp END) AS first_pv_ts,
    MIN(CASE WHEN behavior_type = 'fav' THEN behavior_timestamp END) AS first_fav_ts,
    MIN(CASE WHEN behavior_type = 'cart' THEN behavior_timestamp END) AS first_cart_ts,
    MIN(CASE WHEN behavior_type = 'buy' THEN behavior_timestamp END) AS first_buy_ts
FROM user_behavior
GROUP BY userid, itemid;

ALTER TABLE tmp_user_item_first_behavior
    ADD INDEX idx_tmp_path_user (userid),
    ADD INDEX idx_tmp_path_times
        (first_pv_ts, first_cart_ts, first_fav_ts, first_buy_ts);

-- C. 同一用户、同一商品的严格顺序路径。相同时间戳不能证明顺序，因此后续
-- 步骤的 epoch 必须严格大于前一步。
-- Strict same-user, same-item sequential path reach. Equal timestamps do not
-- establish order, so each later step must have a strictly greater epoch.
WITH user_paths AS (
    SELECT
        userid,
        MAX(first_pv_ts IS NOT NULL) AS has_pv_item,
        MAX(first_pv_ts IS NOT NULL
            AND first_cart_ts > first_pv_ts) AS has_pv_cart_item,
        MAX(first_pv_ts IS NOT NULL
            AND first_cart_ts > first_pv_ts
            AND first_buy_ts > first_cart_ts) AS has_pv_cart_buy_item,
        MAX(first_pv_ts IS NOT NULL
            AND first_fav_ts > first_pv_ts) AS has_pv_fav_item,
        MAX(first_pv_ts IS NOT NULL
            AND first_fav_ts > first_pv_ts
            AND first_buy_ts > first_fav_ts) AS has_pv_fav_buy_item
    FROM tmp_user_item_first_behavior
    GROUP BY userid
), path_counts AS (
    SELECT 1 AS stage_order, 'pv' AS stage, SUM(has_pv_item) AS users
    FROM user_paths
    UNION ALL
    SELECT 2, 'pv_then_cart', SUM(has_pv_cart_item) FROM user_paths
    UNION ALL
    SELECT 3, 'pv_then_cart_then_buy', SUM(has_pv_cart_buy_item) FROM user_paths
    UNION ALL
    SELECT 4, 'pv_then_fav', SUM(has_pv_fav_item) FROM user_paths
    UNION ALL
    SELECT 5, 'pv_then_fav_then_buy', SUM(has_pv_fav_buy_item) FROM user_paths
)
SELECT
    stage_order,
    stage,
    users,
    ROUND(100.0 * users
        / NULLIF(MAX(CASE WHEN stage = 'pv' THEN users END) OVER (), 0), 2)
        AS share_of_pv_users_pct
FROM path_counts
ORDER BY stage_order;

-- 质量检查：顺序路径的子阶段人数不得超过父阶段。
-- QA: sequential child stages cannot exceed their parent stages.
WITH user_paths AS (
    SELECT
        userid,
        MAX(first_pv_ts IS NOT NULL) AS has_pv_item,
        MAX(first_pv_ts IS NOT NULL
            AND first_cart_ts > first_pv_ts) AS has_pv_cart_item,
        MAX(first_pv_ts IS NOT NULL
            AND first_cart_ts > first_pv_ts
            AND first_buy_ts > first_cart_ts) AS has_pv_cart_buy_item,
        MAX(first_pv_ts IS NOT NULL
            AND first_fav_ts > first_pv_ts) AS has_pv_fav_item,
        MAX(first_pv_ts IS NOT NULL
            AND first_fav_ts > first_pv_ts
            AND first_buy_ts > first_fav_ts) AS has_pv_fav_buy_item
    FROM tmp_user_item_first_behavior
    GROUP BY userid
)
SELECT
    CASE
        WHEN SUM(has_pv_cart_buy_item) <= SUM(has_pv_cart_item)
         AND SUM(has_pv_cart_item) <= SUM(has_pv_item)
         AND SUM(has_pv_fav_buy_item) <= SUM(has_pv_fav_item)
         AND SUM(has_pv_fav_item) <= SUM(has_pv_item)
            THEN 'PASS'
        ELSE 'FAIL'
    END AS strict_funnel_hierarchy_status
FROM user_paths;
