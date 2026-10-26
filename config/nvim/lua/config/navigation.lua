require('nvim-tree').setup({
    disable_netrw = true,
    hijack_netrw = true,
    hijack_directories = { enable = true, auto_open = true },
    view = { side = 'left', width = 32 },
    filters = { dotfiles = false },
    git = { enable = true },
    renderer = {
        icons = {
            show = { file = false, folder = false, folder_arrow = false, git = true },
            glyphs = {
                git = { unstaged = 'M', staged = 'S', unmerged = 'U', renamed = 'R',
                    untracked = '?', deleted = 'D', ignored = 'I' },
            },
        },
    },
})
vim.keymap.set('n', '<leader>n', '<Cmd>NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>j', '<Cmd>NvimTreeFindFile<CR>', { desc = 'Reveal file in tree' })

local telescope = require('telescope')
local grep_args = vim.deepcopy(require('telescope.config').values.vimgrep_arguments)
vim.list_extend(grep_args, { '--hidden', '--glob', '!.git' })
telescope.setup({
    defaults = { vimgrep_arguments = grep_args },
    pickers = {
        find_files = { find_command = { 'rg', '--files', '--hidden', '--glob', '!.git' } },
    },
})
local builtin = require('telescope.builtin')
for key, picker in pairs({ ff = 'find_files', fg = 'live_grep', fb = 'buffers', fh = 'help_tags' }) do
    vim.keymap.set('n', '<leader>' .. key, builtin[picker], { desc = 'Find: ' .. picker })
end
