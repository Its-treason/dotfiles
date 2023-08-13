return {
  -- Disbale some stuff
  -- Disable Bufferline, who needs tabs?
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
  },
  {
    "ggandor/flit.nvim",
    enabled = false,
  },
  {
    "folke/persistence.nvim",
    enabled = false,
  },

  -- Configure NeoTree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        bind_to_cwd = true,
        cwd_target = { sidebar = "windows" },
        follow_current_file = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
      },
    },
  },

  -- Telescope config
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- path_display = { "smart" },
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          require("telescope.builtin").find_files()
        end,
        { desc = "Find files" },
      },
    },
  },

  -- Add TSServer and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").on_attach(function(_, buffer)
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { buffer = buffer, desc = "Rename File" })
        end)

        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        keys[#keys + 1] = {
          "gr",
          function()
            require("telescope.builtin").lsp_references({ show_line = false });
          end,
          desc = "References",
        };
      end,
    },
    opts = {
      autoformat = false,
      servers = {
        tsserver = {
          
        }
      }
    },
  },

  -- Auto GuessIndent
  -- :GuessIndent Will retry to guess the indent of a file
  {
    "nmac427/guess-indent.nvim",
    event = "BufEnter",
  },

  -- Mason nvim
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- PHP
        "phpactor",
        "phpmd",
        "phpcs",
        "phpstan",
        -- Web
        "typescript-language-server",
        "css-lsp",
        -- Ansible
        "ansible-language-server",
        "ansible-lint",
        -- Rust
        "rust-analyzer",
        -- Docker
        "docker-compose-language-service",
        "dockerfile-language-server",
        -- Common
        "tree-sitter-cli",
        "sqlls",
        "bash-language-server",
        "marksman", -- Markdown
        "nginx-language-server",
        "yaml-language-server",
      },
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "php",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "rust",
        "dockerfile",
        "sql",
      },
    },
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      {
        "<leader>gd",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "History of current file",
      },
      {
        "<leader>gH",
        "<cmd>DiffviewFileHistory<cr>",
        desc = "Git history",
      },
    },
  },

  -- Harpoon
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
    },
  },

  -- Project.nvim
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    init = function()
      local telescope = require("telescope")
      telescope.load_extension("projects")
    end,
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
        pattern = { ".git", "Makefile", "package.json" },
        scope_dir = "win",
      })
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      event = "Bufenter",
      cmd = { "Telescope" },
    },
    keys = {
      {
        "<leader>o",
        "<cmd>Telescope projects<cr>",
        "Open last projects",
      },
    },
  },
}
