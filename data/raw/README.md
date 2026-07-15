# 原始数据 | Raw Data

下载公开的阿里巴巴天池 `UserBehavior.csv` 数据集，并可将其保存在此目录。
原始 CSV 文件已被 Git 排除，不会上传到仓库。

Download the public Alibaba Tianchi `UserBehavior.csv` dataset and optionally
store it locally in this directory. Raw CSV files are excluded from Git.

预期字段如下，原始文件不含表头：

Expected columns; the raw file has no header row:

```text
userid,itemid,categoryid,behavior_type,behavior_timestamp
```

导入前，请在 `docs/run_records/` 中记录文件名、字节大小、行数、下载来源和
校验和。请勿提交原始数据集。

Before importing, record the file name, byte size, row count, download source,
and checksum in `docs/run_records/`. Do not commit the raw dataset.
