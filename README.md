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

### Word 导出（一键转换）

本模板支持使用 Pandoc 将 LaTeX 一键导出为 Word，**固定格式、保留参考文献、使用 Word 原生公式**。

**前置要求**：安装 [Pandoc](https://pandoc.org/)
```bash
brew install pandoc
```

**快速导出**：
```bash
cd latex
make word-cn    # 导出中文模板
make word-en    # 导出英文模板
```

**固定格式配置**（推荐）：

1. 用 Microsoft Word 打开 `latex/wordTemplate.docx`
2. 修改样式（字体、字号、行距、段落间距等）
3. 另存为 `latex/wordTemplate.docx`
4. 运行 `make word-cn`，导出的 Word 将自动应用预设样式

**特性**：
- ✅ 参考文献自动处理（`--citeproc`）
- ✅ Word 原生公式（可编辑，使用 `--mathml`）
- ✅ 自定义样式模板（通过 `wordTemplate.docx` 固定格式）
- ✅ 图片自动提取到 `./media` 文件夹

**更多选项**：
```bash
make word-basic-cn   # 基础导出（无自定义样式）
make ref-doc         # 生成默认样式模板
make help            # 查看所有命令
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
