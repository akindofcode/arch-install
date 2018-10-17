syntax on

set backspace=indent,eol,start			"Make backspace behave like any other editor.
let mapleader = ','				"The default leader is \, but a comma is much better
set number					"Let's activate line numbers.

"---------Visuals---------"
"colorscheme onedark
set t_CO=256					"Use 256 colors. This is useful for Terminal Vim.

"---------Search---------"
set hlsearch
set incsearch

"---------Mappings---------"

" Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

" Add simple highlight removal
nmap <Leader><space> :nohlsearch<cr>

"---------Auto-Commands---------"

"Automatically source the vimrc file on save
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

