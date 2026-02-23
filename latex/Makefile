# Makefile for LaTeX manuscript
# 编译、清理和预览论文

# 默认编译中文模板
TEX = template-cn
# 可选: template-en

.PHONY: all cn en clean distclean view

# 默认目标: 编译中文模板
all: cn

# 编译中文模板
cn:
	xelatex -interaction=nonstopmode -halt-on-error template-cn.tex
	xelatex -interaction=nonstopmode -halt-on-error template-cn.tex
	@echo "✓ 中文模板编译完成: template-cn.pdf"

# 编译英文模板
en:
	xelatex -interaction=nonstopmode -halt-on-error template-en.tex
	xelatex -interaction=nonstopmode -halt-on-error template-en.tex
	@echo "✓ 英文模板编译完成: template-en.pdf"

# 编译所有模板
all-templates: cn en

# 快速编译（只运行一次，用于调试）
fast:
	xelatex -interaction=nonstopmode $(TEX).tex

# 查看 PDF (macOS)
view:
	open $(TEX).pdf

# 清理辅助文件 (保留 PDF)
clean:
	rm -f *.aux *.log *.out *.toc *.bbl *.blg
	rm -f *.synctex.gz *.fdb_latexmk *.fls
	rm -f *.idx *.ind *.glo *.gls *.lot *.lof
	@echo "✓ 已清理辅助文件"

# 彻底清理（包括 PDF）
distclean: clean
	rm -f *.pdf
	@echo "✓ 已彻底清理（包括 PDF）"

# 帮助信息
help:
	@echo "LaTeX 论文模板 Makefile"
	@echo ""
	@echo "用法:"
	@echo "  make          编译中文模板 (template-cn.tex)"
	@echo "  make cn       编译中文模板"
	@echo "  make en       编译英文模板"
	@echo "  make all-templates  编译所有模板"
	@echo "  make fast     快速编译（只运行一次）"
	@echo "  make view     打开 PDF (macOS)"
	@echo "  make clean    清理辅助文件，保留 PDF"
	@echo "  make distclean  彻底清理，包括 PDF"
	@echo "  make help     显示此帮助信息"
