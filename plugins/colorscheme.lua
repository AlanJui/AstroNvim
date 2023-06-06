return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.nightflyCursorColor = true
      -- vim.g.nightflyItalics = false
      -- vim.g.nightflyTransparent = false
      -- vim.g.nightflyUndercurls = true
      -- vim.g.nightflyUnderlineMatchParen = true
      -- vim.g.nightflyVirtualTextColor = true
      -- vim.g.nightflyWinSeparator = 2
      vim.g.nightflyTerminalColors = true
      vim.g.nightflyNormalFloat = true
      vim.cmd [[colorscheme nightfly]]
    end,
  },
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    priority = 1000,
    config = function() vim.g.material_style = "deep ocean" end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    priority = 1000,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    priority = 1000,
  },
}