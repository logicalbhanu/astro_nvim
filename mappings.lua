-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
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
    ["<S-l>"] = {
      function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
      desc = "Next buffer",
    },
    ["<S-h>"] = {
      function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
      desc = "Previous buffer",
    },
    ["<S-t>"] = { "<C-6><cr>", desc = "last used tab" },
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
    -- Escape twice to exit terminal
    ["<esc><esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
    -- Window movement from terminal and within the terminal(toggleterm is also a temrinal)
    ["<C-w>h"] = { "<C-\\><C-n><C-w>h", desc = "window left" },
    ["<C-w>j"] = { "<C-\\><C-n><C-w>j", desc = "window below" },
    ["<C-w>k"] = { "<C-\\><C-n><C-w>k", desc = "window above" },
    ["<C-w>l"] = { "<C-\\><C-n><C-w>l", desc = "window right" },
    -- to enable cycling between windows smooth in terminal(toggleterm)
    ["<C-w><C-w>"] = { "<C-\\><C-n><C-w><C-w>", desc = "cycle window" },
  },
}
