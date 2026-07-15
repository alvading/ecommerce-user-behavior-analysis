-- 第 2 课：检查生日原始格式与范围
-- Lesson 2: Check raw birthday format and range
--
-- 2026-07-15 学习者实际结果：953/953 为八位数字，格式异常 0；
-- 原始最小值 19840616，最大值 20150815。
-- Actual learner result on 2026-07-15: 953/953 are eight-digit strings, zero
-- format exceptions; raw minimum=19840616 and maximum=20150815.

USE mum_baby_analysis;

SELECT
    COUNT(*) AS total_rows,
    SUM(birthday REGEXP '^[0-9]{8}$') AS eight_digit_birthdays,
    SUM(birthday NOT REGEXP '^[0-9]{8}$') AS invalid_format_birthdays,
    MIN(birthday) AS min_raw_birthday,
    MAX(birthday) AS max_raw_birthday
FROM stg_baby_raw;

