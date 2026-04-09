require 'settings'
require 'plugins'
require 'autocommands'

local keymaps = require 'keymaps'
keymaps.set_general_keymaps()
pcall(function() keymaps.set_telescope_keymaps() end)
