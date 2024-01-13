-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    -- set to true or false etc.
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = false, -- sets vim.opt.wrap
    foldenable = false,
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements
  },
}

-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
-- 	-- set options here
-- 	local_vim.opt.relativenumber = true
-- 	local_vim.opt.number = true
-- 	local_vim.opt.spell = false
-- 	local_vim.opt.signcolumn = "auto"
-- 	local_vim.opt.wrap = false
-- 	-- appending statusline to show codeium status
-- 	-- local_vim.opt.statusline:append("\\{…\\}%3{codeium#GetStatusString()}")
--
-- 	-- set vim.g options here
-- 	local_vim.g.mapleader = " "
-- 	local_vim.g.autoformat_enabled = true
-- 	local_vim.g.cmp_enabled = true
-- 	local_vim.g.autoformat_enabled = true
-- 	local_vim.g.diagnostics_mode = 3 -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)= true
-- 	local_vim.g.icons_enabled = true
-- 	local_vim.g.ui_notifications_enabled = true
--
-- 	return local_vim
-- end
