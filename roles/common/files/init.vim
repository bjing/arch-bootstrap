syntax on
hi Comment ctermfg=cyan
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd FileType yaml setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd FileType text setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set nu
highlight LineNr ctermfg=darkgrey
vnoremap <C-c> "+y
autocmd VimLeave * call system("xsel -ib", getreg('+'))
hi cursorline cterm=NONE term=NONE
set cursorline
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==
nnoremap <leader>` :NERDTreeToggle<CR>
highlight MatchParen ctermbg=darkgray
let &runtimepath.=',~/.config/nvim/neco-ghc-master'

highlight pmenu ctermbg=8 guibg=#606060
highlight pmenusel ctermbg=3 guifg=#dddd00 guibg=#1f82cd
highlight pmenusbar ctermbg=0 guibg=#d6d6d6

call plug#begin('~/.nvim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/syntastic'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdcommenter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'Yggdroot/indentLine'
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

