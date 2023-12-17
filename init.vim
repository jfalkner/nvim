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

" Markdown files will have the following config used
:au FileType md
  \ set cc=120 |
  \ set expandtab |
  \ set shiftwidth=2 |
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ setlocal spell spelllang=en_us

" Plugins using vim-plug: https://github.com/junegunn/vim-plug
call plug#begin()
Plug 'neovim/nvim-lspconfig'

" nvim-cmp setup " For vsnip users.
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

call plug#end()

" Use rust-analyzer with NeoVim's LSP config
"lua require'lspconfig'.rust_analyzer.setup({})

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }
EOF
