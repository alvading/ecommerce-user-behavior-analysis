-- 第 2 课：创建婴儿信息原始暂存表
-- Lesson 2: Create the raw baby-information staging table
--
-- 原始层使用文本类型并允许空值，避免在质量检查前拒绝异常源记录。
-- The raw layer uses text types and permits nulls so anomalous source rows are
-- not rejected before data-quality validation.

USE mum_baby_analysis;

CREATE TABLE stg_baby_raw (
    user_id  VARCHAR(20),
    birthday VARCHAR(20),
    gender   VARCHAR(10)
);

-- 结构验证 | Schema verification
DESCRIBE stg_baby_raw;
SHOW CREATE TABLE stg_baby_raw;

