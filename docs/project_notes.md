# 项目记录 | Project Notes

## 观察窗口清洗结果 | Observation-window cleaning result

历史记录：原始数据 100,150,807 行；分析层保留 100,095,231 行；排除
55,576 行，占 0.0555%。分析时间范围为北京时间 2017-11-25 00:00:00 至
2017-12-03 23:59:59。

- Raw rows: 100,150,807
- Analytical rows retained: 100,095,231
- Rows excluded: 55,576
- Exclusion rate: 0.0555%
- Minimum analytical datetime: 2017-11-25 00:00:00
- Maximum analytical datetime: 2017-12-03 23:59:59

清洗规则：保留 2017-11-25 00:00:00（含）至 2017-12-04 00:00:00
（不含）的记录。

Cleaning rule: retain records from 2017-11-25 00:00:00 inclusive to
2017-12-04 00:00:00 exclusive.

时间口径：北京时间（`UTC+8`）。SQL 使用固定 epoch 边界 `1511539200`
（含）和 `1512316800`（不含）。

Time convention: China Standard Time (`UTC+8`). Fixed epoch boundaries are
used in SQL: `1511539200` inclusive and `1512316800` exclusive.

复现状态（2026-07-15）：原始 CSV 位于 `../UserBehavior.csv/UserBehavior.csv`，
文件大小为 3,672,347,465 字节。外层 `UserBehavior.csv` 实际是目录，因此早期
检查曾误判为空。目前历史结果尚未通过新版流程重新运行确认。

Reproduction status (2026-07-15): the source CSV was located at
`../UserBehavior.csv/UserBehavior.csv` and its size was verified as
3,672,347,465 bytes. The outer `UserBehavior.csv` path is a directory, which
caused an earlier size check to misidentify it as empty. The historical results
have not yet been rerun through the newly versioned pipeline, and no
command-line MySQL client is available in the current execution environment.
Treat the values as prior recorded evidence until a new run record confirms
them.
