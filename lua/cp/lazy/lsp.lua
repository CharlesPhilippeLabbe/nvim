
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        --- Uncomment the two plugins below if you want to manage the language servers from neovim
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {'neovim/nvim-lspconfig'},
        -- Autocompletion
        {'hrsh7th/nvim-cmp', commit = 'b356f2c'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'hrsh7th/cmp-nvim-lua'},
        {'saadparwaiz1/cmp_luasnip'},
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
    },
    config = function ()
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(client, bufnr)
            local opts = {buffer = bufnr, remap = false}


            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gk", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>vk", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)


            vim.keymap.set("n", "<C-s>", function() 
                vim.lsp.buf.format()
                vim.cmd('write')
            end, opts)
            vim.keymap.set("n", "<leader>vf", function() vim.lsp.buf.format({async = false}) end, opts)

        end)

        --autocmd BufWritePre *.go lua vim.lsp.buf.format({ async = false })

        -- to learn how to use mason.nvim with lsp-zero
        -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        require('mason').setup({})
        require('mason-lspconfig').setup({
            handlers =  {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    vim.lsp.config.lua_ls = {
                        settings = lua_opts
                    }
                    vim.lsp.enable('lua_ls')
                end,
            }
        })

        local cmp = require('cmp')
        local cmp_select = {behavior = cmp.SelectBehavior.Select}

        -- this is the function that loads the extra snippets to luasnip
        -- from rafamadriz/friendly-snippets
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            sources = {
                {name = 'path'},
                {name = 'nvim_lsp'},
                {name = 'nvim_lua'},
                {name = 'luasnip', keyword_length = 2},
                {name = 'buffer', keyword_length = 3},
            },
            preselect = cmp.PreselectMode.None,
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                --['<tab>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<tab>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
        })

        vim.lsp.config.clangd = {
            settings = {
                cmd = {'clangd', '--background-index'},
                init_options = {
                },
            }
        }
        vim.lsp.enable('clangd')
    end
}

