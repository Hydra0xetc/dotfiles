local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Global mappings
vim.keymap.set('n', '<leader>w', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand untuk setup LSP keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- setup lsp

vim.lsp.config("tsserver", {
  capabilities = capabilities,
  cmd = { "/data/data/com.termux/files/usr/bin/typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
})

vim.lsp.enable("tsserver")

vim.lsp.config("lua-language-server", {
  capabilities = capabilities,
  cmd = { "/data/data/com.termux/files/usr/bin/lua-language-server" },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  }
})

vim.lsp.enable("lua-language-server")

vim.lsp.config("basedpyright-langserver", {
  capabilities = capabilities,
    cmd = {
     "/data/data/com.termux/files/usr/bin/basedpyright-langserver",
     "--stdio"
  },
  filetypes = { "python" },
  settings = {
		  basedpyrigt = {
          analysis = {
            autoSearchPath = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "basic",
            typeCheckingMode = "off",
          }
        }
    }
})

vim.lsp.enable("basedpyright-langserver")

vim.lsp.config("clangd", {
  capabilities = capabilities,
    cmd = {
    "clangd",
    "--compile-commands-dir=.",
    "--clang-tidy",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  settings = { clangd = {} }
})

vim.lsp.enable("clangd")
