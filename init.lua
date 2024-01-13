-- local venv_path = os.getenv('VIRTUAL_ENV')
-- local py_path = nil
-- -- decide which python executable to use for mypy
-- if venv_path ~= nil then
--   py_path = venv_path .. "/bin/python3"
-- else
--   py_path = vim.g.python3_host_prog
-- end
--
local get_python_path = function()
	local command = "which python"
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()
	return result
end

local py_path = get_python_path()
-- print(py_path)

return {
	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "stable", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "nightly", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_quit = false, -- automatically quit the current session after a successful update
		remotes = { -- easily add new remotes to track
			--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
			--   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
			--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		},
	},

	-- Set colorscheme to use
	colorscheme = "catppuccin",

	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	lsp = {
		-- customize lsp formatting options
		formatting = {
			-- control auto formatting on save
			format_on_save = {
				enabled = true, -- enable or disable format on save globally
				allow_filetypes = { -- enable format on save for specified filetypes only
					-- "go",
				},
				ignore_filetypes = { -- disable format on save for specified filetypes
					-- "python",
				},
			},
			disabled = { -- disable formatting capabilities for the listed language servers
				-- "sumneko_lua",
			},
			timeout_ms = 5000, -- default format timeout
			-- filter = function(client) -- fully override the default formatting function
			--   return true
			-- end
		},
		-- enable servers that you already have installed without mason or if installed
		-- with mason then using below config for that server
		servers = {
			-- "pyright"
			"pylsp",
		},
		config = {
			-- Notes about pylsp:
			-- to install pylsp with mason use masoninstall command,
			-- this will not install all the plugins for the pylsp for
			-- that another command is given by mason wich is ":PylspInstall"
			-- use it like this ":PylspInstall pyls-flake8 pylsp-mypy pyls-isort python-lsp-ruff python-lsp-black"
			-- in vim, basically to installed all the plugin packages that we
			-- usually install with 'pip', use PylspInstall command but in vim
			-- command line as it will install these plugins then in the virtual
			-- environment mason use to install the pylsp
			--
			-- specifically for the below config the needed plugins can be installed
			-- with one single command
			-- ":PylspInstall pyls-flake8 pylsp-mypy pyls-isort python-lsp-black python-lsp-ruff"
			-- if installing on a system level do ensure that the core packages of these plugins
			-- should also be installed, which in this case is 'black', 'isort', 'mypy', 'ruff' and 'flake8'.
			pylsp = {
				plugins = {
					-- formatter options
					black = { enabled = true },
					autopep8 = { enabled = false },
					yapf = { enabled = false },
					-- linter options
					ruff = {
						enabled = true,
						--select = { "ALL" },
						-- this is to select the rules that we want to include
						-- in the diagnostics for the ruff lsp, similarly for format.
						format = { "ALL" },
						extendSelect = { "I" },
					},
					pylint = { enabled = false, executable = "pylint" },
					pyflakes = { enabled = false },
					pycodestyle = { enabled = false },
					mccabe = { enabled = false },
					flake8 = { enabled = true },
					-- flake8 = { enabled = true,  maxLineLength=121, ignore={"E501","F401"} },
					-- these lines are working in nvchad but not here thus using 'setup.cfg'
					-- which is a config file for falke 8 at project root
					-- first neovim will follow setup.cfg and if not found then it follows
					-- these inline settings.
					-- type checker
					pylsp_mypy = {
						enabled = true,
						-- this will make mypy to use this python while looking for type stubs
						-- which we have set to activated virtual environment
						overrides = { "--python-executable", py_path, true },
						report_progress = true,
						live_mode = false,
					},
					-- auto-completion options
					jedi_completion = { fuzzy = true },
					-- import sorting
					pyls_isort = { enabled = true },
				},
				configurationSources = { "flake8" },
			},
			-- pyright = {
			--     reportMissingImports = false
			--   },
		},
	},

	-- Configure require("lazy").setup() options
	lazy = {
		defaults = { lazy = true },
		performance = {
			rtp = {
				-- customize default disabled vim plugins
				disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
			},
		},
	},
	-- This function is run last and is a good place to configuring
	-- augroups/autocommands and custom filetypes also this just pure lua so
	-- anything that doesn't fit in the normal config locations above can go here
	polish = function()
		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }

		-- handling abnormal colors in tmux and neovim
		vim.o.termguicolors = true

		-- setting color for matching parenthesis highlighting, earlier it
		-- was not visible
		vim.api.nvim_command("highlight MatchParen ctermbg=darkcyan guibg=darkcyan")

		-- Set python environment to use for neovim internal stuff,
		vim.g.python3_host_prog = "/home/ubuntu/miniconda3/bin/python3"
	end,
}
