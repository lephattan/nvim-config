syntax on
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set clipboard=unnamedplus
set nowrap
set splitright
set splitbelow
set background=dark
let mapleader=" "
let g:python3_host_prog = expand("~/.envs/nvim/bin/python3")

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'cloudhead/neovim-fuzzy'
"Plug 'vim-scripts/indentpython.vim'
"Plug 'vim-python/python-syntax'
Plug 'nvie/vim-flake8'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'prettier/vim-prettier', {
\ 'do': 'yarn install',
\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'Raimondi/delimitMate'
Plug 'preservim/nerdcommenter'
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-startify'

" Initialize plugin system
call plug#end()
colorscheme gruvbox
let python_highlight_all=1
let g:airline_powerline_fonts = 1

"" My shortcuts
" Ctrl p for fuzzy search
let g:ycm_confirm_extra_conf = 0
set completeopt-=preview
nnoremap <C-n> :FuzzyOpen<CR>
nnoremap <leader>e :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>s :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>vs :vs<CR>
nnoremap <leader>q :q<CR>
nnoremap <c-h> :%s///g<left><left><left>
" leader t for termainal with height of 8
nnoremap <leader>t :8split +terminal<cr>
tnoremap <Esc> <C-\><C-n>
autocmd BufEnter term://* startinsert
autocmd BufLeave term://* stopinsert
autocmd TermOpen * startinsert
" vim-fugitive for git
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
" CocCommand shortcut
nnoremap <C-p> :CocCommand<CR>
" CocSnippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

"" Python PEP 8 indentation
au BufNewFile,BufRead *.py
						\ set tabstop=4
"						\ set softtabstop=4
						\ set shiftwidth=4
						\ set expandtab
						\ set autoindent
						\ set fileformat=unix

"" Python Run and Debug with pudb shortcuts
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python' shellescape(@%, 1)<CR>
autocmd FileType python map <buffer> <F10> :w<CR>:exec '!pudb' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F10> <esc>:w<CR>:exec '!pudb' shellescape(@%, 1)<CR>
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
