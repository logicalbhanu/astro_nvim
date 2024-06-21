-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(
    _,
    opts --[[@as AstroCoreOpts]]
  )
    local maps = opts.mappings
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    -- first key is the mode
    -- second key is the lefthand side of the map

    -- disable stock key-bindings
    -- NORMAL MODE
    maps.n["<C-S>"] = false -- setting a mapping to false will disable it
    maps.n["]b"] = false -- navigate buffer tabs
    maps.n["[b"] = false -- navigate buffer tabs
    maps.n["<Leader>ld"] = false -- hover diagnostics

    -- search diagnostics in current buffer
    maps.n["<Leader>ld"] = { "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Search buffer diagnostics" }

    -- better buffer navigation
    maps.n["<tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" }
    maps.n["<S-tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" }

    -- mappings seen under group name "Buffer"
    maps.n["<Leader>bd"] = {
      function()
        require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
      end,
      desc = "Close buffer from tabline",
    }

    -- tables with just a `desc` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    maps.n["<Leader>b"] = { desc = "Buffers" }

    -- toggle git diff(with gitsigns)
    maps.n["<leader>gd"] = {
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
    }

    -- find project
    maps.n["<leader>fp"] = { "<cmd>Telescope projects<cr>", desc = "Find project" }

    -- dismisss notifications
    maps.n["<leader><ESC>"] = { "<cmd>NoiceDismiss<cr>", desc = "Dismiss notifications" }

    -- configure root dir
    maps.n["<leader>r"] = { "<cmd>AstroRoot<cr>", desc = "Configure root dir" }

    -- TERIMINAL MODE
    -- shift-escape to exit terminal
    maps.t["<leader><ESC><ESC>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" }
    --alternate key-binding to close terminal as esc clash with fish shell escape in vi-mode
    maps.t["<leader>tf"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" }
    -- Enter normal mode in terminal
    maps.t["<leader><ESC>"] = { "<C-\\><C-n>", desc = "Normal mode" }

    -- to enable cycling between windows smooth in terminal(toggleterm)
    maps.t["<C-w><C-w>"] = { "<C-\\><C-n><C-w><C-w>", desc = "cycle window" }

    -- INSERT MODE
    -- codeium key-bindings
    maps.i["<C-e>"] = {
      function() return vim.fn["codeium#Accept"]() end,
      desc = "Codeium completion",
      expr = true,
    }
  end,
}
