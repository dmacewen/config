-- Plugin Manager
vim.g.mapleader = " "
require("config.lazy")

-- Disable default <C-a> mapping in normal mode
vim.api.nvim_set_keymap('n', '<C-a>', '', { noremap = true })

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
require('config.appearance')

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
