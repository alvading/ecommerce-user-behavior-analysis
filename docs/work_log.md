# 工作日志 | Work Log

本文件按时间倒序记录项目的重要变更、决策、验证证据和下一步行动。每条记录保留
中英文信息；新增记录也必须遵循这一规范。

This file records material project changes, decisions, validation evidence,
and next actions. New entries should be added in reverse chronological order.

## 2026-07-15——主分支换题重构 | Main-branch project refactor

### 目标 | Objective

在保留 Git 历史的前提下，将主分支从旧 UserBehavior 日志分析完整切换为母婴
交易分析，避免招聘方看到两套互相冲突的字段和业务口径。

Refactor the main branch from the old UserBehavior event-log analysis to the
maternal and infant transaction project while preserving Git history and
removing conflicting schemas and metrics from the recruiter-facing branch.

### 保留 | Retained

- Git 历史与仓库配置；
- 双语维护规范；
- 分析记录和运行记录框架；
- 工作日志与第 1 课学习记录。

- Git history and repository configuration;
- bilingual maintenance rules;
- analysis/run-record framework;
- work log and Lesson 1 learning evidence.

### 删除或重写 | Removed or rewritten

- 删除所有依赖 `behavior_type`、`pv`、`fav`、`cart` 和旧时间窗口的 SQL；
- 重写 README、路线图、指标字典、项目记录、复现手册和数据说明；
- 新 SQL 目录只保留教学骨架，等待学习者逐课编写和验证查询；
- 旧项目仍可从提交 `9908ed1` 及更早 Git 历史中恢复。

- Removed SQL tied to `behavior_type`, `pv`, `fav`, `cart`, and the old time
  window;
- rewrote the README, roadmap, metric dictionary, notes, runbook, and data
  guidance;
- retained only teaching placeholders in SQL until learner validation;
- the old project remains recoverable from commit `9908ed1` and earlier history.

## 2026-07-15——切换至母婴购物数据集 | Switched to maternal and infant dataset

### 变更 | Change

为便于 SQL 教学和个人电脑反复练习，项目主数据源切换为天池数据集 45“母婴购物
数据集”。原 3.4 GB UserBehavior 数据保留为后续进阶项目，不再作为当前第一
项目的数据源。

To support guided SQL learning and repeatable local practice, the primary
dataset was changed to Tianchi Dataset 45, the maternal and infant shopping
dataset. The original 3.4 GB UserBehavior dataset is retained for a later
advanced project.

### 已核验 | Verified

- 婴儿信息文件：954 个物理行、953 条数据、约 20 KB；
- 交易历史文件：29,972 个物理行、29,971 条数据、约 8.4 MB；
- 两个文件均包含表头，并通过 `user_id` 关联；
- 创建双语第 1 课记录 `docs/lessons/01_dataset_and_schema.md`。

- Baby information: 954 physical rows, 953 data rows, approximately 20 KB;
- trade history: 29,972 physical rows, 29,971 data rows, approximately 8.4 MB;
- both files include headers and join through `user_id`;
- created bilingual Lesson 1 at `docs/lessons/01_dataset_and_schema.md`.

## 2026-07-15——仓库双语化 | Repository bilingual conversion

### 目标 | Objective

将仓库内所有面向读者的 README、项目文档、模板和 SQL 注释统一改为中文与英文
双语，以同时支持中文学习过程和英文求职展示。

Convert every reader-facing README, project document, template, and SQL
comment to Chinese and English so the repository supports both Chinese learning
and English portfolio presentation.

### 已完成 | Completed

- README 增加完整中文说明并保留完整英文版本；
- data、docs 和 SQL 分析目录说明改为双语；
- 数据流程、分析记录模板的标题与字段改为双语；
- 全部 SQL 的业务问题、步骤、警告和 QA 注释改为中英并列；
- 新增 `docs/bilingual_style_guide.md` 约束后续维护方式；
- 保持 SQL 表名、字段名和输出别名为英文。

- Added a complete Chinese README while retaining the English version;
- converted data, docs, and SQL directory guidance to bilingual content;
- made pipeline and analysis-record templates bilingual;
- converted business-question, step, warning, and QA comments in all SQL;
- added `docs/bilingual_style_guide.md` for future maintenance;
- kept SQL table names, columns, and output aliases in English.

