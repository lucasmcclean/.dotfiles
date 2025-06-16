return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme("tokyonight")
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "none", fg = "#a9b1d6" })
      vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none", fg = "#5c6370" })
      vim.api.nvim_set_hl(0, "TabLineSel", { bg = "none" })
      vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })
    end,
  },
}
