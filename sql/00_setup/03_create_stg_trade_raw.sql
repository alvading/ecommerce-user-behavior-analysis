-- 第 2 课：创建交易历史原始暂存表
-- Lesson 2: Create the raw trade-history staging table
--
-- 字段名称和顺序与 CSV 表头一致；原始值先以文本保存。
-- Column names and order match the CSV header; raw values are stored as text.

USE mum_baby_analysis;

CREATE TABLE stg_trade_raw (
    user_id     VARCHAR(20),
    auction_id  VARCHAR(30),
    cat_id      VARCHAR(20),
    cat1        VARCHAR(20),
    property    TEXT,
    buy_mount   VARCHAR(20),
    day         VARCHAR(20)
);

-- 结构验证 | Schema verification
DESCRIBE stg_trade_raw;
SHOW CREATE TABLE stg_trade_raw;

