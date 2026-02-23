// 中英文学术论文模板

// ============================================================
// 数学命令
// ============================================================
#let RR = math.bb("R")      // 实数集
#let NN = math.bb("N")      // 自然数集
#let ZZ = math.bb("Z")      // 整数集
#let CC = math.bb("C")      // 复数集
#let EE = math.bb("E")      // 期望
#let PP = math.bb("P")      // 概率

#let norm(it) = $lr(||#it||)$
#let abs(it) = $lr(|#it|)$
#let inner(it) = $lr(angle.l #it angle.r)$
#let argmin = math.op("arg min", limits: true)
#let argmax = math.op("arg max", limits: true)
#let Var(it) = $op("Var")#it$
#let Cov(it) = $op("Cov")#it$
#let bmat(body) = $mat(delim: "[", #body)$
#let pmat(body) = $mat(delim: "(", #body)$

// ============================================================
// 定理环境
// ============================================================
#let theorem-counter = counter("theorem-counter")

#let theorem-styles = (
  plain: (title-weight: "bold", body-style: (italic: false)),
  definition: (title-weight: "bold", body-style: (italic: false)),
  remark: (title-weight: "regular", body-style: (italic: false)),
)

#let make-theorem(prefix: "Theorem", prefix-cn: "定理", style: "plain", lang: "en") = {
  let config = theorem-styles.at(style)
  let label-name = if lang == "cn" { prefix-cn } else { prefix }
  
  (name: none, body) => {
    theorem-counter.step()
    context {
      let heading-val = counter(heading).get()
      let section-num = if heading-val.len() > 0 { heading-val.at(0) } else { 0 }
      let theorem-num = theorem-counter.get().at(0)
      
      let display-num = if section-num > 0 {
        str(section-num) + "." + str(theorem-num)
      } else {
        str(theorem-num)
      }
      
      block(inset: (left: 0pt, right: 0pt, top: 0.5em, bottom: 0.5em), breakable: true)[
        #text(weight: config.title-weight)[#label-name #display-num]#if name != none [ (#name)].
        #body
      ]
    }
  }
}

// 英文定理环境
#let theorem = make-theorem(prefix: "Theorem", prefix-cn: "定理", style: "plain", lang: "en")
#let lemma = make-theorem(prefix: "Lemma", prefix-cn: "引理", style: "plain", lang: "en")
#let proposition = make-theorem(prefix: "Proposition", prefix-cn: "命题", style: "plain", lang: "en")
#let corollary = make-theorem(prefix: "Corollary", prefix-cn: "推论", style: "plain", lang: "en")
#let definition = make-theorem(prefix: "Definition", prefix-cn: "定义", style: "definition", lang: "en")
#let example = make-theorem(prefix: "Example", prefix-cn: "例", style: "definition", lang: "en")
#let assumption = make-theorem(prefix: "Assumption", prefix-cn: "假设", style: "definition", lang: "en")
#let remark = make-theorem(prefix: "Remark", prefix-cn: "注", style: "remark", lang: "en")

// 中文定理环境
#let theorem-cn = make-theorem(prefix: "Theorem", prefix-cn: "定理", style: "plain", lang: "cn")
#let lemma-cn = make-theorem(prefix: "Lemma", prefix-cn: "引理", style: "plain", lang: "cn")
#let proposition-cn = make-theorem(prefix: "Proposition", prefix-cn: "命题", style: "plain", lang: "cn")
#let corollary-cn = make-theorem(prefix: "Corollary", prefix-cn: "推论", style: "plain", lang: "cn")
#let definition-cn = make-theorem(prefix: "Definition", prefix-cn: "定义", style: "definition", lang: "cn")
#let example-cn = make-theorem(prefix: "Example", prefix-cn: "例", style: "definition", lang: "cn")
#let assumption-cn = make-theorem(prefix: "Assumption", prefix-cn: "假设", style: "definition", lang: "cn")
#let remark-cn = make-theorem(prefix: "Remark", prefix-cn: "注", style: "remark", lang: "cn")

