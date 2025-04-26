return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local custom_lualine_theme = require('lualine.themes.base16')
    custom_lualine_theme.normal.a.gui = ''
    custom_lualine_theme.insert.a.gui = ''
    custom_lualine_theme.visual.a.gui = ''
    custom_lualine_theme.replace.a.gui = ''
    custom_lualine_theme.inactive.a.gui = ''

    require('lualine').setup {
      options = {
        section_separators = '',
        component_separators = '|',
        theme = custom_lualine_theme,
        icons_enabled = true,
        global_status = false
      },
      extensions = { 'lazy', 'fzf', 'mason', 'neo-tree', 'quickfix', 'trouble' },
      sections = {
        lualine_a = { { 'mode', fmt = function(res) return res:sub(1,1) end } },
        lualine_b = { },
        lualine_c = { 'branch', 'diff', 'diagnostics', { 'filename', shorting_target = 40, path = 3 } }, -- show full path
        lualine_x = { {'fileformat', symbols = { unix = 'lf', dos = 'cr+lf', mac = '' } }, 'encoding', 'filetype' },
        lualine_y = { 'location' },
        lualine_z = { 'progress' }
      },
      tabline = {
        -- lualine_a = {
      --     {
      --       'buffers',
      --       mode = 2, -- show buffer name and buffer index
      --       show_filename_only = false,
      --       buffers_color = {
      --         active = 'lualine_y_normal',
      --         inactive = 'lualine_c_normal'
      --       }
      --     }
        -- }
      }
    }
  end
}
