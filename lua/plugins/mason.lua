-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   -- overrides `require("mason-lspconfig").setup(...)`
  --   opts = function(_, opts)
  --     -- add more things to the ensure_installed table protecting against community packs modifying it
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
  --       "lua_ls",
  --       "pylsp",
  --       -- add more arguments for adding more language servers
  --     })
  --   end,
  -- },

  -- mason config to handle pylance too
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "lua:custom-registry", -- custom user registry
        "github:mason-org/mason-registry", -- make sure to add the default registry
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      local cmd = vim.api.nvim_create_user_command
      cmd("MasonUpdate", function(options) require("astrocore.mason").update(options.fargs) end, {
        nargs = "*",
        desc = "Update Mason Package",
        complete = function(arg_lead)
          local _ = require "mason-core.functional"
          return _.sort_by(
            _.identity,
            _.filter(_.starts_with(arg_lead), require("mason-registry").get_installed_package_names())
          )
        end,
      })
      cmd("MasonUpdateAll", function() require("astrocore.mason").update_all() end, { desc = "Update Mason Packages" })
    end,
  },

  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "stylua",
        -- add more arguments for adding more null-ls sources
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
        -- add more arguments for adding more debuggers
      })
    end,
  },
}
