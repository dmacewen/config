local ai_assistant_prompts = {
    -- Code related prompts
    Explain = "Please explain how the following code works.",
    Review = "Please review the following code and provide suggestions for improvement.",
    Tests = "Please explain how the selected code works, then generate unit tests for it.",
    Refactor = "Please refactor the following code to improve its clarity and readability.",
    FixCode = "Please fix the following code to make it work as intended.",
    FixError = "Please explain the error in the following text and provide a solution.",
    BetterNamings = "Please provide better names for the following variables and functions.",
    Documentation = "Please provide documentation for the following code.",
    SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
    SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
    -- Text related prompts
    Summarize = "Please summarize the following text.",
    Spelling = "Please correct any grammar and spelling errors in the following text.",
    Wording = "Please improve the grammar and wording of the following text.",
    Concise = "Please rewrite the following text to make it more concise.",
}

return {
    -- Task Runner
    {
        'stevearc/overseer.nvim',
        lazy = false,
        config = function()
            require('overseer').setup()
        end,
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
                    lualine_c = {{'filename', path = 1}},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                extensions = {'fugitive', 'nvim-tree'}
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        opts = {}
    },
    {
        "folke/snacks.nvim",
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            quickfile = { enabled = true },
            notifier = { enabled = true },
            input = { enabled = true },
            words = { enabled = true },
            indent = {
                enabled = true,
                animate = { enabled = false },
                scope = { enabled = false },
            },
            bufdelete = { enabled = true },
            terminal = {
                enabled = true,
                win = {
                    style = "float",
                    border = "rounded",
                    width = 0.8,
                    height = 0.8,
                },
            },
            picker = {
                enabled = true,
                win = {
                    input = {
                        keys = {
                            ["<Esc>"] = { "close", mode = { "n", "i" } },
                            ["<C-j>"] = { "list_down", mode = { "i" } },
                            ["<C-k>"] = { "list_up", mode = { "i" } },
                        },
                    },
                },
            },
        },
        keys = {
            { "<leader>o", function() Snacks.picker.files() end, desc = "Find files" },
            { "<leader>i", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>p", function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>f", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<C-t>", function() Snacks.terminal.toggle() end, desc = "Toggle terminal", mode = { "n", "t" } },
        },
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
                    vim.keymap.set('n', '<C-g>', gs.preview_hunk, { buffer = bufnr })
                    vim.keymap.set('n', '<S-j>', function() gs.nav_hunk('next') vim.cmd('normal! zz') end, { buffer = bufnr })
                    vim.keymap.set('n', '<S-k>', function() gs.nav_hunk('prev') vim.cmd('normal! zz') end, { buffer = bufnr })
                end
            })
        end
    },
    {
        "NeogitOrg/neogit",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration
        },
        config = function()
            require('neogit').setup {
                kind = "floating"
            }

            vim.keymap.set("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
        end,
    },
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        config = true,
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    },
    -- Autocomplete
    {
        'saghen/blink.cmp',
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
                ['<C-j>'] = { 'select_next' },
                ['<C-k>'] = { 'select_prev' },
                ['<C-l>'] = { 'accept' }, -- Use Ctrl+l to accept completion
                ['<C-h>'] = { 'hide' }, -- Use Ctrl+h to dismiss completion
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = {
                documentation = { auto_show = true },
                ghost_text = { enabled = true },
                accept = {
                    auto_brackets = {
                        enabled = false,
                    },
                    snippet = false, -- Disable snippet expansion on accept
                }
            },
            sources = {
                default = { 'lsp', 'path', 'buffer' },
            },
            -- Disable completion for these files
            enabled = function() return not vim.tbl_contains({ "markdown" }, vim.bo.filetype) end,
        },
        opts_extend = { "sources.default" }
    },
    -- LSP Configuratoin
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                -- A list of servers to automatically install if they're not already installed.
                -- This setting has no effect if `automatic_installation` is false.
                ensure_installed = { "pyright", "ruff", "clangd", "lua_ls" },
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            -- Set blink.cmp capabilities for all servers
            vim.lsp.config('*', {
                capabilities = require('blink.cmp').get_lsp_capabilities(),
            })

            -- Ruff: disable formatting (handled by conform.nvim)
            vim.lsp.config('ruff', {
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            })

            -- Pyright: use Ruff for import organizing
            vim.lsp.config('pyright', {
                settings = {
                    pyright = {
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

            -- Lua LS: configure for Neovim development
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = { 'vim' } },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.enable({ 'ruff', 'pyright', 'lua_ls', 'clangd' })
        end,
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
                    "elixir",
                    "eex", -- Elixir EEx
                    "heex", -- Elixir HEEx
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
    },
    -- Language specific
    {
        'petRUShka/vim-opencl',
        ft = "opencl",
    },
    {
        "elixir-tools/elixir-tools.nvim",
        ft = "elixir",
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
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { "markdown" },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    }
}

