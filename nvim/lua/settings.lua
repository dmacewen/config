-- Basic settings
vim.opt.number = true
vim.opt.hidden = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.scrolloff = 8
vim.opt.compatible = false
vim.opt.shiftwidth = 4
vim.opt.laststatus = 2
vim.opt.backspace = 'indent,eol,start'
vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.completeopt = 'menuone,noselect'

-- Python providers
vim.g.python3_host_prog = '/usr/local/bin/python3'
vim.g.python_host_prog = '/usr/bin/python2'

-- Exclude terminal buffers from buffer list
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.opt_local.buflisted = false
    end
})

-- Quickfix settings
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'qf',
    callback = function()
        vim.opt_local.winheight = 30
        vim.opt_local.buflisted = false
    end
})

