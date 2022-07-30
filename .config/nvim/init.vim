" ------- GENERAL SETTINGS --------

syntax on

set autoindent
set tabstop=3 softtabstop=3
set shiftwidth=3
set expandtab
set smartindent
set relativenumber
set nohlsearch
set noerrorbells
set nu
set hidden
set nowritebackup
set nobackup
set noswapfile
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set scrolloff=8
set signcolumn=number
set ignorecase
set smartcase
set updatetime=300
set encoding=UTF-8
set mouse=a
set splitbelow
set splitright
set cmdheight=1
set shortmess+=c
set nowrap
set termguicolors
set noshowmode

" ---------- PLUGINS ----------

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree' 
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-visual-selection'
" Plug 'glepnir/dashboard-nvim'
"----- vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'KarimElghamry/vim-auto-comment'
Plug 'tanvirtin/monokai.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'alvan/vim-closetag'

call plug#end()

" require plugin configs
lua require('helltis')
lua require'colorizer'.setup()
filetype plugin on
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument


" ---------- COLORSCHEME ----------
colorscheme monokai

" ---------- KEYBINDS ----------
" Shif - Tab to switch tabs
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" ------ nerdtree -----
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" ----- airline settings -----
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

" ----- coc settings -----
let g:coc_global_extensions = [
         \ 'coc-snippets',
         \ 'coc-tsserver',
         \ 'coc-eslint',
         \ 'coc-prettier',
         \ 'coc-json' ]
"         \ 'coc-pairs',
" ----- coc snippets settings -----
"  Make <tab> used for trigger completion,
"  completion confirm, snippet expand and jump like VSCode.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" ----- nerdtree settings -----
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" ----- closetag settings -----
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js,ts'
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }