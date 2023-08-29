return {
  {
    "mhartington/formatter.nvim",
    cmd = { "Format", "FormatWrite" },
    config = function()
      require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.DEBUG,
        filetype = {
          -- TODO: Add formatters for other filetypes
          lua = {
            require("formatter.filetypes.lua").stylua,
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
          },
        },
      })
    end,
    keys = {
      {
        "<leader>cf",
        vim.cmd.FormatWrite,
        desc = "Format file",
      },
    },
  },

  -- Try to auto guess the files indents
  {
    "nmac427/guess-indent.nvim",
    cmd = { "GuessIndent" },
    event = "BufReadPre",
    opts = {},
  },
}
