-- 第 2 课：创建项目数据库 | Lesson 2: Create the project database
-- 学习者已在 MySQL 9.7.1 中执行并验证。
-- Executed and verified by the learner in MySQL 9.7.1.

CREATE DATABASE IF NOT EXISTS mum_baby_analysis
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE mum_baby_analysis;

-- 环境验证 | Environment verification
SELECT
    DATABASE() AS current_database,
    VERSION() AS mysql_version;

