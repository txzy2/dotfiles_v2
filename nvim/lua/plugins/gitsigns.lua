return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = require('gitsigns')
          vim.keymap.set('n', '<leader>hp', gs.prev_hunk, { buffer = bufnr, desc = 'prev hunk' })
          vim.keymap.set('n', '<leader>hn', gs.next_hunk, { buffer = bufnr, desc = 'next hunk' })
          vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = 'stage hunk' })
          vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = 'undo stage hunk' })
          vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = 'reset hunk' })
          vim.keymap.set('n', '<leader>hb', gs.blame_line, { buffer = bufnr, desc = 'blame line' })
          vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = 'diff this' })
        end,
      })
    end,
  },
}
