
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

" Folds in markdown files
function MarkdownLevel()
   let h = matchstr(getline(v:lnum), '^#\+')
   if empty(h)
      return "="
   else
      return ">" . len(h)
   endif
endfunction

augroup markdfown_ft
  autocmd!
  autocmd BufEnter *.md setlocal foldexpr=MarkdownLevel()
  autocmd BufEnter *.md setlocal foldmethod=expr
  autocmd BufEnter *.md :call WordProcessorMode()<cr>
augroup END

augroup c_ft
  autocmd!
  "autocmd FileType c setlocal omnifunc=ale#completion#OmniFunc
  autocmd BufEnter *.h :setlocal filetype=c
augroup END

augroup wiki_ft
  autocmd!
  autocmd BufEnter *.wiki inoremap [<space> - [ ] 
  autocmd BufEnter *.wiki nnoremap <leader>x :VimwikiToggleListItem<cr>
  autocmd BufEnter *.wiki :call WordProcessorMode()<cr>
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jump between c and h (companion) files.
" 
call minpac#add('derekwyatt/vim-fswitch')
nnoremap <leader>h :call FSwitch('%', '')<cr>


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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WIKI
" Vimwiki keeps to-do lists, notes, etc.
" <leader>ww
call minpac#add('vimwiki/vimwiki')
let g:vimwiki_list = [ { 'path': '/home/Rafa/wiki' } ]
let g:vimwiki_folding = 'expr'


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
      \'python': ['flake8'],
      \'json': ['prettier']
      \ }

let g:ale_fixers = {
      \'c': ['clang-format'],
      \'python': ['yapf'],
      \'json': ['prettier']
      \}


"     \'c': ['clangtidy'],
"let g:ale_c_clangtidy_checks = ['readability-braces-around-statements']

let g:ale_c_clangformat_options = '-style=file'

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
call minpac#add('roxma/vim-tmux-clipboard')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folds for markdown files
" 
function MarkdownLevel()
   let h = matchstr(getline(v:lnum), '^#\+') 
   if empty(h) 
      return "=" 
   else 
      return ">" . len(h) 
   endif 
endfunction
au BufEnter *.md setlocal foldexpr=MarkdownLevel()  
au BufEnter *.md setlocal foldmethod=expr 
>>>>>>> dd4c8fb40b32181bad61229d671444e2fb73f4af

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

