local langs = require("languages")

return {
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      local formatters_by_ft = {}

      for lang, config in pairs(langs) do
        if config.formatters and config.formatters.list then
          for _, formatter in pairs(config.formatters.list) do
            table.insert(formatters_by_ft, {
              lang, {
              name = formatter.name or formatter,
              filetypes = config.formatters.filetypes or {},
              args = formatter.args or {},
            }
            })
          end
        end
      end

      conform.setup({ formatters_by_ft = formatters_by_ft })
    end,
  },
}
