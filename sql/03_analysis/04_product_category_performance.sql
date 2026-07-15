-- 业务问题：哪些商品和品类具有最高的用户触达、购买活跃度及 buy/pv 事件比？
-- Business question: Which products and categories show the greatest reach,
-- purchase activity, and buy-to-pv event ratios?
-- 数据不含价格、收入或订单信息，因此这些指标只能作为行为代理。
-- No price/revenue/order data exists; these are behavior proxies only.

USE ecommerce_analysis;
SET time_zone = '+08:00';

-- 头部品类。最低曝光门槛可避免小分母产生虚高排名；发布结论时必须保留该门槛。
-- Top categories. Minimum exposure avoids ranking tiny denominators as strong
-- performers; retain the threshold in any published interpretation.
WITH category_metrics AS (
    SELECT
        categoryid,
        COUNT(*) AS total_events,
        COUNT(DISTINCT userid) AS reached_users,
        COUNT(DISTINCT itemid) AS reached_items,
        SUM(behavior_type = 'pv') AS pv_events,
        SUM(behavior_type = 'fav') AS fav_events,
        SUM(behavior_type = 'cart') AS cart_events,
        SUM(behavior_type = 'buy') AS buy_events,
        COUNT(DISTINCT CASE WHEN behavior_type = 'buy' THEN userid END)
            AS purchasing_users
    FROM user_behavior
    GROUP BY categoryid
)
SELECT
    categoryid,
    total_events,
    reached_users,
    reached_items,
    pv_events,
    fav_events,
    cart_events,
    buy_events,
    purchasing_users,
    ROUND(100.0 * buy_events / NULLIF(pv_events, 0), 4)
        AS buy_to_pv_event_ratio_pct
FROM category_metrics
WHERE pv_events >= 1000
ORDER BY buy_events DESC, purchasing_users DESC
LIMIT 50;

-- 头部商品，使用同样明确的最低曝光保护条件。
-- Top products with the same explicit exposure guard.
WITH item_metrics AS (
    SELECT
        itemid,
        MIN(categoryid) AS categoryid,
        COUNT(*) AS total_events,
        COUNT(DISTINCT userid) AS reached_users,
        SUM(behavior_type = 'pv') AS pv_events,
        SUM(behavior_type = 'fav') AS fav_events,
        SUM(behavior_type = 'cart') AS cart_events,
        SUM(behavior_type = 'buy') AS buy_events,
        COUNT(DISTINCT CASE WHEN behavior_type = 'buy' THEN userid END)
            AS purchasing_users,
        COUNT(DISTINCT categoryid) AS category_count
    FROM user_behavior
    GROUP BY itemid
)
SELECT
    itemid,
    categoryid,
    total_events,
    reached_users,
    pv_events,
    fav_events,
    cart_events,
    buy_events,
    purchasing_users,
    ROUND(100.0 * buy_events / NULLIF(pv_events, 0), 4)
        AS buy_to_pv_event_ratio_pct,
    category_count
FROM item_metrics
WHERE pv_events >= 100
ORDER BY buy_events DESC, purchasing_users DESC
LIMIT 50;

-- 质量检查：识别被映射至多个品类的商品。
-- QA: identify products mapped to more than one category.
SELECT
    COUNT(*) AS multi_category_items
FROM (
    SELECT itemid
    FROM user_behavior
    GROUP BY itemid
    HAVING COUNT(DISTINCT categoryid) > 1
) AS inconsistent_items;
