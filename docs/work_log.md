# 工作日志 | Work Log

本文件按时间倒序记录项目的重要变更、决策、验证证据和下一步行动。每条记录保留
中英文信息；新增记录也必须遵循这一规范。

This file records material project changes, decisions, validation evidence,
and next actions. New entries should be added in reverse chronological order.

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
