"------------------------------------------------
"██    ██ ██ ███    ███ ██████   ██████ 
"██    ██ ██ ████  ████ ██   ██ ██      
"██    ██ ██ ██ ████ ██ ██████  ██      
" ██  ██  ██ ██  ██  ██ ██   ██ ██      
"  ████   ██ ██      ██ ██   ██  ██████ 
"------------------------------------------------
" Author: Nicolas Shannon
" Desription: My personal .vimrc file
"------------------------------------------------
"
"------------------------------------------------
" --- |Pluggins| ---
"------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

" New plugins
Plug 'rktjmp/lush.nvim'
Plug 'justinmk/vim-sneak'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-surround'
" LSP and autocompletion
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'prabirshrestha/vim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'ray-x/lsp_signature.nvim'
Plug 'itchyny/lightline.vim'
Plug 'lewis6991/spellsitter.nvim'
" Code snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'
Plug 'rafamadriz/friendly-snippets'
" IDE-like experience
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdtree'
Plug 'folke/todo-comments.nvim'
Plug 'jreybert/vimagit'
" Neat utilities/features 
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
" Org mode
Plug 'jceb/vim-orgmode'
" Previewers
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Colorscheme add-ons
Plug 'ishan9299/modus-theme-vim' 
" Plug 'sainnhe/everforest'
" Plug 'sainnhe/gruvbox-material'
Plug 'rebelot/kanagawa.nvim'
" Plug 'EdenEast/nightfox.nvim'
" Plug 'sainnhe/sonokai'
Plug 'mcchrish/zenbones.nvim'
" Plug 'morhetz/gruvbox'
" Plug 'sainnhe/edge'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Remap <leader> key from to SPACE
let mapleader = "\<Space>" 

" Set the python3 executable path
let g:python3_host_prog = '/usr/bin/python3'

"------------------------------------------------
" --- |Pluggin Settings| ---
"------------------------------------------------

" let g:lightline = { 'colorscheme': 'wombat', }
" let g:lightline = { 'colorscheme': 'solarized', }
let g:lightline = { 'colorscheme': 'one', }
" let g:lightline = { 'colorscheme': 'vimbones', }

" Colorscheme plugin settings
" let g:everforest_background = 'hard'
" let g:gruvbox_material_background = 'hard'
"let g:sonokai_style = 'espresso'
"let g:sonokai_style = 'default'

" LLP configuration
" autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'pdflatex'
let g:livepreview_use_biber = 1

" markdown-preview 
let g:mkdp_browser = 'firefox'
" let g:mkdp_markdown_css = '/home/nick/.local/share/markdown.css'
let g:mkdp_page_title = '${name}'
let g:mkdp_theme = 'dark'

" vimwiki
let g:vimwiki_list = [{'path': '~/dox/wiki/', 'path_html': '~/dox/public_html/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Define a macro
let @e='/static unsigned int m_indentostatic bool m_loggingEnabled;static void enableDebugLogging();static void disableDebugLogging();'

"------------------------------------------------
" --- |Plugin Maps| ---
"------------------------------------------------

" Nerdtree
noremap <leader>n :NERDTreeToggle<CR>
" NerdTree navigation
" Use gt and gT for tab navigation
nnoremap <C-t> :tabnew<CR>
nnoremap <silent> <C-l> :tabn<CR>
nnoremap <silent> <C-h> :tabp<CR>

" Telescope 
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" todo-comments
" nnoremap <leader>t <cmd>TodoQuickFix<cr>
nnoremap <leader>td <cmd>TodoTelescope<cr>

" Spellsitter "
nnoremap <leader>ss :set spell!<CR>

" Goyo
nnoremap <leader>g <cmd>Goyo <cr>

"------------------------------------------------
" --- |Remaps| ---
"------------------------------------------------

" Save "
nnoremap <C-s> :w<CR>

" Word Count "
nnoremap <C-w> :!wc -w %<cr>

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
" Make calcurse notes markdown compatible
autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
autocmd BufRead,BufNewFile ~/.calcurse/notes/* set filetype=markdown
" Syntax highlighting for org files
autocmd FileType org setlocal filetype=markdown
" Tries to 'print' the current file (convert to pdf)
map <F5> :w<CR>:!printer %<CR>
imap <F5> :w<CR>:!printer %<CR>


"------------------------------------------------
" --- Custom Scripts ---
"------------------------------------------------

" Acronym search
nnoremap <Leader>h :call AcronymSearch()<CR>

function! AcronymSearch()
    let query = expand('<cword>')
    let output = system('vdict ' . query)
    echo output
endfunction

" command! -nargs=1 AcronymSearch :silent !vdict <args>
" nnoremap <Leader>h :<C-u>AcronymSearch <C-R><C-W><CR>

"------------------------------------------------
" --- Standard nvim settings ---
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
" set bg=light

" colorscheme vimbones 
colorscheme kanagawa
" colorscheme gruvbox-material
" colorscheme modus-vivendi
" colorscheme everforest

" Set color column
set colorcolumn=80

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

"------------------------------------------------
" --- |nvim-cmp setup| ---
"------------------------------------------------
set completeopt=menu,menuone,noselect

lua <<EOF

  -- Kanagawa colorscheme customizationn
  require('kanagawa').setup({ 
     colors = {                   
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {ui = {bg = "#161616", bg_gutter="none"}} },
     },
     theme = "wave",
  })
  vim.cmd("colorscheme kanagawa")
  --]]

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        --require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      --{ name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  --local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local capabilities = require('cmp_nvim_lsp').default_capabilities
  -- Plugins 
  require('lspconfig').html.setup {
    capabilities = capabilities
  }
  --require('nvim-autopairs').setup{}
  require('spellsitter').setup{
    enable = true,
    debug = false
  }
  -- Language servers
  require('lspconfig').rust_analyzer.setup{}
  require('lspconfig').pyright.setup{}
  require('lspconfig').bashls.setup{}
  require('lspconfig').lua_ls.setup{}
  require('lspconfig').hls.setup{}
  require('lspconfig').ccls.setup{}
  require('lspconfig').metals.setup{}
  require('lspconfig').html.setup{}
  require('lspconfig').vimls.setup{}
  -- todo-comments
  require('todo-comments').setup{}

EOF
