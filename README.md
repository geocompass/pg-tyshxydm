<h1 align="center">Welcome to pg-tyshxydm 👋</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000" />
</p>

>     PostgreSQL的统一社会信用代码相关的操作函数，包括随机生成、验证等

### 🏠 [Homepage](https://github.com/geocompass/pg-tyshxydm)

## Examples

- 生成18位的随机的统一社会信用代码

```sql
 -- 参数为六位行政区划代码
 -- 返回值为18位统一社会信用代码
 select random_tyshxydm_18('110108') 
```
- 验证统一社会信用代码是否正确
```sql
-- 参数为18位统一社会信用代码 
-- 返回值为 bool
select is_tyshxydm('21110108GLWURT0K9D')
```

## Author

👤 **QQ：1016817543**


## 🤝 Contributing

Contributions, issues and feature requests are welcome!<br />Feel free to check [issues page](https://github.com/geocompass/pg-tyshxydm/issues).

