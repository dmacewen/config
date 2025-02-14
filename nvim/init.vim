""""VIM SETTINGS""""

"" syntax on
filetype off                  " Required

set nu
set hidden
set tabstop=4
set expandtab
set autoindent
set scrolloff=8
set nocompatible              " Required
set shiftwidth=4
set laststatus=2
set statusline+=%*
set statusline+=%#warningmsg#
set backspace=indent,eol,start
set cmdheight=2
set updatetime=300
set shortmess+=c

""""PLUGINS""""

call plug#begin('~/.config/nvim/plugged')
"Testing Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"Async Task/Run
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

"Apperance
Plug 'sainnhe/sonokai'
" Plug 'rebelot/kanagawa.nvim'
" Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

"Misc Tools
Plug 'vim-scripts/gitignore'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'junegunn/vim-slash'
Plug 'github/copilot.vim'
"Plug 'w0rp/ale'

"Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

"Language Server
Plug 'neovim/nvim-lspconfig'
"
" Autocomplete
Plug 'hrsh7th/nvim-compe'
set completeopt=menuone,noselect

"Interface
Plug 'voldikss/vim-floaterm'

"Language specific plugs
Plug 'petRUShka/vim-opencl'
Plug 'shime/vim-livedown', {'for': 'markdown'}
Plug 'cespare/vim-toml', {'for': 'toml'}
" Plug 'fatih/vim-go', {'for': 'go'}
" Plug 'wting/rust.vim', {'for': 'rust'}
" Plug 'lambdatoast/elm.vim', {'for': 'elm'}
" Plug 'racer-rust/vim-racer', {'for': 'rust'}
" Plug 'elixir-lang/vim-elixir', {'for': 'elixir'}
" Plug 'slashmili/alchemist.vim', {'for': 'elixir'}
" Plug 'jelera/vim-javascript-syntax', {'for': ['javascript', 'vue']}
" Plug 'posva/vim-vue', {'for': 'vue'}
" Plug 'keith/swift.vim', {'for': 'swift'}

"Vim in browser text boxes
"Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

call plug#end()

lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}

EOF

""""PLUGIN SETTINGS""""
" Async Task/Run
let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
" Set Quickfix window height
au FileType qf setlocal winheight=30
" au FileType qf setlocal winminheight=30

"Compe
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

""" Configure Telescope """
lua << EOF
require('telescope').setup {
  defaults = {
    pickers = {
        git_files = { recurse_submodules = true },
    },
  }
}

vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = "always",
    border = "rounded",
    show_header = false,
  }
})

EOF



""""" Compe Tab Completion 
lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

""" END Compe Tab completion


let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

""""APPERANCE""""

"" set termguicolors
"" set background=dark
"" colorscheme solarized8

" Important!!
if has('termguicolors')
  set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'shusia'
let g:sonokai_better_performance = 1
colorscheme sonokai


set showtabline=2 "Force tabline to always show

let g:lightline = {
            \ 'colorscheme': 'sonokai',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'tabline': {
            \   'left': [['buffers']]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel'
            \ },
            \ }

""""FUNCTIONS""""

"" Turn relative numbering on and off
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Format current buffer using clang-format
function! FormatBuffer()
  let cursor_pos = getpos('.')
  :%!clang-format -style=file
  call setpos('.', cursor_pos)
endfunction

" Map Ctrl+K to format in both normal and insert mode
nnoremap <C-F> :call FormatBuffer()<CR>
inoremap <C-F> <ESC>:call FormatBuffer()<CR>i

" Format on save
autocmd BufWritePre *.h,*.cc,*.cpp call FormatBuffer()

""""MAPPINGS""""
let mapleader = "\<Space>"
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>

"" Jump 10 lines at a time
nmap <C-j> 10jzz
nmap <C-k> 10kzz

nnoremap <S-j> :GitGutterNextHunk<CR>zz
nnoremap <S-k> :GitGutterPrevHunk<CR>zz

nnoremap <Leader>j :lnext<CR>zz
nnoremap <Leader>k :lprev<CR>zz

nnoremap gd <C-]>
nnoremap gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>

"" Testing Telescope find files
nnoremap <Leader>o <cmd>Telescope git_files recurse_submodules=true<cr>
nnoremap <Leader>i <cmd>Telescope buffers<cr>
nnoremap <Leader>p <cmd>Telescope live_grep<cr>
nnoremap <Leader>t <cmd>Telescope help_tags<cr>


"" Make it so quickfix window doesn't show up in buffer list
autocmd FileType qf set nobuflisted

" Function to toggle quickfix window
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

"" Async Task/Run
nnoremap <Leader>` :call ToggleQuickFix()<CR>
nnoremap <Leader>1 :AsyncTask file-build<CR>
nnoremap <Leader>2 :AsyncTask file-run<CR>


""  Testing native LSP
lua << EOF
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Map to a key like <leader>q
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { noremap = true, silent = true })
-- Map to a different key like <leader>l
vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist, { noremap = true, silent = true })

EOF

"Open Terminal in Floating Window
let g:floaterm_keymap_toggle = '<C-t>'

"neovim terminal
tnoremap <Esc> <C-\><C-N>

"" Capital P for pasting without overwriting register
xnoremap <expr> P '"_d"'.v:register.'P'
