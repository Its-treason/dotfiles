return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      {
        "<leader>/",
        function ()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep (root dir)"
      },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      {
        "<leader><space>",
        function ()
          require("telescope.builtin").find_files({ cwd = vim.loop.cwd() })
        end,
        desc = "Find Files (root dir)"
      },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      {
        "<leader>ff",
        function ()
          require("telescope.builtin").files()
        end,
        desc = "Find Files (root dir)"
      },
      {
        "<leader>fF",
        function ()
          require("telescope.builtin").files({ cwd = false })
        end,
        desc = "Find Files (cwd)",
      },
      { 
        "<leader>fr",
        function ()
          require("telescope.builtin").oldfiles({
            cwd = vim.loop.cwd(),
            sorter = require("telescope.sorters").fuzzy_with_index_bias(),
          })
        end,
        desc = "Recent files"
      },
      -- git
      { "<leader>sgc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>sgs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      {
        "<leader>sg",
        function ()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep (root dir)"
      },
      {
        "<leader>sG",
        function ()
          require("telescope.builtin").live_grep({ cwd = false })
        end,
        desc = "Grep (cwd)",
      },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>sw",
        function ()
          require("telescope.builtin").grep_string({ word_match = "-w" })
        end,
        desc = "Word (root dir)",
      },
      {
        "<leader>uC",
        function ()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Colorscheme with preview"
      },
      {
        "<leader>ss",
        function ()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        function ()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
              "Struct",
              "Trait",
              "Field",
              "Property",
            },
          })
        end,
        desc = "Goto Symbol (Workspace)",
      },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<a-i>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              require("telescope.builtin").find_files({ no_ignore = true, default_text = line })
            end,
            ["<a-h>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              require("telescope.builtin").find_files({ hidden = true, default_text = line })
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  }
}

