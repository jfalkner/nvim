" Jayson's NeoVIM configuration file
"
" http://github.com/jfalkner
" 
" This this is a file that I currently use. I've shared it via GitHub for
" anyone else to use and I've included documentation to help explain what
" everything does.
"
" Checkout the GitHub repository for more docs and videos of how stuff works.
"
" Reload any changes here by restarting nvim or `:source $MYVIMRC`

" Basic Stuff

" Show line numbers
set number

" Add a 120 character line limit
set cc=120

" Show all whitespaces as a character
set list

" Middle-click will paste. This is by default on
set mouse=v

" Highlight search results and incrementally search. This is by default on
set hlsearch
set incsearch

" Ignore case sensitivity. For example, when searching.
set ignorecase


" File-specific config -- settings to change based on file type
"
" Often you'll want to have different settings based on the type of file. For
" example, Python's PEP 8 docs suggest 4-spacing. In JavaScript often
" 2-spacing is used.

" Python files will have the following config used
:au FileType python
  " nvim defaults to use PEP8's: https://neovim.io/doc/user/filetype.html#ft-python-plugin
  \ set cc=120

" JavaScript files will have the following config used
:au FileType javascript
  \ set cc=120 |
  \ set expandtab |
  \ set shiftwidth=2 |
  \ set tabstop=2 |
  \ set softtabstop=2

" HTML files will have the following config used
:au FileType html
  \ set cc=120 |
  \ set expandtab |
  \ set shiftwidth=2 |
  \ set tabstop=2 |
  \ set softtabstop=2

" Plugins using vim-plug: https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'neovim/nvim-lspconfig'
call plug#end()

" Use rust-analyzer with NeoVim's LSP config
lua require'lspconfig'.rust_analyzer.setup({})
