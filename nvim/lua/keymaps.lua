local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader set in init.lua before lazy.vim is initialized
-- Many plugin specific keymaps are set inside of plugin.lua

-- General
-- NOTE: This interferes with closing telescope and terminal windows
-- vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })

-- Buffer navigation
keymap('n', '<C-l>', ':bn<CR>', opts)
keymap('n', '<C-h>', ':bp<CR>', opts)

-- Jump 10 lines
keymap('n', '<C-j>', '10jzz', opts)
keymap('n', '<C-k>', '10kzz', opts)

-- Git navigation
keymap('n', '<S-j>', ':GitGutterNextHunk<CR>zz', opts)
keymap('n', '<S-k>', ':GitGutterPrevHunk<CR>zz', opts)

-- LSP
-- keymap('n', 'gd', '<C-]>', opts)
keymap('n', 'gi', vim.lsp.buf.implementation, opts)
keymap('n', 'gr', vim.lsp.buf.references, opts)

-- Terminal
keymap('t', '<Esc>', '<C-\\><C-N>', opts)
keymap('t', '<C-t>', [[<C-\><C-n>:FloatermToggle<CR>]], { noremap = true, silent = true })

-- QuickFix toggle
keymap('n', '<Leader>`', ':call ToggleQuickFix()<CR>', { noremap = true, silent = true })

-- AsyncTask mappings
keymap('n', '<Leader>1', ':AsyncTask file-build<CR>', { noremap = true, silent = true })
keymap('n', '<Leader>2', ':AsyncTask file-run<CR>', { noremap = true, silent = true })

