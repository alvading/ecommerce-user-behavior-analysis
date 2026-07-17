# 个人数据分析作品集视觉规范

# Visual Design System for Data Analytics Portfolio

## 1. 目的 | Purpose

本规范是后续 BI 看板、分析报告图表、HTML 页面和个人作品网站的统一视觉依据。
颜色必须表达固定含义，不能为了装饰而随机更换。新增页面或图表如果需要偏离本规范，
应在设计稿或代码中说明原因。

This document is the single visual reference for future BI dashboards,
analytical figures, HTML pages, and the personal portfolio website. Colors must
carry stable meanings rather than serve as decoration. Any deliberate exception
should be documented in the design or implementation.

## 2. 设计原则 | Design principles

1. **数据优先 / Data first**：视觉层级服务于结论，不用颜色填满页面。
2. **语义稳定 / Semantic consistency**：同一颜色在所有页面表达同一含义。
3. **少即是多 / Restraint**：一个图表通常只使用一个主色、一个对照色和一个提醒色。
4. **双语一致 / Bilingual consistency**：中文在前、英文在后，使用 `中文 / English`。
5. **可追溯 / Traceability**：标题、口径、单位和坐标轴名称必须完整。
6. **可访问 / Accessibility**：颜色不能成为唯一的信息载体；同时使用文字、数值、线型或标记。

## 3. 核心颜色 | Core palette

| 用途 Role | 名称 Name | 色值 Hex | 使用规则 Usage |
|---|---|---:|---|
| 页面背景 | Canvas background | `#F3F6F8` | 看板、报告图和网站主背景 |
| 卡片背景 | Card surface | `#FFFFFF` | 内容卡片、图表容器、提示框 |
| 主文字 | Primary text | `#17252F` | 标题、重要数值、正文 |
| 次要文字 | Secondary text | `#70808B` | 英文副标题、单位、坐标刻度、来源 |
| 网格与分隔 | Grid and divider | `#E4EBEE` | 坐标网格、表格分隔、非重点轨道 |
| 卡片阴影 | Card shadow | `#DFE7E9` | 低对比度柔和阴影，不使用黑色重阴影 |
| 核心绿色 | Primary green | `#20B47A` | 核心、稳定、主要口径、2014或当前期、正向增长 |
| 浅灰绿色 | Prior-period green | `#DCECE7` | 2013或上一期，只与深绿色配对使用 |
| 珊瑚色 | Attention coral | `#FF785F` | 高数量记录影响、异常关注、重点警示；不表示普通增长 |
| 紫色 | Cumulative purple | `#6674DF` | 累计占比曲线或明确的第二独立序列 |
| 黄色 | Supporting yellow | `#F4BD45` | 第三分类或有限的辅助系列，不用于风险含义 |
| 中性灰 | Neutral series | `#9BABB3` | 非重点品类、其他组、背景对照 |

### 3.1 颜色语义 | Color semantics

- 绿色不自动表示“表现优秀”，而表示当前分析的核心、稳定口径或明确的正增长。
- 珊瑚色只用于需要注意的高数量影响、异常点或风险提示。
- 下降使用珊瑚色或红色向下箭头；上升使用绿色向上箭头。
- 年度比较固定使用“上一期浅灰绿、当前期深绿”，不能逐卡更换颜色。
- 帕累托图固定使用绿色柱形、紫色累计线、珊瑚色 80% 阈值。

- Green does not automatically mean “good”; it identifies the core or stable
  analytical view, the current period, or an explicitly positive change.
- Coral is reserved for high-quantity effects, anomalies, and attention points.
- Decreases use coral/red downward arrows; increases use green upward arrows.
- Period comparisons always use light green for the prior period and deep green
  for the current period.
- Pareto charts always use green bars, a purple cumulative line, and a coral 80%
  threshold.

## 4. 字体与文字层级 | Typography

优先使用系统无衬线字体。中文可使用苹方、黑体或思源黑体；英文使用同一字体家族，
避免在同一页面混用多种字体。

| 层级 Level | 建议字号 Desktop | 用途 Usage |
|---|---:|---|
| 页面主标题 | 30–36 px | 项目或页面名称 |
| 图表标题 | 24–32 px | 单张分析图标题 |
| 卡片指标值 | 28–34 px | KPI 数值 |
| 卡片或章节标题 | 16–20 px | 图表卡片标题 |
| 正文与标注 | 13–16 px | 说明、图例、注释 |
| 坐标刻度与来源 | 11–13 px | 次要但仍需可读的信息 |

