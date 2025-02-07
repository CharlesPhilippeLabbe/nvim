local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set('n', 'gr', function() builtin.lsp_references() end);
vim.keymap.set('n', '<leader>pgb', builtin.git_branches, {})
vim.keymap.set('n', '<leader>pgc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>pls', builtin.lsp_dynamic_workspace_symbols, {})

local setup = require('telescope').setup{defaults ={file_ignore_patterns = {"node%_modules/.*", "./node%_modules/.*", "pkg/*"}} }
