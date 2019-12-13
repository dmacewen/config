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
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
"Plug 'bling/vim-bufferline'
"Plug 'morhetz/gruvbox'

"Misc
Plug 'vim-scripts/gitignore'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
"Plug 'w0rp/ale'

"Code Selection/Navigation
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/vim-slash'
"Plug 'kassio/neoterm'

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

"Experimental
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-clap'
call plug#end()

""""PLUGIN SETTINGS""""

"let g:airline#extensions#tabline#enabled = 1

"Vista (Tags)
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 1


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

"Clap Skim + FZY 'Open' Files - Git Files and Local Files
nnoremap <Leader>o :Clap gfiles<CR>
nnoremap <Leader>O :Clap files<CR>

"Clap Skim + FZY - Buffer Lines and Project Lines
nnoremap <Leader>i :Clap blines<CR>
nnoremap <Leader>I :Clap lines<CR>

"Clap Skim + FZY - Buffer Tags
nnoremap <Leader>t :Clap tags<CR>

"Clap Skim + FZY - Registers
nnoremap <Leader>r :Clap registers<CR>

"Clap Skim + FZY - Marks
nnoremap <Leader>m :Clap marks<CR>

"Toggle Tagbar
nmap <C-t> :Vista!!<CR>

"neovim terminal
tnoremap <Esc> <C-\><C-N>

"Capital P for pasting without overwriting register
xnoremap <expr> P '"_d"'.v:register.'P'

"Open Terminal to Python
nnoremap <silent> <f12> :terminal python3<CR>

"""COC - COPIED FROM GITHUB EXAMPLE """

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

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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


" Using CocList
" Show all diagnostics
"nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
"nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
"nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
"nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
"nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
"nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
"nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
"nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
