return {
  "stevearc/aerial.nvim",
  opts = {},
  -- Optional dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>cot", "<cmd>AerialToggle<CR>", desc = "Toggle Outline Window" },
    { "<leader>coo", "<cmd>AerialOpen<CR>", desc = "Open Outline Window" },
    { "<leader>con", "<cmd>AerialNext<CR>", desc = "Jump forwards 1 symbols" },
    { "<leader>cop", "<cmd>AerialPrev<CR>", desc = "Jump backwards 1 symbols" },
  },
}
