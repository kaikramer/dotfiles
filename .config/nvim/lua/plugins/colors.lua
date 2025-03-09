return {
    {
        "RRethy/nvim-base16",
        config = function()
            -- To disable highlights for supported plugin(s), call the `with_config` function **before** setting the colorscheme.
            require('base16-colorscheme').with_config({
                telescope = true,
                telescope_borders = true,
                indentblankline = true,
                notify = true,
                ts_rainbow = true,
                cmp = true,
                illuminate = true,
                dapui = true,
            })

            require('base16-colorscheme').setup({
                base00 = '#282C34',
                base01 = '#282C34',
                base02 = '#5A6374',
                base03 = '#5A6374',
                base04 = '#5A6374',
                base05 = '#DCDFE4',
                base06 = '#5A6374',
                base07 = '#c5c8e6',
                base08 = '#61AFEF',
                base09 = '#98C379',
                base0A = '#DCDFE4',
                base0B = '#E5C07B',
                base0C = '#C678DD',
                base0D = '#DCDFE4',
                base0E = '#98C379',
                base0F = '#DCDFE4',
            })

            vim.api.nvim_set_hl(0, "TelescopePromptNormal", { fg = "#dcdfe4", bg = "#282c34" })
            vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#dcdfe4", bg = "#282c34" })
            vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "TelescopeBorder" })
            vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#282c34", bg = "#98c379" })
            vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#61afef", bg = "#282c34" })
        end
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require('colorizer').setup()
        end
    }
}
