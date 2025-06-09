local langs = require("config.langs")

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters.clippy = {
        cmd = "cargo",
        stdin = false,
        args = { "clippy", "--message-format", "short" },
        stream = "stderr",
        parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
          source = "clippy",
          severity = vim.diagnostic.severity.WARN,
        }),
      }

      lint.linters.golangci_lint = {
        cmd = "golangci-lint",
        stdin = false,
        args = { "run", "--out-format", "line-number" },
        stream = "stdout",
        parser = require("lint.parser").from_errorformat("%f:%l:%c: %m", {
          source = "golangci-lint",
          severity = vim.diagnostic.severity.WARN,
        }),
      }

      lint.linters_by_ft = vim.tbl_deep_extend("force", {}, langs.linters_by_ft, {
        go   = { "golangci_lint" },
        rust = { "clippy" },
      })
    end
  },
}
