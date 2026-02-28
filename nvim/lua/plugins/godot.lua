return {
  { "habamax/vim-godot" },
  { "skywind3000/asyncrun.vim" },
  {
    "teatek/gdscript-extended-lsp.nvim",
    opts = { view_type = "floating", picker = "snacks" },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            exclude = {
              "*.uid",
              "server.pipe",
            },
          },
        },
      },
    },
  },
}