// ============================================================
// 字体配置
// ============================================================
#let get-fonts(lang, fontset) = {
  if fontset == "mac" or fontset == "macnew" {
    (
      serif: ("Times New Roman", "Songti SC"),
      sans: ("Helvetica", "Heiti SC"),
      mono: ("Menlo", "Courier New"),
      math: ("Latin Modern Math", "Times New Roman"),
    )
  } else if fontset == "windows" {
    (
      serif: ("Times New Roman", "SimSun"),
      sans: ("Arial", "Microsoft YaHei"),
      mono: ("Consolas", "Courier New"),
      math: ("Cambria Math", "Times New Roman"),
    )
  } else if fontset == "fandol" {
    (
      serif: ("FandolSong", "Noto Serif CJK SC"),
      sans: ("FandolHei", "Noto Sans CJK SC"),
      mono: ("FandolFang", "DejaVu Sans Mono", "Noto Sans Mono CJK SC"),
      math: ("Latin Modern Math", "STIX Two Math"),
    )
  } else if fontset == "linux" or fontset == "ubuntu" {
    (
      serif: ("Linux Libertine", "Noto Serif CJK SC"),
      sans: ("Linux Biolinum", "Noto Sans CJK SC"),
      mono: ("DejaVu Sans Mono", "Noto Sans Mono CJK SC"),
      math: ("Latin Modern Math", "STIX Two Math"),
    )
  } else {
    (
      serif: ("Times New Roman", "Songti SC"),
      sans: ("Arial", "Heiti SC"),
      mono: ("Courier New", "Menlo"),
      math: ("Latin Modern Math", "Times New Roman"),
    )
  }
}

