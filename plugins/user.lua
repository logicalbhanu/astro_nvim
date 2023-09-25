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
-- for project root directory setup and management
-- {
--   "ahmedkhalf/project.nvim",
--    lazy=false,
--
--   config = function()
--     require("project_nvim").setup {
--         --require('telescope').load_extension('projects'),
--         --require'telescope'.extensions.projects.projects{},
--       -- your configuration comes here
--       -- or leave it empty to use the default settings
--       -- refer to the configuration section below
--     }
--       -- use "Telescope projects" commands to se recent projects
--   end
-- },
-- setting up telescope media-files extension
  {"nvim-lua/popup.nvim", lazy=false},
  {"nvim-telescope/telescope-media-files.nvim", lazy=false},
  -- use vifm as file manager, lazy=false to make
  -- plugin load at start
  { "vifm/vifm.vim", lazy = false },
}
