return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      server = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace"
              }
            }
          }
        },
        eslint = {},
      }
    },
    config = function(_, opts)
      local lsp_config = require("lspconfig")
      local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

      for server_name,server_opts in pairs(opts.server) do
        server_opts.capabilities = default_capabilities
        lsp_config[server_name].setup(server_opts)
      end
    end,
    keys = {
      { "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, desc = "Goto Definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, desc = "Goto Implementation" },
      { "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, desc = "Goto T[y]pe Definition" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      {
        "<leader>cA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
      }
    }
  },

  {
    "pmizio/typescript-tools.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
    --   settings = {
    --     tsserver_path = "/home/timon/.yarn/bin/tsserver",
    --   },
    },
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate" },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- PHP
        "phpactor",
        "phpmd",
        "phpcs",
        "phpstan",
        -- TS / JS
        "typescript-language-server",
        "eslint",
        "tsserver",
        "prettier",
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
        "tree-sitter-cli",
        "sqlls",
        "bash-language-server",
        "marksman", -- Markdown
        "nginx-language-server",
        "yaml-language-server",
      }
    }
  }
}
