return {
  "stevearc/aerial.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>Lot", "<cmd>AerialToggle<CR>", desc = "Toggle Outline Window" },
    { "<leader>Loo", "<cmd>AerialOpen<CR>", desc = "Open Outline Window" },
    { "<leader>Lon", "<cmd>AerialNext<CR>", desc = "Jump forwards 1 symbols" },
    { "<leader>Lop", "<cmd>AerialPrev<CR>", desc = "Jump backwards 1 symbols" },
  },
}
