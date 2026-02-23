# latex-manuscript-template

XeLaTeX / Typst 学术论文模板（初稿），支持中英混排

## 项目结构

```
├── latex/                    # LaTeX 版本
│   ├── manuscript.cls        # 样式文件
│   ├── references.bib        # 参考文献数据库
│   ├── template-en.tex       # 纯英文模板
│   ├── template-cn.tex       # 纯中文模板
│   └── template-mixed.tex    # 中英混排模板
│
└── typst/                    # Typst 版本
    ├── manuscript.typ        # 样式文件
    ├── references.bib        # 参考文献数据库
    ├── template-en.typ       # 纯英文模板
    ├── template-cn.typ       # 纯中文模板
    └── template-mixed.typ    # 中英混排模板
```

## LaTeX 版本

### 编译方式

```bash
cd latex
xelatex template-en.tex
```

### 文档类选项

| 选项 | 说明 |
|------|------|
| `macnew` / `windows` / `fandol` | 字体集 |
| `cn` | 中文模式（默认英文） |
| `twocolumn` | 双栏排版 |
| `review` | 审稿模式（双倍行距） |

## Typst 版本

### 编译方式

```bash
cd typst
typst compile template-en.typ
```

### 语言设置

在模板文件中设置 `lang: "cn"` 切换为中文模式。

## 特性

- **数学快捷命令**：`\R`, `\E`, `\Var`, `\norm{x}`, `\bmat{}`
- **智能引用**：`\cref{eq:1}` → Eq. (1)
- **单位排版**：`\SI{100}{\milli\second}`
- **定理环境**：自动切换中英文
- **参考文献**：支持 BibTeX/BibLaTeX

## 反馈

欢迎提交 Issue 和 Pull Request。
