"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   ________         _
"  |  ____  \   _   | |
"  | |____) |  (_)  | |   _
"  |  ______/   _   | |__/ /   _____
"  | |         | |  |  _  /   /  _  \
"  | |         | |  | | \ \  |  (_)  \
"  |_|         |_|  |_|  \_\  \____/\_\
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: LeoMao
"
" Version: 5.5.0
"
" Sections:
"    -> Map leader settings
"    -> Plugin Settings
"    -> General
"    -> VIM UI
"    -> Colors and Fonts
"    -> Files, backups and undo
"    -> Text, tab and indent related
"    -> Fold Settings
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Tags
"    -> Key mappings
"    -> Cope
"    -> Language section
"    -> grep
"    -> MISC
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => General {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500
" shell
set shell=$SHELL
"set shell=/bin/bash

" compatibility for vim and neovim
if !has('nvim')
  set nocompatible
  " set term inside tmux for xterm-key on (nvim doesn't need this)
  if &term =~ '^screen\|^tmux' && exists('$TMUX')
    if &term =~ '256color'
      set term=xterm-256color
    else
      set term=xterm
    endif
  endif
  if &term =~ '256color'
    set t_ut=
  endif
  if exists('$TMUX')
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
  endif
endif

" True color support
" If your terminal doesn't support true color,
" set notermguicolors in your local.vim
if has('termguicolors')
  set termguicolors
endif

" Neovim settings
" let g:python3_host_prog = '/usr/bin/python3'

" Enable filetype plugin (called by vim-plug)
"filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

" Clear auto cmd for reload vimrc
autocmd!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Map leader settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set map leader to ' '
let mapleader = ' '
let maplocalleader = ' '
let g:mapleader = ' '
let g:maplocalleader = ' '
runtime custom/leader.vim
" }}}
" => Plugin settings {{{
""""""""""""""""""""""""""""""
" include matchit plugins in vim
if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

" --- vim-plug plugin --- {{{
execute plug#begin()

" NOTE:
" - leomao/lightline-pika is my personal settings.

Plug 'cakebaker/scss-syntax.vim', { 'for': [ 'scss', 'sass' ] }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', { 'for' : 'go' }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'itchyny/lightline.vim'
Plug 'jlanzarotta/bufexplorer'
if !filereadable('/usr/share/vim/vimfiles/plugin/fzf.vim')
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'leomao/lightline-pika'
Plug 'leomao/pikacode.vim'
Plug 'leomao/python-syntax', { 'for': 'python' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'css' ] }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mxw/vim-jsx', { 'for': [ 'javascript', 'javascript.jsx', 'html' ] }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'javascript.jsx', 'html' ] }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'scrooloose/nerdcommenter'
Plug 'szw/vim-tags'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/OmniCppComplete', { 'for': 'cpp' }
Plug 'wavded/vim-stylus', { 'for': 'stylus' }

Plug 'Houl/repmo-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

" syntax checker

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
 Plug 'Shougo/deoplete.nvim'
 Plug 'roxma/nvim-yarp'
 Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" Python autocompletion
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

Plug 'patstockwell/vim-monokai-tasty'


" Linters
Plug 'neomake/neomake'

Plug 'dense-analysis/ale'



"include custom plugin
runtime custom/plugin.vim

execute plug#end()
" }}}

" --- netrw plugin (built-in) --- {{{
let g:netrw_liststyle = 3
let g:netrw_altv = 1
" }}}

" --- fzf plugin --- {{{
nnoremap <leader>f <ESC>:FZF<CR>
nnoremap <leader>bf <ESC>:Buffers<CR>

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" }}}

" --- editorconfig plugin --- {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" }}}

" --- Buffer plugin --- {{{
let g:bufExplorerSortBy = 'name'
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerShowNoName = 1
" }}}

" --- Tagbar plugin --- {{{
nnoremap <silent> <leader>tb :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 25
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 0
" }}}

