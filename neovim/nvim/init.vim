
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Manager Minpac
" 
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Config
" 
set encoding=utf-8
filetype on
filetype plugin on
filetype indent on
set relativenumber
set number
set textwidth=70
set ignorecase 
set smartcase
set shiftwidth=2
set softtabstop=2
set expandtab
set clipboard^=unnamed,unnamedplus
set linebreak
set breakindent
set showbreak=>
set foldmethod=indent
set foldlevelstart=99
set textwidth=0 wrapmargin=0
set hidden
set scrolloff=10
set wildmenu
set wildmode=full
set completeopt=menu,preview,longest
set tags=./tags;

" For motions, underscore separates words.
" For searches with * underscore does not separate words.
"set iskeyword-=_
"nnoremap * :set iskeyword+=_<cr>*:set iskeyword-=_<cr>:set hlsearch<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings particular to a file type 
" 


augroup c_ft
  autocmd!
  "autocmd FileType c setlocal omnifunc=ale#completion#OmniFunc
  autocmd BufEnter *.h :setlocal filetype=c
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
" 
" Use spacebar as leader
nnoremap <space> <nop>
let mapleader=" " 

" fd instead of escape. Also clear search highlight.
nnoremap <esc> <nop>
noremap fd <esc>:noh<cr>
noremap! fd <esc>:noh<cr>
" noremap df <esc>:noh<cr>
" noremap! df <esc>:noh<cr>

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
nnoremap z0 :set foldlevel=99<cr>
nnoremap z1 :set foldlevel=0<cr>
nnoremap z2 :set foldlevel=1<cr>
nnoremap z3 :set foldlevel=2<cr>

" Jump to sections (functions) with [], ][, [[ and ]]. See :h []
nnoremap [[ ?{<CR>w99[{(
nnoremap ]] ][j/{<CR>(
nnoremap ][ /}<CR>b99]}
nnoremap [] k$][%?}<CR>

" Increment and decrement numbers
nnoremap <leader>= <c-a>
nnoremap <leader>- <c-x>

" This one is useful for splitting strings into array items. Ex:
" foo = 'a b c d'
" into
" foo = ['a', 'b', 'c', 'd']
nnoremap <leader>s F'i<return><esc>A<return><esc>kV:s/ /', '/g<return>I[<esc>A]<esc>kJ:noh<return>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom text objects
" 

" Allows for user defined text objects
" See here if more text objects are needed
" https://github.com/kana/vim-textobj-user/wiki
call minpac#add('kana/vim-textobj-user') 

" gb for text object last pasted text.
" Nice with comments or indents, e.g. indent pasted text "=gb"
call minpac#add('saaguero/vim-textobj-pastedtext') 

" f for functions in C, Java and Vimscript. May be extended for more languages.
call minpac#add('kana/vim-textobj-function')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo history
"
call minpac#add('simnalamburt/vim-mundo')
set undofile
autocmd BufWritePre /tmp/* setlocal noundofile
nnoremap <leader>z :MundoToggle<cr>
let g:mundo_prefer_python3 = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy Finder
" 

" TODO: Explore! There are a lot of interesting commands in this plugin. 
" For now, only <leader>t for opening files.
" https://github.com/junegunn/fzf.vim

call minpac#add('junegunn/fzf', {'do': 'install --all'})
call minpac#add('junegunn/fzf.vim')
nmap <leader>t :Files<cr>
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)<Paste>
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
let g:fzf_preview_window = 'right:50%'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump between c and h (companion) files.
" 

call minpac#add('derekwyatt/vim-fswitch')
nnoremap <leader>h :call FSwitch('%', '')<cr>
"autocmd BufEnter *.c let b:fswitchlocs = 'reg:/src/include/,reg:|src|include/**|,ifrel:|/src/|../include|'

" call minpac#add('ericcurtin/CurtineIncSw.vim')
" nnoremap <leader>h :call CurtineIncSw()<cr>

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

call minpac#add('lervag/wiki.vim')
let g:wiki_root = '/home/Rafa/wiki'
let g:wiki_link_target_type = 'md'

let g:wiki_mappings_global = {
      \ '<plug>(wiki-list-toggle)' : '<leader>x',
      \}

function! FoldLevel99(timer)
  setlocal foldlevel=99
endfunction

augroup markdfown_ft
  autocmd!
  autocmd BufEnter *.md :call WordProcessorMode()
  autocmd BufEnter *.md :call timer_start(100, 'FoldLevel99', {'repeat':1}) 
augroup END

augroup wiki_ft
  autocmd!
  autocmd BufEnter *.wiki :setlocal filetype=markdown
  autocmd BufEnter *.wiki :call WordProcessorMode()
  autocmd BufEnter *.wiki :call timer_start(100, 'FoldLevel99', {'repeat':1}) 
  autocmd BufEnter *.wiki inoremap <buffer> [<space> [ ]<space>
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE Plugin provides integration with outside tools such as clang-format
" and gives you omnicompletion <c-x><x-o>, Show errors :lopen, 
" format code <leader>f, jump to definitions <leader>j, and more.
"
call minpac#add('dense-analysis/ale')

let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'c': ['clangd'],
      \'python': ['pycodestyle'],
      \'json': ['prettier']
      \ }

let g:ale_fixers = {
      \'c': ['clang-format'],
      \'cpp': ['clang-format'],
      \'python': ['autopep8'],
      \'json': ['prettier']
      \}

"let g:ale_c_clangformat_options = '-style=file'
let g:ale_python_pycodestyle_options = '--max-line-length=115'
let g:ale_python_autopep8_options = '--max-line-length 115'

nmap <leader>f :ALEFix<cr>

nmap <leader>j :ALEGoToDefinition<cr>

nmap <leader>k :ALEFindReferences<cr>

nmap <leader>e :lopen<cr>

" Style for error markers
let g:ale_set_highlights = 0
let g:ale_sign_error = ' x'
let g:ale_sign_warning = ' !'
let g:ale_sign_info= ' i'
hi link ALEErrorSign cComment
hi link ALEWarningSign cComment
hi link ALEInfoSign cComment

" Maybe set this for python and other ale enabled languages?
" set omnifunc=ale#completion#OmniFunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete 
"

" call minpac#add('Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'})
" let g:deoplete#enable_at_startup = 1
" set completeopt-=preview

" I'm using vim's builtin completion engine. I like it to be case sensitive
" but other things like search in file stay case insensitive. 
au InsertEnter * set noignorecase
au InsertLeave * set ignorecase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle Comments.
"
" In normal mode use "gc" with movemments or "gcc" for current line.
" e.g: "gcp" toggles comments for a paragraph
" In visual mode, select and then do "gc"
call minpac#add('tpope/vim-commentary')

" Comment current line or selection
" nmap <leader>c gcc
" vmap <leader>c gc

" augroup Apache
"    autocmd!
"    autocmd FileType apache setlocal commentstring=#\ %s
" augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Better support for markdown files
" 
call minpac#add('plasticboy/vim-markdown')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ask for sudo password
" 
call minpac#add('lambdalisue/suda.vim')
"cnoremap ee e suda://%
cnoremap ww w suda://%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Integration with tmux
" 
call minpac#add('christoomey/vim-tmux-navigator')
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
"
" call minpac#add('roxma/vim-tmux-clipboard')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Better syntax highlighting. Look for other languages here
" https://github.com/sheerun/vim-polyglot
" 

" For C
call minpac#add('justinmk/vim-syntax-extra')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
" 
call minpac#add('chriskempson/base16-vim')
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

