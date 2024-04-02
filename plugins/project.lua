return {
  -- for project root directory setup and management
  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    cmd = { "Telescope projects" },
    config = function()
      require("project_nvim").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
      require("telescope").load_extension "projects"
      -- use "Telescope projects" commands to see recent projects
    end,
  },
}
