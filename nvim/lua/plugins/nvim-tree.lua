return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup({
        update_focused_file = { enable = true },
        view = { width = 35 },
      })
      vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', {
        desc = 'toggle file explorer',
      })
    end,
  },
}