require('nvim-treesitter.configs').setup({
    -- Install parsers automatically
    ensure_installed = {
        "lua",
        "python",
        "cpp",
        "c",
        "javascript",
        "typescript",
        "rust",
    },

    -- Enable syntax highlighting
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    -- Enable indentation
    indent = {
        enable = true,
    },

    -- Enable incremental selection
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
})

