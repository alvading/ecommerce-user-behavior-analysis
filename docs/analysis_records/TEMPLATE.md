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
| 时间窗口/时区 / Time window/time zone | `2017-11-25` to `2017-12-03`, UTC+8 |
| 使用指标 / Metrics used | 链接至 / Link to `docs/metric_dictionary.md` |
| 过滤条件/阈值 / Filters/thresholds | |

## 验证 | Validation

| 检查 Check | 预期 Expected | 实际 Actual | 状态 Status |
|---|---|---|---|
| Source reconciliation | `PASS` | | |
| Result row count | Defined by output grain | | |
| Null/unclassified rows | 0 unless documented | | |
| Boundary/denominator check | Documented | | |

## 结果 | Results

添加紧凑的结果表或聚合输出链接，不要把数百万行结果粘贴到本文档。

Add a compact result table or link to the saved aggregate output. Do not paste
millions of rows into this document.

## 解读 | Interpretation

### 发现 | Finding

State what the validated result shows without implying causality.

### 业务含义 | Business implication

Explain which decision or operational question the finding informs.

### 建议 | Recommendation

State a testable, prioritized action. Separate evidence from suggestion.

## 限制 | Limitations

- Record missing fields, proxy metrics, observation-window limitations,
  thresholds, and alternative explanations.

## 看板与报告用途 | Dashboard/report usage

- Dashboard page and visual:
- Report section:
- Portfolio website section:
