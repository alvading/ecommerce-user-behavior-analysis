-- 目的：创建可复现的原始层与分析层。
-- Purpose: create reproducible raw and analytical layers.
-- 适用方言：MySQL 8.x。
-- Tested dialect: MySQL 8.x.
-- 可重复执行：仅在对象不存在时创建。
-- Safe to rerun: creates objects only when they do not already exist.

CREATE DATABASE IF NOT EXISTS ecommerce_analysis
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE ecommerce_analysis;

CREATE TABLE IF NOT EXISTS stg_user_behavior (
    userid              BIGINT UNSIGNED NOT NULL,
    itemid              BIGINT UNSIGNED NOT NULL,
    categoryid          BIGINT UNSIGNED NOT NULL,
    behavior_type       VARCHAR(10) NOT NULL,
    behavior_timestamp  BIGINT NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS user_behavior (
    userid              BIGINT UNSIGNED NOT NULL,
    itemid              BIGINT UNSIGNED NOT NULL,
    categoryid          BIGINT UNSIGNED NOT NULL,
    behavior_type       VARCHAR(10) NOT NULL,
    behavior_timestamp  BIGINT NOT NULL,
    behavior_datetime   DATETIME NOT NULL,
    behavior_date       DATE NOT NULL,
    behavior_hour       TINYINT UNSIGNED NOT NULL,
    INDEX idx_ub_user_time (userid, behavior_timestamp),
    INDEX idx_ub_item_behavior (itemid, behavior_type),
    INDEX idx_ub_category_behavior (categoryid, behavior_type),
    INDEX idx_ub_date_hour_behavior
        (behavior_date, behavior_hour, behavior_type)
) ENGINE = InnoDB;
