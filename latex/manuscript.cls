%% ============================================================================
%% 中英文学术论文模板类文件
%% ============================================================================
%% 版本: v1.0
%% 日期: 2026/02/23
%% 编译方式: XeLaTeX / LuaLaTeX
%% ============================================================================
%%
%% 字号配置速查表:
%% ----------------------------------------------------------------------------
%% 元素          当前字号              配置位置                修改方法
%% ----------------------------------------------------------------------------
%% 正文          \zihao{-4} (小四号)   ctexart 加载选项        修改 zihao= 值
%% 一级标题      \Large (西文)         \titleformat{\section}  覆盖命令
%% 二级标题      \large (西文)         \titleformat{\subsection} 覆盖命令
%% 三级标题      \normalsize (西文)    \titleformat{\subsubsection} 覆盖命令
%% 图表标题      \small (五号)         \captionsetup           覆盖命令
%% 子图表标题    \small (五号)         \captionsetup[sub]      覆盖命令
%% 算法体        \small (五号)         \SetAlFnt               覆盖命令
%% 算法标题      \small\bfseries       \SetAlCapFnt            覆盖命令
%% 表格表头      \small (五号)         \theadfont              覆盖命令
%% ----------------------------------------------------------------------------
%% 中文字号命令: \zihao{0~8} 和 \zihao{-0~-8}（负号为小号）
%% 西文字号命令: \Huge, \huge, \LARGE, \Large, \large, \normalsize, \small
%% ============================================================================

%% ----------------------------------------------------------------------------
%% 基础声明
%% ----------------------------------------------------------------------------
%% \NeedsTeXFormat{LaTeX2e} 声明所需的最小LaTeX版本
%% \ProvidesClass 提供类文件信息，包含日期和版本
%% ----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{manuscript}[2026/02/23 v1.0 Chinese academic manuscript template]

%% ----------------------------------------------------------------------------
%% 文档类选项处理
%% ----------------------------------------------------------------------------
%% 本模板支持以下选项:
%%
%% 字体集选项 (fontset):
%%   - macnew    : macOS 系统字体（默认）
%%   - windows   : Windows 系统字体
%%   - fandol    : Fandol 开源字体集（跨平台）
%%   - ubuntu    : Ubuntu 系统字体
%%
%% 语言选项 (lang):
%%   - cn : 中文模式（定理环境等显示中文）
%%   - en : 英文模式（默认，定理环境等显示英文）
%%
%% 版式选项:
%%   - twocolumn : 双栏排版
%%   - review    : 审稿模式（双倍行距，便于批注）
%%
%% 使用示例:
%%   \documentclass[macnew, cn, twocolumn]{manuscript}
%% ----------------------------------------------------------------------------

%% 设置默认值
\newcommand{\manuscript@fontset}{macnew}    % 默认字体集
\newcommand{\manuscript@lang}{en}            % 默认语言: 英文
\newif\ifmanuscript@twocolumn                % 双栏开关
\newif\ifmanuscript@review                   % 审稿模式开关

%% 声明选项
\DeclareOption{macnew}{\renewcommand{\manuscript@fontset}{macnew}}
\DeclareOption{windows}{\renewcommand{\manuscript@fontset}{windows}}
\DeclareOption{fandol}{\renewcommand{\manuscript@fontset}{fandol}}
\DeclareOption{ubuntu}{\renewcommand{\manuscript@fontset}{ubuntu}}
\DeclareOption{cn}{\renewcommand{\manuscript@lang}{cn}}
\DeclareOption{en}{\renewcommand{\manuscript@lang}{en}}
\DeclareOption{twocolumn}{\manuscript@twocolumntrue}
\DeclareOption{review}{\manuscript@reviewtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}  % 传递未知选项到 ctexart
\ProcessOptions\relax

