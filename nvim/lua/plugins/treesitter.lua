return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "rust",
        "typescript",
        "tsx",
        "vim",
        "yaml",
        "svelte",
        "gdscript",
        "gdshader",
        "godot_resource",
      },
      highlight = { enable = true },
      indent = { enable = true },
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true,
      --     keymaps = {
      --       ["af"] = "@function.outer",
      --       ["if"] = "@function.inner",
      --       ["ac"] = "@class.outer",
      --       ["ic"] = "@class.inner",
      --       ["al"] = "@loop.outer",
      --       ["il"] = "@loop.inner",
      --       ["ad"] = "@conditional.outer",
      --       ["id"] = "@conditional.inner",
      --     },
      --   },
      --   move = {
      --     enable = true,
      --     set_jumps = true,
      --     goto_next_start = {
      --       ["]m"] = "@function.outer",
      --       ["]c"] = "@class.outer",
      --     },
      --     goto_previous_start = {
      --       ["[m"] = "@function.outer",
      --       ["[c"] = "@class.outer",
      --     },
      --   },
      --   swap = {
      --     enable = true,
      --     swap_next = {
      --       ["<leader>sn"] = "@parameter.inner",
      --     },
      --     swap_previous = {
      --       ["<leader>sp"] = "@parameter.inner",
      --     },
      --   },
      -- },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
    end,
  },
}
