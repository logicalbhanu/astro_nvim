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
	{ "nvim-lua/popup.nvim", lazy = false },
	{ "nvim-telescope/telescope-media-files.nvim", lazy = false },
	-- use vifm as file manager, lazy=false to make
	-- plugin load at start
	{ "vifm/vifm.vim", lazy = false },

	-- add plugin for catppuccin theme.
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			-- configuration options...
			flavour = "mocha",
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		},
	},

	-- to provide change surround syntax with repetition
	{ "tpope/vim-surround", lazy = false, dependencies = { "tpope/vim-repeat" } },
	{ "tpope/vim-repeat" },

	-- to provide cmd line completions
	{
		"hrsh7th/cmp-cmdline",
		event = "CmdlineEnter",
		config = function()
			local cmp = require("cmp")
			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
		end,
	},
}
