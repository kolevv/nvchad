local builtin = require "statuscol.builtin"

require("statuscol").setup {
  relculright = true,
  ft_ignore = { "NvimTree", "nvdash", "help" },
  segments = {
    { text = { "%s" }, click = "v:lua.ScSa" }, -- signs
    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" }, -- line numbers
    { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- fold chevrons
  },
}
