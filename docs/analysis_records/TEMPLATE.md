# 分析记录 | Analysis Record — ANALYSIS-ID / YYYY-MM-DD

## 问题与决策背景 | Question and decision context

| 项目 Item | 内容 Value |
|---|---|
| 业务问题 / Business question | |
| 目标读者 / Intended audience | |
| 支持的决策 / Decision supported | |
| SQL 文件 / SQL file | |
| Git 提交 / Git commit | |
| 数据流程运行记录 / Pipeline run record | |
| 执行日期 / Execution date | |

## 口径定义 | Definitions

| 项目 Item | 内容 Value |
|---|---|
| 分析粒度 / Analysis grain | |
| 分析总体 / Population | |
| 时间窗口 / Time window | 填写本次查询的实际范围 / Enter the actual query range |
| 使用指标 / Metrics used | 链接至 / Link to `docs/metric_dictionary.md` |
| 过滤条件/阈值 / Filters/thresholds | |

## 验证 | Validation

| 检查 Check | 预期 Expected | 实际 Actual | 状态 Status |
|---|---|---|---|
| 来源对账 / Source reconciliation | `PASS` | | |
| 结果行数 / Result row count | 由输出粒度决定 / Defined by output grain | | |
| 空值或未分类 / Null or unclassified rows | 0，或已说明 / 0 unless documented | | |
| 边界与分母 / Boundary and denominator | 已记录 / Documented | | |

## 结果 | Results

添加紧凑的结果表或聚合输出链接，不要把数百万行结果粘贴到本文档。

Add a compact result table or link to the saved aggregate output. Do not paste
millions of rows into this document.

## 解读 | Interpretation

### 发现 | Finding

说明经过验证的结果显示了什么，不要暗示未经证明的因果关系。

State what the validated result shows without implying causality.

### 业务含义 | Business implication

说明该发现能够支持哪个业务决策或运营问题。

Explain which decision or operational question the finding informs.

### 建议 | Recommendation

提出可测试、有优先级的行动，并明确区分证据与建议。

State a testable, prioritized action. Separate evidence from suggestion.

## 限制 | Limitations

- 记录缺失字段、代理指标、观察窗口、阈值和其他可能解释。
- Record missing fields, proxy metrics, observation-window limitations,
  thresholds, and alternative explanations.

## 看板与报告用途 | Dashboard/report usage

- 看板页面与图表 / Dashboard page and visual:
- 报告章节 / Report section:
- 作品网站章节 / Portfolio website section:
