local telescope = require('telescope')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ph', builtin.help_tags, {})
vim.keymap.set('n', '<leader>pgb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>pgc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>pls', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', 'grr', builtin.lsp_references, {});
vim.keymap.set('n', '<leader>pb', function() builtin.buffers({ignore_current_buffer = true, sort_mru = true, }) end , {})
vim.keymap.set( "n", "<leader>pe", builtin.diagnostics, {})
local setup = telescope.setup{
	defaults = {
		file_ignore_patterns = {"node%_modules/.*", "./node%_modules/.*", "pkg/*"
	},
}}
