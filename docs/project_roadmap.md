# 项目路线图 | Project Roadmap

## 中文概览

项目目标是把阿里巴巴天池用户行为数据集建设成可用于数据分析岗位求职的完整
作品集，包含可复现的数据准备与 SQL 分析、统一指标口径、业务看板、分析报告、
个人作品网站，以及所有决策和结果的追溯记录。

项目分为七个阶段：

1. 基础与可复现性：数据库、导入、环境手册和验证清单；
2. 数据质量与分析数据集：时间异常、重复、空值、值域和层间对账；
3. SQL 业务分析：KPI、行为、时间、漏斗、商品、复购、分群和有限窗口分析；
4. 看板：受众、线框、页面、指标对账和展示材料；
5. 分析报告：执行摘要、方法、发现、建议和技术附录；
6. 作品网站：个人定位、案例页、看板/报告链接、部署和移动端检查；
7. 面试准备：项目陈述、技术权衡、常见问题和简历描述。

每项分析只有同时具备业务问题、指标定义、数据来源、可执行 SQL、验证检查、
保存结果、业务解读、限制说明、工作日志和 README 更新时，才算真正完成。

以下英文版本保留完整的阶段任务和验收标准。

## 1. 项目目标 | Project goal

Build a job-ready data analytics portfolio project from the Alibaba
Tianchi UserBehavior dataset. The final project will demonstrate:

- reproducible data preparation and SQL analysis;
- clear metric definitions and data-quality checks;
- a business-oriented interactive dashboard;
- a concise analytical report with actionable recommendations;
- a personal portfolio website that presents the project to recruiters;
- a traceable record of assumptions, decisions, queries, and outputs.

## 2. 指导原则 | Guiding principles

1. **Evidence before conclusions** — every reported number must be
   reproducible from a versioned query or script.
2. **One definition per metric** — KPI definitions live in the metric
   dictionary and are reused in SQL, the dashboard, and the report.
3. **Preserve raw data** — cleaning is performed downstream; the raw
   staging layer is not overwritten.
4. **Protect data integrity** — user journeys are sampled by user, not by
   individual event row.
5. **Document decisions** — material choices and validation results are
   recorded in the work log.
6. **Portfolio first** — every deliverable should be understandable to a
   hiring manager without access to the local database.

## 3. 交付阶段 | Delivery phases

### 阶段 0——基础与可复现性 | Phase 0 — Foundation and reproducibility

- [x] Create and connect the GitHub repository.
- [x] Record the dataset schema and project context.
- [x] Preserve a staging-to-analytical data architecture.
- [x] Locate and verify the local raw CSV path and file size.
- [x] Add database setup and import SQL.
- [x] Add an environment/setup guide.
- [x] Add a repeatable validation checklist.

**Exit criterion:** a new analyst can follow the documentation and recreate
the analytical table from the public dataset. The instructions exist, but this
criterion remains open until a clean rerun is captured in a run record.

### 阶段 1——数据质量与分析数据集 | Phase 1 — Data quality and analytical dataset

- [x] Define the valid observation window.
- [x] Exclude out-of-window timestamps from the analytical layer.
- [ ] Profile missing values, duplicates, invalid behavior types, and key
  cardinalities.
- [ ] Investigate excluded timestamp records and document the decision.
- [ ] Create a reproducible user-level development sample if needed.
- [ ] Add row-count reconciliation checks between layers.

**Exit criterion:** data-cleaning rules are justified, coded, validated, and
summarized in a data-quality report.

### 阶段 2——SQL 业务分析 | Phase 2 — SQL business analysis

- [ ] Overall KPI and activity overview.
- [ ] Behavior distribution and user engagement.
- [ ] Conversion funnel (`pv`, `fav`, `cart`, `buy`).
- [ ] Hourly and daily activity patterns.
- [ ] Product/category performance.
- [ ] Repeat-purchase and purchase-frequency analysis.
- [ ] User segmentation (RFM or behavior-based segments).
- [ ] Cohort/retention analysis where the nine-day window permits.

**Exit criterion:** each analytical question has a documented definition,
versioned SQL, validated output, interpretation, and limitation.

### 阶段 3——看板 | Phase 3 — Dashboard

- [ ] Define dashboard audience and decisions supported.
- [ ] Create a dashboard wireframe and KPI specification.
- [ ] Build an overview page, funnel page, time-pattern page, and user
  segmentation page.
- [ ] Validate every dashboard figure against SQL outputs.
- [ ] Export screenshots and a dashboard walkthrough for GitHub.

**Exit criterion:** the dashboard tells a coherent business story and all
displayed metrics reconcile with the SQL analysis.

### 阶段 4——分析报告 | Phase 4 — Analytical report

- [ ] Write an executive summary.
- [ ] Explain data, methods, and limitations.
- [ ] Present findings with supporting charts.
- [ ] Translate findings into prioritized business recommendations.
- [ ] Add a technical appendix linking findings to source queries.

**Exit criterion:** the report is recruiter-readable, evidence-backed, and
available in both repository-friendly and shareable formats.

### 阶段 5——作品网站 | Phase 5 — Portfolio website

- [ ] Define personal positioning and site information architecture.
- [ ] Build a responsive landing page and project case-study page.
- [ ] Embed dashboard screenshots or a public dashboard where feasible.
- [ ] Link the report, GitHub repository, and selected SQL examples.
- [ ] Add deployment, accessibility, and mobile checks.

**Exit criterion:** a recruiter can understand the business problem, method,
key findings, and the author's contribution within a few minutes.

### 阶段 6——面试准备 | Phase 6 — Interview readiness

- [ ] Prepare a two-minute project pitch.
- [ ] Document major trade-offs and technical decisions.
- [ ] Prepare likely SQL, metric, data-quality, and business questions.
- [ ] Add a concise resume-ready project description.

## 4. 必需成果结构 | Required artifact structure

```text
data/                 # Data notices, schemas, and small safe samples only
sql/                  # Setup, validation, cleaning, analysis, and QA queries
notebooks/            # Optional Python EDA and chart generation
dashboard/            # Dashboard specification, screenshots, and exports
reports/              # Final analytical report and supporting assets
website/              # Portfolio website source
docs/                 # Roadmap, work log, metric dictionary, and decisions
```

Large raw data, database files, credentials, and machine-specific files must
not be committed.

## 5. 每项分析的完成标准 | Definition of done for every analysis

An analysis item is complete only when it includes:

1. business question;
2. metric definition and grain;
3. source table and filters;
4. executable SQL or script;
5. validation/reconciliation checks;
6. saved result or summarized output;
7. interpretation and business implication;
8. limitations and caveats;
9. work-log entry and README progress update.
