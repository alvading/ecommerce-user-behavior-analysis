# 环境设置与复现手册 | Setup and Reproduction Runbook

## 当前环境 | Current environment

- MySQL 8.x；
- Navicat 或支持 CSV 导入的 MySQL 客户端；
- 本地源目录 `../mum_baby/`；
- 数据库名将在第 1 课建表评审时由学习者确定。

- MySQL 8.x;
- Navicat or another MySQL client with CSV import support;
- local source directory `../mum_baby/`;
- the learner will choose the database name during the Lesson 1 schema review.

## 源文件 | Source files

| 文件 File | 表头 Header | 预期数据行 Expected data rows |
|---|---|---:|
| `(sample)sam_tianchi_mum_baby.csv` | `user_id,birthday,gender` | 953 |
| `(sample)sam_tianchi_mum_baby_trade_history.csv` | `user_id,auction_id,cat_id,cat1,property,buy_mount,day` | 29,971 |

## 计划执行顺序 | Planned execution order

1. 学习者完成表结构并解释字段类型；
2. 创建数据库和原始暂存表；
3. 在 Navicat 中按表头位置导入 CSV；
4. 运行行数、空值、重复、值域和范围检查；
5. 确认清洗规则后创建分析表；
6. 对账源文件、暂存层和分析层；
7. 为本次运行填写 `docs/run_records/TEMPLATE.md`。

1. The learner completes and explains the schema;
2. create the database and raw staging tables;
3. import both CSV files in Navicat by header position;
4. run volume, null, duplicate, domain, and range checks;
5. create analytical tables only after cleaning rules are approved;
6. reconcile source, staging, and analytical layers;
7. complete `docs/run_records/TEMPLATE.md` for the run.

## 证据门槛 | Evidence gate

在真实导入完成以前，不填写 KPI 数值；在行数和清洗对账通过以前，不开始业务
结论；任何异常处理都必须保留排除数量和理由。

Do not publish KPIs before the real import, do not interpret business results
before reconciliation passes, and record the count and reason for every
excluded anomaly.
