-- 第 2 课：验证婴儿信息 CSV 导入
-- Lesson 2: Validate the baby-information CSV import
--
-- 2026-07-15 学习者实际结果：导入前 0 行，导入后 953 行，表头行 0。
-- Actual learner result on 2026-07-15: 0 rows before import, 953 after import,
-- and 0 accidental header rows.

USE mum_baby_analysis;

SELECT COUNT(*) AS imported_rows
FROM stg_baby_raw;

SELECT *
FROM stg_baby_raw
LIMIT 5;

SELECT COUNT(*) AS accidental_header_rows
FROM stg_baby_raw
WHERE user_id = 'user_id';

