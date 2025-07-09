require("core.settings")

require("setup.lazy")

local keymaps = require("core.keymaps")
keymaps.set_general_keymaps()
keymaps.set_telescope_keymaps()

require("core.autocommands")