%% ----------------------------------------------------------------------------
%% 加载基础文档类 ctexart
%% ----------------------------------------------------------------------------
%% ctexart 是 ctex 宏包提供的中文文章类
%%
%% 正文字号配置:
%%   - zihao=-4  : 小四号字（默认正文大小，12pt）
%%   其他可选值: 0/-0/1/-1/2/-2/3/-3/4/-4/5/-5/6/-6/7/-7/8
%%
%% 中文字号命令（可在文档中使用）:
%%   - \zihao{0} 或 \zihao{-0} : 初号/小初 (42pt/36pt)
%%   - \zihao{1} 或 \zihao{-1} : 一号/小一 (26pt/24pt)
%%   - \zihao{2} 或 \zihao{-2} : 二号/小二 (22pt/18pt)
%%   - \zihao{3} 或 \zihao{-3} : 三号/小三 (16pt/15pt)
%%   - \zihao{4} 或 \zihao{-4} : 四号/小四 (14pt/12pt) - 默认正文
%%   - \zihao{5} 或 \zihao{-5} : 五号/小五 (10.5pt/9pt)
%%
%% 其他参数:
%%   - UTF8      : 使用 UTF-8 编码
%%   - a4paper   : A4 纸张
%%   - twoside   : 双面排版（奇偶页不同）
%%   - twocolumn : 双栏（条件加载）
%%   - fontset   : 字体集配置
%% ----------------------------------------------------------------------------
\ifmanuscript@twocolumn
    \LoadClass[UTF8, zihao=-4, a4paper, twoside, twocolumn, fontset=\manuscript@fontset]{ctexart}
\else
    \LoadClass[UTF8, zihao=-4, a4paper, twoside, fontset=\manuscript@fontset]{ctexart}
\fi

%% ----------------------------------------------------------------------------
%% 页面布局配置
%% ----------------------------------------------------------------------------
%% geometry 宏包提供灵活的页面边距设置
%% 参数说明:
%%   - a4paper      : A4 纸张尺寸
%%   - left=2cm     : 左边距 2cm
%%   - right=2cm    : 右边距 2cm
%%   - top=2.5cm    : 上边距 2.5cm
%%   - bottom=2.5cm : 下边距 2.5cm
%%   - headheight   : 页眉高度
%% ----------------------------------------------------------------------------
\RequirePackage[a4paper, left=2cm, right=2cm, top=2.5cm, bottom=2.5cm, headheight=15pt]{geometry}

%% ----------------------------------------------------------------------------
%% 行距与段落设置
%% ----------------------------------------------------------------------------
%% setspace 宏包控制行距
%%   - review 模式: 2.0 倍行距（方便审稿）
%%   - 正常模式  : 1.25 倍行距
%%
%% 段落设置:
%%   - parindent=2em : 首行缩进 2 个字符
%%   - parskip=0pt   : 段落间距为 0
%% ----------------------------------------------------------------------------
\RequirePackage{setspace}
\ifmanuscript@review
    \setstretch{2.0}
\else
    \setstretch{1.25}
\fi
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\RequirePackage{indentfirst}  % 章节首段也缩进

%% ----------------------------------------------------------------------------
%% 字体配置
%% ----------------------------------------------------------------------------
%% fontspec 宏包用于配置系统字体（XeLaTeX/LuaLaTeX 专用）
%% 注意: 中文字体由 ctex 自动配置，这里主要用于西文字体
%% 用户在 .tex 文件中使用 \setmainfont 等命令覆盖
%% ----------------------------------------------------------------------------
\RequirePackage{fontspec}

%% ----------------------------------------------------------------------------
%% 页眉页脚设置
%% ----------------------------------------------------------------------------
%% fancyhdr 宏包提供灵活的页眉页脚控制
%%   - \pagestyle{fancy} : 启用自定义页眉页脚
%%   - \fancyhf{}        : 清空默认页眉页脚
%%
%% 页眉内容:
%%   - LE (Left Even)  : 偶数页左侧 - 页码
%%   - RO (Right Odd)  : 奇数页右侧 - 页码
%%   - RE (Right Even) : 偶数页右侧 - 章节名
%%   - LO (Left Odd)   : 奇数页左侧 - 章节名
%%
%% plain 样式: 用于首页，无页眉
%% ----------------------------------------------------------------------------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\small\thepage}
\fancyhead[RE,LO]{\small\leftmark}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}

