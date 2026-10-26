vim.diagnostic.config({ signs = true, underline = true, virtual_text = false })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostic details' })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLsp', { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get,
                { buffer = event.buf, desc = 'LSP completion' })
        end
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
            { buffer = event.buf, desc = 'Go to definition' })
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({ async = true })
        end, { buffer = event.buf, desc = 'Format buffer' })
    end,
})

require('mason').setup()
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
            telemetry = { enable = false },
        },
    },
})
local servers = { 'lua_ls', 'ts_ls', 'pyright', 'ruby_lsp' }
require('mason-lspconfig').setup({ ensure_installed = servers, automatic_enable = servers })