" --- vim tags plugin --- {{{
let g:vim_tags_use_language_field = 1
let g:vim_tags_project_tags_command = '{CTAGS}
      \ -R --c++-kinds=+pl --python-kinds=-i --fields=+iaS --extra=+q
      \ {OPTIONS} {DIRECTORY} 2>/dev/null'
" }}}

" --- vimtex --- {{{
let g:vimtex_fold_enabled = 0
let g:vimtex_imaps_leader = ';'
let g:vimtex_quickfix_latexlog = {
      \ 'overfull' : 0,
      \ 'underfull' : 0,
      \ 'specifier changed to' : 0,
      \ 'xparse/redefine-command' : 0,
      \ 'script-not-exist' : 0,
      \ }
" }}}

" --- NERD Commenter plugin --- {{{
let g:NERDSpaceDelims = 0
let g:NERDRemoveExtraSpaces = 1
"let g:NERDCreateDefaultMappings = 0
"map <leader>cc <plug>NERDCommenterComment
"map <leader>cu <plug>NERDCommenterUncomment
"map <leader>c<space> <plug>NERDCommenterToggle
" }}}

" --- undotree plugin --- {{{
noremap <silent><F5> <ESC>:UndotreeToggle<CR>
" }}}

" --- Omni complete functions --- {{{
set completeopt=menuone
set omnifunc=syntaxcomplete#Complete

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete

" }}}

" --- Emmet --- {{{
" let g:user_zen_leader_key = '<c-m>'
let g:user_emmet_install_global = 0
au Filetype html,css EmmetInstall
" }}}

" --- lightline --- {{{
let g:lightline = {
      \ 'colorscheme': 'pikacode'
      \ }
let g:lightline_pika_patchfont = {
      \ 'leftsep': "\ue0b0",
      \ 'leftsubsep': "\ue0b1",
      \ 'rightsep': "\ue0b2",
      \ 'rightsubsep': "\ue0b3",
      \ 'branch': "\ue0a0",
      \ 'linecolumn': "\ue0a1",
      \ 'readonly': "\ue0a2",
      \ }
" }}}

" --- vim-go --- {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" }}}

" --- deoplete.nvim --- {{{
" Use deoplete.
" " needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview
"
" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\   'ignore_case': v:true,
\   'smart_case': v:true,
\})
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

set t_Co=256

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0
"let g:neosnippet#enable_completed_snippet = 1
"let g:deoplete#sources#jedi#show_docstring = 1



" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>
"let g:deoplete#sources = {}
"let g:deoplete#sources._ = []
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => VIM UI {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical
set so=7
set wildignorecase
set wildmenu "Turn on WiLd menu
set guitablabel=%t
" stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~,*.synctex.gz,*.pdf

" let alt key can be mapped
set winaltkeys=no
set ruler "Always show current position

if has('gui_running')
  set guioptions-=T "remove toolbar
  set guioptions-=m "remove menubar
  set guioptions-=r "remove scrollbar
endif

" line number will be highlighted if set rnu
"set cursorline " highlight current line *Slow*
set cmdheight=1 " The commandbar height
"set showcmd " display what command was typed
set noshowmode " display current mode

set nu " line number
set rnu " line number (relative number)
set hid " Change buffer - without saving
" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,[,],h,l
" the cursor can be positioned where there is no actual character
" in the visual mode.
set virtualedit=block

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros
set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=0 "How many tenths of a second to blink
" time out of mappings
set timeout
set ttimeoutlen=10
" No sound on errors
set novisualbell
set noerrorbells
set tm=500

set mouse=a
if !has('nvim')
  set t_vb=
  set ttymouse=xterm2
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Colors, Fonts, Encoding {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on " Enable syntax highlight
set background=dark
colorscheme pikacode
" Set font according to system
if has('gui_running')
  if has('win32') || has('win64')
    set gfn=Consolas:h16
  else
    set gfn=Monospace\ 16
  endif
endif
set fileencodings=utf8
set encoding=utf8
" format options
set fo+=Mm " for multi btye character
set fo+=crql
set fo-=t
set ffs=unix,dos,mac " Default file types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Files, backups and undo {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

" Persistent undo
if has('persistent_undo')
  set undodir=$HOME/.vim/.undodir
  set undofile
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Text, tab and indent related {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab

set cino+=g0.5s,h0.5s,(0,W2s

" line break on 80 characters
set tw=80
" color column after 'textwidth'
set colorcolumn=+1

set ai "Auto indent
set wrap " wrap lines
"set nowrap " don't wrap lines
" set si " set smart indent
set listchars=trail:~,precedes:<,extends:>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Fold Settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable
set foldlevelstart=10
set fdm=syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Visual mode related {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Really useful!
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

vnoremap <silent> * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
vnoremap <silent> @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Command mode related {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set current path when vim start
autocmd VimEnter * cd %:p:h
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Moving around, windows, tabs and buffers {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0
noremap 0 ^

" Treat long lines as break lines (useful when moving around in them)
function! ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
  else
    echo "Wrap ON"
    setlocal wrap
    setlocal display+=lastline
  endif
"  call SetWrapKeyMapping()
endfunction
"
"function! SetWrapKeyMapping()
"  if &wrap
"    nnoremap  <buffer> <silent> k gk
"    nnoremap  <buffer> <silent> j gj
"    nnoremap  <buffer> <silent> 0 g^
"    nnoremap  <buffer> <silent> $ g$
"    nnoremap  <buffer> <silent> <Up>   gk
"    nnoremap  <buffer> <silent> <Down> gj
"    nnoremap  <buffer> <silent> <Home> g<Home>
"    nnoremap  <buffer> <silent> <End>  g<End>
"    inoremap <buffer> <silent> <Up>   <Esc>gka
"    inoremap <buffer> <silent> <Down> <Esc>gja
"    inoremap <buffer> <silent> <Home> <Esc>g<Home>i
"    inoremap <buffer> <silent> <End>  <Esc>g<End>a
"    onoremap <buffer> <silent> j gj
"    onoremap <buffer> <silent> k gk
"  else
"    silent! nunmap <buffer> k
"    silent! nunmap <buffer> j
"    silent! nunmap <buffer> 0
"    silent! nunmap <buffer> $
"    silent! nunmap <buffer> <Up>
"    silent! nunmap <buffer> <Down>
"    silent! nunmap <buffer> <Home>
"    silent! nunmap <buffer> <End>
"    silent! iunmap <buffer> <Up>
"    silent! iunmap <buffer> <Down>
"    silent! iunmap <buffer> <Home>
"    silent! iunmap <buffer> <End>
"    silent! ounmap <buffer> j
"    silent! ounmap <buffer> k
"  endif
"endfunction
"
"au BufRead,BufNewFile * call SetWrapKeyMapping()
noremap <silent><F3> :call ToggleWrap()<CR>

inoremap <C-l> <Del>

nnoremap <C-down>  <C-w>j
nnoremap <C-left>  <C-w>h
nnoremap <C-right> <C-w>l
nnoremap <C-up>    <C-w>k

nnoremap <leader>bd :bd<CR>
nnoremap <leader>bp :bp<CR>
nnoremap <leader>bn :bn<CR>

" don't jump to the begin of the line
set nosol

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Statusline {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the statusline
set laststatus=2

" Format the statusline
"set statusline=\ %f%m%r%h\ %w\ %=%y\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}\ %3l/%4L:%3c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Tags {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au Filetype cpp setl tags+=~/.vim/tags/cpptags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Key mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<F2>

" increase and decrease number under the cursor
nnoremap + <C-a>
nnoremap - <C-x>

set clipboard+=unnamed

" Move lines of text using CTRL+[jk]
nnoremap <C-j> :m+<CR>:echo "move line down"<CR>
nnoremap <C-k> :m-2<CR>:echo "move line up"<CR>
vnoremap <C-j> :m'>+<CR>:echo "move block down"<CR>gv
vnoremap <C-k> :m'<-2<CR>:echo "move block up"<CR>gv

nnoremap <silent><leader>/ :nohl<CR>

" left hand esc
nnoremap <C-e> <ESC>
inoremap <C-e> <ESC>
vnoremap <C-e> <ESC>
snoremap <C-e> <ESC>

" smarter command line
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Fast saving
nnoremap <leader>w :w!<CR>
" save with sudo
command! -nargs=0 Wsudo :w !sudo tee > /dev/null %

noremap <silent><F9> <ESC>:wa!<CR>:make<CR><CR>:cw<CR>

" check the syntax group under the cursor
function! ShowHiGroup()
  echo 'hi<' . synIDattr(synID(line('.'),col('.'),1),'name') . '> trans<'
    \ . synIDattr(synID(line('.'),col('.'),0),'name') . '> lo<'
    \ . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . '>'
endfunction
noremap <S-F7> :call ShowHiGroup()<CR>
" workaround for neovim
noremap <F19> :call ShowHiGroup()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Cope {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
noremap <silent><F8> <ESC>:call QFSwitch()<CR>
function! QFSwitch()
  redir => ls_output
  execute ':silent! ls'
  redir END

  let exists = match(ls_output, '[Quickfix List')
  if exists == -1
    execute ':copen'
  else
    execute ':cclose'
  endif
endfunction

noremap <silent><leader>cn :cn<CR>
noremap <silent><leader>cp :cp<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Language section {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" --- python --- {{{
let python_highlight_all = 1
let python_no_parameter_highlight = 1
" }}}
" --- latex --- {{{
let g:tex_flavor = 'latex'
let g:tex_fast = 'Mm'
" }}}
" --- haskell --- {{{
let hs_highlight_boolean = 1
let hs_highlight_types = 1
" }}}
" --- bison/yacc --- {{{
let g:yacc_uses_cpp = 1
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}
" => Load custom settings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime custom/local.vim
" }}}
" vim:fdm=marker:foldlevel=0

""""""""""""""
" Added my own config after this
""""""""""""""
" map leader+qq force leave
nmap <leader>qq :q!<CR>


" Repmo  ---------------------------------------------
" map a motion and its reverse motion:
:noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
:noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l

" if you like `:noremap j gj', you can keep that:
:noremap <expr> j repmo#Key('gj', 'gk')|sunmap j
:noremap <expr> k repmo#Key('gk', 'gj')|sunmap k

" repeat the last [count]motion or the last zap-key:
:map <expr> ; repmo#LastKey(';')|sunmap ;
:map <expr> , repmo#LastRevKey(',')|sunmap ,

" add these mappings when repeating with `;' or `,':
:noremap <expr> f repmo#ZapKey('f')|sunmap f
:noremap <expr> F repmo#ZapKey('F')|sunmap F
:noremap <expr> t repmo#ZapKey('t')|sunmap t
:noremap <expr> T repmo#ZapKey('T')|sunmap T

""""""""""""""""""""""""""""""
" nerdcommenter
""""""""""""""""""""""""""""""
let g:NERDCreateDefaultMappings = 0
nmap <C-c> <plug>NERDCommenterToggle
vmap <C-c> <plug>NERDCommenterToggle gv

""""""""""""""""""""""""""""""
" NERDTree setting
""""""""""""""""""""""""""""""
nmap <leader>t :NERDTreeToggle<CR>
" let NERDTreeWinSize = 23

""""""""""""""""""""""""""""""
" clipboard for vim in different tmux panels
""""""""""""""""""""""""""""""
" copy to buffer
vmap <leader>c :w! ~/.vimbuffer<CR>
nmap <leader>c :.w! ~/.vimbuffer<CR>
" paste from buffer
map <leader>v :r ~/.vimbuffer<CR>

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost * Neomake

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'

" Disable error messages inside the buffer, next to the problematic line
let g:neomake_virtualtext_current_error = 0
"call neomake#configure#automake('nrwi', 500)
let g:neomake_open_list = 2

" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>


let using_neovim = has('nvim')
" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
    colorscheme vim-monokai-tasty
else
    colorscheme delek
endif