%% ----------------------------------------------------------------------------
%% 章节标题格式
%% ----------------------------------------------------------------------------
%% titlesec 宏包用于自定义章节标题样式
%% 格式: \titleformat{命令}{格式}{标签}{间隔}{标题内容}[后缀]
%%
%% 当前设置:
%%   - section       : \Large\bfseries (西文大号粗体)
%%   - subsection    : \large\bfseries (西文中大号粗体)
%%   - subsubsection : \normalsize\bfseries (正常大小粗体)
%%
%% 字号修改方法:
%%   1. 在 .tex 文档中使用 \titleformat 覆盖（推荐）
%%   2. 直接修改本类文件
%%
%% 可用字号命令:
%%   中文字号: \zihao{3}, \zihao{4}, \zihao{-4} 等
%%   西文字号: \Huge, \huge, \LARGE, \Large, \large, \normalsize, \small
%%
%% 示例 - 改为中文学位论文格式:
%%   \titleformat{\section}{\zihao{3}\bfseries}{\thesection}{1em}{}
%%   \titleformat{\subsection}{\zihao{4}\bfseries}{\thesubsection}{1em}{}
%%   \titleformat{\subsubsection}{\zihao{-4}\bfseries}{\thesubsubsection}{1em}{}
%%
%% 间距 (\titlespacing*):
%%   {左边距}{前间距}{后间距}
%% ----------------------------------------------------------------------------
\RequirePackage{titlesec}
\titleformat{\section}{\large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}{\normalsize\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\normalsize\bfseries}{\thesubsubsection}{1em}{}
\titlespacing*{\section}{0pt}{1.5em}{0.8em}
\titlespacing*{\subsection}{0pt}{1.2em}{0.6em}
\titlespacing*{\subsubsection}{0pt}{1em}{0.5em}

%% ----------------------------------------------------------------------------
%% 数学环境配置
%% ----------------------------------------------------------------------------
%% 加载常用数学宏包:
%%   - amsmath  : AMS 数学环境（必须基础包）
%%   - amssymb  : AMS 数学符号
%%   - amsthm   : 定理环境
%%   - mathtools: amsmath 扩展工具
%%   - bm       : 粗体数学符号
%%   - braket   : 量子力学括号符号
%% ----------------------------------------------------------------------------
\RequirePackage{amsmath, amssymb, amsthm}
\RequirePackage{mathtools}
\RequirePackage{bm}
\RequirePackage{braket}

