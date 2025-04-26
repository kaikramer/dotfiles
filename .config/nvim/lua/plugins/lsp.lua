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

            -- See :help vim.diagnostic.Opts
            vim.diagnostic.config {
                severity_sort = true,
                float = { border = 'rounded', source = true },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '󰅚 ',
                        [vim.diagnostic.severity.WARN] = '󰀪 ',
                        [vim.diagnostic.severity.INFO] = '󰋽 ',
                        [vim.diagnostic.severity.HINT] = '󰌶 ',
                    },
                },
                virtual_text = {
                    source = 'if_many',
                    spacing = 2,
                    format = function(diagnostic)
                        local diagnostic_message = {
                            [vim.diagnostic.severity.ERROR] = diagnostic.message,
                            [vim.diagnostic.severity.WARN] = diagnostic.message,
                            [vim.diagnostic.severity.INFO] = diagnostic.message,
                            [vim.diagnostic.severity.HINT] = diagnostic.message,
                        }
                        return diagnostic_message[diagnostic.severity]
                    end,
                },
            }
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show floating window with diagnostic messages' })

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

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
                vim.lsp.handlers.hover,
                { border = 'rounded' }
            )
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = 'rounded' }
            )

            vim.keymap.set('n', '<leader>M', ":Mason<CR>", { noremap = true })

            local telescope = require('telescope.builtin')
            vim.keymap.set('n',        'gO',         telescope.lsp_document_symbols, { noremap = true, desc = "Open document symbols" })
            vim.keymap.set('n',        'gr',         telescope.lsp_references,       { noremap = true, desc = "Goto references" })
            vim.keymap.set('n',        'gd',         vim.lsp.buf.definition,         { noremap = true })
            vim.keymap.set('n',        'gD',         vim.lsp.buf.declaration,        { noremap = true })
            vim.keymap.set('n',        'gi',         vim.lsp.buf.implementation,     { noremap = true })
            vim.keymap.set('n',        'gw',         vim.lsp.buf.workspace_symbol,   { noremap = true })
            vim.keymap.set('n',        'gt',         vim.lsp.buf.type_definition,    { noremap = true })
            vim.keymap.set('n',        'K',          vim.lsp.buf.hover,              { noremap = true })
            vim.keymap.set('n',        '<c-k>',      vim.lsp.buf.signature_help,     { noremap = true })
            vim.keymap.set({'n', 'x'}, '<leader>la', vim.lsp.buf.code_action,        { noremap = true, desc = "code action" })
            vim.keymap.set('n',        '<leader>lr', vim.lsp.buf.rename,             { noremap = true, desc = "rename" })
            vim.keymap.set({'n', 'x'}, '<leader>lf', vim.lsp.buf.format,             { noremap = true, desc = "format" })
        end
    }
}
