return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  -- plugin to copy content to client in visual mode
  -- if this system is uses as server and this neovim
  -- instance is in use.
  {
    "ojroques/nvim-osc52",
  },

  -- use vifm as file manager, lazy=false to make
  -- plugin load at start
  { "vifm/vifm.vim", lazy = false },
}
