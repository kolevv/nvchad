-- Fold text: first line with Treesitter highlighting + a gray " … "
function _G.FoldText()
  local lnum = vim.v.foldstart
  local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
  local suffix = { " … ", "Comment" }

  local ok, parser = pcall(vim.treesitter.get_parser, 0)
  if not ok or not parser then
    return { { line, "Folded" }, suffix }
  end
  local query = vim.treesitter.query.get(parser:lang(), "highlights")
  if not query then
    return { { line, "Folded" }, suffix }
  end

  local tree = parser:parse()[1]
  local result, pos, prev = {}, 0, nil

  for id, node in query:iter_captures(tree:root(), 0, lnum - 1, lnum) do
    local srow, scol, erow, ecol = node:range()
    if srow == lnum - 1 and erow == lnum - 1 then
      local hl = "@" .. query.captures[id]
      local text = line:sub(scol + 1, ecol)
      if prev and prev[1] == scol and prev[2] == ecol then
        result[#result][2] = hl -- same span captured again: later capture wins
      elseif scol >= pos then
        if scol > pos then
          table.insert(result, { line:sub(pos + 1, scol), "Folded" }) -- gap (spaces, punctuation)
        end
        table.insert(result, { text, hl })
        pos = ecol
        prev = { scol, ecol }
      end
    end
  end

  if pos < #line then
    table.insert(result, { line:sub(pos + 1), "Folded" })
  end
  table.insert(result, suffix)
  return result
end
