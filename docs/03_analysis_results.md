# 分析结果 | Analysis Results

## 1. 整体交易规模 | Overall transaction scale

| 指标 Metric | 结果 Result |
|---|---:|
| 交易记录数 / Trade rows | 29,971 |
| 购买用户数 / Purchasing users | 29,944 |
| 不同 `auction_id` / Distinct auction IDs | 28,422 |
| 一级类目 / Top categories | 6 |
| 细分类目 / Detailed categories | 662 |
| 总购买件数 / Total units | 76,250 |

交易记录数只比购买用户数多 27，人均交易记录数为 1.0009，说明数据中的多记录
用户非常少。该结论将在用户级购买频次分析中进一步验证。

Trade rows exceed purchasing users by only 27, producing 1.0009 rows per user.
Multi-row customers are therefore rare and require explicit user-level
frequency validation.

## 2. 购买强度与敏感性 | Purchase intensity and sensitivity

| 指标 Metric | 全量 All rows | `buy_amount < 100` |
|---|---:|---:|
| 交易记录 / Trade rows | 29,971 | 29,906 |
| 购买件数 / Units | 76,250 | 45,755 |
| 每条记录平均件数 / Units per row | 2.54 | 1.53 |
| 人均购买件数 / Units per user | 2.55 | — |

仅 65 条高数量记录就贡献 30,495 件，占总购买件数 39.99%。全量每条记录平均
2.54 件，而 `<100` 子集平均 1.53 件；少量高数量记录使全量均值提高约 66%。

Only 65 high-quantity rows contribute 30,495 units, or 39.99% of all units.
Average units per row are 2.54 overall versus 1.53 below the threshold, meaning
the small high-quantity group raises the overall average by approximately 66%.

### 解读限制 | Interpretation limit

数据缺少价格、订单类型和采购身份，无法确认高数量记录属于批量采购、单位差异
还是异常值。因此保留原始记录，同时在 KPI、趋势和品类分析中展示敏感性对照；
`100` 不是清洗或删除规则。

Without price, order type, or purchaser identity, the data cannot distinguish
bulk purchase, unit differences, and anomalies. Raw rows are retained and a
sensitivity view is reported; 100 is not a cleaning or deletion rule.

## 3. 用户购买频次与复购 | Purchase frequency and repeat purchase

| 指标 Metric | 结果 Result |
|---|---:|
| 购买用户 / Purchasing users | 29,944 |
| 单条记录用户 / Single-row users | 29,919 |
| 多条记录用户 / Multi-row users | 25 |
| 跨日复购用户 / Cross-day repeat users | 24 |
| 跨日复购率 / Cross-day repeat rate | 0.0802% |
| 单用户最大记录数 / Maximum rows per user | 4 |
| 单用户最大购买日期数 / Maximum purchase dates | 4 |

复购定义为“至少两个不同购买日期”，而不是简单出现多行。唯一一个“多行但单日”
用户在 2014-10-06 购买两个不同 `auction_id`，每条 1 件，属于同日多商品记录，
不计为跨日复购。

Repeat purchase is defined as activity on at least two distinct dates, not
simply multiple rows. The only multi-row single-day user purchased two different
auction IDs on 2014-10-06, one unit each, and is not classified as cross-day
repeat.

### 业务含义 | Business implication

99.9% 以上用户仅有一条交易记录，复购信号极弱。该数据集适合描述销售、时间和
品类结构，但不适合建立复杂 RFM 或复购预测模型。运营建议应聚焦首次购买结构和
品类表现，不夸大用户生命周期结论。

More than 99.9% of users have a single row, leaving extremely weak repeat
signals. The dataset supports sales, time, and category description but not
complex RFM or repeat-purchase prediction. Recommendations should focus on
first-purchase structure and category performance rather than overstating
lifecycle conclusions.

## 4. 时间趋势 | Time trends

2012 年仅覆盖 7 月至 12 月，2015 年仅覆盖 1 月至 2 月 5 日，因此年度同比只比较
完整的 2013 和 2014 年。2014 年交易记录和购买用户分别同比增长 54.04% 和
54.13%，表明交易规模扩大主要来自购买用户增长。原始购买件数增长 85.16%，
但 `<100` 敏感性口径仅增长 49.27%。高数量购买件数增长 155.43%，贡献总件数
增量的 61.70%，说明少量大数量记录显著放大了原始销量增幅。

2012 covers only July through December, while 2015 ends on February 5; annual
YoY analysis therefore compares only complete years 2013 and 2014. Trade rows
and purchasing users grew by 54.04% and 54.13%, indicating that expansion was
primarily user-driven. Raw units rose 85.16%, versus 49.27% under the `<100`
sensitivity view. High-quantity units grew 155.43% and contributed 61.70% of
the total unit increase, materially amplifying raw unit growth.

### 月度高峰 | Monthly peak

2014 年 12 个月的交易记录数均较 2013 年同月增长，增幅为 21.30%–120.75%。
2014 年 11 月以 1,833 条交易记录位列样本期第一；即使采用 `<100` 口径，当月
2,460 件仍为第一，说明交易活跃高峰并非完全由大数量记录造成。

Trade rows increased year over year in every month of 2014, ranging from
21.30% to 120.75%. November 2014 ranked first in the sample with 1,833 rows and
also ranked first under the `<100` sensitivity view with 2,460 units, confirming
that the activity peak was not solely created by high-quantity rows.

