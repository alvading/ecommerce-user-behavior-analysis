# 项目路线图 | Project Roadmap

## 目标 | Goal

在教师引导下，亲自完成一个可复现、可解释、可用于数据分析岗位求职的淘宝母婴
交易分析项目，并将每一步的 SQL、验证结果、业务解读和作品成果以中英双语维护。

Complete a reproducible and interview-ready Taobao maternal and infant
transaction analysis project through guided SQL learning, with bilingual SQL,
validation evidence, interpretation, dashboard, report, and website artifacts.

## 阶段与验收 | Phases and acceptance criteria

### 阶段 1：数据认识与表结构 | Phase 1: Dataset and schema

- [x] 下载并定位两个 CSV；
- [x] 核验表头、样例和行数；
- [x] 提交第一版字段类型判断；
- [ ] 完成字段类型评审；
- [ ] 学习者亲自编写 `CREATE TABLE`；
- [ ] 说明主键、关联键和暂存/分析分层。

**验收：** 学习者能解释每个字段类型和键设计，而不只是运行现成代码。

**Acceptance:** the learner can explain every type and key decision rather
than only running prepared SQL.

### 阶段 2：导入与质量验证 | Phase 2: Import and validation

- [x] 创建并验证项目数据库；
- [x] 创建两张暂存表；
- [x] 导入两个 CSV 并完成源文件行数对账；
- [ ] 导入两份 CSV 并对账物理行数；
- [ ] 检查空值、重复、值域、日期和购买数量；
- [ ] 验证 `user_id` 关联覆盖率和 `auction_id` 唯一性；
- [ ] 保存双语运行记录。

**验收：** 每条清洗规则都有查询证据，导入与源文件行数能够对账。

### 阶段 3：清洗与建模 | Phase 3: Cleaning and modeling

- [ ] 将原始日期安全转换为 `DATE`；
- [ ] 处理或隔离异常生日、交易日期、性别和购买数量；
- [ ] 创建婴儿维度表与交易事实表；
- [ ] 增加必要索引；
- [ ] 完成暂存层到分析层对账。

**验收：** 分析表可重复生成，类型正确，排除记录全部可解释。

### 阶段 4：SQL 业务分析 | Phase 4: SQL analysis

- [ ] 整体交易与销量 KPI；
- [ ] 年、季度和月度趋势；
- [ ] 一级类目与细分类目表现；
- [ ] 用户购买频次与复购；
- [ ] 婴儿年龄与性别分析；
- [ ] 用户分层及业务建议。

**验收：** 每项分析包含业务问题、口径、SQL、QA、真实结果、解读和限制。

### 阶段 5：Power BI 看板 | Phase 5: Power BI dashboard

- [ ] 明确看板受众和业务决策；
- [ ] 设计概览、趋势、品类、用户和母婴属性页面；
- [ ] 将所有 KPI 与 SQL 对账；
- [ ] 导出截图和看板说明。

### 阶段 6：报告与作品网站 | Phase 6: Report and website

- [ ] 完成中英双语分析报告；
- [ ] 建立响应式个人作品网站和项目案例页；
- [ ] 展示问题、方法、关键发现、限制和建议；
- [ ] 链接 GitHub、SQL、看板与报告；
- [ ] 完成移动端和可访问性检查。

### 阶段 7：面试准备 | Phase 7: Interview readiness

- [ ] 两分钟项目陈述；
- [ ] SQL、数据质量和业务问题清单；
- [ ] 关键技术权衡说明；
- [ ] 中英文简历项目描述。

## 每项分析的完成标准 | Definition of done

每项分析必须同时具有：业务问题、分析粒度、指标口径、来源与过滤、学习者执行的
SQL、验证检查、保存结果、非因果业务解读、限制、工作日志和面试表达。

Every analysis requires a business question, grain, metric definition, source
and filters, learner-executed SQL, validation, saved result, non-causal
interpretation, limitations, work-log entry, and interview takeaway.
