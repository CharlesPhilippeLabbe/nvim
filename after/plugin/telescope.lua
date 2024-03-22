local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({search = vim.fn.input("Grep > ")});
end)
vim.keymap.set('n', 'gr', function() builtin.lsp_references() end);
local setup = require('telescope').setup{defaults ={file_ignore_patterns = {"node%_modules/.*", "./node%_modules/.*"}} }
