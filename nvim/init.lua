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

-- Overseer task output toggle
vim.keymap.set('n', '<Leader>`', '<cmd>OverseerToggle<CR>', {noremap = true, silent = true})
