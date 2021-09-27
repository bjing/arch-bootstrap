" Runtime path
let &runtimepath.=',~/.config/nvim/neco-ghc-master'

" Colors and general stuff
syntax on
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
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
hi CocErrorSign guifg=#000000
hi CocWarningSign guifg=#000000 guibg=#ffffff

" Tags
set tags=./.tags,.tags;$HOME

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
nnoremap <C-q> :q<CR>
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
nnoremap <silent><F2> :Vista!!<CR>
inoremap <silent><F2> :Vista!!<CR>
nnoremap <silent><C-M-Left> <C-o>
inoremap <silent><C-M-Left> <ESC><C-o>
nnoremap <silent><C-M-Right> <C-i>
inoremap <silent><C-M-Right> <ESC><C-i>

" Finding files
set autochdir
set path+=**
set wildmenu

call plug#begin('~/.nvim/plugged')

if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/syntastic'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdcommenter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'Yggdroot/indentLine'
  Plug 'https://github.com/obszczymucha/vim-startify.git'
  Plug 'liuchengxu/vista.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
endif

let g:necoghc_enable_detailed_browse = 1
let g:indentLine_first_char = '┊'
let g:indentLine_char = '┊'
let g:indentLine_showFirstIndentLevel = 1
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#max_abbr_width = 0
"let g:deoplete#max_kind_width = 0
"let g:deoplete#max_menu_width = 0
let g:syntastic_haskell_checkers = ['hlint']

call plug#end()

"call deoplete#custom#source('_',  'max_menu_width', 0)
"call deoplete#custom#source('_',  'max_abbr_width', 0)
"call deoplete#custom#source('_',  'max_kind_width', 0)

" NERDTree related
"autocmd VimEnter * if argc() == 0 | NERDTree | endif
let NERDTreeMapPreview = '<space>'
let NERDTreeQuitOnOpen = 1

function! FindTagsDirectory(file)
    " This removes the last path from the a:file e.g. src/Lib -> src
    " Meaning that the tags file should live in a directory one level above.
    let path = substitute(a:file, "/\\=[^/]*$", "", "")
    if path == ""
        return ""
    endif

    let file = path . "/.tags"
    if filereadable(file)
        return path
    else
        return FindTagsDirectory(path)
    endif
endfunction

function! DelTagOfFile(tagsdir,file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = a:tagsdir . "/.tags"
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
  let tagfilename = tagsdir . "/.tags"
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

" Use K to show documentation in preview window
nnoremap <silent> <M-q> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 0

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }


function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:airline_theme='deus'
let g:airline_symbols={
\  'colnr': 'c:',
\  'linenr': ' l:'
\}

let g:airline_powerline_fonts = 1
