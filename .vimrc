" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                  " required

" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
source ~/.vimrc.before
endif

" enable mouse
:set mouse=a

"========================== Plug (plugin manager)  ============================
"
" automatic installation of Plug

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" test support
Plug 'vim-test/vim-test'

" git blame
Plug 'zivyangll/git-blame.vim'

" endwise to add the keyword end automatically in Ruby
Plug 'tpope/vim-endwise'

" fuzzy file search
Plug 'kien/ctrlp.vim'

" fuzzy file search and more with fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install()}}
Plug 'junegunn/fzf.vim'

" NERDTree
Plug 'preservim/nerdtree'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

"ag.vim
Plug 'rking/ag.vim'

" vim syntax highlight for slim
Plug 'slim-template/vim-slim'

" Syntax highlighting for html5
Plug 'othree/html5.vim'

" Ale for dense analysis and elixir LS
Plug 'dense-analysis/ale'

" Buffergator for managing buffers
Plug 'jeetsukumaran/vim-buffergator' 

" Elixir syntax highlighting
Plug 'elixir-editors/vim-elixir'

" Plugin to use Elixir's build tool, mix
Plug 'mattreduce/vim-mix'

" Elixir mix format
Plug 'mhinz/vim-mix-format'

" HTML autocomplete
Plug 'alvan/vim-closetag'

" ultisnips, Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Tailwind css intellisense
Plug 'iamcco/coc-tailwindcss'

" YouCompleteMe
Plug 'ycm-core/YouCompleteMe'

" syntastic syntax checking plugin
Plug 'vim-syntastic/syntastic'

" vim-jsx got deprecated and broke, so I'll try vim-jsx-pretty!
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

"pangloss/vim-javascript for JavaScript syntax
Plug 'pangloss/vim-javascript'

" prettier plugin for autoformat
Plug 'prettier/vim-prettier', {'do': 'yarn install'}

" Auto pairs, auto-complete parentheses and brakets
Plug 'jiangmiao/auto-pairs'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting


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

" ============= Format elixir on save ========================
" elixir files not being assigned right filetype automatically
au BufRead,BufNewFile *.ex,*.exs set filetype=elixir
au BufRead,BufNewFile *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
au BufRead,BufNewFile mix.lock set filetype=elixir

" Run mix format on save
let g:mix_format_on_save = 1

" ========================== TABS =========================
"Map :tabnew to T
:map ) :tabnew

" Go to first tab
" map <C-t><up> :tabr<cr>

" Go to last tab
" map <C-t><down> :tabl<cr>

" Go to previous tab
" map <C-t><left> :tabp<cr>

" Go to next tab
" map <C-t><right> :tabn<cr>

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
" colorscheme Tomorrow-Night
set background=dark
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme solarized8
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
let g:closetag_filenames = '*.html,*.leex,*.erb,*.eex, *.heex, *.ex, *.js,*.jsx, *.sface'
"let g:closetag_filetypes = 'html,xhtml,phtml,eex,leex,erb,ex,rb'

" ================== SYNTASTIC ======================
let g:syntastic_javascript_checkers = ['eslint']

" ============ USER VIM COLOR THEME ON TMUX =======================

" use 256 colors in terminal
"if !has("gui_running")
"    set t_Co=256
"    set term=screen-256color
"endif

" fix cursor display in cygwin
"if has("win32unix")
"    let &t_ti.="\e[1 q"
"    let &t_SI.="\e[5 q"
"    let &t_EI.="\e[1 q"
"    let &t_te.="\e[0 q"
"endif

" ============ ULTISNIPS TRIGGER CONFIGURATION =======================
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<f4>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ========================= PRETTIER ==================================
" overwrite default prettier configuration
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'

" running before saving in vim
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

packloadall


" ====================== File search with FZF and  ==========================
nnoremap <leader>f :Files<cr>

" ====================== Configure elixirLS ==========================

let g:ale_elixir_elixir_ls_config = { 'elixirLS': { 'dialyzerEnabled': v:false  }  }

let g:ale_linters = {}
let g:ale_linters.elixir = [ 'credo', 'elixir-ls'  ]

" Required, tell ALE where to find Elixir LS
let g:ale_elixir_elixir_ls_release = expand("~/elixir-ls/rel")
"let g:ale_fixers.elixir = ['mix_format']

nnoremap <leader>df :ALEGoToDefinition<cr>
nnoremap <leader>dv :ALEGoToDefinition -vsplit<cr>
nnoremap <leader>dh :ALEGoToDefinition -split<cr>
nnoremap <leader>dt :ALEGoToDefinition -tab<cr>

nnoremap df :ALEFix<cr>
nnoremap K :ALEHover<cr>

" ====================== git blame mapping  ==========================
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

" ====================== vim test  ==========================
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
