return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local langs = {
        'c', 'cpp', 'php', 'javascript', 'typescript', 'html', 'css', 'twig',
      }
      require('nvim-treesitter').setup({
        ensure_installed = langs,
      })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = langs,
        callback = function()
          vim.treesitter.start()
          if vim.bo.filetype == 'php' then
            vim.bo.syntax = 'ON'
          end
        end,
      })
    end,
  },
}