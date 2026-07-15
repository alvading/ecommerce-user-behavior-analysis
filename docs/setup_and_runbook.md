# 环境设置与复现手册 | Setup and Reproduction Runbook

## 目的 | Purpose

本手册用于从阿里巴巴天池公开 UserBehavior CSV 重建 MySQL 分析层，并将环境
设置、原始导入、验证、清洗和对账分开，以便审计每个报告结果。

This runbook recreates the MySQL analytical layer from the public Alibaba
Tianchi UserBehavior CSV. It separates setup, raw ingestion, validation,
cleaning, and reconciliation so every reported result can be audited.

## 环境要求 | Requirements

- MySQL 8.x，并为约一亿行数据和索引预留足够磁盘空间；
- 支持 `LOAD DATA LOCAL INFILE` 的客户端，或 Navicat 导入向导；
- 无表头的公开 `UserBehavior.csv`；
- 所有时间分析将数据库会话时区设为 `+08:00`。

- MySQL 8.x with enough disk space for roughly 100 million rows and indexes;
- a client that supports `LOAD DATA LOCAL INFILE` (or Navicat's import wizard);
- the public headerless `UserBehavior.csv` file;
- database session time zone set to `+08:00` for all datetime analysis.

## 执行顺序 | Execution order

按以下英文编号步骤依次执行。每一步的输出都要保存在运行记录中；只有当对账状态
为 `PASS` 且所有不一致计数为零时，才能继续业务分析。

1. Run `sql/00_setup/01_create_database_and_tables.sql`.
2. Restore the raw CSV and record its provenance in a run record.
3. Edit and run `sql/00_setup/02_import_raw_data.sql`, or import the five
   columns through Navicat into `stg_user_behavior`.
4. Run `sql/01_validation/01_initial_data_validation.sql` and save the output.
5. Review invalid behaviors, duplicate events, and out-of-window rows before
   approving the cleaning rule.
6. Run `sql/02_cleaning/01_create_analytical_table.sql`.
7. Run `sql/02_cleaning/02_reconcile_analytical_table.sql`.
8. Continue only when reconciliation status is `PASS` and all mismatch counts
   are zero.

## 导入说明 | Import notes

CSV 无表头，字段顺序如下。使用 Navicat 时选择逗号分隔、换行分行、UTF-8
编码，并按位置映射字段。导入时不要转换时间戳，暂存表必须保留原始整数。

The CSV has no header and uses this order:

```text
userid,itemid,categoryid,behavior_type,behavior_timestamp
```

For Navicat, select comma as the field delimiter, newline as the row delimiter,
UTF-8 as the encoding, and map fields by position. Do not transform timestamps
during import: the staging table must retain the raw integer value.

## 时间口径 | Time convention

项目将事件时间戳解释为北京时间（`UTC+8`），并使用固定 epoch 值避免受机器
默认时区影响。如果权威数据说明与此不符，必须记录依据、修改所有相关查询并重跑。

The project interprets event timestamps in China Standard Time (`UTC+8`). The
valid window is represented with fixed epoch values to avoid dependence on a
machine's default time zone:

- start: `1511539200` = `2017-11-25 00:00:00` UTC+8, inclusive;
- end: `1512316800` = `2017-12-04 00:00:00` UTC+8, exclusive.

If later evidence from the dataset publisher contradicts this convention, log
the source and decision, revise all dependent queries, and rerun validation.

## 必需证据 | Required evidence

每次完整运行都应复制 `docs/run_records/TEMPLATE.md` 创建带日期的记录，填写数据
来源、文件大小与校验和、工具版本、执行信息、验证结果、异常和输出位置。不得记录
密码、连接字符串或其他凭据。

For every complete run, create a dated copy of
`docs/run_records/TEMPLATE.md`. Record:

- dataset source, local file name, size, checksum, and retrieval date;
- MySQL and client versions;
- execution date and analyst;
- row counts and validation results;
- reconciliation result;
- anomalies, decisions, and links to saved outputs.

Do not paste passwords, connection strings, or other credentials into the
record.
