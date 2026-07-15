-- 第 2 课：验证婴儿信息中的 user_id 唯一性
-- Lesson 2: Validate user_id uniqueness in baby information
--
-- 2026-07-15 学习者实际结果：返回 0 行，不存在重复 user_id。
-- Actual learner result on 2026-07-15: zero rows returned; no duplicate
-- user_id values exist.

USE mum_baby_analysis;

SELECT
    user_id,
    COUNT(*) AS occurrence_count
FROM stg_baby_raw
GROUP BY user_id
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC, user_id;

