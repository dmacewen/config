-- Generated with the help of Claude 3.5 Sonet
-- Plugin Manager
require("config.lazy")

vim.g.mapleader = " "

-- Initialize lazy.nvim
require('lazy').setup('plugins', {
    defaults = { lazy = true },
    install = {
        colorscheme = { "sonokai" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- Load core configurations
require('settings')
require('keymaps')

-- Load plugin configurations
require('config.lsp')
require('config.telescope')
require('config.treesitter')
require('config.appearance')
require('config.floaterm')

-- Async Task/Run settings
vim.g.asyncrun_open = 6
vim.g.asyncrun_rootmarks = {'.git', '.svn', '.root', '.project', '.hg'}

-- Function to toggle quickfix window
_G.toggle_quickfix = function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win.quickfix == 1 then
            qf_exists = true
        end
    end
    if qf_exists then
        vim.cmd('cclose')
    else
        vim.cmd('copen')
    end
end

-- Quickfix toggle mapping
vim.keymap.set('n', '<Leader>`', toggle_quickfix, {noremap = true, silent = true})


