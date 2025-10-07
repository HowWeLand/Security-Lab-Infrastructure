" ~/.vimrc
" Optimal Vim configuration for Ansible development on Kali Linux

" Ensure pathogen is properly initialized FIRST
filetype off
execute pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

" Syntax highlighting and file type detection
syntax on

" Set encoding
set encoding=utf-8

" Display settings
set number                      " Show line numbers
set ruler                       " Show cursor position
set cursorline                  " Highlight current line
set showcmd                     " Show command in bottom bar
set wildmenu                    " Visual autocomplete for command menu
set lazyredraw                  " Redraw only when we need to
set showmatch                   " Highlight matching [{()}]
set laststatus=2                " Always show status line

" Search settings
set incsearch                   " Search as characters are entered
set hlsearch                    " Highlight matches
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present

" Tab and indentation settings
set tabstop=2                   " Number of visual spaces per TAB
set softtabstop=2               " Number of spaces in tab when editing
set shiftwidth=2                " Number of spaces to use for autoindent
set expandtab                   " Tabs are spaces
set autoindent                  " Autoindent new lines
set smartindent                 " Smart autoindenting

" Other settings
set backspace=indent,eol,start  " Make backspace behave normally
set history=1000                " Remember more commands and search history
set undolevels=1000             " Many levels of undo
set title                       " Change the terminal's title
set visualbell                  " Don't beep
set noerrorbells                " Don't beep
set mouse=a                     " Enable mouse support

" Ansible/YAML specific settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal indentkeys-=<:>

" ALE configuration
let g:ale_enabled = 1
let g:ale_linters = {
\   'yaml': ['yamllint', 'ansible-lint'],
\   'ansible': ['yamllint', 'ansible-lint'],
\}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" EasyAlign configuration
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Auto-pairs configuration
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`'}

" NERDTree configuration (check if plugin exists)
if exists(":NERDTreeToggle")
  let NERDTreeShowHidden=1
  let NERDTreeQuitOnOpen=1
  let NERDTreeAutoDeleteBuffer=1
  let NERDTreeMinimalUI = 1
  let NERDTreeIgnore = ['\.pyc$', '\.swp$'] " Ignore some file
endif


" Autostart NERDTree when passed a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Even better with error checking:
command! Cheat if filereadable(expand('~/VIM_CHEATSHEET')) |
    \ execute 'edit ' . expand('~/VIM_CHEATSHEET') |
    \ else |
    \ echo 'Cheat sheet not found at: ' . expand('~/VIM_CHEATSHEET') |
    \ endif

" Color scheme - try multiple dark options
colorscheme molokai-dark
set background=dark

" Additional visual enhancements
set t_Co=256
highlight Comment cterm=italic
highlight LineNr ctermfg=darkgrey
highlight CursorLine ctermbg=black
highlight CursorLineNr ctermfg=yellow
