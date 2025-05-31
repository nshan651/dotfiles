"---------------------------------------------------------------------------------
"  __  __  ___  _  _  ___  __  __  ___  _          __   __ ___  __  __  ___   ___ 
" |  \/  ||_ _|| \| ||_ _||  \/  |/   \| |         \ \ / /|_ _||  \/  || _ \ / __|
" | |\/| | | | | .  | | | | |\/| || - || |__        \   /  | | | |\/| ||   /| (__ 
" |_|  |_||___||_|\_||___||_|  |_||_|_||____|        \_/  |___||_|  |_||_|_\ \___|
"---------------------------------------------------------------------------------
" Author: Nicolas Shannon
" Desription: My minimal .vimrc config
"---------------------------------------------------------------------------------

" Remap <leader> key from to SPACE
let mapleader = "\<Space>" 

" Set the python3 executable path
let g:python3_host_prog = '/usr/bin/python3'

"------------------------------------------------
" --- |Remaps| ---
"------------------------------------------------

" Save "
nnoremap <C-s> :w<CR>

" Word Count "
nnoremap <C-w> :!wc -w %<cr>

" Toggle spelling 
nnoremap <leader>ss :set spell!<CR>

"------------------------------------------------
" --- |Auto Commands| ---
"------------------------------------------------

" Autocompile code
" Python
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" Lua
autocmd FileType lua map <buffer> <F9> :w<CR>:exec '!lua' shellescape(@%, 1)<CR>
autocmd FileType lua imap <buffer> <F9> <esc>:w<CR>:exec '!lua' shellescape(@%, 1)<CR>
" LLPStartPreview for Latex
autocmd FileType tex map <buffer> <F9> :w<CR>:LLPStartPreview<CR>
autocmd FileType tex imap <buffer> <F9> <esc>:w<CR>:LLPStartPreview<CR>
" Markdown
autocmd FileType markdown map <buffer> <F9> :w<CR>:MarkdownPreview<CR>
autocmd FileType markdown imap <buffer> <F9> <esc>:w<CR>:MarkdownPreview<CR>
" init.vim reload
autocmd FileType vim map <buffer> <F9> :w<CR>:so %<CR>
autocmd FileType vim imap <buffer> <F9> <esc>:w<CR>:so %<CR>
" Syntax highlighting for org files
autocmd FileType org setlocal filetype=markdown
" Tries to 'print' the current file (convert to pdf)
map <F5> :w<CR>:!printer %<CR>
imap <F5> :w<CR>:!printer %<CR>

"------------------------------------------------
" --- Custom Functions ---
"------------------------------------------------

" Acronym search
nnoremap <Leader>h :call AcronymSearch()<CR>

function! AcronymSearch()
    let query = expand('<cword>')
    let output = system('vdict ' . query)
    echo output
endfunction

" Toggle transpareny
let t:isTransparent = 0

function! BGToggleTransparency()
  if t:isTransparent == 0
    hi Normal guibg=#111111 ctermbg=black
    set background=dark
    let t:isTransparent = 1
  else
    hi Normal guibg=NONE ctermbg=NONE
    let t:isTransparent = 0
  endif
endfunction

nnoremap <leader>b <cmd>:call BGToggleTransparency()<CR>

"------------------------------------------------
" --- Standard vim settings ---
"------------------------------------------------

" Set 'nocompatible' for issues with distro
set nocompatible
filetype plugin on

" Set clipboard to use system clipboard
set clipboard+=unnamedplus

if has('termguicolors')
    set termguicolors
endif

set bg=dark

colorscheme torte

if has('filetype')
  filetype indent plugin on
endif

if has('syntax')
  syntax on
endif

if has('mouse')
  set mouse=a
endif
set exrc
set guicursor=

set hidden

set noerrorbells
set wildmenu

set nohlsearch
set incsearch
set noruler
set noshowcmd

set scrolloff=8
set noswapfile
set nobackup
set ignorecase
set smartcase
set number relativenumber
set nu
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent

" Set color column
set colorcolumn=80
hi ColorColumn ctermbg=1 guibg=DarkBlue
