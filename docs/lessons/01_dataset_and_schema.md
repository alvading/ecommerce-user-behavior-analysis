# 第 1 课：认识数据与设计表结构 | Lesson 1: Dataset and Schema Design

## 学习目标 | Learning objectives

- 区分 CSV 的物理行数和实际数据行数；
- 根据样例和业务含义判断 MySQL 字段类型；
- 理解为什么原始暂存表应尽量保留源数据；
- 识别关联键、主键候选和可能的数据质量风险。

- Distinguish physical CSV rows from actual data rows;
- infer MySQL data types from samples and business meaning;
- understand why a raw staging table should preserve source values;
- identify join keys, primary-key candidates, and data-quality risks.

## 数据源核验 | Source verification

核验日期 / Verification date: `2026-07-15`

| 文件 File | 字节大小 Size | 物理行数 Physical rows | 数据行数 Data rows |
|---|---:|---:|---:|
| `(sample)sam_tianchi_mum_baby.csv` | 约 20 KB | 954 | 953 |
| `(sample)sam_tianchi_mum_baby_trade_history.csv` | 约 8.4 MB | 29,972 | 29,971 |

两个 CSV 都包含表头。实际数据行数等于物理行数减一。

Both CSV files include a header. Actual data rows equal physical rows minus
one.

## 字段清单 | Field inventory

### 婴儿信息 | Baby information

| 字段 Field | 样例 Example | 业务含义 Business meaning |
|---|---|---|
| `user_id` | `2757` | 用户标识 / User identifier |
| `birthday` | `20130311` | 婴儿出生日期 / Baby birth date |
| `gender` | `1` | 性别编码 / Gender code |

### 交易记录 | Trade history

| 字段 Field | 样例 Example | 业务含义 Business meaning |
|---|---|---|
| `user_id` | `786295544` | 用户标识 / User identifier |
| `auction_id` | `41098319944` | 交易或商品记录标识 / Transaction or item record identifier |
| `cat_id` | `50014866` | 细分类目编码 / Detailed category code |
| `cat1` | `50022520` | 一级类目编码 / Top-level category code |
| `property` | `21458:86755362;...` | 商品属性编码串 / Encoded item properties |
| `buy_mount` | `2` | 购买数量 / Purchase quantity |
| `day` | `20140919` | 购买日期 / Purchase date |

## 已识别的设计风险 | Identified design risks

1. `auction_id` 示例值超过有符号 `INT` 的最大值，不能直接使用普通 `INT`。
2. `property` 可能很长，不适合短 `VARCHAR`，也不能当作数值。
3. `birthday` 和 `day` 虽然看起来像整数，但业务上是日期。
4. `gender` 是分类编码，不应拿来进行加减运算。
5. `user_id` 是两表关联键，但是否唯一必须分别验证，不能仅凭字段名假设。

1. Sample `auction_id` values exceed signed `INT`; ordinary `INT` is unsafe.
2. `property` can be long and is neither a short string nor a numeric value.
3. `birthday` and `day` look numeric but represent dates.
4. `gender` is a categorical code, not an arithmetic measure.
5. `user_id` joins the tables, but uniqueness must be tested rather than
   assumed from the name.

## 本课练习 | Exercise

请为每个字段填写你建议的 MySQL 类型，并简要说明理由。先不要查最终答案。

Choose a MySQL type for every field and briefly explain why. Do not look up a
final solution yet.

| 表 Table | 字段 Field | 你建议的类型 Your type | 理由 Reason |
|---|---|---|---|
| baby | `user_id` | | |
| baby | `birthday` | | |
| baby | `gender` | | |
| trade | `user_id` | | |
| trade | `auction_id` | | |
| trade | `cat_id` | | |
| trade | `cat1` | | |
| trade | `property` | | |
| trade | `buy_mount` | | |
| trade | `day` | | |

## 课程状态 | Lesson status

- [x] 已核验文件、表头、样例和行数 / Verified files, headers, samples, and rows
- [x] 学习者提交第一版字段类型判断 / Learner submitted first type inference
- [ ] 共同评审建表方案 / Review schema together
- [ ] 学习者编写并执行 `CREATE TABLE` / Learner writes and runs `CREATE TABLE`
- [ ] 记录真实导入结果 / Record actual import results

> 后续验证更新 / Later validation update: `stg_baby_raw.user_id` 在 953 条记录中
> 无 NULL、无空字符串且无重复，因此已确认是清洗后维度表的主键候选。
>
> `stg_baby_raw.user_id` was later verified as non-null, non-blank, and unique
> across 953 records, confirming it as the cleaned dimension's primary-key
> candidate.

## 学习者第一版答案 | Learner's first answer

| 表 Table | 字段 Field | 第一版类型 First type |
|---|---|---|
| baby | `user_id` | `BIGINT` |
| baby | `birthday` | `DATE` |
| baby | `gender` | `VARCHAR(10)` |
| trade | `user_id` | `BIGINT` |
| trade | `auction_id` | `BIGINT` |
| trade | `cat_id` | `BIGINT` |
| trade | `cat1` | `BIGINT` |
| trade | `property` | `STRING`（MySQL 无此类型 / not a MySQL type） |
| trade | `buy_mount` | `BIGINT` |
| trade | `day` | `TIMESTAMP` |

## 第一轮教师反馈 | First review

