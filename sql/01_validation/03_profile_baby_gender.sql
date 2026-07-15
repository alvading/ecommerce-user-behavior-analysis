-- 第 2 课：验证 gender 值域与分布
-- Lesson 2: Validate the gender domain and distribution
--
-- 2026-07-15 学习者实际结果：0=489，1=438，2=26；值长均为 1；合计 953。
-- Actual learner result on 2026-07-15: 0=489, 1=438, 2=26; every value has
-- length 1; total=953.

USE mum_baby_analysis;

SELECT
    gender,
    CHAR_LENGTH(gender) AS value_length,
    COUNT(*) AS user_count
FROM stg_baby_raw
GROUP BY
    gender,
    CHAR_LENGTH(gender)
ORDER BY gender;

