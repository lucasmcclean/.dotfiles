local M = {}

function M.scrolloff()
  return (vim.o.lines / vim.o.columns > 0.75) and 30 or 10
end

return M
