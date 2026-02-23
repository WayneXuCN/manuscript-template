# Makefile for LaTeX manuscript
# 编译、清理、预览和导出论文

# 默认编译中文模板
TEX = template-cn
# 可选: template-en

# Word 模板配置
# 使用自定义样式模板（在 Word 中预设好样式后保存）
WORD_TEMPLATE = wordTemplate.docx

# 公式格式选项
#   --mathml          : Word 原生公式（可编辑，推荐）
#   --webtex          : 转换为图片（显示准确但不可编辑）
#   -t docx+native_numbering : 保留 LaTeX 编号
MATH_FORMAT = --mathml

# 参考文献标题（根据语言设置）
REF_TITLE_CN = 参考文献
REF_TITLE_EN = References

# Pandoc 基础选项
#   --metadata=reference-section-title: 设置参考文献章节标题
PANDOC_BASE = --from latex+raw_tex \
		--citeproc \
		--bibliography=references.bib \
		--metadata=reference-section-title=$(REF_TITLE_CN) \
		--resource-path=. \
		--extract-media=./media \
		--wrap=none

# 完整导出选项（带样式模板）
PANDOC_OPTS = $(PANDOC_BASE) \
		--reference-doc=$(WORD_TEMPLATE) \
		$(MATH_FORMAT)

# 备用导出选项（无样式模板）
PANDOC_BASIC = $(PANDOC_BASE) \
		$(MATH_FORMAT)

.PHONY: all cn en word word-cn word-en clean distclean view

# 默认目标: 编译中文模板
all: cn

# ============================================================================
# PDF 编译
# ============================================================================

# 编译中文模板
cn:
	xelatex -interaction=nonstopmode -halt-on-error template-cn.tex
	bibtex template-cn
	xelatex -interaction=nonstopmode -halt-on-error template-cn.tex
	xelatex -interaction=nonstopmode -halt-on-error template-cn.tex
	@echo "✓ 中文模板编译完成: template-cn.pdf"

# 编译英文模板
en:
	xelatex -interaction=nonstopmode -halt-on-error template-en.tex
	bibtex template-en
	xelatex -interaction=nonstopmode -halt-on-error template-en.tex
	xelatex -interaction=nonstopmode -halt-on-error template-en.tex
	@echo "✓ 英文模板编译完成: template-en.pdf"

# 编译所有模板
all-templates: cn en

# 快速编译（只运行一次，用于调试）
fast:
	xelatex -interaction=nonstopmode $(TEX).tex

# ============================================================================
# Word 导出（使用 Pandoc）
# ============================================================================

# 导出中文模板为 Word
word-cn:
	@echo "正在导出中文模板为 Word 文档..."
	pandoc template-cn.tex -o template-cn.docx $(PANDOC_OPTS)
	@echo "✓ Word 导出完成: template-cn.docx"

# 导出英文模板为 Word（使用英文参考文献标题）
word-en:
	@echo "正在导出英文模板为 Word 文档..."
	pandoc template-en.tex -o template-en.docx \
		--from latex+raw_tex \
		--citeproc \
		--bibliography=references.bib \
		--metadata=reference-section-title=$(REF_TITLE_EN) \
		--resource-path=. \
		--extract-media=./media \
		--wrap=none \
		--reference-doc=$(WORD_TEMPLATE) \
		$(MATH_FORMAT)
	@echo "✓ Word 导出完成: template-en.docx"

# 导出默认模板为 Word
word: word-cn

# 导出所有模板为 Word
word-all: word-cn word-en

# ============================================================================
# 查看和清理
# ============================================================================

# 查看 PDF (macOS)
view:
	open $(TEX).pdf

# 清理辅助文件 (保留 PDF 和 Word)
clean:
	rm -f *.aux *.log *.out *.toc *.bbl *.blg
	rm -f *.synctex.gz *.fdb_latexmk *.fls
	rm -f *.idx *.ind *.glo *.gls *.lot *.lof
	rm -rf ./media
	@echo "✓ 已清理辅助文件"

