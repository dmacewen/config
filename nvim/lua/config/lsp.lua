-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = false,
    float = {
        source = "always",
        border = "rounded",
        show_header = false,
    }
})

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '<C-d>', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist, { noremap = true, silent = true })
