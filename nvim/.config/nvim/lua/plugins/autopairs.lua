return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
