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
vim.api.nvim_create_user_command('Bw', function() Snacks.bufdelete() end, {})
vim.cmd('cabbrev bw Bw')

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
local function run_task_by_index(index)
    local tasks_file = vim.fn.getcwd() .. '/.vscode/tasks.json'
    local file = io.open(tasks_file, 'r')
    if not file then
        vim.notify('No .vscode/tasks.json found', vim.log.levels.WARN)
        return
    end
    local content = file:read('*a')
    file:close()
    local ok, data = pcall(vim.json.decode, content)
    if not ok or not data.tasks or not data.tasks[index] then
        vim.notify('Task ' .. index .. ' not found', vim.log.levels.WARN)
        return
    end
    local overseer = require('overseer')
    overseer.open()
    overseer.run_task({ name = data.tasks[index].label })
end

for i = 1, 9 do
    keymap('n', '<Leader>' .. i, function() run_task_by_index(i) end, opts)
end
keymap('n', '<Leader>0', '<cmd>OverseerRun<CR>', opts)
