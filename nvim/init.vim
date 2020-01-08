""""VIM SETTINGS""""

syntax on
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

call plug#begin('~/.vim/plugged')
"Apperance
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

"Misc Tools
Plug 'vim-scripts/gitignore'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'junegunn/vim-slash'
"Plug 'w0rp/ale'

"Language Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Interface
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-clap', { 'do': function('clap#helper#build_all') }
Plug 'voldikss/vim-floaterm'

"Language specific plugs
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'wting/rust.vim', {'for': 'rust'}
Plug 'lambdatoast/elm.vim', {'for': 'elm'}
Plug 'racer-rust/vim-racer', {'for': 'rust'}
Plug 'elixir-lang/vim-elixir', {'for': 'elixir'}
Plug 'slashmili/alchemist.vim', {'for': 'elixir'}
Plug 'jelera/vim-javascript-syntax', {'for': ['javascript', 'vue']}
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'shime/vim-livedown', {'for': 'markdown'}
Plug 'cespare/vim-toml', {'for': 'toml'}

call plug#end()

""""PLUGIN SETTINGS""""

"Vista (Tags)
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1

"Floaterm
let g:floaterm_position = 'center'


""""APPERANCE""""
set termguicolors
set background=dark
colorscheme solarized8_flat

set showtabline=2 "Force tabline to always show

let g:lightline = {
            \ 'colorscheme': 'solarized',
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

"Turn relative numbering on and off
function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

""""MAPPINGS""""
let mapleader = "\<Space>"
nmap <C-l> :bn<CR>
nmap <C-h> :bp<CR>

"Jump 10 lines at a time
nmap <C-j> 10jzz
nmap <C-k> 10kzz

"nmap <C-]> :GitGutterNextHunk<CR>zz
nnoremap <S-j> :GitGutterNextHunk<CR>zz
"nmap <C-[> :GitGutterPrevHunk<CR>zz
nnoremap <S-k> :GitGutterPrevHunk<CR>zz

"Clap Skim + FZY 'Open' Files - Git Files and Local Files
nnoremap <Leader>o :Clap files<CR>
nnoremap <Leader>O :Clap gfiles<CR>

"Clap Skim + FZY - Buffer Lines and Project Lines
nnoremap <Leader>i :Clap blines<CR>
nnoremap <Leader>I :Clap lines<CR>

"Clap Skim + FZY - Buffer Tags
nnoremap <Leader>t :Clap tags<CR>

"Clap Skim + FZY - Registers
nnoremap <Leader>r :Clap registers<CR>

"Clap Skim + FZY - Marks
nnoremap <Leader>m :Clap marks<CR>

"Clap Skim + FZY - Marks
nnoremap <Leader>f :Clap quickfix<CR>

"Toggle Tagbar
nmap <F12> :Vista!!<CR>

"Open Terminal in Floating Window
let g:floaterm_keymap_toggle = '<C-t>'

"neovim terminal
tnoremap <Esc> <C-\><C-N>

"Capital P for pasting without overwriting register
xnoremap <expr> P '"_d"'.v:register.'P'


"""COC - COPIED FROM GITHUB EXAMPLE """
""" WORTH REVIEWING...

set statusline^=%{coc#status()}
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"Use Tab and S-Tab to jump though snippet
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use D for show documentation in preview window
"nnoremap <silent> D :call <SID>show_documentation()<CR>
nnoremap <C-D> :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Remap for format selected region
"vmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
