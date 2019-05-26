" Runtime path
let &runtimepath.=',~/.config/nvim/neco-ghc-master'

" Colors and general stuff
syntax on
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set nu
set cursorline
set nocompatible
hi Comment ctermfg=cyan
hi cursorline cterm=NONE term=NONE
highlight LineNr ctermfg=darkgrey
highlight MatchParen ctermbg=darkgray
highlight pmenu ctermbg=8 guibg=#606060
highlight pmenusel ctermbg=3 guifg=#dddd00 guibg=#1f82cd
highlight pmenusbar ctermbg=0 guibg=#d6d6d6

" Tags
set tags=./tags,tags;$HOME

" File type specifics
autocmd FileType yaml setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd FileType text setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Remaps
vnoremap <C-c> "+y
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==
nnoremap <leader>` :NERDTreeToggle<CR>
nnoremap <M-`> :wincmd w<CR>
nnoremap <M-q> :q<CR>
nnoremap <M-S-q> :q!<CR>
nnoremap <M-Tab> :wincmd r<CR>
nnoremap <M-1> :Startify<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-[> <C-t>

" Finding files
set autochdir
set path+=**
set wildmenu

call plug#begin('~/.nvim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/syntastic'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdcommenter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'Yggdroot/indentLine'
  Plug 'mhinz/vim-startify'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1
let g:necoghc_enable_detailed_browse = 1
let g:indentLine_first_char = '┊'
let g:indentLine_char = '┊'
let g:indentLine_showFirstIndentLevel = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_kind_width = 0
let g:deoplete#max_menu_width = 0

call plug#end()

call deoplete#custom#source('_',  'max_menu_width', 0)
call deoplete#custom#source('_',  'max_abbr_width', 0)
call deoplete#custom#source('_',  'max_kind_width', 0)

"autocmd VimEnter * if argc() == 0 | NERDTree | endif
let NERDTreeMapPreview='<space>'

