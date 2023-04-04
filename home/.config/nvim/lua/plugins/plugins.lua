-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- Configure NeoTree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
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
      -- TODO: This does nto override the original shortcut, idk why
      {
        "gr",
        function()
          require("telescope.builtin").lsp_references({ show_line = false })
        end,
        desc = "References",
        remap = true,
      },
    },
  },

  -- Disable Bufferline, who needs tabs?
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },

  -- Add TSServer and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
  },

  -- Auto GuessIndent
  {
    "nmac427/guess-indent.nvim",
    opts = {},
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
        -- TS / JS
        "typescript-language-server",
        -- Ansible
        "ansible-language-server",
        "ansible-lint",
        -- Rust
        "rust-analyzer",
        "rustfmt",
        -- Docker
        "docker-compose-language-service",
        "dockerfile-language-server",
        -- Common
        "sqlls",
        "bash-language-server",
        "marksman", -- Markdown
        "nginx-language-server",
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

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
      },
    },
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
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
}