%% ----------------------------------------------------------------------------
%% 数学快捷命令
%% ----------------------------------------------------------------------------
%% 常用数集:
%%   - \R : 实数集 ℝ
%%   - \N : 自然数集 ℕ
%%   - \Z : 整数集 ℤ
%%   - \C : 复数集 ℂ
%%
%% 概率统计:
%%   - \E    : 期望 ��
%%   - \Var  : 方差
%%   - \Cov  : 协方差
%%   - \Prob : 概率 ℙ
%%
%% 运算符:
%%   - \argmax, \argmin : 带约束的 arg max/min
%%   - \norm{}          : 范数 ‖·‖
%%   - \abs{}           : 绝对值 |·|
%%   - \inner{}         : 内积 ⟨·,·⟩
%%
%% 矩阵:
%%   - \bmat{} : 方括号矩阵 [·]
%%   - \pmat{} : 圆括号矩阵 (·)
%% ----------------------------------------------------------------------------
\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}
\newcommand{\Z}{\mathbb{Z}}
\newcommand{\C}{\mathbb{C}}
\newcommand{\E}{\mathbb{E}}
\newcommand{\Var}{\mathrm{Var}}
\newcommand{\Cov}{\mathrm{Cov}}
\newcommand{\Prob}{\mathbb{P}}
\DeclareMathOperator*{\argmax}{arg\,max}
\DeclareMathOperator*{\argmin}{arg\,min}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\inner}{\langle}{\rangle}
\newcommand{\bmat}[1]{\begin{bmatrix}#1\end{bmatrix}}
\newcommand{\pmat}[1]{\begin{pmatrix}#1\end{pmatrix}}

%% ----------------------------------------------------------------------------
%% 定理环境定义
%% ----------------------------------------------------------------------------
%% 使用条件判断根据语言选项定义不同名称的定理环境
%%
%% 英文模式 (en):
%%   - theorem: Theorem (定理)
%%   - lemma: Lemma (引理)
%%   - proposition: Proposition (命题)
%%   - corollary: Corollary (推论)
%%   - definition: Definition (定义)
%%   - example: Example (示例)
%%   - assumption: Assumption (假设)
%%   - remark: Remark (注)
%%
%% 中文模式 (cn):
%%   - 同上，但显示中文名称
%%
%% 定理样式 (\theoremstyle):
%%   - plain    : 斜体文本（定理、引理等）
%%   - definition: 正体文本（定义、示例等）
%%   - remark   : 正体小号文本（注）
%% ----------------------------------------------------------------------------
\RequirePackage{ifthen}
\ifthenelse{\equal{\manuscript@lang}{en}}{%
    \theoremstyle{plain}
    \newtheorem{theorem}{Theorem}[section]
    \newtheorem{lemma}[theorem]{Lemma}
    \newtheorem{proposition}[theorem]{Proposition}
    \newtheorem{corollary}[theorem]{Corollary}
    \theoremstyle{definition}
    \newtheorem{definition}[theorem]{Definition}
    \newtheorem{example}[theorem]{Example}
    \newtheorem{assumption}[theorem]{Assumption}
    \theoremstyle{remark}
    \newtheorem{remark}[theorem]{Remark}
    \newcommand{\keywordstext}{Keywords}
    \renewcommand{\abstractname}{Abstract}
    \renewcommand{\refname}{References}
}{%
    \theoremstyle{plain}
    \newtheorem{theorem}{定理}[section]
    \newtheorem{lemma}[theorem]{引理}
    \newtheorem{proposition}[theorem]{命题}
    \newtheorem{corollary}[theorem]{推论}
    \theoremstyle{definition}
    \newtheorem{definition}[theorem]{定义}
    \newtheorem{example}[theorem]{例}
    \newtheorem{assumption}[theorem]{假设}
    \theoremstyle{remark}
    \newtheorem{remark}[theorem]{注}
    \newcommand{\keywordstext}{关键词}
    \renewcommand{\abstractname}{摘要}
    \renewcommand{\refname}{参考文献}
}

%% ----------------------------------------------------------------------------
%% 附录样式配置
%% ----------------------------------------------------------------------------
%% 使用 \appendix 命令后，章节编号自动变为 A, B, C...
%% 本配置定义附录的标题格式和编号样式
%%
%% 配置说明:
%%   - 附录章节编号: A, B, C... (由 \thesection 自动处理)
%%   - 标题格式: 与正文章节一致，可独立修改
%%   - 支持多级附录: \subsection 变为 A.1, A.2...
%%
%% 使用方法:
%%   \appendix
%%   \section{附录标题}     % 显示为: 附录 A  附录标题
%%   \subsection{子附录}    % 显示为: A.1  子附录
%%
%% 如需更改附录标题前缀（如改为"Appendix"）:
%%   \renewcommand{\appendixname}{Appendix}  % 英文模式
%%   \renewcommand{\appendixname}{附录}      % 中文模式（已默认）
%% ----------------------------------------------------------------------------

%% 定义附录名称（根据语言自动设置）
\ifthenelse{\equal{\manuscript@lang}{en}}{%
    \renewcommand{\appendixname}{Appendix}
}{%
    \renewcommand{\appendixname}{附录}
}

%% 附录章节标题格式（与正文一致，可独立调整）
%% 使用 \appendix 后，\thesection 自动变为 A, B, C...
\let\oldappendix\appendix
\renewcommand{\appendix}{%
    \oldappendix
    %% 附录章节标题格式
    \titleformat{\section}{\large\bfseries}{\appendixname~\thesection}{1em}{}
    %% 附录二级标题格式 (A.1, A.2...)
    \titleformat{\subsection}{\normalsize\bfseries}{\thesubsection}{1em}{}
    %% 附录三级标题格式 (A.1.1, A.1.2...)
    \titleformat{\subsubsection}{\normalsize\bfseries}{\thesubsubsection}{1em}{}
    %% 重置章节编号
    \setcounter{section}{0}
    \setcounter{subsection}{0}
    \setcounter{subsubsection}{0}
    %% 重新定义 section 的计数器输出格式为大写字母
    \renewcommand{\thesection}{\Alph{section}}
    \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
    \renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}
}

%% ----------------------------------------------------------------------------
%% 图表管理
%% ----------------------------------------------------------------------------
%% 加载的宏包:
%%   - graphicx   : 插入图片
%%   - booktabs   : 专业表格线（三线表）
%%   - array      : 增强表格功能
%%   - multirow   : 跨行合并
%%   - subcaption : 子图/子表支持
%%   - caption    : 图表标题格式控制
%%
%% 图表标题字号配置 (\captionsetup):
%%   当前设置: font={small, bf} - 小号粗体
%%
%% 字号选项:
%%   - font={small, bf}      : 五号字 (10.5pt) 粗体
%%   - font={footnotesize, bf}: 小五号 (9pt) 粗体
%%   - font={normalsize, bf} : 小四号 (12pt) 粗体
%%   - font={zihao=5, bf}    : 五号字 (中文)
%%
%% 修改方法:
%%   在 .tex 文档中使用 \captionsetup 覆盖:
%%     \captionsetup{font={zihao=5, bf}}  % 改为五号字
%%
%% 其他格式选项:
%%   - justification=centering : 居中
%%   - labelsep=colon          : 标签分隔符用冒号 (图1: 标题)
%%   - labelsep=space          : 空格分隔 (图1 标题)
%%   - skip=8pt                : 标题与内容间距
%%
%% 子图标题设置 (\captionsetup[sub]):
%%   当前: font=small, labelfont=bf
%%
%% 浮动体参数（控制图表位置）:
%%   - topnumber/bottomnumber : 每页顶部/底部最大浮动体数
%%   - totalnumber            : 每页总浮动体数
%% ----------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{subcaption}
\RequirePackage{caption}
\captionsetup{font={small, bf}, justification=centering, labelsep=colon, skip=8pt}
\captionsetup[sub]{font=small, labelfont=bf}
\setcounter{topnumber}{4}
\setcounter{bottomnumber}{4}
\setcounter{totalnumber}{8}
\renewcommand{\floatpagefraction}{0.9}
\renewcommand{\textfraction}{0.05}
\renewcommand{\topfraction}{0.95}
\renewcommand{\bottomfraction}{0.95}

%% ----------------------------------------------------------------------------
%% 表格增强
%% ----------------------------------------------------------------------------
%% tabularx : 自动调整列宽的表格环境
%% makecell : 单元格内换行和格式控制
%% \thead   : 表头格式（粗体小号）
%% \theadgape: 表头间距
%% ----------------------------------------------------------------------------
\RequirePackage{tabularx}
\RequirePackage{makecell}
\renewcommand{\theadfont}{\bfseries\small}
\renewcommand{\theadgape}{\small}

%% ----------------------------------------------------------------------------
%% 列表优化
%% ----------------------------------------------------------------------------
%% enumitem 宏包提供灵活的列表格式控制
%% 默认设置:
%%   - nosep      : 紧凑模式（无额外间距）
%%   - leftmargin=2em : 左缩进 2 字符
%%   - label=\textbullet : 项目符号为圆点
%% ----------------------------------------------------------------------------
\RequirePackage{enumitem}
\setlist{nosep, leftmargin=2em}
\setlist[itemize]{label=\textbullet}
\setlist[enumerate]{label=\arabic*.}

%% ----------------------------------------------------------------------------
%% 脚注样式
%% ----------------------------------------------------------------------------
%% footmisc 宏包增强脚注功能
%% 选项:
%%   - bottom   : 脚注放在页面底部
%%   - perpage  : 每页重新编号
%%   - hang     : 悬挂缩进
%% ----------------------------------------------------------------------------
\RequirePackage[bottom, perpage, hang]{footmisc}
\renewcommand{\footnotemargin}{1.5em}
\renewcommand{\footnotelayout}{\hspace{1em}}

%% ----------------------------------------------------------------------------
%% 算法伪代码
%% ----------------------------------------------------------------------------
%% algorithm2e 宏包提供算法环境
%% 选项:
%%   - linesnumbered : 显示行号
%%   - ruled         : 带标题框线
%%   - vlined        : 垂直缩进线
%%
%% 算法字号配置:
%%   当前设置:
%%     - \SetAlFnt{\small}          : 算法体 - 五号字 (10.5pt)
%%     - \SetAlCapFnt{\small\bfseries} : 标题编号 - 五号粗体
%%     - \SetAlCapNameFnt{\small\bfseries} : 标题名称 - 五号粗体
%%
%% 可选字号:
%%   - \small      : 五号 (10.5pt) - 默认
%%   - \footnotesize : 小五号 (9pt)
%%   - \normalsize   : 小四号 (12pt)
%%   - \zihao{5}     : 五号中文字号
%%   - \zihao{-4}    : 小四号中文字号
%%
%% 修改方法:
%%   在 .tex 文档中重新设置:
%%     \SetAlFnt{\zihao{5}}          % 算法体改五号
%%     \SetAlCapFnt{\zihao{5}\bfseries}  % 标题改五号粗体
%%
%% 命令重定义:
%%   - \SetKwInput{KwIn}{Input}  : 将 \KwIn 显示为 "Input"
%% ----------------------------------------------------------------------------
\RequirePackage[linesnumbered, ruled, vlined]{algorithm2e}
\SetAlFnt{\small}
\SetAlCapFnt{\small\bfseries}
\SetAlCapNameFnt{\small\bfseries}
\SetKwInput{KwIn}{Input}
\SetKwInput{KwOut}{Output}

%% ----------------------------------------------------------------------------
%% 参考文献
%% ----------------------------------------------------------------------------
%% biblatex 宏包提供现代化的参考文献管理
%% 选项:
%%   - backend=biber   : 使用 biber 后端（推荐）
%%   - style=numeric   : 数字引用样式 [1,2,3]
%%   - sorting=none    : 按引用顺序排序
%%   - sortcites=true  : 同一引用点内排序
%%   - maxnames=3      : 最多显示 3 个作者
%%   - minnames=1      : 超过时显示 "et al."
%%   - hyperref=true   : 启用引用超链接（点击跳转到参考文献）
%%   - backref=true    : 在参考文献后显示引用页码反向链接
%%
%% 编译方式: xelatex -> biber -> xelatex -> xelatex
%%
%% 常用引用命令:
%%   - \cite{key}      : [1]
%%   - \parencite{key} : [1]
%%   - \textcite{key}  : Author [1]
%%   - \footcite{key}  : 脚注引用
%%
%% 打印参考文献:
%%   - \printbibliography : 打印参考文献列表
%% ----------------------------------------------------------------------------
\RequirePackage[backend=biber, style=numeric, sorting=none, sortcites=true, maxnames=3, minnames=1, hyperref=true, backref=true]{biblatex}

%% ----------------------------------------------------------------------------
%% 单位排版
%% ----------------------------------------------------------------------------
%% siunitx 宏包提供标准单位排版
%% 设置:
%%   - per-mode=symbol : 使用符号形式（如 m/s）
%%   - separate-uncertainty=true : 不确定度分开显示
%%
%% 常用命令:
%%   - \SI{数值}{单位} : 如 \SI{10}{\meter\per\second}
%%   - \num{数值}     : 格式化数字
%% ----------------------------------------------------------------------------
\RequirePackage{siunitx}
\sisetup{per-mode=symbol, separate-uncertainty=true}

%% ----------------------------------------------------------------------------
%% 超链接
%% ----------------------------------------------------------------------------
%% hyperref 宏包为目录、引用等添加超链接
%% 注意: 应在大部分宏包之后加载
%%
%% xcolor 提供颜色支持
%% bookmark 生成 PDF 书签，改善导航结构
%%
%% 超链接颜色设置:
%%   - linkcolor  : 内部链接（章节、公式等）
%%   - citecolor  : 引用链接
%%   - urlcolor   : URL 链接
%%   - colorlinks : true 显示颜色，false 使用边框
%% ----------------------------------------------------------------------------
\RequirePackage{xcolor}
\RequirePackage{bookmark}  % 必须在 hyperref 之前加载，优化 PDF 书签
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,
    linkcolor=blue!70!black,
    citecolor=blue!70!black,
    urlcolor=blue!60!black
}

