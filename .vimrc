" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                  " required

" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
source ~/.vimrc.before
endif

"========================== Vundle ============================

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" endwise to add the keyword end automatically in Ruby
Plugin 'tpope/vim-endwise'

" fuzzy file search
Plugin 'kien/ctrlp.vim'

" fuzzy file search and more with fzf
Plugin 'junegunn/fzf', { 'do': { -> fzf#install()}}
Plugin 'junegunn/fzf.vim'

" NERDTree
Plugin 'preservim/nerdtree'

"ag.vim
Plugin 'rking/ag.vim'

" vim syntax highlight for slim
Plugin 'slim-template/vim-slim'

" Tomorrow color theme
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

" Buffergator for managing buffers
Plugin 'jeetsukumaran/vim-buffergator' 

" Elixir syntax highlighting
Plugin 'elixir-editors/vim-elixir'

" Plugin to use Elixir's build tool, mix
Plugin 'mattreduce/vim-mix'

" HTML autocomplete
Plugin 'alvan/vim-closetag'

" ALE
Plugin 'dense-analysis/ale'

" ultisnips, Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" YouCompleteMe
Plugin 'ycm-core/YouCompleteMe'

"pangloss/vim-javascript for JavaScript syntax
Plugin 'pangloss/vim-javascript'

"syntax file for TypeScript
Plugin 'leafgarland/typescript-vim'

"Syntax highlighting and indentation for JSX
Plugin 'peitalin/vim-jsx-typescript'

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

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader=","
set timeout timeoutlen=1500

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
endif

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set wrap
set linebreak    "Wrap lines at convenient points

set omnifunc=syntaxcomplete#Complete  "AUTOCOMPLETION
" ================ Custom Settings ========================

" Window pane resizing
" height
nnoremap <silent> <Leader>] :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>[ :exe "resize " . (winheight(0) * 2/3)<CR>
"width
nnoremap <silent> <Leader>s :exe "vertical resize -20"<CR>
nnoremap <silent> <Leader>w :exe "vertical resize +20"<CR>

" ========================== TABS =========================
"Map :tabnew to T
:map ) :tabnew

"Tab navigation
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

" =================== Seeing Is Believing =================
"
" " Assumes you have a Ruby with SiB available in the PATH
"
" " Annotate every line
"
nmap <leader>nn :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
"
"  " Annotate marked lines
"
nmap <leader>n :%.!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk --xmpfilter-style<CR>;
"
"  " Remove annotations
"
nmap <leader>c :%.!seeing_is_believing --clean<CR>;
"
"  " Mark the current line for annotation
"
nmap <leader>m A # => <Esc>
"
"  " Mark the highlighted lines for annotation
"
vmap <leader>m :norm A # => <Esc>

" ============================= NERDTREE =============================
"To open NERDTree automatically when vim starts up if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" To show dot files
let NERDTreeShowHidden=1

"Map NerdTree toggle to <F2>
map <F2> :NERDTreeToggle<CR>

" ============================ COPY AND PASTE ======================

"Remap the paste command
noremap <leader>p "*]p:set nopaste<CR>
"Copy to both clipboard and primary selection
vnoremap <leader>c "*y :let @+=@*<CR>
"=================== CHANGE TO CURRENT DIRECTORY======================

" Change directory to the file being edited and print new dir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

"======================= SLIM SYNTAX HIGHLIGHTER ====================
"to avoid known problem with plugin, which uses `setfiletype` upon autodetect
"but does not override filetype once it was set. see https://github.com/slim-template/vim-slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

"============================ FILE PREVIEW WITH FZF VIM =============

autocmd! VimEnter * command! -nargs=* -complete=file Ag :call fzf#vim#ag_raw(<q-args>, fzf#wrap('ag-raw',
\ {'options': "--preview 'coderay $(cut -d: -f1 <<< {}) 2> /dev/null | sed -n $(cut -d: -f2 <<< {}),\\$p | head -".&lines."'"}))

command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

"====================== COLORSCHEME DIRECTIVE======================
colorscheme Tomorrow-Night

" ========================================
"auto-complete html tags
:iabbrev <// </<C-X><C-O>

"================================= SOLVE RECOMPILE :NOOP IN ELIXIR ======================
" https://mangalakader.github.io/post/elixir-shell-recompile-noop-issue/
au FileType elixir let $MIX_ENV = 'test'

"============== RECOGNIZE .slive FILES AS .slim ======================
au BufRead,BufNewFile *.slive setlocal filetype=slim

"============== RECOGNIZE .slime FILES AS .slim ======================
au BufRead,BufNewFile *.slime setlocal filetype=slim

"=============== OPEN HTML FILES IN BROWSER ==================
nnoremap <F12>c :exe ':silent !chromium-browser %'<CR>
nnoremap <F12>f :silent update<Bar>silent !firefox %:p &<CR>
"nnoremap <F5> :silent update<Bar>silent !xdg-open %:p &<CR>
nnoremap <F5> :silent update<Bar>silent !google-chrome %:p &<CR>

"================ CLOSE TAG OPTIONS=========================
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.leex,*.erb,*.eex'
"let g:closetag_filetypes = 'html,xhtml,phtml,eex,leex,erb,ex,rb'

" =================== LINTER CONFIGURATION =================
let g:ale_linters = {
  \ 'javascript' : ['eslint'],
  \}

" styling the signs:
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" This flag can be set to 0 to disable linting when the buffer is entered.
let g:ale_lint_on_enter = 0

" ============= CONFIGURE VIM-JSX-TYPESCRIPT HIGHLIGHTER ==========
"
" set filetypes as typescriptreact
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" set jsx-tag colors
" dark red
hi tsxTagName guifg=#E06C75
hi tsxComponentName guifg=#E06C75
hi tsxCloseComponentName guifg=#E06C75

" orange
hi tsxCloseString guifg=#F99575
hi tsxCloseTag guifg=#F99575
hi tsxCloseTagName guifg=#F99575
hi tsxAttributeBraces guifg=#F99575
hi tsxEqual guifg=#F99575

" yellow
hi tsxAttrib guifg=#F8BD7F cterm=italic

" light-grey
hi tsxTypeBraces guifg=#999999
" dark-grey
hi tsxTypes guifg=#666666

" ============ USER VIM COLOR THEME ON TMUX =======================

" use 256 colors in terminal
if !has("gui_running")
    set t_Co=256
    set term=screen-256color
endif

" fix cursor display in cygwin
if has("win32unix")
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"
endif

" ============ ULTISNIPS TRIGGER CONFIGURATION =======================
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<f4>"
let g:UltiSnipsJumpForwardTrigger="<S-f>"
let g:UltiSnipsJumpBackwardTrigger="<S-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
