return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', telescope.find_files, { desc = 'find files' })
      vim.keymap.set('n', '<C-f>', telescope.live_grep, { desc = 'grep text' })
      vim.keymap.set('n', '<C-b>', telescope.buffers, { desc = 'buffers' })
      vim.keymap.set('n', '<C-g>', telescope.git_files, { desc = 'git files' })
    end,
  },
}