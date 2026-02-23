// 中文学术论文模板
// 编译: typst compile template-cn.typ

#import "manuscript.typ": manuscript, theorem-cn as theorem, lemma-cn as lemma, definition-cn as definition, remark-cn as remark, proposition-cn as proposition, corollary-cn as corollary, example-cn as example, assumption-cn as assumption, RR, NN, ZZ, CC, EE, PP, Var, Cov, norm, abs, bmat, pmat, argmin, argmax, todo, highlight
#import "@preview/algo:0.3.6": algo, i, d, comment

#set par(
  first-line-indent: (amount: 2em, all: true),
  leading: 0.55em,
  spacing: 0.65em,
  justify: true,
)

#manuscript(
  title: [论文标题],
  authors: (
    (
      name: "徐文杰",
      affiliation: "a,b",
      affiliation-display: "中国科学院科技战略咨询研究院，北京 100190",
      corresponding: true,
    ),
    (
      name: "第二作者",
      affiliation: "a",
      affiliation-display: "中国科学院科技战略咨询研究院，北京 100190",
    ),
    (
      name: "第三作者",
      affiliation: "b",
      affiliation-display: "中国科学院大学公共政策与管理学院，北京 100049",
    ),
  ),
  abstract: [在此撰写摘要。摘要应简要概括论文的主要贡献、方法和结果，通常在 150--250 字之间。],
  keywords: ("关键词 1", "关键词 2", "关键词 3", "关键词 4"),
  lang: "cn",
)[

= 引言 <sec:intro>

在此撰写引言部分。介绍研究背景、问题描述和论文结构 @example2023paper。

本模板支持中英文混排（Chinese and English mixed typesetting），数学公式和术语可以自然切换。

主要贡献包括：
+ 贡献 1
+ 贡献 2
+ 贡献 3

= 相关工作 <sec:related>

综述相关文献，将你的工作定位在现有研究中。

= 方法 <sec:method>

== 问题建模 <sec:formulation>

描述问题建模。关键公式应编号：

$ f(x) = sum_(i=1)^n alpha_i dot g_i(x) $ <eq:example>

其中 $alpha_i$ 为参数，$g_i(x)$ 为基函数。

设 $x in RR^n$，期望 $EE[X]$ 和方差 $Var(X)$ 计算如下。

#definition(name: "术语名称")[
  在此给出定义。
]

#theorem(name: "定理名称")[
  在此陈述定理内容。
]

#lemma(name: "引理名称")[
  在此陈述引理内容。
]

== 算法 <sec:algorithm>

#figure(
  kind: "algorithm",
  supplement: [算法],
  algo(
    title: "算法名称",
    line-numbers: true,
    stroke: 0.5pt + gray,
    fill: rgb(98%, 98%, 98%),
    indent-guides: 0.5pt + luma(220),
    indent-size: 15pt,
    inset: 8pt,
  )[
    *输入:* 输入参数\
    *输出:* 输出结果\
    步骤 1 描述\
    *for* 每次迭代 *do* #i
      更新步骤 #d\
    *end for*\
    *return* 最终结果
  ],
  caption: [算法名称],
) <alg:example>

@alg:example 展示了主要算法流程。

= 实验 <sec:exp>

== 实验设置 <sec:setup>

描述数据集、基线方法和评价指标。

#figure(
  table(
    columns: 3,
    align: center,
    stroke: (x, y) => if y == 0 { 0.8pt + black }
                      else if y == 1 { 0.4pt + black }
                      else if y == 4 { 0.8pt + black }
                      else { none },
    table.header(
      [*指标*], [*数据集 A*], [*数据集 B*],
    ),
    [样本数], [XXX], [XXX],
    [特征数], [XXX], [XXX],
    [类别数], [XXX], [XXX],
  ),
  caption: [数据集统计],
) <tab:data>

== 实验结果 <sec:results>

#figure(
  table(
    columns: 4,
    align: center,
    stroke: (x, y) => if y == 0 { 0.8pt + black }
                      else if y == 1 { 0.4pt + black }
                      else if y == 4 { 0.8pt + black }
                      else { none },
    table.header(
      [*方法*], [*指标 1*], [*指标 2*], [*指标 3*],
    ),
    [基线 1], [XX.X], [XX.X], [XX.X],
    [基线 2], [XX.X], [XX.X], [XX.X],
    table.cell(fill: rgb(95%, 95%, 95%), [*本文方法*]), 
    table.cell(fill: rgb(95%, 95%, 95%), [*XX.X*]), 
    table.cell(fill: rgb(95%, 95%, 95%), [*XX.X*]), 
    table.cell(fill: rgb(95%, 95%, 95%), [*XX.X*]),
  ),
  caption: [性能对比],
) <tab:results>

@tab:results 展示了对比结果。结果表明本文方法优于所有基线方法。

= 结论 <sec:conclusion>

总结主要发现并讨论未来工作方向。

#bibliography("references.bib", style: "gb-7714-2015-numeric")
]