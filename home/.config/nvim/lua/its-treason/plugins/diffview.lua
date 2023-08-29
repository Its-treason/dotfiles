return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewFileHistory", "DiffviewOpen", "DiffviewClose" },
    keys = {
      {
        "<leader>Gf",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "Show current file history",
      },
      {
        "<leader>Gh",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "Show git history",
      },
      {
        "<leader>Gd",
        "<cmd>DiffviewOpen<cr>",
        desc = "Open diffview",
      },
      {
        "<leader>Gq",
        "<cmd>DiffviewClose<cr>",
        desc = "Close diffview",
      },
    }
  }
}