# 彻底清理（包括 PDF 和 Word）
distclean: clean
	rm -f *.pdf *.docx
	@echo "✓ 已彻底清理（包括 PDF 和 Word）"

# ============================================================================
# Word 样式模板
# ============================================================================

# 生成默认 Word 样式模板（首次使用或需要重置时运行）
ref-doc:
	@echo "正在生成 Word 样式模板..."
	pandoc --print-default-data-file reference.docx > manuscript-reference.docx
	@echo "✓ Word 样式模板已生成: manuscript-reference.docx"
	@echo ""
	@echo "提示: 用 Word 打开 manuscript-reference.docx，修改样式后保存，"
	@echo "     后续导出的 Word 文档将使用这些样式。"

# 基本 Word 导出（不使用自定义样式模板）
word-basic-cn:
	@echo "正在导出中文模板为 Word（基本模式）..."
	pandoc template-cn.tex -o template-cn.docx $(PANDOC_BASIC)
	@echo "✓ Word 导出完成: template-cn.docx"

word-basic-en:
	@echo "正在导出英文模板为 Word（基本模式）..."
	pandoc template-en.tex -o template-en.docx $(PANDOC_BASIC)
	@echo "✓ Word 导出完成: template-en.docx"

# ============================================================================
# 高质量 Word 导出（使用 LibreOffice，更接近 PDF 样式）
# ============================================================================

# 使用 LibreOffice 将 PDF 转换为 Word（样式最准确）
word-pdf-cn: cn
	@echo "使用 LibreOffice 从 PDF 转换为 Word（高质量）..."
	libreoffice --headless --convert-to docx --outdir . template-cn.pdf 2>/dev/null || \
	@echo "提示: 未安装 LibreOffice，使用 pandoc 作为备用方案" && make word-cn

word-pdf-en: en
	@echo "使用 LibreOffice 从 PDF 转换为 Word（高质量）..."
	libreoffice --headless --convert-to docx --outdir . template-en.pdf 2>/dev/null || \
	@echo "提示: 未安装 LibreOffice，使用 pandoc 作为备用方案" && make word-en

# ============================================================================
# 帮助信息
# ============================================================================

help:
	@echo "LaTeX 论文模板 Makefile"
	@echo ""
	@echo "=== PDF 编译 ==="
	@echo "  make              编译中文模板 (template-cn.tex)"
	@echo "  make cn           编译中文模板"
	@echo "  make en           编译英文模板"
	@echo "  make all-templates 编译所有模板"
	@echo "  make fast         快速编译（只运行一次）"
	@echo ""
	@echo "=== Word 导出（固定格式）==="
	@echo "  make word-cn      导出中文为 Word（使用 wordTemplate.docx 样式）"
	@echo "  make word-en      导出英文为 Word（使用 wordTemplate.docx 样式）"
	@echo "  make word-all     导出所有模板为 Word"
	@echo ""
	@echo "=== 配置说明 ==="
	@echo "  1. 在 Word 中打开 manuscript-reference.docx 预设样式"
	@echo "  2. 保存为 wordTemplate.docx（Makefile 中 WORD_TEMPLATE 变量）"
	@echo "  3. 运行 make word-cn 导出，将自动应用预设样式"
	@echo "  4. 公式使用 Word 原生格式（可编辑），参考文献自动处理"
	@echo ""
	@echo "=== 公式编号说明 ==="
	@echo "  Word导出使用 --mathml 生成Word原生公式（可编辑）"
	@echo "  公式编号可能显示在公式右侧"
	@echo "  如需精确编号，建议在Word中手动调整或使用PDF版本"
	@echo ""
	@echo "=== 备用方案 ==="
	@echo "  make word-basic-cn 基础导出（无自定义样式）"
	@echo "  make ref-doc       生成默认样式模板 manuscript-reference.docx"
	@echo ""
	@echo "=== 其他 ==="
	@echo "  make view         打开 PDF (macOS)"
	@echo "  make clean        清理辅助文件"
	@echo "  make distclean    彻底清理"
	@echo "  make help         显示此帮助信息"
