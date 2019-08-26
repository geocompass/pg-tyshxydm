# pg-tyshxydm
统一社会信用代码相关的PostgreSQL函数，包括验证、随机生成等
## 如何安装
复制[pg-tyshxydm.sql](./pg-tyshxydm.sql)文件中的全部代码在数据库执行。
## 示例
- 生成18位的随机的统一社会信用代码
```sql
 -- 参数为六位行政区划代码
 select random_tyshxydm_18('110108') 
```
## *联系作者*
QQ：1016817543
