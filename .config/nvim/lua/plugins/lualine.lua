return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local custom_lualine_theme = require('lualine.themes.onedark')
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
        icons_enabled = false,
        global_status = false
      },
      extensions = { 'lazy', 'fzf', 'mason', 'nerdtree', 'nvim-tree', 'quickfix', 'trouble' },
      sections = {
        lualine_a = { { 'mode', fmt = function() return ' ' end, draw_empty = true, padding = 0  } },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', shorting_target = 40, path = 3 } }, -- show full path
        lualine_x = { 'fileformat', 'encoding', 'filetype' },
        lualine_y = { 'location', 'progress',  },
        lualine_z = { { 'mode', fmt = function() return ' ' end, draw_empty = true, padding = 0 } }
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            mode = 2, -- show buffer name and buffer index
            show_filename_only = false,
            buffers_color = {
              active = 'lualine_y_normal',
              inactive = 'lualine_c_normal'
            }
          }
        }
      }
    }
  end
}