规则：

- 主标题采用 `中文 / English`，英文可与中文同一行或作为下一行副标题。
- 指标名称优先写全，例如“购买件数（单条 `<100`） / Units from rows `<100`”。
- 不使用含义不清的 `Rows <100`；这可能被误解为“记录数小于100”。
- “件/条”统一翻译为 `units per row`。
- 英文大小写使用句首大写，不混用全大写长标题。

## 5. 页面与卡片 | Layout and cards

### 5.1 页面结构 | Page structure

- 页面背景使用 `#F3F6F8`。
- 内容区左右留白在桌面端建议为页面宽度的 3%–5%。
- 卡片之间保持稳定间距，建议 16–24 px。
- 每个页面只保留一个明显主标题。
- 首屏优先呈现结论和关键指标，再展示分析过程。

### 5.2 卡片样式 | Card style

- 白色背景，圆角建议 16–20 px。
- 阴影应轻柔，偏移 4–8 px，不使用浓重黑色阴影。
- KPI 卡片底部可使用短绿色装饰线；所有中性 KPI 统一绿色，不用红绿暗示好坏。
- 卡片内部不嵌套过多小卡片。
- 重点信息优先用文字、数值和留白突出，不依赖粗边框。

## 6. 图表规范 | Chart standards

### 6.1 标题与说明 | Titles and notes

每张图必须包含：

1. 中英文图表标题；
2. 一句说明分析口径或主要发现；
3. 图例（仅在无法直接标注系列时使用）；
4. 数据单位；
5. 必要的来源或口径说明。

### 6.2 坐标轴 | Axes

- 横轴标题位于绘图区水平中心，写作 `中文 / English`。
- 左纵轴标题与绘图区左边界对齐。
- 双轴图的右纵轴标题与绘图区右边界对齐。
- 坐标标题、刻度和图例不得接触数据线、柱形或卡片边缘。
- 百分比、件数、人数和记录数必须标明单位。
- 网格线使用 `#E4EBEE`，线宽 1–2 px，不使用深色粗网格。

### 6.3 折线图 | Line charts

- 主分析口径使用绿色；受高数量记录影响的原始件数使用珊瑚色。
- 折线可适度平滑，但必须通过原始数据点，不能改变峰谷含义。
- 重点月份使用低透明度背景带；默认不加边框，以免干扰阅读。
- 图例放在坐标区上方或空白区域，不能遮挡坐标轴和数据点。
- 极值直接标注数值；其他点不重复显示全部标签。

### 6.4 柱形图与年度比较 | Bars and period comparison

- 不同指标宜使用独立卡片，而不是把不同量级的增长率强行放在同一坐标轴。
- 同一指标的上一期和当前期使用浅灰绿与深绿。
- 上升或下降百分比必须同时显示方向箭头和数值。
- 珊瑚提示只标记受高数量记录影响的指标，不改变年度柱形颜色。

### 6.5 份额矩阵 | Share matrix

- 所有列使用相同刻度，当前项目固定为 0–60%。
- 核心品类使用绿色，高数量影响明显的品类使用珊瑚色，其余品类使用中性灰。
- 不使用整行外框；通过颜色、文字权重和分隔线突出重点。
- 每个条形末端直接显示百分比。

### 6.6 环形图 | Donut charts

- 仅用于少量类别的构成分析，建议不超过 6–7 类。
- 中心显示总量及单位。
- 图例必须同时显示类别编码和占比。
- 类别颜色在同一项目中保持一致。
- 若数据不含价格，不使用“销售额占比”，应写“交易记录占比”。

### 6.7 帕累托图 | Pareto charts

- 柱形按交易记录数降序排列。
- 头部组使用核心绿色，长尾使用浅绿色。
- 累计占比使用紫色曲线。
- 80%参考线和节点使用珊瑚色。
- 左轴为交易记录数，右轴为累计占比，横轴为细分类目排名。
- 关键节点说明放在累计线下方的空白区域，用短引导线连接；不能遮挡曲线。
- `100%`标签必须与累计线保留明显间距。

### 6.8 生命周期与人群图 | Lifecycle and demographic charts

