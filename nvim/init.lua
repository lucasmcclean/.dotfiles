vim.loader.enable()

require 'settings'
require 'plugins'
require 'autocommands'

local keymaps = require 'keymaps'
keymaps.set_general_keymaps()
