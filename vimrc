" General vim settings {{{1

" Tabs {{{2
set tabstop=4
set shiftwidth=4
set expandtab

" Line numbers {{{2
set relativenumber

" Plugins {{{1
call plug#begin('~/.vim/plugged')

" Airline {{{2
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" LaTeX {{{2
Plug 'lervag/vimtex'

" CoC {{{2
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
    \ 'coc-snippets', 
    \ 'coc-clangd', 
    \ 'coc-pyright',
    \ 'coc-vimtex',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-json',
    \ 'coc-julia']

" Syntax highlighting {{{2
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Color scheme {{{2
set termguicolors
Plug 'arcticicestudio/nord-vim'

call plug#end()

" Settings {{{1

" Coc {{{2

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

" Tree-Sitter {{{2
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "python" },  -- list of language that will be disabled
    custom_captures = {
      ["keyword.operator"] = "TSKeyword", -- Keyword, TSKeyword, Operator
    },
  },
}
EOF

" Colorscheme {{{2
colorscheme nord

" Transparent background {{{2
hi Normal guibg=NONE

" vim:foldmethod=marker