## 2026-07-15——源路径纠正与教学流程 | Source-path correction and teaching workflow

### 纠正 | Correction

- Verified that `../UserBehavior.csv` is a directory, not the CSV file itself.
- Located the actual file at `../UserBehavior.csv/UserBehavior.csv`.
- Verified its size as 3,672,347,465 bytes (approximately 3.4 GiB).
- Retracted the earlier zero-byte conclusion, which resulted from checking the
  OneDrive directory rather than the nested file.

### 约定的工作方式 | Working method agreed

This project is a guided SQL learning project. Future work follows a teaching
cycle: explain the business question and SQL concept, let the learner write or
run a small step, inspect the real result together, then document the validated
query, interpretation, and interview takeaway. Prepared solution SQL remains a
reference and will not be presented as learner-validated work before execution.

## 2026-07-15——可复现数据库流程基线 | Reproducible database pipeline baseline

### 目标 | Objective

Turn the historical database work into a versioned, rerunnable pipeline with
explicit validation gates.

### 新增 | Added

- Database and table creation SQL for staging and analytical layers.
- A guarded raw CSV import template.
- Raw-layer profiling for volume, cardinality, behavior domain, nulls, exact
  duplicates, timestamp-window reconciliation, and daily distribution.
- An idempotent analytical-table rebuild with derived datetime, date, and hour
  columns.
- Analytical-layer row reconciliation and derived-column integrity checks.
- A setup/reproduction runbook and a dated run-record template.
- Git exclusions for raw data, generated data, credentials, and local files.

### 决策 | Decisions

- Interpret Unix timestamps in China Standard Time (`UTC+8`) unless
  authoritative source documentation later proves otherwise.
- Use fixed epoch boundaries (`1511539200` to `1512316800`) so cleaning is not
  affected by the database server's default time zone.
- Make the analytical rebuild idempotent with `TRUNCATE` followed by `INSERT`,
  preventing duplicate rows when the script is rerun.
- Treat the historical row counts as prior recorded evidence, not as a fresh
  pipeline validation.

### 已完成验证 | Verification performed

- Confirmed both epoch boundaries resolve to the documented local datetimes in
  the workspace time zone (`+08:00`).
- Passed Git whitespace/error checks for all changes.
- Confirmed no command-line MySQL client is currently available in this
  execution environment, so database execution remains pending.

### 下一步 | Next action

Restore the raw CSV and run the setup, import, validation, cleaning, and
reconciliation sequence. Save the results in a dated run record before using
the dataset for KPI analysis.

## 2026-07-15——项目范围与可追溯性基线 | Project scope and traceability baseline

### 目标 | Objective

Define the repository as a complete, reproducible data analytics portfolio
project rather than only a collection of SQL queries.

### 仓库审计 | Repository audit

- Confirmed the formal repository remote:
  `https://github.com/alvading/ecommerce-user-behavior-analysis.git`.
- Confirmed the working branch is `main` and the worktree was clean before
  this documentation update.
- Found an existing README, one project-notes file, and one cleaning query.
- Found a separate `ecommerce-user-behavior-analysis-v0.2` directory outside
  the formal repository. Its visible content matches the formal repository
  except for repository metadata; it is not treated as the source of truth.
- Initially misidentified the nested source as zero bytes because the outer
  `.csv`-named path was treated as the file. See the correction above.

### 决策 | Decisions

- `ecommerce-user-behavior-analysis/` is the single source of truth for all
  future project work.
- The raw dataset will remain outside Git because of its size; only download,
  schema, import, validation, and provenance documentation will be versioned.
- Each result must be traceable to a query/script and a documented metric
  definition before it is used in the dashboard, report, or website.
- The project will progress through foundation, data quality, SQL analysis,
  dashboard, report, website, and interview-readiness phases.

### 新增 | Added

- `docs/project_roadmap.md` — phased delivery plan and definition of done.
- `docs/work_log.md` — chronological decision and evidence record.
- `docs/metric_dictionary.md` — initial KPI definition register.

### 下一步 | Next action

Use the verified local source file to run reproducible ingestion and
data-quality validation scripts before validating business-analysis results.
