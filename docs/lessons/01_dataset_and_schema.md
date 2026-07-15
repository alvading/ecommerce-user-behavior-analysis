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
