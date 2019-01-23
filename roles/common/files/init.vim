syntax on
hi Comment ctermfg=cyan
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set nu
highlight LineNr ctermfg=darkgrey
vnoremap <C-c> "+y
autocmd VimLeave * call system("xsel -ib", getreg('+'))
hi cursorline cterm=NONE term=NONE
set cursorline
nnoremap <S-Up> :m .-2<CR>==
nnoremap <S-Down> :m .+1<CR>==

call plug#begin('~/.nvim/plugged')

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

let g:deoplete#enable_at_startup = 1
let g:necoghc_enable_detailed_browse = 1

call plug#end()

