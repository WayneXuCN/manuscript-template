%% ============================================================
%% 中英文学术论文模板
%% 编译: XeLaTeX / LuaLaTeX
%% ============================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{manuscript}[2026/02/23 v1.0 Chinese academic manuscript template]

%% 文档类选项
%% fontset: 字体集, lang: 语言, twocolumn: 双栏, review: 审稿模式
\newcommand{\manuscript@fontset}{macnew}
\newcommand{\manuscript@lang}{en}
\newif\ifmanuscript@twocolumn
\newif\ifmanuscript@review

\DeclareOption{macnew}{\renewcommand{\manuscript@fontset}{macnew}}
\DeclareOption{windows}{\renewcommand{\manuscript@fontset}{windows}}
\DeclareOption{fandol}{\renewcommand{\manuscript@fontset}{fandol}}
\DeclareOption{ubuntu}{\renewcommand{\manuscript@fontset}{ubuntu}}
\DeclareOption{cn}{\renewcommand{\manuscript@lang}{cn}}
\DeclareOption{en}{\renewcommand{\manuscript@lang}{en}}
\DeclareOption{twocolumn}{\manuscript@twocolumntrue}
\DeclareOption{review}{\manuscript@reviewtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

%% 加载基础文档类
\ifmanuscript@twocolumn
    \LoadClass[UTF8, zihao=-4, a4paper, twoside, twocolumn, fontset=\manuscript@fontset]{ctexart}
\else
    \LoadClass[UTF8, zihao=-4, a4paper, twoside, fontset=\manuscript@fontset]{ctexart}
\fi

%% 页面布局: A4, 2cm边距, 2.5cm上下边距
\RequirePackage[a4paper, left=2cm, right=2cm, top=2.5cm, bottom=2.5cm, headheight=15pt]{geometry}

%% 行距与段落: 1.25倍行距, 首行缩进2em
\RequirePackage{setspace}
\ifmanuscript@review
    \setstretch{2.0}
\else
    \setstretch{1.25}
\fi
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}
\RequirePackage{indentfirst}

%% 字体配置
\RequirePackage{fontspec}

%% 页眉页脚
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\small\thepage}
\fancyhead[RE,LO]{\small\leftmark}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}

%% 章节标题格式
\RequirePackage{titlesec}
\titleformat{\section}{\Large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}{\large\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\normalsize\bfseries}{\thesubsubsection}{1em}{}
\titlespacing*{\section}{0pt}{1.5em}{0.8em}
\titlespacing*{\subsection}{0pt}{1.2em}{0.6em}
\titlespacing*{\subsubsection}{0pt}{1em}{0.5em}

%% 数学环境
\RequirePackage{amsmath, amssymb, amsthm}
\RequirePackage{mathtools}
\RequirePackage{bm}
\RequirePackage{braket}

% 数学快捷命令
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

%% 定理环境 - 支持中英文
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

%% 图表管理
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

%% 表格增强
\RequirePackage{tabularx}
\RequirePackage{makecell}
\renewcommand{\theadfont}{\bfseries\small}
\renewcommand{\theadgape}{\small}

%% 列表优化
\RequirePackage{enumitem}
\setlist{nosep, leftmargin=2em}
\setlist[itemize]{label=\textbullet}
\setlist[enumerate]{label=\arabic*.}

%% 脚注样式
\RequirePackage[bottom, perpage, hang]{footmisc}
\renewcommand{\footnotemargin}{1.5em}
\renewcommand{\footnotelayout}{\hspace{1em}}

%% 算法伪代码
\RequirePackage[linesnumbered, ruled, vlined]{algorithm2e}
\SetAlFnt{\small}
\SetAlCapFnt{\small\bfseries}
\SetAlCapNameFnt{\small\bfseries}
\SetKwInput{KwIn}{Input}
\SetKwInput{KwOut}{Output}

%% 参考文献
\RequirePackage[numbers, sort&compress]{natbib}

%% 单位排版
\RequirePackage{siunitx}
\sisetup{per-mode=symbol, separate-uncertainty=true}

