-- Pandoc Lua 过滤器
-- 用于优化 LaTeX 到 Word 的转换
-- 主要功能：保留公式编号、处理交叉引用

-- 公式编号计数器
local eqCounter = 0

-- 处理 RawBlock（保留 equation 环境的编号）
function RawBlock(elem)
  if elem.format == "tex" or elem.format == "latex" then
    local text = elem.text
    
    -- 处理 equation 环境，提取编号
    if text:match("\\begin{equation}") then
      eqCounter = eqCounter + 1
      
      -- 提取标签
      local label = text:match("\\label{([^}]+)}")
      
      -- 提取公式内容（去掉 begin/end 和 label）
      local content = text:gsub("\\begin{equation}.*\n?", "")
                          :gsub("\\label{[^}]+}", "")
                          :gsub("\\end{equation}", "")
                          :gsub("^%s*", "")
                          :gsub("%s*$", "")
      
      -- 如果有标签，创建带编号的公式
      if label then
        -- 返回数学公式，Word 会显示为原生公式
        -- 编号需要通过其他方式处理
        return pandoc.Para({
          pandoc.Math("DisplayMath", content),
          pandoc.Str(" "),
          pandoc.Str("(" .. eqCounter .. ")")
        })
      end
    end
  end
  
  return elem
end

-- 处理 display math，添加编号
function Math(elem)
  if elem.mathtype == "DisplayMath" then
    -- DisplayMath 已经是行间公式
    -- 编号保留在原始文本中
    return elem
  end
  return elem
end

-- 重置计数器（每个文档开始时）
function Pandoc(doc)
  eqCounter = 0
  return doc
end