%% ----------------------------------------------------------------------------
%% 智能引用
%% ----------------------------------------------------------------------------
%% cleveref 宏包自动识别引用类型并添加前缀
%% 应在 hyperref 之后加载
%%
%% 使用 \cref{label} 代替 \ref{label}:
%%   - 公式 : Eq. (1) / 式 (1)
%%   - 图   : Fig. 1 / 图 1
%%   - 表   : Table 1 / 表 1
%%   - 章节 : Section 1 / 第 1 节
%% ----------------------------------------------------------------------------
\RequirePackage{cleveref}
\crefname{equation}{Eq.}{Eqs.}
\crefname{figure}{Fig.}{Figs.}
\crefname{table}{Table}{Tables}
\crefname{section}{Section}{Sections}
\crefname{algorithm}{Algorithm}{Algorithms}
\crefname{theorem}{Theorem}{Theorems}
\crefname{lemma}{Lemma}{Lemmas}
\crefname{definition}{Definition}{Definitions}

%% ----------------------------------------------------------------------------
%% 自定义命令
%% ----------------------------------------------------------------------------
%% \keywords{} : 关键词命令（用于旧模板兼容）
%% \todo{}     : TODO 标记（红色粗体）
%% ----------------------------------------------------------------------------
\newcommand{\keywords}[1]{\par\noindent\textbf{\keywordstext: }#1\par}
\newcommand{\todo}[1]{\textcolor{red}{\textbf{[TODO: #1]}}}

%% ----------------------------------------------------------------------------
%% 独立摘要命令
%% ----------------------------------------------------------------------------
%% \Abstract{}  : 独立摘要命令（替代环境形式）
%% \Keywords{}  : 独立关键词命令
%% 使用后自动恢复首行缩进
%% ----------------------------------------------------------------------------
\newcommand{\Abstract}[1]{%
    \par\small\noindent\textbf{\abstractname}\quad#1\par\global\@afterindenttrue%
}

\newcommand{\Keywords}[1]{%
    \par\small\noindent\textbf{\keywordstext: }#1\par\global\@afterindenttrue%
}

%% ----------------------------------------------------------------------------
%% 摘要环境（向后兼容）
%% ----------------------------------------------------------------------------
%% 重定义 abstract 环境以保持向后兼容
%% 推荐使用 \Abstract{} 命令替代
%% ----------------------------------------------------------------------------
\renewenvironment{abstract}{\par\small\noindent\textbf{\abstractname}\quad\ignorespaces}{\par\global\@afterindenttrue}

%% ============================================================================
%% 模块化作者配置系统
%% ============================================================================
%% 本系统提供灵活的作者和单位配置，支持:
%%   - 多作者
%%   - 多单位
%%   - 自动标记上标
%%   - 通讯作者自动脚注
%%
%% 使用方法:
%%   \authorinfo[标记]{姓名}{单位标记}{邮箱}
%%   \affiliation{标记}{单位名称}
%%
%% 示例:
%%   \authorinfo[*]{张三}{a}{zhang@example.edu}
%%   \authorinfo[]{李四}{a,b}{li@example.edu}
%%   \affiliation{a}{中国科学院}
%%   \affiliation{b}{清华大学}
%%
%% ----------------------------------------------------------------------------

%% 需要 etoolbox 提供列表操作
\RequirePackage{etoolbox}

%% 语言相关的通讯作者文本
\newcommand{\ManuscriptCorrText}{%
    \ifthenelse{\equal{\manuscript@lang}{en}}{Corresponding author}{通讯作者}%
}

%% ----------------------------------------------------------------------------
%% 计数器和存储列表
%% ----------------------------------------------------------------------------
%% 计数器:
%%   - ManuscriptAuthorCount : 作者数量
%%   - ManuscriptAffilCount  : 单位数量
%%   - ManuscriptCorrCount   : 通讯作者数量
%%
%% 存储列表:
%%   - \ManuscriptAuthorList : 作者列表字符串
%%   - \ManuscriptAffilList  : 单位列表字符串
%%   - \ManuscriptCorrList   : 通讯作者脚注列表
%% ----------------------------------------------------------------------------
\newcounter{ManuscriptAuthorCount}
\newcounter{ManuscriptAffilCount}
\newcounter{ManuscriptCorrCount}

\newcommand{\ManuscriptAuthorList}{}
\newcommand{\ManuscriptAffilList}{}
\newcommand{\ManuscriptCorrList}{}

%% ----------------------------------------------------------------------------
%% 清空配置命令
%% ----------------------------------------------------------------------------
%% \clearauthors 重置所有作者和单位配置
%% 用于同一文档内重新开始配置
%% ----------------------------------------------------------------------------
\newcommand{\clearauthors}{%
    \renewcommand{\ManuscriptAuthorList}{}%
    \renewcommand{\ManuscriptAffilList}{}%
    \renewcommand{\ManuscriptCorrList}{}%
    \setcounter{ManuscriptAuthorCount}{0}%
    \setcounter{ManuscriptAffilCount}{0}%
    \setcounter{ManuscriptCorrCount}{0}%
}

%% ----------------------------------------------------------------------------
%% 添加单位命令
%% ----------------------------------------------------------------------------
%% 用法: \affiliation{标记}{单位名称}
%% 参数:
%%   - 标记: 用于关联作者和单位（如 a, b, c）
%%   - 单位名称: 完整的机构名称和地址
%%
%% 注意: 标记顺序不影响显示顺序
%% ----------------------------------------------------------------------------
\newcommand{\affiliation}[2]{%
    \stepcounter{ManuscriptAffilCount}%
    \appto\ManuscriptAffilList{\small\textsuperscript{#1}#2\\}%
}

%% ----------------------------------------------------------------------------
%% 添加作者命令
%% ----------------------------------------------------------------------------
%% 用法: \authorinfo[标记]{姓名}{单位标记}{邮箱}
%% 参数:
%%   - [标记]: 可选，* 表示通讯作者，将添加脚注
%%   - 姓名: 作者姓名
%%   - 单位标记: 关联单位，多个用逗号分隔（如 a,b）
%%   - 邮箱: 邮箱地址（通讯作者会显示在脚注中）
%%
%% 功能:
%%   - 自动添加作者之间的逗号分隔
%%   - 为单位标记添加上标
%%   - 为通讯作者标记添加上标
%%   - 自动收集通讯作者信息到脚注
%% ----------------------------------------------------------------------------
\newcommand{\authorinfo}[4][]{%
    \stepcounter{ManuscriptAuthorCount}%
    %% 添加到作者列表
    \ifnum\value{ManuscriptAuthorCount}>1
        \appto\ManuscriptAuthorList{, }%
    \fi
    \appto\ManuscriptAuthorList{#2}%
    \ifx\relax#3\relax\else
        \appto\ManuscriptAuthorList{\textsuperscript{#3}}%
    \fi
    \ifx\relax#1\relax\else
        \appto\ManuscriptAuthorList{\textsuperscript{#1}}%
    \fi
    %% 如果是通讯作者，添加到脚注列表
    \ifx\relax#1\relax\else
        \ifnum\value{ManuscriptCorrCount}>0
            \appto\ManuscriptCorrList{; }%
        \fi
        \stepcounter{ManuscriptCorrCount}%
        \appto\ManuscriptCorrList{\textsuperscript{#1}\ManuscriptCorrText: \href{mailto:#4}{#4}}%
    \fi
}

%% ----------------------------------------------------------------------------
%% 生成作者块
%% ----------------------------------------------------------------------------
%% 内部命令，生成作者和单位信息的排版
%% 输出格式:
%%   作者1^a, 作者2^a,b, 作者3^b
%%   ^a 单位1
%%   ^b 单位2
%% ----------------------------------------------------------------------------
\newcommand{\makeauthorblock}{%
    \ManuscriptAuthorList\\[4pt]%
    \ManuscriptAffilList%
}

%% ----------------------------------------------------------------------------
%% 生成作者脚注
%% ----------------------------------------------------------------------------
%% 内部命令，生成通讯作者脚注
%% 使用 \footnote 但不显示编号（\thefootnote 为空）
%% ----------------------------------------------------------------------------
\newcommand{\makeauthorfootnote}{%
    \ifx\ManuscriptCorrList\empty\else
        \begingroup
            \renewcommand{\thefootnote}{}%
            \footnote{\ManuscriptCorrList}%
        \endgroup
    \fi
}

%% ----------------------------------------------------------------------------
%% 标题生成命令
%% ----------------------------------------------------------------------------
%% 重定义 \maketitle 以使用自定义的作者系统
%% 排版顺序:
%%   1. 居中标题（大号粗体）
%%   2. 作者和单位信息块
%%   3. 通讯作者脚注（如果有）
%%
%% 垂直间距:
%%   - 标题与作者: 0.8em
%%   - 作者与正文: 0.8em
%% ----------------------------------------------------------------------------
\renewcommand{\maketitle}{%
    \begingroup
        \centering
        {\Large\bfseries\@title\par}
        \vspace{0.8em}
        {\normalsize\makeauthorblock\par}%
    \endgroup
    \vspace{0.8em}%
    \makeauthorfootnote
}

%% ----------------------------------------------------------------------------
%% 类文件结束
%% ----------------------------------------------------------------------------
\endinput