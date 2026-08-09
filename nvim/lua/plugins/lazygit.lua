return {
  {
    'kdheepak/lazygit.nvim',
    config = function()
      vim.keymap.set('n', '<leader>gg', function()
        require('lazygit').lazygit()
      end, { desc = 'open lazygit' })
    end,
  },
}