- `user_id`、`auction_id`、`cat_id` 和 `cat1` 使用 `BIGINT` 是安全方向；这些
  编码不应参与算术，可进一步考虑 `UNSIGNED`。
- `birthday` 在业务分析层应为 `DATE`，但原始 CSV 是 `YYYYMMDD`；暂存层可先用
  `CHAR(8)` 保留原值，清洗时再转换。
- `gender` 是分类编码。`VARCHAR(10)` 能保存，但 `TINYINT UNSIGNED` 加值域检查
  更紧凑，也更能表达 0/1/2 编码。
- MySQL 没有 `STRING` 类型；长属性编码串适合 `TEXT`。
- `buy_mount` 是购买数量，但 `BIGINT` 通常过大；应先查看最小值和最大值，再在
  `SMALLINT UNSIGNED` 或 `INT UNSIGNED` 中选择。
- `day` 只有日期、没有时分秒，分析层应使用 `DATE` 而非 `TIMESTAMP`；暂存层可
  先使用 `CHAR(8)`。

- `BIGINT` is a safe direction for identifier fields; `UNSIGNED` may express
  the non-negative domain more clearly.
- `birthday` belongs in `DATE` in the analytical layer, while staging can
  preserve the raw `YYYYMMDD` value as `CHAR(8)`.
- `gender` is categorical. `TINYINT UNSIGNED` plus a domain check is more
  precise than `VARCHAR(10)` for codes 0/1/2.
- MySQL has no `STRING` type; use `TEXT` for the long encoded property value.
- Profile `buy_mount` before choosing between `SMALLINT UNSIGNED` and
  `INT UNSIGNED`; `BIGINT` is likely unnecessary.
- `day` has no time-of-day component, so the analytical type should be `DATE`,
  not `TIMESTAMP`; staging may preserve it as `CHAR(8)`.

## 学习者第二版建表草案 | Learner's second schema draft

学习者已正确调整 `gender`、`property`、`buy_mount` 和 `day` 的主要类型，并
开始编写 `dim_baby` 与 `fact_trade`。

The learner corrected the main types for `gender`, `property`, `buy_mount`,
and `day`, then drafted `dim_baby` and `fact_trade`.

### 第二轮反馈 | Second review

1. `user_id BIGINT UNSIGNED，` 使用了中文全角逗号，MySQL 会报语法错误；SQL
   标点必须使用英文半角 `,`。
2. 两张表尚未定义主键。`dim_baby.user_id` 是主键候选，但必须先验证源数据是否
   重复；`auction_id` 也是候选，但其唯一性和业务粒度尚未验证。
3. 分析层中的 `day` 建议改名为 `trade_date`，使含义明确并避免与日期函数混淆。
4. `buy_mount` 是源文件字段名；分析层可改为更规范的 `buy_amount`，暂存层则保留
   原名以便对账。
5. 暂时不为 `fact_trade.user_id` 添加外键，因为婴儿信息只覆盖部分交易用户；
   强制外键可能导致合法交易无法进入事实表。
6. 在质量检查完成前，不急于添加 `NOT NULL`、`UNIQUE` 或 `CHECK` 约束；应先用
   暂存表验证真实数据是否满足这些假设。

1. The Chinese full-width comma after `UNSIGNED` causes a MySQL syntax error;
   SQL punctuation must use the ASCII comma `,`.
2. Neither table has a primary key. `dim_baby.user_id` and `auction_id` are
   candidates, but source uniqueness must be validated first.
3. Rename analytical `day` to `trade_date` for clarity.
4. Preserve source `buy_mount` in staging, but analytical `buy_amount` is a
   clearer name.
5. Do not add a foreign key from trades to babies yet because baby information
   covers only a subset of purchasing users.
6. Validate the staging data before enforcing `NOT NULL`, `UNIQUE`, or `CHECK`.

## 学习者第三版：原始暂存表 | Learner's third draft: raw staging

学习者采纳了“暂存表先不设置主键”的设计，并为两个 CSV 编写了初版原始表。

The learner adopted staging tables without primary keys and drafted raw tables
for both CSV files.

### 第三轮反馈 | Third review

1. `std_trade_raw` 是拼写错误，应与另一张表统一为 `stg_trade_raw`；`stg` 是
   staging（暂存）的常用缩写。
2. 原始表字段名应与 CSV 表头保持一致：使用 `buy_mount` 和 `day`。规范化名称
   `buy_amount`、`trade_date` 留给清洗后的事实表。
3. 当前数字字段使用 `BIGINT`/`INT` 是“类型化暂存表”方案；如果源文件出现空白、
   非数字或异常字符，导入可能失败或发生隐式转换。
4. 对强调可追溯性的 `_raw` 落地层，更稳健的方案是除长文本外先使用 `VARCHAR`/
   `CHAR` 保存原值，完成质量检查后再转换到强类型分析表。
5. 原始表不添加主键、外键、唯一性或业务检查约束，以免在调查前丢失异常记录。

1. Rename the typo `std_trade_raw` to `stg_trade_raw`; `stg` conventionally
   means staging.
2. Raw columns should match CSV headers: retain `buy_mount` and `day`; reserve
   `buy_amount` and `trade_date` for the cleaned fact table.
3. Numeric types create a typed staging layer but may reject or coerce malformed
   source values.
4. A traceable `_raw` landing layer is safer when raw values are stored as
   `VARCHAR`/`CHAR` and converted only after validation.
5. Do not add keys or business constraints to the raw tables.
