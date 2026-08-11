return {
  {
    'rmagatti/auto-session',
    lazy = false,
    config = function()
      require('auto-session').setup({
        suppressed_dirs = { '~/', '~/Downloads', '~/Documents', '~/Desktop' },
      })
      vim.keymap.set('n', '<leader>wr', '<cmd>SessionRestore<CR>', { desc = 'restore session' })
      vim.keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { desc = 'save session' })
      vim.keymap.set('n', '<leader>wd', '<cmd>SessionDelete<CR>', { desc = 'delete session' })
    end,
  },
}
