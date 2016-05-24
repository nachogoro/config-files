set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
" Set desertink as colorscheme.
" desert is also nice
colorscheme desertink

let mapleader = ","

" 4 spaces tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" For sanity
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

" Show unexpanded tabs as '|' and trailing spaces as '-'
set listchars=tab:\|\ ,trail:-

" Show non printable characters a '^'
set list

" Fix searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Handle long lines
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=80

" Disable arrow keys (sigh)
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" System clipboard copy and paste
"vnoremap <C-c> "*y
"noremap <C-v> "*p

" Autochange current directory to current file
set autochdir

" Open splits below and to the right
set splitright
set splitbelow

" Whitelist YCM python configuration
let g:ycm_extra_conf_globlist = ['~/projects']

" Open NERDTree with F3
noremap <F3> :vsp<return>:NERDTree<return><C-w>l<return>:set showtabline=2<return>

" Replace all occurences of word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/



