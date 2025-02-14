local telescope = require('telescope')

telescope.setup({
    defaults = {
        pickers = {
            git_files = { 
                recurse_submodules = true 
            },
        },
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            },
        },
    },
})

