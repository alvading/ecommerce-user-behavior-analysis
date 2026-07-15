# 双语维护规范 | Bilingual Style Guide

## 中文规范

本仓库所有面向读者的内容均采用中文和英文双语维护。

- Markdown 标题采用“中文｜English”；长文档可以先提供完整中文版本，再提供
  完整英文版本。
- 表格列名采用“中文 / English”，代码字段名保持原样。
- SQL 的业务问题、口径、步骤、风险和质量检查注释必须中英并列。
- SQL 标识符、表名、字段名和输出别名保持英文，便于 MySQL、Power BI 和国际
  招聘场景复用。
- 新增或修改内容时，必须同步更新两种语言；若两种语言含义冲突，以经过数据验证
  的业务口径为准，并立即修正另一种语言。
- 技术术语首次出现时提供双语名称，后续可保留 KPI、CTE、QA 等常用缩写。
- Git 配置和代码规则不翻译，只将面向人的注释双语化。

## English guidelines

All reader-facing content in this repository is maintained in both Chinese and
English.

- Markdown headings use “Chinese | English.” Long documents may provide a
  complete Chinese version followed by a complete English version.
- Table headers use “Chinese / English”; code field names remain unchanged.
- SQL comments for business questions, definitions, steps, risks, and QA must
  be bilingual.
- SQL identifiers, table names, column names, and output aliases remain in
  English for reuse in MySQL, Power BI, and international recruiting contexts.
- Whenever content changes, update both languages. If meanings conflict, use
  the data-validated business definition and immediately correct the other
  language.
- Give the bilingual name when a technical term first appears; common English
  abbreviations such as KPI, CTE, and QA may be reused afterward.
- Do not translate configuration or code rules; translate only human-facing
  comments.

