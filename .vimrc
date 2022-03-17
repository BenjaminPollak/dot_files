" - - - - - - - -  GENERAL - - - - - - - - 
set nocompatible
syntax on " turns on syntax highlighting

" - - - - - - - - NORMAL MODE - - - - - - - - 
set number relativenumber " line numbers
set laststatus=2 " show status line
set showcmd " Displays normal mode input

" - - - - - - - - SEARCH - - - - - - - - 
set hls " Turns on Highlighting searching
set incsearch " highlights while searching 
set smartcase ignorecase

" - - - - - - - - REMAPS - - - - - - - - 
nmap <tab> ! " <tab> acts as exclamation
" smart window movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" - - - - - - - - SPACING - - - - - - - - 
" default tab behavior
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" Governs PL-specific tab behvaior
autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2
" shifting behavior
set smartindent autoindent " makes indenting easier

" turn on higlighting
highlight Visual cterm=reverse ctermbg=NONE

" - - - - - - - - VIM BAD - - - - - - - - 
" CVE-2019-12735
set nomodeline
set secure
