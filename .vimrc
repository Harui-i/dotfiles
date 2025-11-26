set tabstop=2
set shiftwidth=2
set expandtab
set number
set title
set showcmd
set smartindent
set hlsearch
set incsearch

if &term =~ "xterm"
  " Normal mode: Block
  let &t_SI = "\<Esc>[6 q"
  " Insert mode: Insert
  let &t_EI = "\<Esc>[2 q"
  " Replace mode: Underline
  let &t_SR = "\<Esc>[4 q"
endif

syntax on
