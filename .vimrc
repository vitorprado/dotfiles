set t_Co=256
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Numbers
set number
set numberwidth=5

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

syntax enable

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  autocmd BufNewFile,BufRead *.gradle setf groovy
  autocmd FileType groovy setlocal tabstop=4
  autocmd FileType groovy setlocal shiftwidth=4

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

set textwidth=120
set colorcolumn=+1

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 1
let g:syntastic_java_checkers = ['javac']
let g:syntastic_java_javac_config_file_enabled = 1

let g:airline_powerline_fonts = 1

if has("gui_running")
  set mouse=a

  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guioptions-=M

  set background=dark
  colorscheme inkpot

  set guifont=Monaco\ for\ Powerline:h13
  set linespace=10
endif

let g:airline_theme='base16'  " Airline Plugin Theme

map <silent> <C-k> :NERDTreeToggle<CR>  " NERDTree
let g:NERDTreeDirArrows=1

" Local config
if filereadable($HOME . "/.vimrc.self")
  source ~/.vimrc.self
endif
