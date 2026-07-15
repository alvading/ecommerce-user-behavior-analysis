# 电商用户行为与转化分析 | E-commerce User Behavior and Conversion Analysis

[中文](#中文说明) · [English](#english-version)

## 中文说明

### 项目概述

这是一个基于阿里巴巴天池公开 `UserBehavior` 数据集的个人数据分析作品集
项目。项目使用 MySQL 和 SQL 分析电商用户行为与转化路径，重点展示数据质量
验证、指标口径设计、业务分析、可视化表达和可复现工作流程。

> **状态：** 进行中<br>
> **主要工具：** MySQL、SQL、Navicat<br>
> **计划工具：** Python（Pandas）、Power BI<br>
> **数据集：** 阿里巴巴天池 UserBehavior 公开数据集

### 业务问题

项目主要回答以下问题：

- 用户在观察期内有多活跃？
- 浏览、收藏、加购和购买行为如何分布？
- 用户转化路径的主要流失环节在哪里？
- 用户活跃度如何随日期和小时变化？
- 购买频次和复购事件呈现什么特征？
- 如何根据行为和购买特征划分用户群体？
- 哪些发现可以支持用户运营与转化优化？

### 数据字段

| 字段 | 中文说明 | English description |
|---|---|---|
| `userid` | 用户唯一标识 | Unique user identifier |
| `itemid` | 商品唯一标识 | Unique item identifier |
| `categoryid` | 商品品类标识 | Product category identifier |
| `behavior_type` | 行为类型：`pv`、`fav`、`cart`、`buy` | Behavior type |
| `behavior_timestamp` | Unix 行为时间戳 | Unix timestamp of the event |

每一行代表一条用户对商品产生的行为事件。原始数据共记录 100,150,807 行；
历史验证发现原始时间戳包含异常值。当前分析窗口为北京时间 2017-11-25
00:00:00（含）至 2017-12-04 00:00:00（不含），保留 100,095,231 行，
排除 55,576 行。以上历史结果仍需通过新版可复现流程重新运行确认。

### 数据架构

```text
原始 CSV / Raw CSV
        ↓
原始暂存表 / stg_user_behavior
        ↓
质量验证 / Data validation
        ↓
清洗与用户级抽样 / Cleaning and user-level sampling
        ↓
分析表 / user_behavior
        ↓
SQL 分析 → Python EDA → Power BI 看板 → 业务报告 → 作品网站
```

原始暂存表始终保留导入数据，清洗逻辑只应用于下游分析层。需要开发样本时按
用户抽样并保留被选用户的完整行为历史，避免按事件抽样破坏用户路径。

### 项目阶段

1. 数据导入与原始层保留；
2. 数据质量验证与时间异常调查；
3. 清洗规则和用户级开发样本；
4. KPI、趋势、漏斗、复购、商品和用户分群 SQL 分析；
5. Python 探索性分析；
6. Power BI 业务看板；
7. 分析报告、个人作品网站和面试材料。

本项目采用教学驱动方式推进：每一步先学习业务问题和 SQL 知识点，再由学习者
执行查询、验证真实结果、解释业务含义，最后把经过验证的 SQL、结果和结论写入
仓库。预先准备的 SQL 只作为参考答案，不代表已经完成分析验证。

### 文档入口

- [项目路线图｜Project roadmap](docs/project_roadmap.md)
- [SQL 学习路线｜Guided SQL learning path](docs/learning_path.md)
- [执行与复现手册｜Setup and reproduction runbook](docs/setup_and_runbook.md)
- [指标字典｜Metric dictionary](docs/metric_dictionary.md)
- [工作日志｜Work log](docs/work_log.md)
- [项目记录｜Project notes](docs/project_notes.md)
- [双语维护规范｜Bilingual style guide](docs/bilingual_style_guide.md)

### 当前状态

- 已关联 GitHub 仓库并建立分层数据架构；
- 已定位原始文件 `../UserBehavior.csv/UserBehavior.csv`，大小为
  3,672,347,465 字节；
- 已建立数据库初始化、导入、验证、清洗与对账 SQL；
- 已建立核心业务分析 SQL 草案和双语文档规范；
- 下一学习步骤是第 1 课：在 Navicat 中确认 MySQL 环境、原始表结构和初始
  数据画像；
- 看板、最终报告和个人作品网站尚未完成。

原始数据不会提交到 GitHub。本项目不包含任何雇主专有数据。

### 作者

Alva Ding——信息系统专业毕业，拥有 BI 项目、业务系统、数据集成、供应链流程
和跨职能项目交付经验，正在通过本项目展示端到端数据分析能力。

---

## English Version

## Project Overview

This is an independent data analytics portfolio project based on the
public Alibaba Tianchi UserBehavior dataset.

The project analyzes e-commerce user behavior and conversion patterns
using SQL and BI-oriented analytical thinking. The goal is to identify
behavioral patterns, validate data quality, investigate conversion
bottlenecks, and translate analytical findings into business insights.

> **Status:** In progress  
> **Primary tools:** MySQL, SQL, Navicat  
> **Planned tools:** Python (Pandas), Power BI  
> **Dataset:** Alibaba Tianchi UserBehavior public dataset

## Business Context

An e-commerce platform generates a large volume of behavioral event
data, including page views, favorites, add-to-cart actions, and
purchases.

The analysis aims to understand how users interact with products and
move through the purchasing journey. Key business questions include:

- How active are users during the observation period?
- How are user behavior events distributed?
- Where are the major conversion bottlenecks?
- How do user activity patterns vary by time?
- What patterns can be observed in repeat purchases?
- Can users be segmented based on behavioral and purchasing
  characteristics?
- Which findings could support user operations and conversion
  improvement?

## Dataset

| Field                | Description                                       |
|----------------------|---------------------------------------------------|
| `userid`             | Unique user identifier                            |
| `itemid`             | Unique item identifier                            |
| `categoryid`         | Product category identifier                       |
| `behavior_type`      | User behavior type: `pv`, `fav`, `cart`, or `buy` |
| `behavior_timestamp` | Unix timestamp of the behavior event              |

### Data Granularity

One row represents **one user behavior event**.

### Initial Data Profile

- Total rows imported: **100,150,807**
- Observed behavior types: `pv`, `fav`, `buy`, `cart`
- Raw minimum timestamp: `-2134949234`
- Raw maximum timestamp: `2122867355`

The initial timestamp range indicates potential anomalous values. These
records are being investigated before defining analytical cleaning
rules.

## Data Architecture

``` text
Raw CSV
   |
   v
stg_user_behavior
   |
   v
Data Validation
   |
   v
Data Cleaning / User-level Sampling
   |
   v
user_behavior
   |
   v
SQL Analysis -> Python EDA -> Dashboard -> Business Insights
```

The staging table retains imported raw records. Cleaning and sampling
logic is applied downstream rather than modifying the raw staging layer.

## Analytical Workflow

1.  **Data ingestion** — Import the full public dataset and preserve raw
    records in `stg_user_behavior`.
2.  **Data validation** — Validate row count, sample records, behavior
    categories, and timestamp range.
3.  **Data cleaning** — Define the valid observation period, investigate
    outliers, check duplicates and missing values, and build a clean
    analytical table.
4.  **Development sampling** — Sample users rather than individual
    events and retain complete event histories for selected users.
5.  **SQL analysis** — Analyze activity, event distribution, conversion
    funnel, time patterns, repeat purchase, and user segments.
6.  **Python exploratory analysis** — Use Pandas for further exploration
    and visualization.
7.  **Dashboard** — Build a business-oriented Power BI dashboard and
    communicate actionable insights.

## Why User-level Sampling?

The project focuses on user behavior paths and conversion. Randomly
sampling individual event rows may remove parts of a user’s behavioral
sequence. For example, a `pv -> cart -> buy` journey could become
`pv -> cart` if the purchase event is excluded.

Therefore, the development dataset will use **user-level sampling and
retain all events for selected users**.

## Repository Structure

``` text
ecommerce-user-behavior-analysis/
├── README.md
├── .gitignore
├── data/
│   ├── raw/
│   │   └── README.md
│   └── processed/
│       └── README.md
├── sql/
│   ├── 00_setup/
│   │   ├── 01_create_database_and_tables.sql
│   │   └── 02_import_raw_data.sql
│   ├── 01_validation/
│   │   └── 01_initial_data_validation.sql
│   ├── 02_cleaning/
│   │   ├── 01_create_analytical_table.sql
│   │   └── 02_reconcile_analytical_table.sql
│   └── 03_analysis/
│       └── README.md
├── notebooks/
│   └── README.md
├── dashboard/
│   └── README.md
└── docs/
    ├── project_notes.md
    ├── project_roadmap.md
    ├── setup_and_runbook.md
    ├── metric_dictionary.md
    ├── work_log.md
    └── run_records/
        └── TEMPLATE.md
```

## Current Progress

- [x] Downloaded and extracted the raw dataset
- [x] Installed and initialized local MySQL
- [x] Created the project database
- [x] Created the staging table
- [x] Imported 100,150,807 raw event records
- [x] Validated behavior categories
- [x] Identified anomalous timestamp range
- [x] Added versioned database setup and import templates
- [x] Added raw-layer validation and analytical-layer reconciliation SQL
- [x] Added a reproducible runbook and run-record template
- [ ] Investigate timestamp anomalies
- [x] Define observation-window cleaning rules
- [ ] Run the complete pipeline again from the verified local source CSV
- [ ] Create user-level development sample
- [ ] Complete SQL exploratory analysis
- [ ] Build conversion funnel analysis
- [ ] Complete repeat-purchase analysis
- [ ] Add Python EDA
- [ ] Build Power BI dashboard
- [ ] Summarize business insights and recommendations

## Project Documentation

- [Project roadmap](docs/project_roadmap.md) — phases, deliverables, and
  completion criteria.
- [Work log](docs/work_log.md) — chronological decisions, evidence, and next
  actions.
- [Metric dictionary](docs/metric_dictionary.md) — canonical KPI definitions
  and interpretation constraints.
- [Project notes](docs/project_notes.md) — current cleaning results.
- [Setup and reproduction runbook](docs/setup_and_runbook.md) — required
  environment, execution order, and evidence gates.
- [Guided SQL learning path](docs/learning_path.md) — lesson sequence and the
  explain–execute–interpret–document workflow.
- [Bilingual style guide](docs/bilingual_style_guide.md) — maintenance rules
  for Chinese/English documents and SQL comments.

> **Current reproducibility note (2026-07-15):** the source is stored at
> `../UserBehavior.csv/UserBehavior.csv` (3,672,347,465 bytes). The outer path
> is a folder whose name also ends in `.csv`. Existing database results still
> need to be reproduced through the versioned pipeline and recorded.

## Portfolio Positioning

This project demonstrates a transition from BI and business systems
experience toward hands-on data analytics. It emphasizes SQL-based
exploration, data quality validation, analytical data modeling, business
metric definition, user behavior analysis, and BI-oriented
communication.

## Data Usage Notice

This project uses a public dataset for independent portfolio analysis.
The raw dataset is **not stored in this GitHub repository**. No
proprietary employer data is included.

## Author

Alva Ding

Information Systems graduate with professional experience in BI
projects, business systems, data integration, supply chain processes,
and cross-functional project delivery.


## Validation Update — Observation Window

- Raw rows: **100,150,807**
- Analytical rows retained: **100,095,231**
- Rows excluded from the analytical layer: **55,576**
- Exclusion rate: **0.0555%**
- Minimum analytical datetime: **2017-11-25 00:00:00**
- Maximum analytical datetime: **2017-12-03 23:59:59**

Daily profiling confirmed the declared observation window from **2017-11-25 through 2017-12-03**. Records outside this period remain in `stg_user_behavior` but are excluded from `user_behavior`.

All time-based SQL uses China Standard Time (`UTC+8`). The filter uses fixed
epoch boundaries so the result does not depend on a machine's default time
zone. This convention must be revised and the pipeline rerun if authoritative
dataset documentation indicates a different time zone.
