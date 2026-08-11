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
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd', 'intelephense', 'ts_ls', 'html' },
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
              vim.fn.cursor(item.lnum, item.col)
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