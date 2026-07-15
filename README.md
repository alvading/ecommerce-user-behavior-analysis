# 淘宝母婴商品交易与用户消费分析

# Taobao Maternal and Infant Transaction & Customer Analysis

[中文](#中文说明) · [English](#english-version)

## 中文说明

### 项目概述

这是一个以 SQL 学习和数据分析岗位求职为目标的端到端作品集项目。项目基于
[阿里云天池母婴购物数据集](https://tianchi.aliyun.com/dataset/45)，通过真实的
淘宝母婴商品交易记录和婴儿信息，逐步完成数据库设计、数据质量检查、SQL 业务
分析、Power BI 看板、双语分析报告和个人作品网站。

本项目不是一次性生成答案，而是采用“讲解 → 学习者编写/执行 → 共同调试 →
验证结果 → 记录结论”的教学流程。只有学习者理解并亲自验证过的 SQL 才会作为
正式成果进入仓库。

> **状态：** 进行中——第 1 课：数据认识与表结构设计<br>
> **主要工具：** MySQL、Navicat、SQL<br>
> **计划工具：** Power BI、HTML/CSS/JavaScript<br>
> **语言：** 中文与英文双语

### 数据集

原始文件存放在仓库外部的 `../mum_baby/`，不会提交至 GitHub。

| 数据表 | 文件 | 数据行数 | 主要内容 |
|---|---|---:|---|
| 婴儿信息 | `(sample)sam_tianchi_mum_baby.csv` | 953 | 用户、婴儿生日、性别编码 |
| 交易历史 | `(sample)sam_tianchi_mum_baby_trade_history.csv` | 29,971 | 用户、交易/商品、品类、属性、购买数量、日期 |

两张表通过 `user_id` 关联。实际关联覆盖率、唯一性、日期有效性、购买数量范围和
性别值域必须通过 SQL 验证，不能仅凭字段说明假设。

### 核心业务问题

- 数据期内的交易记录数、购买用户数和购买件数是多少？
- 销量如何随年、季度和月份变化？
- 哪些一级类目和细分类目贡献最高？
- 用户购买频次和复购行为如何分布？
- 婴儿年龄与性别是否对应不同的购买结构？
- 如何识别高频用户、复购用户和有流失风险的用户？
- 哪些发现可以支持选品、营销和用户运营？

数据不含价格、收入、利润、浏览、收藏或加购行为，因此项目不分析 GMV、利润或
浏览到购买的转化漏斗。

### 数据架构

```text
原始 CSV / Raw CSV
        ↓
原始暂存表 / Staging tables
        ↓
数据质量验证 / Data-quality validation
        ↓
类型转换与清洗 / Type conversion and cleaning
        ↓
维度表 + 事实表 / Dimension + fact tables
        ↓
SQL 分析 → Power BI 看板 → 双语报告 → 作品网站
```

### 教学路线

1. 认识 CSV、判断字段类型、设计表结构；
2. 建库建表、导入数据、完成质量检查；
3. 建立清洗后的维度表与事实表并完成对账；
4. 分析整体 KPI 和时间趋势；
5. 分析商品与品类表现；
6. 分析用户购买频次、复购和分层；
7. 关联婴儿信息，分析年龄与性别差异；
8. 设计并验证 Power BI 看板；
9. 完成双语报告、个人作品网站和面试表达。

### 仓库结构

```text
ecommerce-user-behavior-analysis/
├── README.md
├── data/                       # 数据说明；不包含原始 CSV
├── sql/
│   ├── 00_setup/              # 学习者编写的建库、建表与导入 SQL
│   ├── 01_validation/         # 数据质量检查
│   ├── 02_cleaning/           # 清洗、建模与对账
│   └── 03_analysis/           # 经过验证的业务分析
└── docs/
    ├── lessons/               # 每一课的知识、练习和反馈
    ├── run_records/           # 数据流程执行证据
    ├── analysis_records/      # 查询结果、解读和限制
    ├── learning_path.md
    ├── metric_dictionary.md
    ├── project_roadmap.md
    └── work_log.md
```

### 当前进度

- [x] 确认并下载母婴购物数据集
- [x] 核验两个 CSV 的文件名、表头、样例和行数
- [x] 建立双语教学与成果追踪框架
- [x] 清理旧 UserBehavior 项目在主分支中的专用 SQL
- [ ] 完成第 1 课字段类型与表结构评审
- [ ] 学习者编写并执行建表 SQL
- [ ] 导入并验证真实数据
- [ ] 完成 SQL 业务分析
- [ ] 完成 Power BI 看板
- [ ] 完成双语报告和个人作品网站

### 文档入口

- [第 1 课：数据与表结构](docs/lessons/01_dataset_and_schema.md)
- [SQL 学习路线](docs/learning_path.md)
- [项目路线图](docs/project_roadmap.md)
- [指标字典](docs/metric_dictionary.md)
- [环境与复现手册](docs/setup_and_runbook.md)
- [工作日志](docs/work_log.md)
- [双语维护规范](docs/bilingual_style_guide.md)

### 作者

Alva Ding——信息系统专业毕业，拥有 BI 项目、业务系统、数据集成、供应链流程和
跨职能项目交付经验，正在通过本项目展示端到端数据分析能力。

---

## English Version

### Overview

This is an end-to-end SQL learning and data-analytics portfolio project based
on the [Alibaba Tianchi maternal and infant shopping dataset](https://tianchi.aliyun.com/dataset/45).
It uses real Taobao transaction and baby-information records to develop database
design, data-quality, SQL analysis, Power BI, bilingual reporting, and portfolio
website skills.

The project follows an instructor-guided cycle: explanation, learner writing or
execution, joint debugging, validation, and documented interpretation. Only SQL
that the learner understands and validates becomes a formal portfolio artifact.

### Dataset

The source files remain outside Git in `../mum_baby/`.

| Table | File | Data rows | Content |
|---|---|---:|---|
| Baby information | `(sample)sam_tianchi_mum_baby.csv` | 953 | User, birthday, gender code |
| Trade history | `(sample)sam_tianchi_mum_baby_trade_history.csv` | 29,971 | User, transaction/item, categories, properties, quantity, date |

The tables join on `user_id`. SQL must verify uniqueness, join coverage, date
validity, purchase-quantity ranges, and the gender domain.

### Business questions

- What are the transaction-row, purchasing-user, and unit volumes?
- How do purchase quantities change by year, quarter, and month?
- Which top-level and detailed categories contribute most?
- How are purchase frequency and repeat purchase distributed?
- Do baby age and gender correspond to different purchase patterns?
- How can customers be segmented for merchandising and operations?

The dataset has no price, revenue, profit, page-view, favorite, or cart data.
Therefore, the project does not claim GMV, profit, or browse-to-purchase funnel
metrics.

### Workflow

```text
Raw CSV → staging → validation → cleaning → dimension/fact model
        → SQL analysis → Power BI → bilingual report → portfolio website
```

### Current status

Lesson 1 is in progress: the files and schemas have been inspected, and the
learner is revising data types before writing the first `CREATE TABLE` scripts.
See the Chinese section above and the linked bilingual documents for the full
roadmap and progress checklist.
