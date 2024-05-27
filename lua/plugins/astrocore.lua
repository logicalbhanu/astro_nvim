-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        termguicolors = true, -- handling abnormal colors in tmux and neovim
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- disable stock key-bindings

        ["<C-S>"] = false, -- setting a mapping to false will disable it
        ["]b"] = false, -- navigate buffer tabs
        ["[b"] = false, -- navigate buffer tabs

        -- better buffer navigation
        ["<tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },

        -- toggle git diff(with gitsigns)
        ["<leader>gd"] = {
          function()
            -- check whether buffer is showing git diff
            if vim.wo.diff then
              -- if buffer is showing git diff then run :on command
              vim.cmd "on"
            else
              require("gitsigns").diffthis()
            end
          end,
          desc = "Toggle git diff",
        },

        -- find project
        ["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Find project" },
      },

      t = {

        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
        -- shift-escape to exit terminal
        ["<leader><ESC><ESC>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
        --alternate key-binding to close terminal as esc clash with fish shell escape in vi-mode
        ["<leader>tf"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
        -- Enter normal mode in terminal
        ["<leader><ESC>"] = { "<C-\\><C-n>", desc = "Normal mode" },

        -- to enable cycling between windows smooth in terminal(toggleterm)
        ["<C-w><C-w>"] = { "<C-\\><C-n><C-w><C-w>", desc = "cycle window" },
      },

      i = {

        -- codeium key-bindings
        ["<C-g>"] = {
          function() return vim.fn["codeium#Accept"]() end,
          desc = "Codeium completion",
          expr = true,
        },
      },
    },
  },
}
