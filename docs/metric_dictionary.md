# 指标字典 | Metric Dictionary

本文件是 SQL、看板、报告和作品网站的统一口径来源。所有指标当前均为“待验证”，
只有实际执行 SQL、完成对账并记录结果后才能发布。

This is the shared definition source for SQL, dashboard, report, and website.
All metrics remain pending until SQL execution and reconciliation are recorded.

## 数据粒度 | Data grain

| 对象 Object | 暂定粒度 Provisional grain | 验证要求 Validation required |
|---|---|---|
| 婴儿信息 / Baby information | 每个 `user_id` 一行 | 检查重复用户 |
| 交易历史 / Trade history | 每行一条交易或商品购买记录 | 验证 `auction_id` 唯一性与业务含义 |
| 购买数量 / Purchase quantity | `buy_mount` | 检查零值、负值和极端值 |

## 核心指标 | Core metrics

| 指标 Metric | 定义 Definition | SQL 逻辑 SQL logic | 状态/限制 Status / caveat |
|---|---|---|---|
| 交易记录数 / Trade rows | 清洗后交易表行数 | `COUNT(*)` | 待验证；不直接称为订单数 |
| 购买用户数 / Purchasing users | 不重复交易用户数 | `COUNT(DISTINCT user_id)` | 待验证 |
| 购买件数 / Units purchased | 有效 `buy_mount` 之和 | `SUM(buy_mount)` | 待验证异常数量 |
| 人均购买件数 / Units per user | 购买件数 ÷ 购买用户数 | `SUM(buy_mount) / COUNT(DISTINCT user_id)` | 非客单价 |
| 人均交易记录数 / Trade rows per user | 交易记录数 ÷ 购买用户数 | `COUNT(*) / COUNT(DISTINCT user_id)` | 不等同订单频次，需先确认粒度 |
| 复购用户 / Repeat purchaser | 至少出现两条有效交易记录的用户 | 用户级 `COUNT(*) >= 2` | 代理指标；需验证交易粒度 |
| 复购用户率 / Repeat purchaser rate | 复购用户 ÷ 购买用户 | 用户级比率 | 不等同长期留存率 |
| 活跃类目数 / Active categories | 有交易记录的不同类目数 | `COUNT(DISTINCT cat1/cat_id)` | 分一级和细分类目 |
| 有婴儿信息用户率 / Baby-info coverage | 能关联婴儿表的交易用户 ÷ 全部交易用户 | `LEFT JOIN` 后用户级比率 | 必须展示样本覆盖限制 |

## 派生维度 | Derived dimensions

| 维度 Dimension | 规则 Rule | 注意 Caveat |
|---|---|---|
| 交易日期 / Trade date | 将 `day` 的 `YYYYMMDD` 转为 `DATE` | 无效日期应保留并记录 |
| 婴儿生日 / Baby birthday | 将 `birthday` 的 `YYYYMMDD` 转为 `DATE` | 用户填写值可能不真实 |
| 交易时年龄 / Age at trade | 交易日期与生日之差 | 负年龄和异常高年龄需调查 |
| 性别标签 / Gender label | 根据数据说明映射 0/1/2 | 发布前核对权威字段说明 |

## 禁止使用的指标 | Unsupported metrics

由于缺少必要字段，不得计算或声称以下指标：收入、GMV、利润、客单价、浏览转化率、
加购转化率、广告 ROI、渠道归因和完整客户生命周期价值。

Do not calculate or claim revenue, GMV, profit, average order value,
browse/cart conversion, advertising ROI, channel attribution, or full customer
lifetime value because the required fields do not exist.
