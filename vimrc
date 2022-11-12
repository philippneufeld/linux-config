
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber

" Map leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "


call plug#begin('~/.vim/plugged')

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" LaTeX
Plug 'lervag/vimtex'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 
            \ 'coc-ultisnips', 'coc-sh', 'coc-clangd', 'coc-pyright', 'coc-vimtex',
            \ 'coc-html', 'coc-css', 'coc-tsserver', 'coc-json', 'coc-julia']

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" File explorer
Plug 'nvim-tree/nvim-web-devicons' " for file icons
Plug 'nvim-tree/nvim-tree.lua'

" Color scheme
set termguicolors
Plug 'arcticicestudio/nord-vim'

call plug#end()

"
" CoC settings
"
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif &filetype ==# 'tex'
    VimtexDocPackage
  else
    call CocAction('doHover')
  endif
endfunction

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

"
" Tree sitter settings
"
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "latex" },  -- list of language that will be disabled
    custom_captures = {
      ["keyword.operator"] = "TSKeyword", -- Keyword, TSKeyword, Operator
    },
  },
}
EOF

"
" File explorer settings
"
lua <<EOF
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup()
EOF

nmap <leader>tt :NvimTreeFocus<ENTER>
nmap <leader>tr :NvimTreeToggle<ENTER>

"
" Colorscheme settings
"
colorscheme nord
hi Normal guibg=NONE " Transparent background
