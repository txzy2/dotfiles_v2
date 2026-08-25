return {
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup({
        disable_inline_completion = true,
        keymaps = {
          accept_suggestion = '<C-g>',
          accept_word = '<C-n>',
          clear_suggestion = '<C-x>',
        },
      })
    end,
  },
}
