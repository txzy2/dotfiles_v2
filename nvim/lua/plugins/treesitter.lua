return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        ensure_installed = {
          'c', 'cpp', 'php', 'javascript', 'typescript', 'html', 'css', 'twig',
        },
        highlight = { enable = true },
      })
    end,
  },
}