%% 超链接
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\hypersetup{colorlinks=true, linkcolor=blue!70!black, citecolor=blue!70!black, urlcolor=blue!60!black}

%% 智能引用
\RequirePackage{cleveref}
\crefname{equation}{Eq.}{Eqs.}
\crefname{figure}{Fig.}{Figs.}
\crefname{table}{Table}{Tables}
\crefname{section}{Section}{Sections}
\crefname{algorithm}{Algorithm}{Algorithms}
\crefname{theorem}{Theorem}{Theorems}
\crefname{lemma}{Lemma}{Lemmas}
\crefname{definition}{Definition}{Definitions}

%% 自定义命令
\newcommand{\keywords}[1]{\par\noindent\textbf{\keywordstext: }#1\par}
\newcommand{\todo}[1]{\textcolor{red}{\textbf{[TODO: #1]}}}

%% 独立摘要命令 \Abstract{内容}
\newcommand{\Abstract}[1]{%
    \par\small\noindent\textbf{\abstractname}\quad#1\par\global\@afterindenttrue%
}

%% 独立关键词命令 \Keywords{内容}
\newcommand{\Keywords}[1]{%
    \par\small\noindent\textbf{\keywordstext: }#1\par\global\@afterindenttrue%
}

%% 摘要环境（保持向后兼容）
\renewenvironment{abstract}{\par\small\noindent\textbf{\abstractname}\quad\ignorespaces}{\par\global\@afterindenttrue}

%% ============================================================
%% 模块化作者配置系统
%% ============================================================

% 需要 etoolbox 提供更可靠的列表操作
\RequirePackage{etoolbox}

% 语言相关的通讯作者文本
\newcommand{\ManuscriptCorrText}{%
    \ifthenelse{\equal{\manuscript@lang}{en}}{Corresponding author}{通讯作者}%
}

% 计数器
\newcounter{ManuscriptAuthorCount}
\newcounter{ManuscriptAffilCount}
\newcounter{ManuscriptCorrCount}

% 存储列表
\newcommand{\ManuscriptAuthorList}{}
\newcommand{\ManuscriptAffilList}{}
\newcommand{\ManuscriptCorrList}{}

% 清空配置命令
\newcommand{\clearauthors}{%
    \renewcommand{\ManuscriptAuthorList}{}%
    \renewcommand{\ManuscriptAffilList}{}%
    \renewcommand{\ManuscriptCorrList}{}%
    \setcounter{ManuscriptAuthorCount}{0}%
    \setcounter{ManuscriptAffilCount}{0}%
    \setcounter{ManuscriptCorrCount}{0}%
}

% 添加单位
% 用法: \affiliation{标记}{单位名称}
\newcommand{\affiliation}[2]{%
    \stepcounter{ManuscriptAffilCount}%
    \appto\ManuscriptAffilList{\small\textsuperscript{#1}#2\\}%
}

% 添加作者
% 用法: \authorinfo[标记]{姓名}{单位标记}{邮箱}
% 标记: * 表示通讯作者
\newcommand{\authorinfo}[4][]{%
    \stepcounter{ManuscriptAuthorCount}%
    % 添加到作者列表
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
    % 如果是通讯作者，添加到脚注列表
    \ifx\relax#1\relax\else
        \ifnum\value{ManuscriptCorrCount}>0
            \appto\ManuscriptCorrList{; }%
        \fi
        \stepcounter{ManuscriptCorrCount}%
        \appto\ManuscriptCorrList{\textsuperscript{#1}\ManuscriptCorrText: \href{mailto:#4}{#4}}%
    \fi
}

% 生成作者块
\newcommand{\makeauthorblock}{%
    \ManuscriptAuthorList\\[4pt]%
    \ManuscriptAffilList%
}

% 生成脚注
\newcommand{\makeauthorfootnote}{%
    \ifx\ManuscriptCorrList\empty\else
        \begingroup
            \renewcommand{\thefootnote}{}%
            \footnote{\ManuscriptCorrList}%
        \endgroup
    \fi
}

% 标题生成
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

\endinput
