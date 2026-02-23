# Makefile for Typst manuscript
# 编译、清理和预览论文

.PHONY: all cn en clean distclean watch view help

# 默认编译中文模板
TYP = template-cn
# 可选: template-en

# 默认目标: 编译中文模板
all: cn

# 编译中文模板
cn:
	@typst compile template-cn.typ template-cn.pdf
	@echo "✓ 中文模板编译完成: template-cn.pdf"

# 编译英文模板
en:
	@typst compile template-en.typ template-en.pdf
	@echo "✓ 英文模板编译完成: template-en.pdf"

# 编译所有模板
all-templates: cn en

# 快速编译（调试模式）
fast:
	@typst compile --diagnostics-format=short $(TYP).typ $(TYP).pdf

# 监视模式（自动重新编译）
watch:
	@typst watch $(TYP).typ $(TYP).pdf

# 查看 PDF (macOS)
view:
	@open $(TYP).pdf

# 清理 PDF 文件
clean:
	@rm -f *.pdf
	@echo "✓ 已清理 PDF 文件"

# 彻底清理（包括可能的临时文件）
distclean: clean
	@rm -f *.tmp *.bak
	@rm -rf .typst/
	@echo "✓ 已彻底清理"

# 帮助信息
help:
	@echo "Typst 论文模板 Makefile"
	@echo ""
	@echo "用法:"
	@echo "  make              编译中文模板 (template-cn.typ)"
	@echo "  make cn           编译中文模板"
	@echo "  make en           编译英文模板"
	@echo "  make all-templates 编译所有模板"
	@echo "  make fast         快速编译（调试模式）"
	@echo "  make watch        监视模式（自动重新编译）"
	@echo "  make view         打开 PDF (macOS)"
	@echo "  make clean        清理 PDF 文件"
	@echo "  make distclean    彻底清理，包括临时文件"
	@echo "  make help         显示此帮助信息"
