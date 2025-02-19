vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local oil = require("oil")
oil.setup({-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
  default_file_explorer = false,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    -- "icon",
    "permissions",
    "size",
    "mtime",
  },
  case_insensitive = false,
  show_hidden = true,
  view_options = {
      show_hidden = true
  }
}) 

vim.api.nvim_create_user_command("Ex", 'Oil --float', {desc = "Open Git vertically", nargs = '*' })
