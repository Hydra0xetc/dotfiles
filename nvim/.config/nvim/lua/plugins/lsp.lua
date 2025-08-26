vim.lsp.handlers["textDocument/inlayHint"] = function() end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
          cmd = {
            "clangd",
            "--compile-commands-dir=.",
          },
          init_options = {
            compilationDatabasePath = ".",
          },
        },

        lua_ls = {
          cmd = { "/data/data/com.termux/files/usr/bin/lua-language-server" },
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
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
          },
        },
        bashls = {},
        jsonls = {},
        html = {},
        ts_ls = {},

        -- Nonaktifkan pyright
        pyright = false,

        -- Aktifkan basedpyright
        basedpyright = {
          mason = false,
          cmd = { "basedpyright-langserver", "--stdio" },
          settings = {
            python = {
              analysis = {
                autoSearchPath = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
              },
            },
          },
        },

        gopls = {},
      },
    },
  },
}
