# 指标字典 | Metric Dictionary

本文件是 SQL、看板、报告和作品网站中所有 KPI 口径的唯一事实来源。标记为
**草稿 / Draft** 的数值必须在发布前完成实际运行和验证。

This is the single source of truth for KPI definitions used in SQL, dashboard
pages, reports, and the portfolio website. Values marked **Draft** must be
validated before publication.

## 数据集约定 | Dataset conventions

| 项目 Item | 定义 Definition |
|---|---|
| Event grain | One row represents one user-product behavior event. |
| Valid window | `2017-11-25 00:00:00` inclusive to `2017-12-04 00:00:00` exclusive. |
| Valid behavior | `pv`, `fav`, `cart`, `buy`. |
| Time zone | China Standard Time (`UTC+8`) is the documented project convention; revise and rerun if authoritative publisher evidence differs. |
| Analytical table | `ecommerce_analysis.user_behavior`. |

## 核心 KPI | Core KPIs

| KPI | 定义 Definition | SQL 逻辑 SQL logic | 状态/限制 Status / caveat |
|---|---|---|---|
| Total events | Number of valid event rows. | `COUNT(*)` | Validated: 100,095,231 rows. |
| Active users | Distinct users with at least one valid event. | `COUNT(DISTINCT userid)` | Draft; calculate and validate. |
| Product reach | Distinct products with at least one valid event. | `COUNT(DISTINCT itemid)` | Draft. |
| Category reach | Distinct categories with at least one valid event. | `COUNT(DISTINCT categoryid)` | Draft. |
| Page views | Count of `pv` events. | `SUM(behavior_type = 'pv')` | Event count, not unique views. |
| Favorites | Count of `fav` events. | `SUM(behavior_type = 'fav')` | Event count. |
| Add-to-cart events | Count of `cart` events. | `SUM(behavior_type = 'cart')` | Event count. |
| Purchase events | Count of `buy` events. | `SUM(behavior_type = 'buy')` | Treats each buy row as an event; quantity and revenue are unavailable. |
| Purchasing users | Distinct users with at least one `buy` event. | `COUNT(DISTINCT CASE WHEN behavior_type='buy' THEN userid END)` | Draft. |
| Event purchase rate | Purchase events divided by page-view events. | `buy_events / pv_events` | A behavior ratio, not a session conversion rate. |
| User purchase conversion | Purchasing users divided by active users. | `purchasing_users / active_users` | Window-level user conversion. |
| Cart-to-buy user conversion | Users with a buy divided by users with a cart event. | distinct-user ratio | Does not prove the purchased item was the carted item unless item-level matching is added. |
| Average events per active user | Total events divided by active users. | `total_events / active_users` | Draft. |
| Purchase frequency | Purchase events divided by purchasing users. | `buy_events / purchasing_users` | Event-based proxy because order IDs and quantities are unavailable. |
| Repeat purchaser rate | Users with at least two buy events divided by purchasing users. | user-level buy count | Event-based proxy; multiple rows may not equal distinct orders. |

## 用户分群 | User segments

分群互斥，并按表中顺序优先判断。英文规则是 SQL 实现的正式名称，中文用于学习和
业务沟通。

Segments are mutually exclusive and evaluated in the listed priority order.

| 分群 Segment | 规则 Rule | 解读 Interpretation |
|---|---|---|
| Repeat buyer | At least two `buy` events. | Highest observed purchase-event engagement; not a customer-value measure. |
| Single buyer | Exactly one `buy` event. | Purchased once during the short window. |
| Cart no buy | No `buy`, at least one `cart`. | Expressed stronger intent without an observed purchase. |
| Favorite no cart or buy | No `buy` or `cart`, at least one `fav`. | Expressed interest without stronger observed action. |
| Browser only | No `buy`, `cart`, or `fav`. | Only page-view behavior was observed. |

## 解读限制 | Interpretation constraints

以下限制必须同时出现在分析记录、看板说明和最终报告中：数据没有价格、收入、
订单号、会话、渠道、促销、设备或人口属性；`buy` 只能称为购买事件；漏斗阶段
不天然具有顺序；九天窗口不足以支持长期留存、季节性或生命周期价值结论。

- The dataset contains no price, revenue, order ID, session ID, traffic source,
  promotion, device, or user-demographic fields.
- `buy` rows should be described as purchase events, not confirmed distinct
  orders, until an order-level identifier is available.
- Funnel stages are not automatically sequential. A strict path funnel needs
  user/item/time ordering rules, while a broad funnel is only stage reach.
- The nine-day observation window is suitable for short-term behavior analysis
  but limits long-term retention, seasonality, and customer-lifetime claims.
