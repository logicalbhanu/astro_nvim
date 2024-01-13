-- customize mason plugins
return {
	-- use mason-lspconfig to configure LSP installations
	{
		"williamboman/mason-lspconfig.nvim",
		-- overrides `require("mason-lspconfig").setup(...)`
		opts = {
			ensure_installed = { "lua_ls", "pyright", "jsonls"} --, "pylsp" },
		},
	},
	-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
	{
		"jay-babu/mason-null-ls.nvim",
		-- overrides `require("mason-null-ls").setup(...)`
		opts = {
			ensure_installed = { "prettier", "markdownlint" },
			-- ensure_installed = { "prettier", "stylua", "flake8", "markdownlint" },
			-- stylua is not working since the sytlua installed by mason or null_ls
			-- is requiring glibc version greater than the one on this system, also
			-- in this case even running the command ':!stylua %' is also using the 
			-- stylua installed by mason, so its better to remove the one with mason
			-- and use this command to use stylua on system to format the current file.
			-- obviously it should be already installed in this system.
		},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		-- overrides `require("mason-nvim-dap").setup(...)`
		opts = {
			ensure_installed = { "python" },
		},
	},
}
