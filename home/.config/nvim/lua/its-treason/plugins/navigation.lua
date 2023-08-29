return {
    {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon add file",
      },
      {
        "<leader>h",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Harpoon open quick menu",
      },
      {
        "<C-e>",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Harpoon: Goto file 1",
      },
      {
        "<C-t>",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Harpoon: Goto file 2",
      },
      {
        "<C-n>",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Harpoon: Goto file 3",
      },
    },
  },

  -- Project.nvim
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
        pattern = { ".git" },
        scope_dir = "win",
      })

      local telescope = require("telescope")
      telescope.load_extension("projects")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>o",
        "<cmd>Telescope projects<cr>",
        "Open last projects",
      },
      {
        "<leader>O",
        "<cmd>ProjectRoot<cr>",
        "Add dir to project list",
      },
    },
  },

  -- Scratch files
  {
    "Sonicfury/scretch.nvim",
    event = "VeryLazy",
    opts = {
      scretch_dir = vim.fn.stdpath("data") .. '/scretch/',
    },
    keys = {
      {
        "<leader>Sn",
        function ()
          require("scretch").new()
        end,
        desc = "Create new scretch file",
      },
      {
        "<leader>SN",
        function ()
          require("scretch").new_named()
        end,
        desc = "Create new named scretch file",
      },
      {
        "<leader>Sl",
        function ()
          require("scretch").last()
        end,
        desc = "Open last scretch file",
      },
      {
        "<leader>So",
        function ()
          require("scretch").explore()
        end,
        desc = "Explore scretch files",
      },
    }
  }
}
