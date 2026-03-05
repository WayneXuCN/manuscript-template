# Makefile for LaTeX manuscript
# 编译、清理、预览和导出论文

# ============================================================================
# 配置变量
# ============================================================================

# Word 模板配置
# 可通过 make xxx.docx TEMPLATE=mytemplate.docx 指定自定义模板
TEMPLATE ?= wordTemplate.docx

# 公式格式选项
#   --mathml  : Word 原生公式（可编辑，推荐）
#   --webtex  : 转换为图片（显示准确但不可编辑）
MATH_FORMAT = --mathml

# 参考文献标题
REF_TITLE = References

# Pandoc 基础选项
PANDOC_BASE = --from latex+raw_tex \
		--citeproc \
		--bibliography=references.bib \
		--metadata=reference-section-title=$(REF_TITLE) \
		--resource-path=. \
		--extract-media=./media \
		--wrap=none

# 完整导出选项（带样式模板和编号）
PANDOC_OPTS = $(PANDOC_BASE) \
		--reference-doc=$(TEMPLATE) \
		-t docx+native_numbering \
		$(MATH_FORMAT)

.PHONY: clean distclean view help word-basic all

# ============================================================================
# 默认目标
# ============================================================================

# 获取目标文件名（去掉扩展名）
FILE = $(basename $(MAKECMDGOALS))

# 输出文件名（默认与输入相同）
OUT ?= $(FILE)

# ============================================================================
# 编译规则
# ============================================================================

# PDF 编译规则：make xxx.pdf 或 make xxx（默认）
%.pdf: %.tex
	xelatex -interaction=nonstopmode -halt-on-error $<
	biber $(basename $<)
	xelatex -interaction=nonstopmode -halt-on-error $<
	xelatex -interaction=nonstopmode -halt-on-error $<
	@echo "✓ 编译完成: $@"

# 默认规则：make xxx 等同于 make xxx.pdf
%: %.tex
	$(MAKE) $@.pdf

# ============================================================================
# Word 导出
# ============================================================================

# Word 导出规则：make xxx.docx
%.docx: %.tex
	@echo "正在导出为 Word 文档..."
	@if [ -f "$(TEMPLATE)" ]; then \
		echo "使用模板: $(TEMPLATE)"; \
		pandoc $< -o $@ $(PANDOC_OPTS); \
	else \
		echo ""; \
		echo "⚠ 模板文件 '$(TEMPLATE)' 不存在"; \
		echo "  - 使用基本模式导出（无自定义样式）"; \
		echo "  - 或创建模板文件: $(TEMPLATE)"; \
		echo "  - 或指定其他模板: make $@ TEMPLATE=your_template.docx"; \
		echo ""; \
		pandoc $< -o $@ $(PANDOC_BASE) $(MATH_FORMAT); \
	fi
	@echo "✓ Word 导出完成: $@"

# ============================================================================
# 其他命令
# ============================================================================

# 快速编译（只运行一次 xelatex）
fast:
	@if [ -z "$(FILE)" ]; then \
		echo "错误: 请指定文件名，如 make fast FILE=template-cn"; \
		exit 1; \
	fi
	xelatex -interaction=nonstopmode $(FILE).tex

# 基本 Word 导出（不使用自定义样式模板）
word-basic:
	@if [ -z "$(FILE)" ]; then \
		echo "错误: 请指定文件名，如 make word-basic FILE=template-cn"; \
		exit 1; \
	fi
	@echo "正在导出为 Word（基本模式）..."
	pandoc $(FILE).tex -o $(OUT).docx $(PANDOC_BASE) $(MATH_FORMAT)
	@echo "✓ Word 导出完成: $(OUT).docx"

# 清理辅助文件 (保留 PDF 和 Word)
clean:
	rm -f *.aux *.log *.out *.toc *.bbl *.blg *.bcf *.run.xml
	rm -f *.synctex.gz *.fdb_latexmk *.fls
	rm -f *.idx *.ind *.glo *.gls *.lot *.lof
	rm -rf ./media
	@echo "✓ 已清理辅助文件"

# 彻底清理（包括 PDF 和 Word，但保留模板文件）
distclean: clean
	@# 删除 PDF 和 Word 文件，但排除模板文件
	@for f in *.pdf; do \
		[ -f "$$f" ] && rm -f "$$f" && echo "删除: $$f"; \
	done
	@for f in *.docx; do \
		if [ -f "$$f" ] && [ "$$f" != "$(TEMPLATE)" ]; then \
			rm -f "$$f" && echo "删除: $$f"; \
		fi; \
	done
	@echo "✓ 已彻底清理（保留模板: $(TEMPLATE)）"

# ============================================================================
# 帮助信息
# ============================================================================

help:
	@echo "LaTeX 论文模板 Makefile"
	@echo ""
	@echo "=== PDF 编译 ==="
	@echo "  make xxx              编译 xxx.tex → xxx.pdf"
	@echo "  make xxx.pdf          同上（显式指定）"
	@echo "  make fast FILE=xxx    快速编译（只运行一次 xelatex）"
	@echo ""
	@echo "=== Word 导出 ==="
	@echo "  make xxx.docx                      导出 xxx.tex → xxx.docx"
	@echo "  make xxx.docx TEMPLATE=my.docx     使用指定模板导出"
	@echo "  make word-basic FILE=xxx [OUT=yyy] 基本 Word 导出（无样式模板）"
	@echo ""
	@echo "=== 清理 ==="
	@echo "  make clean            清理辅助文件"
	@echo "  make distclean        彻底清理（保留模板文件）"
	@echo ""
	@echo "=== 配置变量 ==="
	@echo "  TEMPLATE              Word 模板文件（默认: wordTemplate.docx）"
	@echo ""
	@echo "=== 其他 ==="
	@echo "  make help             显示此帮助"