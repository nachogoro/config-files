set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'Houl/repmo-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fisadev/vim-isort'
Plugin 'nachogoro/vim-fswitch'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'python-mode/python-mode'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
" Necessary to install vim-session
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

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

set encoding=utf-8

let mapleader=","
set mouse=a
set number
set relativenumber
set tabstop=4
vmap <C-c> "+y
set showtabline=1
set shiftwidth=4
set listchars=tab:\|\ ,trail:-
set list
set splitbelow
set splitright
set cc=80
" Always show statusline
set laststatus=2
noremap <F2> :set tabstop=2<return>:set shiftwidth=2<return>:set expandtab<return>
noremap <F3> :vsp<return>:NERDTree<return><C-w>l<return>:set showtabline=2<return>
noremap <F4> :set tabstop=4<return>:set shiftwidth=4<return>:set expandtab<return>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Dark color scheme (disabled)
" colorscheme desertink

" Light color scheme
colorscheme solarized

" Autocomplete like bash
set wildmode=longest,list,full
set wildmenu

" Change directory automatically
set autochdir

" Replace word under cursor
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Necessary for NERD Commenter
filetype plugin on

" Fix search/replace
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
" Unhighlight search results and close any preview buffers
nnoremap <leader><space> :noh<cr><c-w>z<cr>
nnoremap <tab> %
vnoremap <tab> %

" Enable code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Keep undo history
set undofile
set undodir=~/.vim/undo

" Reference text between the specified delimiters with the
" <v/d/c/y><i/a><delimiter> idiom
for char in [ '_', '.', ':', ',', ';', '/', '*', '+', '%', '-' ]
  execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
  execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
  execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
  execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" In a visual selection, yank from each line until specified delimiter
xno <leader>yt <esc>:call <sid>yank_before_pattern()<cr>

fu! s:yank_before_pattern() abort
    let pattern = input('pattern: ')
    norm! '<
    if search(pattern, 'cnW', line("'>"))
        exe "norm! y'>pV']:s/".pattern.".*//\<cr>gvd:noh<cr>"
    endif
endfu

" Set ctags file
set tags=tags;/

" Shortcuts for navigating to definitions using YouCompleteMe
" Open definition in new vertical split
map <leader>ds :vsp <CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>
" Open definition in new tab
map <leader>dt :tab split<CR>:exec("YcmCompleter GoToDefinitionElseDeclaration")<CR>

" Shortcut to switch between header and source file in C/C++
map <leader>gh :FSHere<CR>


" Although ag can normally allow CtrlP to avoid caching, it's better to leave
" it enabled for large source code bases
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Fix order of ag results
if executable('matcher')
    let g:ctrlp_match_func = { 'match': 'GoodMatch' }

    function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

      " Create a cache file if not yet exists
      let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
      if !( filereadable(cachefile) && a:items == readfile(cachefile) )
        call writefile(a:items, cachefile)
      endif
      if !filereadable(cachefile)
        return []
      endif

      " a:mmode is currently ignored. In the future, we should probably do
      " something about that. the matcher behaves like "full-line".
      let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
      if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
        let cmd = cmd.'--no-dotfiles '
      endif
      let cmd = cmd.a:str

      return split(system(cmd), "\n")

    endfunction
end

" Fuzzy search in buffer
nnoremap <c-n> :CtrlPLine<CR>

" Session management
" Save current session as default
map <leader>ss :SaveSession 
" Open current session as default
map <leader>os :OpenSession 
" Do not prompt to load or save the session
let g:session_autoload = 'no'
let g:session_autosave = 'no'

" Make fugitive open vertical splits
set diffopt+=vertical

" Configure syntastic with default settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=4


" Configure Powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup


" Configure YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Display the documentation for a method using YouCompleteMe instead of pydoc
nnoremap K :YcmCompleter GetDoc<CR>


" Use ViM's old reg exp engine, since the new one is not great in some
" circumstances. Experimental change.
set regexpengine=1

" Use lazy redraw to attempt to improve scrolling speed. Experimental change
" which many people agree should be set by default.
set lazyredraw

""""""""""""""""""""""""
" Python configuration "
""""""""""""""""""""""""
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

let python_highlight_all=1
syntax on

" Add support to virtualenv in Python (detect whether we are in a virtual
" environment and if so YouCompleteMe will do smart suggestions)
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" python-mode
let g:pymode_python='python3'
" Disable rope completion, since it clashes with YouCompleteMe
let g:pymode_rope=0
let g:pymode_rope_completion=0
let g:pymode_rope_complete_on_dot=0
let g:pymode_rope_lookup_project=0

" Let syntastic run the checks for Python files when saving
let g:pymode_lint_on_write=0
" Disable preview of documentation when selecting an option from the
" autocomplete menu
set completeopt=menuone

"""""""""""""""""""""""""""""""
" End of Python configuration "
"""""""""""""""""""""""""""""""

" Flag extraneous whitespace.
" This needs to come after the Python configuration.
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.cpp,*cxx,*.h match BadWhitespace /\s\+$/

" Configuration for vim-isort
let g:vim_isort_map = ''
let g:vim_isort_python_version = 'python3'


"""""""""""""
" repmo-vim "
"""""""""""""
" map a motion and its reverse motion:
:noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
:noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l
:noremap <expr> <Up> repmo#Key('<Up>', '<Down>')|sunmap <Up>
:noremap <expr> <Down> repmo#Key('<Down>', '<Up>')|sunmap <Down>
" if you like `:noremap j gj', you can keep that:
:map <expr> j repmo#Key('gj', 'gk')|sunmap j
:map <expr> k repmo#Key('gk', 'gj')|sunmap k

" repeat the last [count]motion or the last zap-key:
:map <expr> ; repmo#LastKey(';')|sunmap ;
:map <expr> - repmo#LastRevKey('-')|sunmap -

" add these mappings when repeating with `;' or `,':
:noremap <expr> f repmo#ZapKey('f')|sunmap f
:noremap <expr> F repmo#ZapKey('F')|sunmap F
:noremap <expr> t repmo#ZapKey('t')|sunmap t
:noremap <expr> T repmo#ZapKey('T')|sunmap T
