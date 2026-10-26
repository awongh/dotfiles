if vim.fn.has('nvim-0.12.6') == 0 then
    error('This configuration requires Neovim 0.12.6 or newer')
end

require('config.options')
require('config.packages')
require('config.navigation')
require('config.lsp')
