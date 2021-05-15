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
autocmd FileType haskell setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" Remaps
cnoreabbrev rl source ~/.config/nvim/init.vim
vnoremap <C-c> "+y
nnoremap <C-S-Up> :m .-2<CR>==
nnoremap <C-S-Down> :m .+1<CR>==
nnoremap <leader>` :NERDTreeToggle<CR>
nnoremap <M-Tab> :wincmd w<CR>
inoremap <M-Tab> <C-[> :wincmd w<CR>
tnoremap <M-Tab> <C-\><C-n> :wincmd w<CR>
nnoremap <M-q> :q<CR>
nnoremap <M-S-q> :q!<CR>
nnoremap <M-`> :wincmd r<CR>
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
nnoremap <M-C-h> <C-w>5<
nnoremap <M-C-l> <C-w>5>
nnoremap <M-C-j> <C-w>5-
nnoremap <M-C-k> <C-w>5+
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
nnoremap <silent><F12> :noh<CR>
nnoremap ty :.!typeOf %

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
  Plug 'https://github.com/obszczymucha/vim-startify.git'
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
let g:syntastic_haskell_checkers = ['hlint']

call plug#end()

call deoplete#custom#source('_',  'max_menu_width', 0)
call deoplete#custom#source('_',  'max_abbr_width', 0)
call deoplete#custom#source('_',  'max_kind_width', 0)

" NERDTree related
"autocmd VimEnter * if argc() == 0 | NERDTree | endif
let NERDTreeMapPreview = '<space>'
let NERDTreeQuitOnOpen = 1

function! FindTagsDirectory(file)
    let path = substitute(a:file, "/\\=[^/]*$", "", "")
    if path == ""
        return ""
    endif

    let file = path . "/tags"
    if filereadable(file)
        return path
    else
        return FindTagsDirectory(path)
    endif
endfunction

function! DelTagOfFile(tagsdir,file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = a:tagsdir . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateHaskellTags()
  let tagsdir = FindTagsDirectory(getcwd())

  if tagsdir == ""
      return
  endif

  let f = expand("%:p")
  let tagfilename = tagsdir . "/tags"
  "let cmd = 'hasktags -c -a -f ' . tagfilename . ' --extra=+q ' . '"' . f . '"'
  let cmd = 'hasktags -c -a -f ' . tagfilename . ' "' . f . '"'
  call DelTagOfFile(tagsdir,f)
  let resp = system(cmd)
endfunction

autocmd BufWritePost *.hs call UpdateHaskellTags()

" Enable per-project vimrc
set exrc
set secure

let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'browser',                                   },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
"      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },

let g:startify_enable_unsafe = 0
let g:startify_files_number = 10
let g:startify_show_dotfiles = 0
"let g:startify_prevent_browser_cursor_lock = 1

let g:startify_bookmarks = [ {'a': '~/.config/nvim/init.vim'} ]
let g:startify_browser_startup_jump = 1
let g:startify_custom_header = ""

