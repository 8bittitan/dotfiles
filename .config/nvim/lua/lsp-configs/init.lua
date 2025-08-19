local lspconfig = require('lspconfig')

local original_capabilities = vim.lsp.protocol.make_client_capabilities()
local default_capabilities = require('blink.cmp').get_lsp_capabilities(original_capabilities)

-- Zig specific
vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

local config = {
  on_attach = function(client, bufnr)
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    if client.server_capabilities.documentFormattingProvider then
      ---@diagnostic disable-next-line: deprecated
      vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')
    end

    if client.name == 'eslint' then
      client.server_capabilities.documentFormattingProvider = true
    elseif client.name == 'ts_ls' or client.name == 'typescript-tools' then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
  capabilities = default_capabilities,
  flags = { debounce_text_changes = 200 },
}

return {
  function(server_name)
    lspconfig[server_name].setup(config)
  end,
  ruby_lsp = function()
    lspconfig.ruby_lsp.setup({
      on_attach = config.on_attach,
      capabilities = config.capabilities,
      init_options = {
        experimentalFeaturesEnabled = true,
      },
    })
  end,
  lua_ls = function()
    lspconfig.lua_ls.setup({
      on_attach = config.on_attach,
      capabilities = config.capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          completion = {
            callSnippet = 'Both',
          },
          workspace = {
            checkThirdParty = false,
          },
        },
      },
    })
  end,
  ts_ls = function()
    lspconfig.ts_ls.setup({
      capabilities = config.capabilities,
      on_attach = config.on_attach,
      single_file_support = false,
      init_options = {
        preferences = {
          includeCompletionsWithSnippetText = true,
          includeCompletionsForImportStatements = true,
        },
      },
    })
  end,
  eslint = function()
    local opts = {}
    local cwd = vim.fn.getcwd()

    if string.find(cwd, 'AlgoliaWeb') then
      opts.rulePaths = { './_client/.eslint_rules' }
    end

    if string.find(cwd, '_client') then
      opts.rulePaths = { './.eslint_rules' }
    end

    if string.find(cwd, '_client_admin') then
      opts.rulePaths = { './eslint_rules' }
    end

    lspconfig.eslint.setup({
      capabilities = config.capabilities,
      settings = {
        packageManager = 'yarn',
        options = opts,
      },
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true

        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })

        config.on_attach(client, bufnr)
      end,
    })
  end,
  tailwindcss = function()
    local experimentalOpts = {}
    local cwd = vim.fn.getcwd()

    if string.find(cwd, 'AlgoliaWeb') and not string.find(cwd, '_client_admin') then
      experimentalOpts = {
        configFile = '_client/.vscode/tailwind-vscode.config.js',
      }
    end

    if string.find(cwd, '_client') and not string.find(cwd, '_client_admin') then
      experimentalOpts = {
        configFile = '.vscode/tailwind-vscode.config.js',
      }
    end

    if string.find(cwd, '_client_admin') then
      experimentalOpts = {
        configFile = './tailwind.config.js',
      }
    end

    lspconfig.tailwindcss.setup({
      capabilities = config.capabilities,
      on_attach = config.on_attach,
      settings = {
        tailwindCSS = {
          experimental = experimentalOpts,
        },
      },
    })
  end,
  zls = function()
    lspconfig.zls.setup({
      cmd = { '/usr/local/bin/zls' },
      capabilities = config.capabilities,
      on_attach = config.on_attach,
      settings = {
        zls = {
          build_on_save_alternative_watch = true,
        },
      },
    })
  end,
  biome = function()
    lspconfig.biome.setup({
      on_attach = function(client, bufnr)
        -- NOTE: Not ideal, but works for now until Conform has better support for biome@v2
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          callback = function()
            -- HACK: Override notify for now
            local orignal = vim.notify

            ---@diagnostic disable-next-line: duplicate-set-field
            vim.notify = function(msg, level, opts)
              if msg == 'No code actions available' then
                return
              end
              orignal(msg, level, opts)
            end

            vim.lsp.buf.code_action({
              ---@diagnostic disable-next-line: assign-type-mismatch, missing-fields
              context = { only = { 'source.fixAll.biome' } },
              apply = true,
            })
          end,
        })

        config.on_attach(client, bufnr)
      end,
      capabilities = config.capabilities,
    })
  end,
  jsonls = function()
    lspconfig.jsonls.setup({
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })
  end,
  yamlls = function()
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = '',
          },
          schemas = require('schemastore').yaml.schemas(),
        },
      },
    })
  end,
}
