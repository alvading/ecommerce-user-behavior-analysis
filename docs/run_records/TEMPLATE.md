# 数据流程运行记录 | Data Pipeline Run Record — YYYY-MM-DD

## 环境 | Environment

| 项目 Item | 内容 Value |
|---|---|
| 分析人员 / Analyst | |
| 执行日期 / Execution date | |
| MySQL 版本 / MySQL version | |
| SQL 客户端及版本 / SQL client and version | |
| 数据库名称 / Database name | |

## 源文件 | Source files

| 检查 Check | Baby CSV | Trade CSV |
|---|---|---|
| 文件名 / File name | `(sample)sam_tianchi_mum_baby.csv` | `(sample)sam_tianchi_mum_baby_trade_history.csv` |
| 文件大小 / File size | | |
| SHA-256 / Checksum | | |
| 物理行数 / Physical rows | 954 | 29,972 |
| 预期数据行 / Expected data rows | 953 | 29,971 |

## 导入对账 | Import reconciliation

| 检查 Check | 预期 Expected | 实际 Actual | 状态 Status |
|---|---:|---:|---|
| 婴儿暂存表行数 / Baby staging rows | 953 | | |
| 交易暂存表行数 / Trade staging rows | 29,971 | | |

## 数据质量 | Data quality

| 检查 Check | 结果 Result | 状态 Status |
|---|---:|---|
| 婴儿表空值 / Baby nulls | | |
| 交易表空值 / Trade nulls | | |
| 重复婴儿用户 / Duplicate baby users | | |
| 重复交易记录 / Duplicate trade rows | | |
| `auction_id` 重复 / Duplicate auction IDs | | |
| 无效生日 / Invalid birthdays | | |
| 无效交易日期 / Invalid trade dates | | |
| 无效性别编码 / Invalid gender codes | | |
| 非正购买数量 / Non-positive quantities | | |
| 婴儿信息用户覆盖率 / Baby-info user coverage | | |

## 清洗层对账 | Cleaning reconciliation

| 检查 Check | 预期 Expected | 实际 Actual | 状态 Status |
|---|---:|---:|---|
| 交易分析表行数 / Analytical trade rows | | | |
| 婴儿维度表行数 / Baby dimension rows | | | |
| 排除记录数 / Excluded rows | 有明确理由 / Explained | | |
| 日期转换失败 / Date conversion failures | 0 或已记录 / 0 or documented | | |

## 决策、异常与输出 | Decisions, anomalies, and outputs

- 记录异常、调查证据、清洗决策及对应 SQL。
- 添加查询输出、截图或聚合文件链接。
- 不得记录密码、连接字符串或其他凭据。

- Record anomalies, evidence, cleaning decisions, and related SQL.
- Link query outputs, screenshots, or aggregate files.
- Never include passwords, connection strings, or credentials.
