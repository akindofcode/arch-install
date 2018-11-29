syntax on

set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'takac/vim-hardtime'
call plug#end()

set backspace=2 				"backspace delete like most programs in insert mode

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

