return {
    -- Telescope and dependencies
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
        cmd = "Telescope",
        keys = {
            { "<leader>o", "<cmd>Telescope git_files recurse_submodules=true<cr>" },
            { "<leader>i", "<cmd>Telescope buffers<cr>" },
            { "<leader>p", "<cmd>Telescope live_grep<cr>" },
            { "<leader>t", "<cmd>Telescope help_tags<cr>" },
        },
    },

    -- Async Task/Run
    {
        'skywind3000/asynctasks.vim',
        dependencies = { 'skywind3000/asyncrun.vim' },
        cmd = { "AsyncTask", "AsyncRun" },
        lazy = false,
    },

    -- Appearance
    {
        'sainnhe/sonokai',
        lazy = false, -- Color schemes should load immediately
        priority = 1000, -- Load before other plugins
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        priority = 100,
        lazy = false,
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'sonokai',
                    icons_enabled = true,
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {},
                    globalstatus = true,  -- Use global statusline
                    refresh = {
                        statusline = 100,  -- Faster refresh rate
                        tabline = 100,
                        winbar = 100
                    }
                },
                tabline = {
                    lualine_a = {{
                        'buffers',
                        mode = 2,
                        icons_enabled = true,
                        use_mode_colors = true,  -- Better visual feedback
                        buffers_color = {
                            active = 'lualine_a_normal',    -- Color for active buffer
                            inactive = 'lualine_b_normal',  -- Color for inactive buffers
                        },
                        symbols = {
                            modified = ' ●',
                            alternate_file = '',
                            directory = '',
                        },
                    }},
                    lualine_z = {'tabs'}
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                extensions = {'fugitive', 'nvim-tree'}
            })
        end
    },
    -- Git integration
    {
        'airblade/vim-gitgutter',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'tpope/vim-fugitive',
        cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
    },
    {
        'vim-scripts/gitignore',
        event = { "BufReadPre", "BufNewFile" },
    },

    -- Misc Tools
    {
        'tpope/vim-abolish',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'junegunn/vim-slash',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'github/copilot.vim',
        event = "InsertEnter",
    },

    -- LSP and completion
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        'hrsh7th/nvim-compe',
        event = "InsertEnter",
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {
                    "lua",
                    "python",
                    "cpp",
                    "c",
                    "javascript",
                    "typescript",
                    "rust",
                    "vim",
                    "vimdoc",
                    "query",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true,
                },
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
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
    },

    -- Terminal
    {
        'voldikss/vim-floaterm',
        keys = {
            { "<C-t>", "<cmd>FloatermToggle<cr>" },
        },
    },

    -- Language specific
    {
        'petRUShka/vim-opencl',
        ft = "opencl",
    },
    {
        'shime/vim-livedown',
        ft = "markdown",
    },
    {
        'cespare/vim-toml',
        ft = "toml",
    },
}

