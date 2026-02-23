// 英文学术论文模板
// 编译: typst compile template-en.typ

#import "manuscript.typ": manuscript, theorem, lemma, definition, remark, example, assumption, proposition, corollary, RR, NN, ZZ, CC, EE, PP, Var, Cov, norm, abs, bmat, pmat, argmin, argmax, todo, highlight
#import "@preview/algo:0.3.6": algo, i, d, comment

#set par(
  first-line-indent: (amount: 2em, all: true),
  leading: 0.55em,
  spacing: 0.65em,
  justify: true,
)

#manuscript(
  title: [Your Paper Title Here],
  authors: (
    (
      name: "Wenjie Xu",
      affiliation: "a,b",
      affiliation-display: "Institutes of Science and Development, Chinese Academy of Sciences, Beijing 100190, China",
      corresponding: true,
    ),
    (
      name: "Second Author",
      affiliation: "a",
      affiliation-display: "Institutes of Science and Development, Chinese Academy of Sciences, Beijing 100190, China",
    ),
    (
      name: "Third Author",
      affiliation: "b",
      affiliation-display: "School of Public Policy and Management, University of Chinese Academy of Sciences, Beijing 100049, China",
    ),
  ),
  abstract: [Write your abstract here. The abstract should briefly summarize the main contributions, methodology, and results of your paper. Keep it concise and informative, typically within 150--250 words.],
  keywords: ("Keyword 1", "Keyword 2", "Keyword 3", "Keyword 4"),
  lang: "en",
)[

= Introduction <sec:intro>

Write your introduction here. Provide background context, state the research problem, and outline the paper structure @example2023paper.

The main contributions of this paper include:
+ Contribution 1
+ Contribution 2
+ Contribution 3

The remainder of this paper is organized as follows. @sec:method presents the methodology. @sec:exp describes the experiments. @sec:conclusion concludes the paper.

= Related Work <sec:related>

Review relevant literature and position your work.

= Methodology <sec:method>

== Problem Formulation <sec:formulation>

Describe the problem formulation. Key equations should be numbered:

$ f(x) = sum_(i=1)^n alpha_i dot g_i(x) $ <eq:example>

where $alpha_i$ are the parameters and $g_i(x)$ are the basis functions.

Let $x in RR^n$, the expected value $EE[X]$ and variance $Var(X)$ are computed.

#definition(name: "Term Name")[
  Provide the definition here.
]

#theorem(name: "Theorem Name")[
  State the theorem here.
]

#lemma(name: "Lemma Name")[
  State the lemma here.
]

== Algorithm <sec:algorithm>

#figure(
  kind: "algorithm",
  supplement: [Algorithm],
  algo(
    title: "Algorithm Name",
    line-numbers: true,
    stroke: 0.5pt + gray,
    fill: rgb(98%, 98%, 98%),
    indent-guides: 0.5pt + luma(220),
    indent-size: 15pt,
    inset: 8pt,
  )[
    *Input:* Input parameters\
    *Output:* Output result\
    Step 1 description\
    *for* each iteration *do* #i
      Update step #d\
    *end for*\
    *return* Final result
  ],
  caption: [Algorithm Name],
) <alg:example>

@alg:example shows the main algorithm workflow.

= Experiments <sec:exp>

== Experimental Setup <sec:setup>

Describe datasets, baseline methods, and evaluation metrics.

#figure(
  table(
    columns: 3,
    align: center,
    stroke: (x, y) => if y == 0 { 0.8pt + black }
                      else if y == 1 { 0.4pt + black }
                      else if y == 4 { 0.8pt + black }
                      else { none },
    table.header(
      [*Metric*], [*Dataset A*], [*Dataset B*],
    ),
    [Samples], [XXX], [XXX],
    [Features], [XXX], [XXX],
    [Classes], [XXX], [XXX],
  ),
  caption: [Dataset Statistics],
) <tab:data>

== Results <sec:results>

#figure(
  table(
    columns: 4,
    align: center,
    stroke: (x, y) => if y == 0 { 0.8pt + black }
                      else if y == 1 { 0.4pt + black }
                      else if y == 4 { 0.8pt + black }
                      else { none },
    table.header(
      [*Method*], [*Metric 1*], [*Metric 2*], [*Metric 3*],
    ),
    [Baseline 1], [XX.X], [XX.X], [XX.X],
    [Baseline 2], [XX.X], [XX.X], [XX.X],
    table.cell(fill: rgb(95%, 95%, 95%), [*Ours*]), 
    table.cell(fill: rgb(95%, 95%, 95%), [*XX.X*]), 
    table.cell(fill: rgb(95%, 95%, 95%), [*XX.X*]), 
    table.cell(fill: rgb(95%, 95%, 95%), [*XX.X*]),
  ),
  caption: [Performance Comparison],
) <tab:results>

@tab:results shows the comparison results. Our method outperforms all baselines.

= Conclusion <sec:conclusion>

Summarize the main findings and discuss future work directions.

#bibliography("references.bib", style: "ieee")
]