-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- A custom flags table to be passed to all language servers  (`:h lspconfig-setup`)
    flags = {
      exit_timeout = 5000,
    },
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
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 5000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
      -- "pylance",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      pylsp = {
        settings = {

          pylsp = {
            plugins = {
              -- formatter options
              black = { enabled = true },
              autopep8 = { enabled = false },
              yapf = { enabled = false },

              -- rope(refactoring tool) configuration
              -- slowing down my system, better not to use
              -- rope_autoimport = {
              --   enabled = true,
              --   completions = { enabled = true },
              --   code_actions = { enabled = true },
              -- },
              -- rope_completion = { enabled = true },

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
              -- flake8 = { enabled = true },
              flake8 = { enabled = true, maxLineLength = 121, ignore = { "F401", "W503" } },
              -- we can use 'setup.cfg' or .flake8, which is a config file for flake8
              -- at project root, first we will look for 'setup.cfg' or .flake8
              -- and if not found then it follows these inline settings.

              -- type checker
              -- mypy = { enabled = true },
              -- not working(working in mac at present in astronvim v4 didn't check on linux yet)
              -- with this new way of configuring pylsp in neovim(AstroNvim)
              -- i.e. pylsp = { settings = { pylsp = { plugins = "settings for pylsp" } } }
              -- way of configuration
              pylsp_mypy = {
                enabled = true,
                -- this will make mypy to use this python while looking for type stubs
                -- which we have set to activated virtual environment, raising error
                -- with this, though working fine without it.
                -- overrides = { "--python-executable", py_path, true },
                report_progress = true,
                live_mode = true,
              },
              -- auto-completion options
              jedi_completion = { fuzzy = true },
              -- import sorting
              pyls_isort = { enabled = true },
            },
            configurationSources = { "flake8" },
          },
        },
      },

      -- currently latest pylance supported version is 2024.3.2
      pylance = {
        filetypes = { "python" },
        root_dir = function(...)
          return require("lspconfig.util").root_pattern(unpack {
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
          })(...)
        end,
        cmd = { "pylance", "--stdio" },
        single_file_support = true,
        before_init = function(_, c) c.settings.python.pythonPath = vim.fn.exepath "python3" end,

        settings = {
          python = {
            analysis = {
              diagnosticMode = "workspace",
              -- diagnosticMode = "openFilesOnly",
              typeCheckingMode = "basic",
              autoImportCompletions = true,
              autoFormatStrings = true,
              autoImportUserSymbols = true,
              importFormat = "relative",
              completeFunctionParens = true,
              inlayHints = {
                variableTypes = true,
                functionReturnTypes = true,
                callArgumentNames = true,
                pytestParameters = true,
              },
              useLibraryCodeForTypes = true,
            },
          },
        },
        handlers = {
          ["workspace/executeCommand"] = function(_, result)
            if result and result.label == "Extract Method" then
              vim.ui.input({ prompt = "New name: ", default = result.data.newSymbolName }, function(input)
                if input and #input > 0 then vim.lsp.buf.rename(input) end
              end)
            end
          end,
        },
        commands = {
          PylanceExtractMethod = {
            function()
              local arguments = {
                vim.uri_from_bufnr(0):gsub("file://", ""),
                require("vim.lsp.util").make_given_range_params().range,
              }
              vim.lsp.buf.execute_command { command = "pylance.extractMethod", arguments = arguments }
            end,
            description = "Extract Method",
            range = 2,
          },
          PylanceExtractVariable = {
            function()
              local arguments = {
                vim.uri_from_bufnr(0):gsub("file://", ""),
                require("vim.lsp.util").make_given_range_params().range,
              }
              vim.lsp.buf.execute_command { command = "pylance.extractVariable", arguments = arguments }
            end,
            description = "Extract Variable",
            range = 2,
          },
        },
        docs = {
          package_json = (vim.env.MASON or "") .. "/packages/pylance/extension/package.json",
          description = [[
      https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance
      `pylance`, Fast, feature-rich language support for Python
      ]],
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_codelens_refresh = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/codeLens",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "InsertLeave", "BufEnter" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Refresh codelens (buffer)",
          callback = function(args)
            if require("astrolsp").config.features.codelens then vim.lsp.codelens.refresh { bufnr = args.buf } end
          end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<Leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client)
            return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens
          end,
        },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
