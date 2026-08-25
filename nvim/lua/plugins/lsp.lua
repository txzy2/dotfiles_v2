return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim' },
    config = function()
      vim.diagnostic.config({
        virtual_lines = { current = true },
        virtual_text = { prefix = '●' },
        signs = true,
        underline = true,
        update_in_insert = false,
      })
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'intelephense', 'ts_ls', 'html', 'twiggy_language_server' },
        automatic_enable = true,
      })

      local function go_to_definition()
        vim.lsp.buf.definition({
          reuse_win = true,
          on_list = function(result)
            if #result.items == 0 then
              return
            end
            if #result.items == 1 then
              local item = result.items[1]
              local b = item.bufnr or vim.fn.bufadd(item.filename)
              vim.bo[b].buflisted = true
              vim.api.nvim_win_set_buf(0, b)
              vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
              return
            end
            vim.fn.setloclist(0, result.items, 'r')
            vim.cmd('lopen')
            local augroup = vim.api.nvim_create_augroup('LspDefAutoClose', { clear = true })
            vim.api.nvim_create_autocmd('WinLeave', {
              group = augroup,
              once = true,
              callback = function()
                vim.cmd('lclose')
                pcall(vim.api.nvim_del_augroup_by_id, augroup)
              end,
            })
          end,
        })
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', go_to_definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

          vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })

          vim.keymap.set('n', '<leader>ih', function()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = args.buf })
          end, opts)
        end,
      })

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { '*.php', '*.php3', '*.php4', '*.php5', '*.phtml' },
        callback = function()
          vim.b.autoformat = false
        end,
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.c', '*.h', '*.cpp', '*.hpp', '*.cc', '*.cxx' },
        callback = function()
          if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
            vim.lsp.buf.format({ async = false })
          end
        end,
      })
    end,
  },
}