但当月原始 13,044 件中，6 条 `buy_amount >= 100` 的记录贡献 10,584 件，即
81.14%；其中单条 10,000 件记录占当月总件数 76.66%。因此，11 月原始件数同比
增长 413.95%，而 `<100` 口径购买件数同比仅增长 46.69%。看板与结论应同时展示
交易记录、原始件数和购买件数（单条记录 `<100`），且不能在缺乏业务证据时把
大数量记录直接认定为错误。

However, six rows with `buy_amount >= 100` contributed 10,584 of November's
13,044 raw units, or 81.14%; one 10,000-unit row alone represented 76.66%.
Consequently, raw units grew 413.95% year over year while units from rows below
100 grew only 46.69%. The dashboard should show trade rows, raw units, and the
`<100`-per-row view together, without labeling high-quantity rows as errors
absent business evidence.

## 5. 品类结构与增长 | Category structure and growth

`cat1=50008168` 贡献 41.69% 的交易记录和 32.37% 的 `<100` 口径购买件数，是覆盖
最广且表现最稳定的一级品类。原始件数最高的 `cat1=28` 有 52.15% 来自高数量
记录；`cat1=50014815` 的对应比例更高达 56.81%，因此两者不能仅凭原始件数
排名判断品类表现。数据没有提供品类名称映射，结论保留原始编码，不推测名称。

`cat1=50008168` contributes 41.69% of trade rows and 32.37% of sensitivity
units, making it the broadest and most stable top-level category. High-quantity
rows supply 52.15% of raw units for `cat1=28` and 56.81% for
`cat1=50014815`, so raw-unit ranking alone would misrepresent performance. As
no category-name mapping is provided, findings retain source codes.

2013→2014 年，`50008168` 增加 2,073 条交易记录，贡献整体交易行增量的
39.33%；`28` 和 `50014815` 分别贡献 24.38% 和 17.57%。前三个一级品类合计
贡献 81.28% 的交易行增长。`50022520` 自身增速最高（64.56%），但其绝对增量
仅为 481 条，说明增长率与增长贡献需要同时评估。

From 2013 to 2014, `50008168` added 2,073 rows and contributed 39.33% of total
row growth; `28` and `50014815` contributed 24.38% and 17.57%. Together, the
top three supplied 81.28% of growth. `50022520` had the highest category-level
growth rate (64.56%) but added only 481 rows, demonstrating why rate and
absolute contribution should be evaluated together.

### 细分类目与长尾 | Detailed categories and long tail

662 个 `cat_id` 均只对应一个 `cat1`。交易记录 Top 10 仅占 31.29%，`<100` 口径
Top 10 占 30.58%；两种口径都需要 123 个细分类目才能达到累计 80%。123 个占
全部细分类目的 18.58%，接近二八分布，同时 Top 10 占比不高，体现出头部集中与
长尾并存。`cat_id=50018831` 的高数量件数占自身原始件数 87.13%，其原始销量
排名尤其需要谨慎解释。

Each of the 662 `cat_id` values maps to one `cat1`. The Top 10 account for only
31.29% of trade rows and 30.58% of units from rows below 100; both measures require 123
detailed categories to reach 80% cumulatively. Those 123 represent 18.58% of
all detailed categories, broadly resembling an 80/20 distribution while the
low Top-10 share still indicates a substantial long tail. For
`cat_id=50018831`, high-quantity rows contribute 87.13% of raw units, requiring
particular caution when interpreting its raw-unit rank.

## 6. 人口属性补充分析 | Demographic supplement

婴儿信息只匹配 953 名用户和 956 条交易记录，即全部交易用户的 3.18%，因此本节
仅描述匹配子样本。天池说明指出出生日期和性别由用户填写，可能不真实；本数据中
交易相对出生日期的月份差为 -25 至 339。15 条记录早于设定的可能孕期范围，39
条发生在出生 72 个月以后，合计占匹配交易的 5.65%。这些记录保留在原始模型中，
但不纳入主要年龄阶段解释。

Baby information matches only 953 users and 956 rows, or 3.18% of all
purchasing users, so this section describes only the matched subsample. Tianchi
notes that birth date and gender are user-entered and may be inaccurate. Months
from birth range from -25 to 339; 15 rows precede the assumed plausible prenatal
window and 39 occur at 72 months or later, together representing 5.65% of
matched rows. They remain in the model but are excluded from the primary age
interpretation.

在 `-10` 至 `71` 个月的902条分析记录中，出生后0–11个月占比最高（34.26%）；
12–23个月占21.62%，且敏感性口径每条平均1.70件，为各阶段最高。可能孕期购买
占11.42%。这些阶段差异属于描述性结果，不能推广到全部交易用户。

Within the 902-row analytical window from -10 to 71 months, age 0–11 months is
the largest stage (34.26%). Age 12–23 months represents 21.62% and has the
highest sensitivity average at 1.70 units per row. Possible prenatal purchases
account for 11.42%. These are descriptive subsample results and are not
generalizable to all purchasing users.

男婴、女婴和未知性别分别占匹配用户的 51.31%、45.96% 和 2.73%。男女婴交易
记录最多的一级品类均为 `50008168`，前三个主要品类也相同，整体品类构成相似。
男婴敏感性口径每条1.58件、女婴1.28件，但受样本覆盖、字段可信度和商品信息
缺失限制，不能据此推断性别造成购买量差异。

Boys, girls, and unknown gender represent 51.31%, 45.96%, and 2.73% of matched
users. `50008168` is the leading top-level category for both boys and girls,
and their top three categories are the same, indicating broadly similar mixes.
Sensitivity averages are 1.58 units per row for boys and 1.28 for girls, but
coverage, field reliability, and missing product context prevent causal gender
claims.
