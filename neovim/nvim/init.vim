
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Manager Minpac
" 

" To install/update plugins :call InstallPlugins() 
function! InstallPlugins()
  packadd minpac
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Allows for user defined text objects
  " See here if more text objects are needed
  " https://github.com/kana/vim-textobj-user/wiki
  call minpac#add('kana/vim-textobj-user') 

  " gb for text object last pasted text.
  " Nice with comments or indents, e.g. indent pasted text "=gb"
  call minpac#add('saaguero/vim-textobj-pastedtext') 

  " f for functions in C, Java and Vimscript. May be extended for more languages.
  call minpac#add('kana/vim-textobj-function')
  call minpac#add('thinca/vim-textobj-function-javascript') " Adds JS support
  call minpac#add('bps/vim-textobj-python')                 " Adds python support
  call minpac#add('kentaro/vim-textobj-function-php')       " Adds php

  " Better paragraphs. p for paragraphs, { and } for motions.
  call minpac#add('pianohacker/vim-textobj-indented-paragraph')

  call minpac#add('mbbill/undotree')

  call minpac#add('junegunn/fzf', {'do': 'install --bin'})
  call minpac#add('junegunn/fzf.vim')

  call minpac#add('derekwyatt/vim-fswitch')

  call minpac#add('lervag/wiki.vim')

  call minpac#add('SirVer/ultisnips')
  call minpac#add('honza/vim-snippets')

  call minpac#add('dense-analysis/ale')

  call minpac#add('tpope/vim-commentary')

  call minpac#add('plasticboy/vim-markdown')
  call minpac#add('lambdalisue/suda.vim')
  call minpac#add('christoomey/vim-tmux-navigator')

  " Better syntax highlighting. Look for other languages here
  " https://github.com/sheerun/vim-polyglot
  call minpac#add('justinmk/vim-syntax-extra') " For C
  call minpac#add('jelera/vim-javascript-syntax') " Javascript
  call minpac#add('amadeus/vim-xml') " XML

  call minpac#add('chriskempson/base16-vim')

  call minpac#add('vim-vdebug/vdebug', {'type': 'opt'}) 

  call minpac#update()
  call minpac#clean()
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config
" 
set encoding=utf-8
filetype on
filetype plugin on
filetype indent on
set relativenumber
set number
set ignorecase 
set smartcase
set shiftwidth=2
set softtabstop=2
set expandtab
set clipboard^=unnamed,unnamedplus
set linebreak
set breakindent
set showbreak=>>
set foldmethod=indent
set foldlevelstart=99
set textwidth=0 wrapmargin=0
set hidden
set scrolloff=10
set wildmenu
set wildmode=full
set laststatus=0

" For motions, underscore separates words.
" For searches with * underscore does not separate words.
"set iskeyword-=_
"nnoremap * :set iskeyword+=_<cr>*:set iskeyword-=_<cr>:set hlsearch<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings particular to a file type 

augroup c_ft
  autocmd!
  " autocmd BufEnter *.h :setlocal filetype=c
augroup END

augroup cpp_ft
  autocmd!
  autocmd FileType cpp :setlocal foldmethod=syntax
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
" 

" " Training wheels: Don't use backspace repeatedly, use <c-w> or <c-h>
" " inoremap <backspace> <nop>
" nnoremap jj <nop>
" nnoremap kk <nop>
" nnoremap hh <nop>
" nnoremap ll <nop>

" Use spacebar as leader
nnoremap <space> <nop>
let mapleader=" " 

" fd instead of escape. Also clear search highlight.
nnoremap <esc> <nop>
noremap fd <esc>:noh<cr>
noremap! fd <esc>:noh<cr>
" noremap df <esc>:noh<cr>
" noremap! df <esc>:noh<cr>

" Ctrl backspace deletes one word in insert mode
" noremap! <c-backspace> bbb
" noremap! <backspace> aaa

" Ctrl+v is normally visual block mode, change to leader+v
noremap <leader>v <C-v>

" Paste and indent 
noremap <leader>p p=gb

