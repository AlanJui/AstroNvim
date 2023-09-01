return {
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
      -- color_overrides = {
      --   all = {
      --     text = "#ffffff",
      --   },
      --   latte = {
      --     base = "#aaaaaa",
      --     mantle = "#242424",
      --     crust = "#474747",
      --   },
      --   frappe = {},
      --   macchiato = {},
      --   mocha = {},
      -- },
      -- custom_highlights = function(colors)
      --   return {
      --     Comment = { fg = colors.flamingo },
      --     TabLineSel = { bg = colors.pink },
      --     CmpBorder = { fg = colors.surface2 },
      --     Pmenu = { bg = colors.none },
      --   }
      -- end,
    },
  },
}
