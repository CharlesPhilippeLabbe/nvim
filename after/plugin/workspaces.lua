-- returns true if `dir` is a child of `parent`
local is_dir_in_parent = function(dir, parent)
  if parent == nil then return false end
  local ws_str_find, _ = string.find(dir, parent, 1, true)
  if ws_str_find == 1 then
    return true
  else
    return false
  end
end

-- convenience function which wraps is_dir_in_parent with active file
-- and workspace.
local current_file_in_ws = function()
  local workspaces = require('workspaces')
  local ws_path = require('workspaces.util').path
  local current_ws = workspaces.path()
  local current_file_dir = ws_path.parent(vim.fn.expand('%:p', true))

  return is_dir_in_parent(current_file_dir, current_ws)
end

-- set workspace when changing buffers
local my_ws_grp = vim.api.nvim_create_augroup("my_ws_grp", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
  callback = function()
    -- do nothing if not file type
    local buf_type = vim.api.nvim_get_option_value("buftype", { buf = 0 })
    if (buf_type ~= "" and buf_type ~= "acwrite") then
      return
    end

    -- do nothing if already within active workspace
    if current_file_in_ws() then
      return
    end

    local workspaces = require('workspaces')
    local ws_path = require('workspaces.util').path
    local current_file_dir = ws_path.parent(vim.fn.expand('%:p', true))

    -- filtered_ws contains workspace entries that contain current file
    local filtered_ws = vim.tbl_filter(function(entry)
      return is_dir_in_parent(current_file_dir, entry.path)
    end, workspaces.get())

    -- select the longest match
    local selected_workspace = nil
    for _, value in pairs(filtered_ws) do
      if not selected_workspace then
        selected_workspace = value
      end
      if string.len(value.path) > string.len(selected_workspace.path) then
        selected_workspace = value
      end
    end
    if selected_workspace then workspaces.open(selected_workspace.name) end
  end,

  group = my_ws_grp
})

-- use below example if using any `open` hooks, such as telescope, otherwise
-- the hook will run every time when switching to a buffer from a different
-- workspace.

local workspaces = require("workspaces")
local resetFile = "/home/clabb/.config/nvim/lua/cp/set.lua"
local remapFile = "/home/clabb/.config/nvim/lua/cp/remap.lua"
workspaces.setup({
  hooks = {
    open = {
      -- do not run hooks if file already in active workspace
      function()
        if current_file_in_ws() then
          return false
        end
      end,

      function()
        require('telescope.builtin').find_files()
        end,
--    function()
--          local workFile = workspaces.path() .. ".nvim.lua"
--          --TODO cleanup
--          local f=io.open(workFile,"r")
--          if f~=nil then
--              io.close(f)
--              dofile(workFile)
--          else
--              dofile(resetFile)
--              dofile(remapFile)
--          end
--      end
    }
  }
})



vim.keymap.set("n", "<leader>wo", workspaces.open)
vim.keymap.set("n", "<leader>wa", workspaces.add)
