return {
    -- Telescope and dependencies
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        cmd = "Telescope",
        keys = {
            { "<leader>o", "<cmd>Telescope git_files recurse_submodules=true<cr>" },
            { "<leader>i", "<cmd>Telescope buffers<cr>" },
            { "<leader>p", "<cmd>Telescope live_grep<cr>" },
            { "<leader>t", "<cmd>Telescope help_tags<cr>" },
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    mappings = {
                        -- Close telescope with escape
                        i = {
                            ["<esc>"] = require('telescope.actions').close,
                        },
                        n = {
                            ["<esc>"] = require('telescope.actions').close,
                        },
                    },
                },
            })
        end
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
        'lewis6991/gitsigns.nvim',
        lazy = false,
        config = function()
            require('gitsigns').setup({
                signs = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    vim.keymap.set('n', '<C-g>', gs.preview_hunk)
                end
            })
        end
    },
    -- Misc Tools
    {
        'zbirenbaum/copilot.lua',
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    keymap = {
                        accept = "<C-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<C-]>",
                        prev = "<C-[>",
                        dismiss = "<C-e>",
                    },
                },
            })
        end,
    },
    -- Autocomplete
    {
        'saghen/blink.cmp',
        dependencies = {
            "fang2hou/blink-copilot",
            opts = {
                max_completions = 1,  -- Global default for max completions
                max_attempts = 2,     -- Global default for max attempts
                -- `kind` is not set, so the default value is "Copilot"
            }
        },
        lazy = false,
        -- use a release tag to download pre-built binaries
        version = '*',
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- See the full "keymap" documentation for information on defining your own keymap.
            keymap = { 
                preset = 'super-tab',
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'buffer', 'copilot' },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                        opts = {
                            -- Local options override global ones
                            -- Final settings: max_completions = 3, max_attempts = 2, kind = "Copilot"
                            max_completions = 3,  -- Override global max_completions
                        }
                    },
                },
            },
        },
        opts_extend = { "sources.default" }
    },
    -- LSP Configuratoin
    {
        'neovim/nvim-lspconfig',
        lazy=false,
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require('lspconfig')

            lspconfig.ruff.setup({ 
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- Disable default formatting
                    client.server_capabilities.document_formatting = false
                    client.server_capabilities.document_range_formatting = false
                end,
            })

            lspconfig.pyright.setup({ 
                capabilities = capabilities,
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            typeCheckingMode = "standard",
                            autoImportCompletions = true,
                            autoSearchPaths = true,
                        },
                    },
                },
            })

            lspconfig.clangd.setup({ capabilities = capabilities })
        end
    },
    {
        'stevearc/conform.nvim',
        lazy=false,
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    python = { "ruff_format", "ruff_fix", lsp_format = "fallback" },
                    cpp = { "clang-format", lsp_format = "fallback" },
                    c = { "clang-format", lsp_format = "fallback"  },
                },
                format_on_save = {
                    timeout_ms = 500,
                },
            })
        end

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
        'akinsho/toggleterm.nvim', 
        version = "*", 
        lazy=false,
        config = function()
            require("toggleterm").setup({
                -- Set the terminal to float
                direction = 'float',
                -- Configure the floating window
                float_opts = {
                    border = 'curved',
                    width = function()
                        return math.floor(vim.o.columns * 0.8)
                    end,
                    height = function()
                        return math.floor(vim.o.lines * 0.8)
                    end,
                },
                open_mapping = [[<C-t>]],
            })
        end
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
    {
        "elixir-tools/elixir-tools.nvim",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local elixir = require("elixir")
            local elixirls = require("elixir.elixirls")

            elixir.setup {
                nextls = {enable = true},
                elixirls = {
                    enable = true,
                    settings = elixirls.settings {
                        dialyzerEnabled = false,
                        enableTestLenses = false,
                    },
                    on_attach = function(client, bufnr)
                        vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
                        vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
                        vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
                    end,
                },
                projectionist = {
                    enable = false
                }
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    }
}

