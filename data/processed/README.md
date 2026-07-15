# 处理后数据 | Processed Data

生成的数据摘录保存在本地此目录，并默认被 Git 排除。供看板使用的小型、聚合、
非敏感结果文件，后续可以通过 `.gitignore` 的明确例外规则加入仓库。

Generated extracts are stored locally here and excluded from Git. Small,
aggregated, non-sensitive result files intended for the dashboard may later be
added through an explicit `.gitignore` exception.

当前 MySQL 分析表是处理后数据的唯一事实来源：

The MySQL analytical table is the current source of truth:
`ecommerce_analysis.user_behavior`.
