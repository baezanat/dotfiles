return { "Iron-E/nvim-soluarized",
  config = function()
    vim.opt.termguicolors = true
    vim.opt.bg = 'dark' -- or 'light'
    -- vim.api.nvim_command 'colorscheme soluarized'
    vim.cmd.colorscheme 'soluarized'
  end
}