" expand {<cr> and {<space> in insert mode 
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap {<space> { }<esc>hi 
inoremap (<space> ( )<esc>hi
inoremap [<space> [ ]<esc>hi

" Always show command history with :
" nnoremap : q:i
" vnoremap : q:i

" Navigate open buffers
nnoremap <leader>n :bn<cr>
nnoremap <leader>N :bp<cr>
nnoremap <leader>l :Buffers<cr>
nnoremap <leader>d :bd<cr>

" Folds
" Disabling this. Use zR, zr, zM, zm instead. (z reduce and z more)
" nnoremap z0 :set foldlevel=99<cr>
" nnoremap z1 :set foldlevel=0<cr>
" nnoremap z2 :set foldlevel=1<cr>
" nnoremap z3 :set foldlevel=2<cr>

" Jump to sections (functions) with [], ][, [[ and ]]. See :h []
nnoremap [[ ?{<CR>w99[{(
nnoremap ]] ][j/{<CR>(
nnoremap ][ /}<CR>b99]}
nnoremap [] k$][%?}<CR>

" Increment and decrement numbers
nnoremap <leader>a <c-a>
nnoremap <leader>x <c-x>
vnoremap g<leader>a g<c-a>
vnoremap g<leader>x g<c-x>

" This one is useful for splitting strings into array items. Ex:
" foo = 'a b c d'
" into
" foo = ['a', 'b', 'c', 'd']
nnoremap <leader>s F'i<return><esc>A<return><esc>kV:s/ /', '/g<return>I[<esc>A]<esc>kJ:noh<return>

" Surround a word in C++ comments. Useful for parameter names in functions.
nnoremap gciw <right>bi/* <esc>ea */<esc>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctags
"
" Generate tags manually, externally, with something like 
" `ctags --recurse -languages=c --languages=c++ ./` 
"
" Or, see the automatic git hooks I set up for this in
" ~/Config/git/gittemplate/hooks
" Explained here: https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html

" Jump to tag under cursor with <c-[> or g<c-[>, use [t and ]t to jump to other
" occurences. Also :tag <keyword> is useful

" Look for tags file in file directory or current directory
" set tags=./tags,tags,/home/rvg/tags
set tags=./tags,tags

nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
nnoremap <silent> [T :tfirst<CR>
nnoremap <silent> ]T :tlast<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocompletion

" Completion case sensitive, other things like search in file stay case
" insensitive. 
au InsertEnter * set noignorecase
au InsertLeave * set ignorecase

set completeopt=menu,longest


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom text objects
" 

" call minpac#add('libclang-vim/libclang-vim')
" call minpac#add('libclang-vim/vim-textobj-function-clang')        " C++ (not
" working, could not figure out how to add mappings.


" I changed this in pack/minpac/start/vim-textobj-indented-paragraph/plugin/indented-paragraph.vim 
" to get the normal paragraph mappings instead of the unfamiliar ones defined in the plugin.
"
" call textobj#user#plugin('indentedparagraph', {
" \   '-': {
" \     'select-a-function': 'indented_paragraph#SelectA',
" \     'select-a': 'ap',
" \     'select-i-function': 'indented_paragraph#SelectI',
" \     'select-i': 'ip',
" \     'move-n-function': 'indented_paragraph#MoveN',
" \     'move-n': '}',
" \     'move-p-function': 'indented_paragraph#MoveP',
" \     'move-p': '{',
" \   },
" \ })

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo history
"

set undofile
autocmd BufWritePre /tmp/* setlocal noundofile
nnoremap <leader>z :UndotreeToggle<cr>

"" Another option is vim-undo (commented out below). Better search in history of file but not working
"" last time I checked.

" call minpac#add('simnalamburt/vim-mundo')
" autocmd BufWritePre /tmp/* setlocal noundofile
" nnoremap <leader>z :MundoToggle<cr>
" let g:mundo_prefer_python3 = 1
" let g:mundo_auto_preview_delay = 1000


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy Finder
" 

" TODO: Explore! There are a lot of interesting commands in this plugin. 
" For now, only <leader>t for opening files.
" https://github.com/junegunn/fzf.vim

nmap <leader>t :Files<cr>
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)<Paste>
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
let g:fzf_preview_window = []

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump between c and h (companion) files.
" 

nnoremap <leader>h :call FSwitch('%', '')<cr>
"autocmd BufEnter *.c let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,ifrel:|/src/|../include|'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line wrapping and vertical movement as a word processor.
" Better for writing text, not code.

" :call WordProcessorMode()

function! WordProcessorMode()
  setlocal formatoptions=1
  setlocal showbreak=
  map <buffer> j gj
  map <buffer> k gk
  map <buffer> $ g$
  map <buffer> ^ g^
  map <buffer> 0 g0
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" WIKI
"" Wiki.vim keeps to-do lists, notes, etc.
"" <leader>ww

let g:wiki_root = '/home/Rafa/wiki'
let g:wiki_link_target_type = 'md'

" let g:wiki_mappings_global = {
"       \ '<plug>(wiki-list-toggle)' : '<leader>x',
" \}

function! FoldLevel99(timer)
  setlocal foldlevel=99
endfunction

augroup markdfown_ft
  autocmd!
  autocmd BufEnter *.md :call WordProcessorMode()
  " autocmd BufEnter *.md :call timer_start(100, 'FoldLevel99', {'repeat':1}) 
augroup END

augroup wiki_ft
  autocmd!
  autocmd BufEnter *.wiki :setlocal filetype=markdown
  autocmd BufEnter *.wiki :setlocal conceallevel=1
  autocmd BufEnter *.wiki :call WordProcessorMode()
  " autocmd BufEnter *.wiki :call timer_start(100, 'FoldLevel99', {'repeat':1}) 
  autocmd BufEnter *.wiki inoremap <buffer> [<space> [ ]<space>
augroup END

" Open file links with xdg-open
let g:wiki_file_open = 'WikiFileOpen'
function! WikiFileOpen(...) abort dict
  silent execute '!xdg-open' fnameescape(self.path) '&'
  return 1
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE Plugin provides integration with outside tools such as language servers,
" linters and fixers and gives you a bunch of things. I'm using it to show
" compiler errors (linting) and automatic code formating (fixing). 
" :lopen
" <leader>f
"

let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'c': ['clangd'],
      \ 'cpp': ['clangd'],
      \'json': ['prettier'],
      \ }
" \'php': ['phpcs']
" \'python': ['pycodestyle'],
" \'javascript': ['eslint']

let g:ale_fixers = {
      \'c': ['clang-format'],
      \'cpp': ['clang-format'],
      \'json': ['prettier'],
      \'html': ['prettier'],
      \'python': ['yapf'],
      \'php': ['php_cs_fixer'],
      \'xml': ['xmllint']
      \}
" \'javascript': ['eslint']

" let g:ale_javascript_eslint_use_global = 1
" let g:ale_python_pycodestyle_options = '--max-line-length=115'
" let g:ale_python_autopep8_options = '--max-line-length 115'

" This might be useful when working with non C file types?
" set omnifunc=ale#completion#OmniFunc 

nmap <leader>f :ALEFix<cr>
nmap <leader>e :lopen<cr>

" Style for error markers
let g:ale_set_highlights = 0
let g:ale_sign_error = ' x'
let g:ale_sign_warning = ' !'
let g:ale_sign_info= ' i'
hi link ALEErrorSign cComment
hi link ALEWarningSign cComment
hi link ALEInfoSign cComment

" Jump around with ALE
nmap <leader>j :ALEGoToDefinition<cr>
nmap <leader>k :ALEFindReferences<cr>

let g:ale_php_phpcs_standard='PSR12'
let g:ale_php_cs_fixer_options='--rules=@PSR12'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle Comments.
"
" In normal mode use "gc" with movemments or "gcc" for current line.
" e.g: "gcp" toggles comments for a paragraph
" In visual mode, select and then do "gc"

" Comment current line or selection
" nmap <leader>c gcc
" vmap <leader>c gc

" augroup Apache
"    autocmd!
"    autocmd FileType apache setlocal commentstring=#\ %s
" augroup END

augroup c_ftft
   autocmd!
   autocmd FileType c :setlocal commentstring=//\ %s
   autocmd FileType cpp :setlocal commentstring=//\ %s
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ask for sudo password
" 
"cnoremap ee e suda://%
cnoremap ww w suda://%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Integration with tmux
" 
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-a>h :TmuxNavigateLeft<cr>
nnoremap <silent> <c-a>j :TmuxNavigateDown<cr>
nnoremap <silent> <c-a>k :TmuxNavigateUp<cr>
nnoremap <silent> <c-a>l :TmuxNavigateRight<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use TMUX clipboard instead of X11 clipboard. 
" This is useful for remote ssh+tmux sessions.
" 
" Use this only in remote machines. It breaks linewise pasting as described
" in https://github.com/roxma/vim-tmux-clipboard/issues/4 but it's still
" useful for remote ssh+tmux sessions.

" call minpac#add('roxma/vim-tmux-clipboard')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
" 
syntax enable
set background=dark
let base16colorspace=256
colorscheme base16-monokai

" Change colors of the leftmost column (left of linenumbers)
highlight SignColumn ctermfg=240 ctermbg=0
highlight ShowmarksHLl ctermfg=240 ctermbg=0
highlight ShowmarksHLu ctermfg=240 ctermbg=0
highlight ShowmarksHLo ctermfg=240 ctermbg=0
highlight ShowmarksHLm ctermfg=240 ctermbg=0

" Change colors of folds
highlight Folded ctermfg=240 ctermbg=0

" Change color of line numbers
highlight LineNr ctermfg=240 ctermbg=0

" " Change color of comments
" highlight Comment ctermfg=4

" " Show a colored column
" set colorcolumn=68
" highlight ColorColumn ctermbg=0

" F10 to show syntax group of current word. Useful when setting up colors or highlighting.
" map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
" \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP Debugger
" :packadd vdebug to enable the plugin and then <f5> to listen for
" connections. You'll need to change mappings below for projects that use
" remote debugger (docker containers for example).

let g:vdebug_options = {
\   'path_maps': {
\        "/var/1rpm/source/source": "/home/Rafa/Projects/Active/OneRPM/repos/onerpm-legacy/source",
\        "/var/www/": "/home/Rafa/Projects/Active/OneRPM/repos/onerpm-api",
\   },
\}

