return {
  -- LSP server
  {
    "git@github.com:neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = {
          noremap = true,
          silent = true,
          buffer = bufnr,
        }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

        if client.supports_method("textDocument/formatting") then
          local group = vim.api.nvim_create_augroup("LspFormatting", {
            clear = true,
          })
          vim.api.nvim_clear_autocmds({
            group = group,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                bufnr = bufnr,
              })
            end,
          })
        end
      end
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostic = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      }
      for server, config in pairs(servers) do
        config = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
        }, config)
        lspconfig[server].setup(config)
      end
    end,
  },

  -- Linter
  {
    "git@github.com:nvimtools/none-ls.nvim",
    dependencies = {
      "git@github.com:nvim-lua/plenary.nvim",
    },
    config = function()
      local none_ls = require("null-ls")
      none_ls.setup({
        sources = {
          none_ls.builtins.formatting.stylua,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            local group = vim.api.nvim_create_augroup("LspFormatting", {
              clear = true,
            })
            vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = group,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },

  -- Auto complete
  {
    "git@github.com:hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "git@github.com:hrsh7th/cmp-nvim-lsp",
      "git@github.com:hrsh7th/cmp-path",
      "git@github.com:hrsh7th/cmp-buffer",
      "git@github.com:L3MON4D3/LuaSnip",
      "git@github.com:saadparwaiz1/cmp_luasnip",
      "git@github.com:rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
      })
    end,
  }
}
