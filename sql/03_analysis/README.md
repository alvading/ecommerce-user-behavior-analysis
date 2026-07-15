# SQL 业务分析 | SQL Business Analysis

只有当分析层对账状态为 `PASS` 后，才能运行这些脚本。所有脚本使用
`ecommerce_analysis.user_behavior` 和北京时间（`UTC+8`）。

Run these scripts only after the analytical-layer reconciliation status is
`PASS`. All scripts use `ecommerce_analysis.user_behavior` and China Standard
Time (`UTC+8`).

## 执行顺序 | Execution order

| 顺序 Order | 文件 File | 业务问题 Business question | 主要输出粒度 Main output grain |
|---:|---|---|---|
| 1 | `01_overview_kpis.sql` | 整体规模和购买活跃度如何？ / What is the scale and overall purchase activity? | 项目/窗口一行 / One project/window row |
| 2 | `02_behavior_and_time_trends.sql` | 行为与活跃用户如何随日期和小时变化？ / How do behavior and active users vary? | 行为/日期/小时 |
| 3 | `03_conversion_funnel.sql` | 多少用户触达行为并完成有序路径？ / How many users complete ordered paths? | 漏斗阶段 / Funnel stage |
| 4 | `04_product_category_performance.sql` | 哪些商品和品类吸引并转化用户？ / Which products and categories perform? | 商品/品类 |
| 5 | `05_repeat_purchase.sql` | 购买事件的集中与重复程度如何？ / How repeated are purchase events? | 用户/频次桶 |
| 6 | `06_user_segments.sql` | 每位用户属于哪个互斥行为分群？ / Which segment does each user belong to? | 用户/分群 |

## 输出规范 | Output discipline

大型结果保存在 Git 之外的带日期目录中。每个脚本都必须使用
`docs/analysis_records/TEMPLATE.md` 记录脚本版本、执行日期、数据库快照、行数、
对账、发现、业务解读和限制。SQL 文件只是版本化分析定义；完成实际执行、验证和
解读之前，路线图任务仍视为未完成。

Save results in a dated folder outside Git if they are large. Copy only small
aggregated outputs intended for reporting into a future approved results
folder. For each script, complete `docs/analysis_records/TEMPLATE.md` with:

- the exact script and Git commit;
- execution date and database snapshot/run record;
- row count and reconciliation checks;
- findings, business interpretation, and limitations.

The SQL files are versioned analysis definitions. A roadmap item remains
incomplete until its query has been executed, validated, and interpreted.
