# 项目记录 | Project Notes

## 当前数据源 | Current dataset

- 来源 / Source: [阿里云天池母婴购物数据集](https://tianchi.aliyun.com/dataset/45)
- 本地目录 / Local directory: `../mum_baby/`
- 婴儿信息 / Baby information: 953 data rows
- 交易历史 / Trade history: 29,971 data rows
- 关联字段 / Join key: `user_id`

## 当前范围 | Current scope

项目分析交易数量、购买件数、时间趋势、品类表现、用户购买频次、复购、用户分层，
以及与婴儿年龄和性别相关的购买差异。

The project analyzes transaction counts, purchased units, time trends, category
performance, purchase frequency, repeat purchase, customer segments, and
purchase differences associated with baby age and gender.

## 明确限制 | Explicit limitations

- 无价格字段，不能计算收入、GMV、客单价或利润；
- 无浏览、收藏和加购记录，不能分析完整转化漏斗；
- `auction_id` 的业务唯一性需由 SQL 验证；
- 婴儿信息仅覆盖部分交易用户，关联覆盖率需实际计算；
- 性别和生日来自用户填写，可能存在缺失、不真实或异常值。

- No price means no revenue, GMV, average-order-value, or profit metrics;
- no browse, favorite, or cart events means no full conversion funnel;
- the business uniqueness of `auction_id` requires SQL validation;
- baby information covers only part of the trade users, so join coverage must
  be measured;
- user-provided gender and birthday values may be missing or inaccurate.
