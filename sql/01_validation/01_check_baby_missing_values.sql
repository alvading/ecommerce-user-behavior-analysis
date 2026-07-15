-- 第 2 课：检查婴儿信息表的 NULL 与空字符串
-- Lesson 2: Check nulls and blank strings in baby information
--
-- 2026-07-15 学习者实际结果：953 行；三个字段的 NULL 和空字符串均为 0。
-- Actual learner result on 2026-07-15: 953 rows; all three columns have zero
-- nulls and zero blank strings.

USE mum_baby_analysis;

SELECT
    COUNT(*) AS total_rows,

    COUNT(user_id) AS non_null_user_id,
    SUM(user_id IS NULL) AS null_user_id,
    SUM(user_id IS NOT NULL AND TRIM(user_id) = '') AS blank_user_id,

    COUNT(birthday) AS non_null_birthday,
    SUM(birthday IS NULL) AS null_birthday,
    SUM(birthday IS NOT NULL AND TRIM(birthday) = '') AS blank_birthday,

    COUNT(gender) AS non_null_gender,
    SUM(gender IS NULL) AS null_gender,
    SUM(gender IS NOT NULL AND TRIM(gender) = '') AS blank_gender

FROM stg_baby_raw;