// ============================================================
// 主模板函数
// ============================================================
#let manuscript(
  title: none,
  authors: (),
  abstract: [],
  keywords: (),
  lang: "en",
  twocolumn: false,
  review: false,
  fontset: "auto",
  doc,
) = {
  let detected-fontset = if fontset == "auto" { "macnew" } else { fontset }
  let fonts = get-fonts(lang, detected-fontset)
  let is-cn = lang == "cn"
  
  let localized = if is-cn { 
    (
      abstract: "摘要", 
      keywords: "关键词", 
      references: "参考文献",
      algorithm: "算法",
      figure: "图",
      table: "表",
      corresponding: "通讯作者",
    )
  } else { 
    (
      abstract: "Abstract", 
      keywords: "Keywords", 
      references: "References",
      algorithm: "Algorithm",
      figure: "Figure",
      table: "Table",
      corresponding: "Corresponding author",
    )
  }

  // 字号设置
  let body-size = 12pt
  let large-size = 14pt      // 四号
  let small-size = 10.5pt    // 五号
  let footnote-size = 9pt    // 小五号

  // 页面设置: A4, 2cm边距, 2.5cm上下边距
  set page(
    paper: "a4",
    margin: (left: 2cm, right: 2cm, top: 2.5cm, bottom: 2.5cm),
    columns: if twocolumn { 2 } else { 1 },
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        let is-even = calc.rem(page-num, 2) == 0
        set text(size: small-size, font: fonts.serif)
        
        let elems = query(selector(heading).before(here()))
        let section-headings = elems.filter(h => h.level == 1)
        let current-section = if section-headings.len() > 0 {
          let section-heading = section-headings.last()
          if section-heading.numbering != none {
            [#section-heading.numbering #h(0.4em) #section-heading.body]
          } else {
            section-heading.body
          }
        } else {
          []
        }
        
        if is-even {
          [#page-num #h(1fr) #current-section]
        } else {
          [#current-section #h(1fr) #page-num]
        }
        v(-0.3em)
        line(length: 100%, stroke: 0.4pt + black)
      }
    },
    footer: [],
    numbering: "1",
    number-align: right,
  )
  
  set document(title: title)
  
  // 段落设置: 首行缩进2em, 行距1.25倍(0.55em), 段间距0.65em
  // 参考: https://forum.typst.app/t/getting-office-365-word-line-spacing-in-typst/3422
  set par(
    justify: true, 
    first-line-indent: (amount: 2em, all: true),
    leading: 0.55em,
    spacing: 0.65em,
  )
  
  set text(
    font: fonts.serif,
    size: body-size,
    lang: if is-cn { "zh" } else { "en" },
    region: if is-cn { "cn" } else { "us" },
  )
  
  show math.equation: set text(font: fonts.math, weight: "regular")
  show raw: set text(font: fonts.mono, size: footnote-size)
  
  // 标题格式
  set heading(numbering: "1.1.1")
  show heading: set block(above: 1.2em, below: 0.6em)
  
  show heading.where(level: 1): it => {
    set text(size: large-size, weight: "bold", font: fonts.serif)
    set block(above: 1.5em, below: 0.8em)
    it
    theorem-counter.update(0)
  }
  
  show heading.where(level: 2): it => {
    set text(size: body-size, weight: "bold", font: fonts.serif)
    set block(above: 1.2em, below: 0.6em)
    it
  }
  
  show heading.where(level: 3): it => {
    set text(size: body-size, weight: "bold", font: fonts.serif)
    set block(above: 1em, below: 0.5em)
    it
  }
  
  // 图表标题: 小字号, 粗体, 居中, 冒号分隔
  show figure.caption: it => {
    set text(size: small-size, weight: "bold", font: fonts.serif)
    set align(center)
    block(width: 100%)[
      #strong[#it.supplement #it.counter.display():] #it.body
    ]
  }
  
  set figure.caption(position: bottom)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: "algorithm"): set figure.caption(position: top)
  show figure.where(kind: "algorithm"): set text(size: small-size, font: fonts.serif)
  show figure: set block(spacing: 8pt)
  
  // 列表格式
  set enum(numbering: "1.", spacing: 0.3em, indent: 2em, body-indent: 0.5em)
  set list(spacing: 0.3em, indent: 2em, body-indent: 0.5em, marker: ([•], [--], [∗], [‣]))
  
  // 脚注
  set footnote(numbering: "1")
  show footnote: set text(size: footnote-size, font: fonts.serif)
  
  // 链接样式
  show link: it => { set text(fill: rgb(0, 0, 140), font: fonts.serif); it }
  show ref: it => { set text(fill: rgb(0, 0, 140)); it }
  show cite: it => { set text(fill: rgb(0, 0, 140)); it }

  // 作者信息处理
  let author-names = authors.map(a => {
    if a.at("affiliation", default: none) != none {
      [#a.name #super[#a.affiliation]]
    } else {
      a.name
    }
  }).join(", ")
  
  let unique-affiliations = (:)
  for a in authors {
    if a.at("affiliation", default: none) != none and a.at("affiliation-display", default: none) != none {
      let marks = a.affiliation.split(",")
      for m in marks {
        let mark = m.trim()
        if unique-affiliations.at(mark, default: none) == none {
          unique-affiliations.insert(mark, a.affiliation-display)
        }
      }
    }
  }
  
  let affiliations-list = unique-affiliations
    .pairs()
    .map(((mark, display)) => { [#super[#mark] #display] })
    .join(linebreak())
  
  let has-corresponding = authors.any(a => a.at("corresponding", default: false))
  
  // 标题区域
  let title-block = align(center)[
    #text(size: large-size, weight: "bold", font: fonts.serif)[#title]
  ]
  
  let authors-block = align(center)[
    #text(size: body-size, font: fonts.serif)[
      #author-names#if has-corresponding { super[∗] }
    ]
  ]
  
  let affiliations-block = align(center)[
    #text(size: small-size, font: fonts.serif)[
      #affiliations-list
      #if has-corresponding [
        \\#super[∗] #localized.corresponding
      ]
    ]
  ]
  
  // 摘要区域
  let abstract-block = block(width: 100%)[
    #set par(first-line-indent: 0em, spacing: 0.65em)
    #text(size: small-size, font: fonts.serif)[
      *#localized.abstract* #abstract
      #if keywords.len() > 0 [
        #v(0.5em)
        *#localized.keywords:* #keywords.join("; ")
      ]
    ]
  ]
  
  // 返回完整文档
  [
    #title-block
    #v(1em)
    #authors-block
    #v(0.5em)
    #affiliations-block
    #v(1em)
    #abstract-block
    #v(0.5em)
    #{
      set par(
        justify: true, 
        first-line-indent: (amount: 2em, all: true),
        leading: 0.55em,
        spacing: 0.65em,
      )
      doc
    }
  ]
}

// 辅助命令
#let todo(it) = text(fill: rgb(200, 0, 0), weight: "bold")[[TODO: #it]]
#let highlight(it) = text(fill: rgb(0, 0, 180))[#it]