# 数据流程运行记录 | Data Pipeline Run Record — YYYY-MM-DD

## 环境 | Environment

| 项目 Item | 内容 Value |
|---|---|
| 分析人员 / Analyst | |
| 执行日期 / Execution date | |
| MySQL 版本 / MySQL version | |
| SQL 客户端及版本 / SQL client and version | |
| 会话时区 / Session time zone | `+08:00` |

## 源数据 | Source data

| 项目 Item | 内容 Value |
|---|---|
| Dataset source URL | |
| Retrieval date | |
| Local file name | `UserBehavior.csv` |
| File size in bytes | |
| SHA-256 checksum | |
| Physical CSV row count | |

## 验证结果 | Validation results

| 检查 Check | 结果 Result | 状态 Status |
|---|---:|---|
| Staging rows | | |
| Distinct users | | |
| Distinct items | | |
| Distinct categories | | |
| Invalid behavior rows | | |
| Rows with null fields | | |
| Duplicate event groups | | |
| Excess duplicate rows | | |
| Rows before valid window | | |
| Rows inside valid window | | |
| Rows after valid window | | |

## 分析层对账 | Analytical-layer reconciliation

| 检查 Check | 预期 Expected | 实际 Actual | 状态 Status |
|---|---:|---:|---|
| Analytical rows | | | |
| Excluded rows | | | |
| Datetime mismatches | 0 | | |
| Date mismatches | 0 | | |
| Hour mismatches | 0 | | |
| Invalid behavior rows | 0 | | |
| Out-of-window rows | 0 | | |

## 决策与异常 | Decisions and anomalies

- 在此记录观察、调查证据和批准的决策。

- Add observations, investigation evidence, and approved decisions here.

## 输出位置 | Output locations

- 在此添加查询输出或截图链接。

- Add links to query outputs or screenshots here.
