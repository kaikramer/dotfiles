return {
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require('nvim-highlight-colors').setup({})
        end
    },
    {
        "RRethy/nvim-base16",
        enabled = true,
        config = function()
            -- To disable highlights for supported plugin(s), call the `with_config` function **before** setting the colorscheme.
            require('base16-colorscheme').with_config({
                telescope = false,
                telescope_borders = true,
                indentblankline = true,
                notify = true,
                ts_rainbow = true,
                cmp = true,
                illuminate = true,
                dapui = true,
            })

            require('base16-colorscheme').setup({
                base00 = '#282c34',
                base01 = '#282c34',
                base02 = '#5c6370',
                base03 = '#5c6370',
                base04 = '#5c6370',
                base05 = '#dcdfe4',
                base06 = '#5c6374',
                base07 = '#c5c8e6',
                base08 = '#dcdfe4',
                base09 = '#abb2bf',
                base0A = '#56b6c2',
                base0B = '#e5c07b',
                base0C = '#c678dd',
                base0D = '#61afef',
                base0E = '#98c379',
                base0F = '#dcdfe4',
            })

            vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#61afef", bg = "#282c34" })
            vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#61afef", bg = "#282c34" })
            vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#61afef", bg = "#282c34" })
            vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#61afef", bg = "#282c34" })
        end
    }
}
