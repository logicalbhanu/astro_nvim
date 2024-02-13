-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local utils = require "astronvim.utils"
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

    -- better buffer navigation with Shift+l and h.
    -- setting a mapping to false will disable it
    ["]b"] = false,
    ["[b"] = false,
    ["<tab>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-tab>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<S-t>"] = { "<C-6><cr>", desc = "last used tab" },
    ["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Find project" },
    ["<leader>te"] = {
      function() utils.toggle_term_cmd "vifm" end,
      desc = "ToggleTerm vifm",
    },

    -- toggle git diff, it is still a work in progress
    ["<leader>gd"] = {
      function()
        if vim.wo.diff then
          -- if buffer is showing git diff
          vim.cmd "on"
        else
          require("gitsigns").diffthis()
        end
      end,
      desc = "Toggle git diff",
    },
  },
  v = {
    -- copy selection to client clipboard
    ["<leader>c"] = {
      require("osc52").copy_visual,
      desc = "Copy to client",
    },
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

    -- Window movement from terminal and within the terminal(toggleterm is also a temrinal)
    ["<C-w>h"] = { "<C-\\><C-n><C-w>h", desc = "window left" },
    ["<C-w>j"] = { "<C-\\><C-n><C-w>j", desc = "window below" },
    ["<C-w>k"] = { "<C-\\><C-n><C-w>k", desc = "window above" },
    ["<C-w>l"] = { "<C-\\><C-n><C-w>l", desc = "window right" },
    -- to enable cycling between windows smooth in terminal(toggleterm)
    ["<C-w><C-w>"] = { "<C-\\><C-n><C-w><C-w>", desc = "cycle window" },
  },
}
