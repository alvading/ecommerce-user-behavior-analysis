# 第 2 课：数据库、暂存表与导入 | Lesson 2: Database, Staging, and Import

## 学习目标 | Learning objectives

- 创建项目数据库并理解字符集与排序规则；
- 创建不强制业务唯一性的原始暂存表；
- 将 CSV 导入结果与源文件行数对账；
- 用真实查询结果记录环境和执行证据。

- Create the project database and understand charset/collation;
- create raw staging tables without assumed business uniqueness;
- reconcile CSV imports to source row counts;
- record environment and execution evidence from real query output.

## 已验证环境 | Verified environment

核验日期 / Verification date: `2026-07-15`

| 项目 Item | 实际结果 Actual result | 状态 Status |
|---|---|---|
| 当前数据库 / Current database | `mum_baby_analysis` | PASS |
| MySQL 版本 / MySQL version | `9.7.1` | PASS |

学习者执行了 `CREATE DATABASE`、`USE` 和环境验证查询，并返回以上结果。

The learner executed `CREATE DATABASE`, `USE`, and the environment verification
query and reported the results above.

## 当前步骤 | Current step

- [x] 创建并选择项目数据库 / Create and select the project database
- [x] 创建 `stg_baby_raw` / Create `stg_baby_raw`
- [x] 验证婴儿暂存表结构 / Verify the baby staging schema
- [x] 创建 `stg_trade_raw` / Create `stg_trade_raw`
- [x] 验证交易暂存表结构 / Verify the trade staging schema
- [x] 导入并对账婴儿信息 CSV / Import and reconcile the baby CSV
- [x] 导入并对账交易历史 CSV / Import and reconcile the trade CSV

## `stg_baby_raw` 验证结果 | Schema result

| 字段 Field | 类型 Type | 允许空值 Nullable | 状态 Status |
|---|---|---|---|
| `user_id` | `VARCHAR(20)` | YES | PASS |
| `birthday` | `VARCHAR(20)` | YES | PASS |
| `gender` | `VARCHAR(10)` | YES | PASS |

未设置主键、唯一约束或业务检查，符合原始暂存层设计。

No primary key, unique constraint, or business check is enforced, matching the
raw-staging design.

## `stg_trade_raw` 验证结果 | Schema result

| 字段 Field | 类型 Type | 允许空值 Nullable | 状态 Status |
|---|---|---|---|
| `user_id` | `VARCHAR(20)` | YES | PASS |
| `auction_id` | `VARCHAR(30)` | YES | PASS |
| `cat_id` | `VARCHAR(20)` | YES | PASS |
| `cat1` | `VARCHAR(20)` | YES | PASS |
| `property` | `TEXT` | YES | PASS |
| `buy_mount` | `VARCHAR(20)` | YES | PASS |
| `day` | `VARCHAR(20)` | YES | PASS |

字段数量、顺序和名称与交易 CSV 表头一致。

The count, order, and names match the trade CSV header.

## 婴儿信息导入结果 | Baby import result

| 检查 Check | 预期 Expected | 实际 Actual | 状态 Status |
|---|---:|---:|---|
| 导入前行数 / Rows before import | 0 | 0 | PASS |
| 导入后行数 / Rows after import | 953 | 953 | PASS |
| 误导入表头 / Accidental header rows | 0 | 0 | PASS |

婴儿信息暂存表与源 CSV 数据行数完全对账。

The baby staging table reconciles exactly to the source CSV data-row count.

## 交易历史导入结果 | Trade import result

| 检查 Check | 预期 Expected | 实际 Actual | 状态 Status |
|---|---:|---:|---|
| 导入前行数 / Rows before import | 0 | 0 | PASS |
| 导入后行数 / Rows after import | 29,971 | 29,971 | PASS |
| 误导入表头 / Accidental header rows | 0 | 0 | PASS |
| 抽样字段对齐 / Sample field alignment | 正确 / Correct | 正确 / Correct | PASS |

交易暂存表与源 CSV 数据行数完全对账，长属性串未造成后续字段错位。

The trade staging table reconciles exactly to the source CSV, and the long
property string did not shift subsequent fields.

## 婴儿表字段完整性 | Baby-field completeness

| 检查 Check | `user_id` | `birthday` | `gender` | 状态 Status |
|---|---:|---:|---:|---|
| 非 NULL / Non-null | 953 | 953 | 953 | PASS |
| NULL | 0 | 0 | 0 | PASS |
| 空字符串 / Blank string | 0 | 0 | 0 | PASS |

完整性通过不代表值域、格式或唯一性通过，仍需后续检查。

Completeness does not prove valid domains, formats, or uniqueness; those checks
remain pending.

## 婴儿用户唯一性 | Baby-user uniqueness

| 检查 Check | 实际结果 Actual | 状态 Status |
|---|---:|---|
| 重复 `user_id` 分组 / Duplicate user-ID groups | 0 | PASS |
| NULL `user_id` / Null user IDs | 0 | PASS |

在当前数据快照中，`user_id` 已满足非空和唯一要求，可以作为清洗后
`dim_baby` 的主键。该结论不用于约束原始暂存表。

In the current snapshot, `user_id` is non-null and unique and can serve as the
cleaned `dim_baby` primary key. The raw staging table remains unconstrained.

## 性别值域 | Gender domain

| 原始编码 Raw code | 字符长度 Length | 用户数 Users |
|---|---:|---:|
| `0` | 1 | 489 |
| `1` | 1 | 438 |
| `2` | 1 | 26 |
| **合计 / Total** | | **953** |

值域和长度检查通过，清洗后可转换为 `TINYINT UNSIGNED` 并限制为 0/1/2。
编码对应的性别标签必须依据权威数据说明确认，不能根据人数推断。

The domain and length checks pass. The cleaned value can use
`TINYINT UNSIGNED` with a 0/1/2 constraint. Gender labels require authoritative
dataset documentation and must not be inferred from counts.

## 生日格式与范围 | Birthday format and range

| 检查 Check | 实际结果 Actual | 状态 Status |
|---|---:|---|
| 总行数 / Total rows | 953 | |
| 八位数字 / Eight-digit values | 953 | PASS |
| 格式异常 / Invalid formats | 0 | PASS |
| 原始最小值 / Raw minimum | `19840616` | REVIEW |
| 原始最大值 / Raw maximum | `20150815` | REVIEW |

所有值都满足 `YYYYMMDD` 的外观格式，但边界值仍需进行日期转换和业务合理性检查。
特别是 1984 年生日必须结合交易日期计算年龄后再决定如何处理。

Every value matches the appearance of `YYYYMMDD`, but boundary values still
require calendar conversion and business-plausibility checks. In particular,
the 1984 birthday requires age-at-transaction analysis before a cleaning rule
is chosen.
