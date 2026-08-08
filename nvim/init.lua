vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.clipboard = 'unnamedplus'

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = { 'c', 'cpp' },
        highlight = { enable = true },
      })
    end },

  { 'folke/tokyonight.nvim', priority = 1000,
    config = function()
      vim.cmd.colorscheme('tokyonight-night')
    end },

  { 'williamboman/mason.nvim', build = ':MasonUpdate',
    config = function()
      require('mason').setup()
    end },

  { 'williamboman/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason.nvim' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'clangd' },
        automatic_enable = true,
      })
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
        end,
      })
    end },

  { 'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'path' },
        }),
      })
    end },

  { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', telescope.find_files, { desc = 'find files' })
      vim.keymap.set('n', '<C-f>', telescope.live_grep, { desc = 'grep text' })
      vim.keymap.set('n', '<C-b>', telescope.buffers, { desc = 'buffers' })
      vim.keymap.set('n', '<C-g>', telescope.git_files, { desc = 'git files' })
    end },

  { 'kdheepak/lazygit.nvim',
    config = function()
      vim.keymap.set('n', '<leader>gg', function()
        require('lazygit').lazygit()
      end, { desc = 'open lazygit' })
    end },
}, {})
