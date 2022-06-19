-- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
-- stylua: ignore
local colors = {
  nord1  = '#3B4252',
  nord3  = '#4C566A',
  nord4  = '#4C566A',
  nord5  = '#D8DEE9',
  nord6  = '#ECEFF4',
  nord7  = '#8FBCBB',
  nord8  = '#88C0D0',
  nord9  = '#81A1C1',
  nord10 = '#5E81AC',
  nord11 = '#BF616A',
  nord12 = '#D08770',
  nord13 = '#EBCB8B',
  nord14 = '#A3BE8C',
  nord15 = '#B48EAD',
}

return {
  normal = {
    a = { fg = colors.nord1, bg = colors.nord9 },
    b = { fg = colors.nord5, bg = colors.nord1 },
    c = { fg = colors.nord5, bg = colors.nord3 },
  },
  insert = { a = { fg = colors.nord1, bg = colors.nord14 } },
  visual = { a = { fg = colors.nord1, bg = colors.nord13 } },
  replace = { a = { fg = colors.nord1, bg = colors.nord15 } },
  inactive = {
    a = { fg = colors.nord1, bg = colors.nord9 },
    b = { fg = colors.nord5, bg = colors.nord1 },
    c = { fg = colors.nord5, bg = colors.nord1 },
  },
}
