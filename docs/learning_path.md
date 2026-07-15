# SQL 引导式学习路线 | Guided SQL Learning Path

## 学习约定 | Learning agreement

本仓库既是求职作品集，也是学习过程记录。目标不只是得到最终 SQL 文件，而是让
学习者能够解释业务问题、编写或调整查询、验证结果，并在面试中为自己的分析
结论辩护。

This repository is both a portfolio project and a learning record. The goal is
not merely to obtain final SQL files: the learner should be able to explain the
business question, write or adapt the query, validate the result, and defend
the interpretation in an interview.

每节课遵循“定义问题 → 学习知识点 → 预测结果 → 执行 SQL → 调试与解读 →
记录成果 → 总结面试表达”的闭环。

Each lesson follows this cycle:

1. define one business question;
2. learn the SQL concepts required for it;
3. predict the expected output grain and checks;
4. write or run the query in MySQL/Navicat;
5. share the real output and any error message;
6. debug and interpret the result together;
7. save the validated SQL and analysis record;
8. summarize the interview-ready takeaway.

## 课程顺序 | Lesson sequence

| 课次 Lesson | 主题 Topic | SQL 技能 SQL skills | 作品集成果 Portfolio output |
|---:|---|---|---|
| 1 | 理解并验证数据源 / Understand and validate the source | `SELECT`, `COUNT`, `DISTINCT`, `GROUP BY`, `MIN`, `MAX` | 初始数据画像 / Initial data profile |
| 2 | 定义干净分析窗口 / Define the clean analysis window | Unix 时间戳、`WHERE`、条件聚合 | 清洗决策与对账 / Cleaning decision and reconciliation |
| 3 | 整体业务 KPI / Overall business KPIs | CTE、`CASE`、比率、`NULLIF` | KPI 概览 / KPI overview |
| 4 | 行为与时间趋势 / Behavior and time trends | 日期/小时分组、窗口汇总 | 趋势分析 / Trend analysis |
| 5 | 转化漏斗 / Conversion funnel | 用户级聚合、分阶段逻辑 | 宽口径与严格漏斗 / Broad and strict funnels |
| 6 | 商品与品类表现 / Product/category performance | 排名、阈值、分母控制 | 表现分析表 / Performance tables |
| 7 | 复购分析 / Repeat purchase | 用户级汇总、分布 | 复购分析 / Repeat-purchase analysis |
| 8 | 用户分群 / User segmentation | 特征工程、互斥 `CASE` 规则 | 分群画像 / Segment profile |
| 9 | 看板数据模型 / Dashboard data model | 视图/导出表、指标对账 | 看板数据集 / Dashboard-ready dataset |
| 10 | 故事表达与作品集 / Storytelling and portfolio | 从证据到洞察的推理 | 报告与网站案例 / Report and website case study |

## 当前课程 | Current lesson

**第 1 课：数据源验证。** 从针对 `stg_user_behavior` 的小型只读查询开始。在
学习者理解并验证原始表以前，不运行准备好的下游分析脚本。

**Lesson 1: source validation.** Start from small, read-only queries against
`stg_user_behavior`. Do not run the prepared downstream analysis scripts until
the learner understands and validates the source table.
