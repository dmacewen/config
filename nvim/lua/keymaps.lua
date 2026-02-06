local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader set in init.lua before lazy.vim is initialized
-- Many plugin specific keymaps are set inside of plugin.lua

-- General
-- Stop insert with escape
keymap('i', '<Esc>', '<cmd>stopinsert<CR>', { noremap = true })

-- Buffer navigation
keymap('n', '<C-l>', ':bn<CR>', opts)
keymap('n', '<C-h>', ':bp<CR>', opts)

-- Jump 10 lines
keymap('n', '<C-j>', '10jzz', opts)
keymap('n', '<C-k>', '10kzz', opts)

-- Swap <C-i> and <C-o> to map to forward and backward jump
keymap('n', '<C-i>', '<C-o>', opts)
keymap('n', '<C-o>', '<C-i>', opts)

-- LSP
keymap('n', 'gi', function() Snacks.picker.lsp_implementations() end, opts)
keymap('n', 'gr', function() Snacks.picker.lsp_references() end, opts)
keymap('n', 'gd', function() Snacks.picker.lsp_definitions() end, opts)
keymap('n', '<C-f>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

-- Terminal
keymap('t', '<Esc>', '<C-\\><C-N>', opts)

-- Overseer task mappings
keymap('n', '<Leader>1', '<cmd>OverseerRun<CR>', opts)
keymap('n', '<Leader>2', '<cmd>OverseerToggle<CR>', opts)
