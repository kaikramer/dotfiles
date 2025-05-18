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
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            {
                'saghen/blink.cmp',

                -- use a release tag to download pre-built binaries
                version = '1.*',

                ---@module 'blink.cmp'
                ---@type blink.cmp.Config
                opts = {
                    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
                    -- 'super-tab' for mappings similar to vscode (tab to accept)
                    -- 'enter' for enter to accept
                    -- 'none' for no mappings
                    --
                    -- All presets have the following mappings:
                    -- C-space: Open menu or open docs if already open
                    -- C-n/C-p or Up/Down: Select next/previous item
                    -- C-e: Hide menu
                    -- C-k: Toggle signature help (if signature.enabled = true)
                    --
                    -- See :h blink-cmp-config-keymap for defining your own keymap
                    keymap = { preset = 'enter' },

                    completion = {
                        -- Disable auto brackets
                        -- NOTE: some LSPs may add auto brackets themselves anyway
                        accept = { auto_brackets = { enabled = false }, },

                        -- Don't select by default, auto insert on selection
                        list = { selection = { preselect = false, auto_insert = false } },

                        documentation = { auto_show = true, auto_show_delay_ms = 0, },
                    },

                    -- Default list of enabled providers defined so that you can extend it
                    -- elsewhere in your config, without redefining it, due to `opts_extend`
                    sources = {
                        default = { 'lazydev', 'lsp', 'path', 'buffer' },
                        providers = {
                            lazydev = {
                                name = "LazyDev",
                                module = "lazydev.integrations.blink",
                                -- make lazydev completions top priority (see `:h blink.cmp`)
                                score_offset = 100,
                            },
                        },
                    },

                    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
                    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
                    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
                    fuzzy = { implementation = "prefer_rust_with_warning" }
                },
                opts_extend = { "sources.default" }
            }

        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()

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
