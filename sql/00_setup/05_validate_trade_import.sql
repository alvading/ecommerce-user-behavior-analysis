-- 第 2 课：验证交易历史 CSV 导入
-- Lesson 2: Validate the trade-history CSV import
--
-- 2026-07-15 学习者实际结果：导入前 0 行，导入后 29,971 行，表头行 0，
-- property、buy_mount 和 day 抽样字段未错位。
-- Actual learner result on 2026-07-15: 0 rows before import, 29,971 after
-- import, 0 accidental header rows, and correctly aligned sampled fields.

USE mum_baby_analysis;

SELECT COUNT(*) AS imported_rows
FROM stg_trade_raw;

SELECT COUNT(*) AS accidental_header_rows
FROM stg_trade_raw
WHERE user_id = 'user_id'
   OR auction_id = 'auction_id';

SELECT
    user_id,
    auction_id,
    cat_id,
    cat1,
    LEFT(property, 50) AS property_preview,
    buy_mount,
    day
FROM stg_trade_raw
LIMIT 5;

