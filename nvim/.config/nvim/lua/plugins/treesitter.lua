local languages = require("res.languages")

local treesitter_langs = {}
for lang, config in pairs(languages) do
  if not config.skip_treesitter then
    table.insert(treesitter_langs, lang)
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = treesitter_langs,
      auto_install = true,
      indent = { enable = true },
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  { "nvim-treesitter/nvim-treesitter-textobjects" },
}
