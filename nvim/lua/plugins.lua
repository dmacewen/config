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
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                        n = {
                            ["<esc>"] = require('telescope.actions').close,
                        },
                    },
                    pickers = {
                        git_files = {
                            recurse_submodules = true,
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
    {
        "NeogitOrg/neogit",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
            "sindrets/diffview.nvim",        -- optional - Diff integration

            -- Only one of these is needed.
            "nvim-telescope/telescope.nvim", -- optional
        },
        config = function()
            vim.keymap.set("n", "<leader>g", "<cmd>Neogit<CR>", { desc = "Open Neogit" })
        end,
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
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        lazy = true,
        dependencies = {
            { 'zbirenbaum/copilot.lua' },
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
            prompts = ai_assistant_prompts,
            -- model = "claude-3.7-sonnet",
            -- model = "gemini-2.5-pro",
            mappings = {
                -- Use tab for completion
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<Tab>",
                },
                -- Close the chat
                close = {
                    normal = "q",
                    insert = "<C-c>",
                },
                -- Reset the chat buffer
                reset = {
                    normal = "<C-x>",
                    insert = "<C-x>",
                },
                -- Submit the prompt to Copilot
                submit_prompt = {
                    normal = "<CR>",
                    insert = "<C-CR>",
                },
                -- Accept the diff
                accept_diff = {
                    normal = "<C-y>",
                    insert = "<C-y>",
                },
                -- Show help
                show_help = {
                    normal = "g?",
                },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            chat.setup(opts)

            local select = require("CopilotChat.select")
            vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
                chat.ask(args.args, { selection = select.visual })
            end, { nargs = "*", range = true })

            -- Custom buffer for CopilotChat
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true

                    -- Get current filetype and set it to markdown if the current filetype is copilot-chat
                    local ft = vim.bo.filetype
                    if ft == "copilot-chat" then
                        vim.bo.filetype = "markdown"
                    end
                end,
            })
        end,
        event = "VeryLazy",
        keys = {
            -- Chat with Copilot in visual mode
            {
                "<leader>a",
                ":CopilotChatVisual",
                mode = "x",
                desc = "CopilotChat - Open in vertical split",
            },
            -- Toggle Copilot Chat Vsplit
            { "<leader>a", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
        },
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
            -- enabled = function()
            --     -- Disable in copilot-chat buffers
            --     return vim.bo.filetype ~= "copilot-chat"
            -- end,
            -- Disable completion for these files
            enabled = function() return not vim.tbl_contains({ "copilot-chat", "markdown" }, vim.bo.filetype) end,
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

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT if you're using Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get diagnostics for defined globals
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false, -- Avoid issues with sumneko_lua finding itself if you have it installed elsewhere
                        },
                        -- Do not send telemetry data containing a randomized machine name
                        telemetry = {
                            enable = false,
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
        ft = { "markdown", "copilot-chat" },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    }
}

