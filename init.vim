" Jayson's NeoVIM configuration file
"
" http://github.com/jfalkner
" 
" This this is a file that I currently use. I've shared it via GitHub for
" anyone else to use and I've included documentation to help explain what
" everything does.
"
" Checkout the GitHub repository for more docs and videos of how stuff works.

" Basic Stuff

" Show line numbers
set number

" Add a 80 character line limit
set cc=80

" Show all whitespaces as a character
set list


" File-specific config -- settings to change based on file type
"
" Often you'll want to have different settings based on the type of file. For
" example, Python's PEP 8 docs suggest 4-spacing. In JavaScript often
" 2-spacing is used.

" Python files will have the following config used
:au FileType python
  " nvim defaults to use PEP8's: https://neovim.io/doc/user/filetype.html#ft-python-plugin
  \ set cc=80

" JavaScript files will have the following config used
:au FileType javascript
  \ set cc=80 |
  \ set expandtab |
  \ set shiftwidth=2 |
  \ set tabstop=2 |
  \ set softtabstop=2

