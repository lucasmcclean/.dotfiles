local langs = require("languages")

return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      local linters_by_ft = {}

      for lang, config in pairs(langs) do
        if config.linters and config.linters.list and config.linters.filetypes then
          for _, linter in ipairs(config.linters.list) do
            for _, ft in ipairs(config.linters.filetypes) do
              if not linters_by_ft[ft] then
                linters_by_ft[ft] = {}
              end
              table.insert(linters_by_ft[ft], linter.name)
            end
            table.insert(linters_by_ft[lang], linter.name)
            if type(linter) == "table" then
              lint.linters[linter.name] = vim.tbl_deep_extend("force", lint.linters[linter.name] or {}, {
                args = linter.args or {},
              })
            end
          end
        end
      end

      lint.linters_by_ft = linters_by_ft
    end
  },
}
