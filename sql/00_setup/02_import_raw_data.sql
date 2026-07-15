-- 目的：将无表头的公开 CSV 加载至暂存表。执行前请替换文件路径。
-- Purpose: template for loading the headerless public CSV into the staging
-- table. Replace the path before execution.
--
-- 前置条件：
-- Prerequisites:
--   1. 在 MySQL 客户端连接中启用 LOCAL INFILE。
--      Enable LOCAL INFILE in the MySQL client connection.
--   2. 确认 CSV 包含五个逗号分隔字段且无表头。
--      Verify the CSV has five comma-separated columns and no header.
--   3. 原始文件不得纳入 Git。
--      Keep the raw file outside Git.
--
-- 本脚本只清空暂存层。确认目标数据库后，再取消 TRUNCATE 和 LOAD 的注释。
-- This script intentionally clears only the staging layer. Uncomment the
-- TRUNCATE and LOAD statements after confirming the target database.

USE ecommerce_analysis;

-- TRUNCATE TABLE stg_user_behavior;

-- LOAD DATA LOCAL INFILE '/absolute/path/to/UserBehavior.csv'
-- INTO TABLE stg_user_behavior
-- CHARACTER SET utf8mb4
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- (userid, itemid, categoryid, behavior_type, behavior_timestamp);

-- 导入后的即时检查 | Immediate import checks
SELECT COUNT(*) AS staging_rows
FROM stg_user_behavior;

SELECT *
FROM stg_user_behavior
LIMIT 10;
