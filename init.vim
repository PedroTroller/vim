call plug#begin('~/.vim/plugged')

Plug 'SirVer/ultisnips'
Plug 'arnaud-lb/vim-php-namespace'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'evidens/vim-twig'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'jparise/vim-graphql'
Plug 'majutsushi/tagbar'
Plug 'nanotech/jellybeans.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'phpactor/phpactor', {'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o'}
Plug 'powerline/powerline'
"Plug 'roxma/nvim-completion-manager'
Plug 'sheerun/vim-polyglot'
Plug 'sjbach/lusty'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'w0rp/ale'
Plug 'google/vim-jsonnet'

call plug#end()

set hidden
set encoding=utf-8
set fileencoding=utf-8

let mapleader=","               " Use the comma as leader
set history=1000                " Increase history
set nospell

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.
set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.
set showmatch                     " Show matching char (like {})

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Use an SCM instead of swap files

"
" Tabs & Indentation
"
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent shiftwidth=4 softtabstop=4 tabstop=4 expandtab
set smartindent
set list
set listchars=eol:↩,trail:‧,tab:>⁙
if has('gui_running')
    set listchars=eol:↩,trail:‧,tab:>⁙
endif

"
" omnicompletion
"
set completeopt=menuone

set laststatus=2                   " Show the status line all the time

autocmd BufReadPost fugitive://* set bufhidden=delete

"
" Highlight current line
"
set cursorline

"
"Change line numbers color
"
autocmd InsertEnter * hi LineNr      ctermfg=16 ctermbg=214 guifg=Orange guibg=Blue
autocmd InsertLeave * hi LineNr      term=underline ctermfg=59 ctermbg=232 guifg=#605958 guibg=#151515

autocmd BufEnter    * hi SpellCap    guisp=Orange

"
" Remove trailing whitespaces and ^M chars
"
autocmd FileType php,js,css,html,xml,yaml,vim autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

"
" Use the htmljinja syntax for twig files
"
au BufNewFile,BufRead *.twig set ft=twig
au BufNewFile,BufRead *.twig set syntax=htmljinja
au BufNewFile,BufRead *.jsonld set ft=json
au BufNewFile,BufRead *.yml.dist set ft=yaml
au BufNewFile,BufRead *.yaml.dist set ft=yaml
au BufNewFile,BufRead *.toml set ft=yaml
au BufNewFile,BufRead *.ts set ft=typescript
au BufNewFile,BufRead .env.dist set ft=sh
au BufNewFile,BufRead *.xml.twig set ft=xml
au BufNewFile,BufRead *.vue set ft=html
au BufNewFile,BufRead .php_cs* set ft=php

"
" Syntastic
"
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_enable_balloons = 1

"
" Disable folding by default
"
set nofoldenable

"
"undo
"
set undolevels=1000             " use many levels of undo

"
" Deactivate mouse!
"
set mouse-=a

"
" Interface
"

set ruler                           " Show cursor position
set number                          " Show line numbers
set notitle                         " Don't show title in console title bar
set novisualbell                    " Don't use the visual bell
set wrap                            " Wrap lineource $MYVIMRC
set showmatch                       " Show matching (){}[]

if (has('gui_running'))
    set guioptions-=m               " Remove menu bar
    set guioptions-=T               " Remove toolbar
    set guioptions-=r               " Remove right-hand scroll bar
endif

" Redraw screen
nmap <leader>r :redraw!<cr>

" Clear search highlight
nmap <silent> <leader>/ :let @/=""<cr>

" Change cursor color depending on the mode
if &term =~ "xterm"
    let &t_SI = "\<Esc>]12;orange\x7"
    let &t_EI = "\<Esc>]12;white\x7"
endif

"
" Command line
"

set wildmenu                        " Better completion
set wildmode=list:longest           " BASH style completion
set wildignore=.git,*.swp,*.jpg,*.png,*.xpm,*.gif

"
" Navigation & Viewport
"

set scrolloff=5
set sidescrolloff=5
set hidden                          " Allow switch beetween modified buffers
set backspace=indent,eol,start      " Improve backspacing

" Restore cursor position
autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Faster viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
nnoremap <C-j> 3j
nnoremap <C-k> 3k

" Faster window resizing
" vertical
nnoremap + 3<c-w>+
nnoremap 6 3<c-w>-
" horizontal
nnoremap = 3<c-w>>
nnoremap - 3<c-w><

"command mode
inoremap <S-CR> <Esc>

" paste "0, ie: before-last yanked register
nnoremap <leader>p "0p
vnoremap <leader>p "0p


cabbrev bda bufdo bd<cr>

"
" Chars
"
set encoding=utf-8

"
" Syntax & File types
"

filetype on
filetype plugin on
filetype indent on



" map for cscope

nmap <C-@>s :cscope find s <C-R>=expand("<cword>")<CR>
nmap <C-@>g :cscope find g <C-R>=expand("<cword>")<CR>
nmap <C-@>c :cscope find c <C-R>=expand("<cword>")<CR>
nmap <C-@>t :cscope find t <C-R>=expand("<cword>")<CR>
nmap <C-@>e :cscope find e <C-R>=expand("<cword>")<CR>
nmap <C-@>f :cscope find f <C-R>=expand("<cfile>")<CR>
nmap <C-@>i :cscope find i ^<C-R>=expand("<cfile>")<CR>
nmap <C-@>d :cscope find d <C-R>=expand("<cword>")<CR>


" Explore tags for the word under the cursor
"map <C-l> <C-]>
" Explore tags list for the word under the cursor OR go directly to it if only one result
map <C-l> g<C-]>
" Back to previous location after browsing tags
map <C-h> <C-T>
" Jump to next tag match
map ]t :tnext<CR>
" Jump to previous tag match
map [t :tprevious<CR>

" TagList
let g:Tlist_Ctags_Cmd = 'ctags'
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "name"

"
" Coloration
"
set t_Co=256
colorscheme jellybeans

"
" Lusty
"
map <leader>lp :LustyJugglePrevious<cr>
map <leader>lr :LustyFilesystemExplorerFromHere<cr>
let g:LustyJugglerShowKeys = 0

"
" CtrlP
"
nmap <C-p> :CtrlP
vmap <C-p> :CtrlP

"
" PHPCS
"
let &colorcolumn = join(range(81,121),",")

autocmd BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))

function! <SID>MkdirsIfNotExists(directory)
    if(!isdirectory(a:directory))
        call system('mkdir -p '.shellescape(a:directory))
    endif
endfunction

"
" easy copy-paste clipboard
"
vmap <Leader>y "+y<CR>
nmap <Leader>p "+p<CR>

"
" Tabularize
"
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a=> :Tabularize /=><CR>
vmap <Leader>a=> :Tabularize /=><CR>
nmap <Leader>a\| :Tabularize \ze/\|\zs<CR>
vmap <Leader>a\| :Tabularize \ze/\|\zs<CR>
nmap <Leader>a: :Tabularize /: \zs<CR>
vmap <Leader>a: :Tabularize /: \zs<CR>
nmap <Leader>a, :Tabularize /, \zs<CR>
vmap <Leader>a, :Tabularize /, \zs<CR>
