return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            {
                "j-hui/fidget.nvim",
                tag = "legacy",
                event = "LspAttach",
            },
            "folke/neodev.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            -- Set up Mason before anything else
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "html",
                },
                automatic_installation = true,
            })
            require("mason-lspconfig").setup_handlers {
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                -- ["rust_analyzer"] = function ()
                --    require("rust-tools").setup {}
                --end
            }

            require("neodev").setup()

            -- Turn on lsp status information
            require('fidget').setup()

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })

            vim.keymap.set('n', '<leader>M', ":Mason<CR>", { noremap = true })

            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true })
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { noremap = true })
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap = true })
            vim.keymap.set('n', 'gw', vim.lsp.buf.workspace_symbol, { noremap = true })
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true })
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { noremap = true })
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true })
            vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, { noremap = true })
            vim.keymap.set('n', '<c-1>', vim.lsp.buf.code_action, { noremap = true })
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { noremap = true })
            vim.keymap.set({ 'n', 'x' }, '<leader>lf', vim.lsp.buf.format, { noremap = true })
        end
    }
}