- 同一维度的各阶段统一使用绿色，避免为每个阶段随机着色。
- 通过长度、直接标注和文字说明区分阶段。
- 阶段名称使用母婴语境，例如“婴儿期 / Infant”“幼儿早期 / Toddler”。
- 样本覆盖有限时，必须注明“仅作补充描述，不外推至全部用户”。

## 7. 看板规范 | Dashboard standards

推荐顺序：

1. 页面标题、分析时间范围；
2. 4–6 个关键 KPI；
3. 最重要的时间趋势；
4. 数量结构或数据质量提醒；
5. 品类构成与增长来源；
6. 集中度、二八结构或用户补充分析；
7. 数据来源、分析者和口径说明。

看板应做到“一屏讲清主线”。静态看板避免放入无功能的搜索框、菜单或筛选器。
交互式 HTML 看板只在确实提供筛选、悬停或钻取功能时显示控件。

## 8. 个人网站规范 | Portfolio website standards

### 8.1 网站视觉 | Website visual language

- 网站沿用浅灰背景和白色卡片，不另建一套颜色体系。
- 首页主按钮使用核心绿色；次按钮使用白底深色文字。
- 珊瑚色只用于提醒、异常发现或重要数据质量说明，不用于普通导航。
- 项目详情页按照“背景—数据—方法—发现—建议—限制—SQL”的故事顺序展开。
- 图表保持报告中的颜色映射，不能在网站中重新着色。

### 8.2 CSS 设计变量 | CSS design tokens

```css
:root {
  --color-bg: #f3f6f8;
  --color-surface: #ffffff;
  --color-text: #17252f;
  --color-text-muted: #70808b;
  --color-grid: #e4ebee;
  --color-shadow: #dfe7e9;

  --color-primary: #20b47a;
  --color-prior-period: #dcece7;
  --color-attention: #ff785f;
  --color-cumulative: #6674df;
  --color-support: #f4bd45;
  --color-neutral-series: #9babb3;

  --radius-card: 18px;
  --space-card: 20px;
  --shadow-card: 4px 8px 0 #dfe7e9;
}
```

### 8.3 推荐组件 | Recommended components

- `PageHeader`：中英文标题、项目摘要、时间范围；
- `KpiCard`：指标名、数值、单位或同比；
- `InsightCard`：图表和一句关键结论；
- `MethodNote`：数据口径与限制；
- `ProjectCaseStudy`：背景、SQL、发现和建议；
- `ChartLegend`：统一图例；
- `SourceFooter`：数据来源与作者。

## 9. 可访问性检查 | Accessibility checklist

- 正文和背景对比度至少达到 WCAG AA。
- 字号不小于 11 px；关键说明不小于 13 px。
- 颜色含义同时配合文字、箭头或形状。
- 不使用红绿两色作为唯一对比方式。
- 图表提供替代文本或相邻文字总结。
- 交互控件具有键盘焦点状态和清晰标签。
- 移动端不能出现横向文字裁切。

## 10. 发布前检查 | Pre-publication checklist

- [ ] 所有标题、指标、图例和结论均为中英双语；
- [ ] 横轴、左纵轴和右纵轴标题已对齐且不接触数据线；
- [ ] 单位、百分比和时间范围完整；
- [ ] 颜色符合固定语义；
- [ ] 图例未遮挡坐标轴或数据；
- [ ] 重点标注未越出边界或压住曲线；
- [ ] 中英文术语与报告正文一致；
- [ ] 高数量记录影响使用珊瑚色而非随机颜色；
- [ ] 图表在桌面端和移动端均可阅读；
- [ ] 数据来源、分析者和口径说明完整。

## 11. 当前项目基准 | Current project references

- 总看板：`assets/figures/06_bi_dashboard.png`
- 年度指标卡：`assets/figures/01_annual_growth.png`
- 月度趋势：`assets/figures/02_monthly_sensitivity.png`
- 一级品类矩阵：`assets/figures/03_category_comparison.png`
- 帕累托图：`assets/figures/04_pareto_categories.png`
- 母婴生命周期：`assets/figures/05_demographic_stages.png`

这些文件是本规范的当前视觉基准。后续修改应优先更新本规范，再同步到看板、报告和网站。

These files are the current visual references. Future changes should update
this design system first and then be applied consistently to dashboards,
reports, and the portfolio website.
