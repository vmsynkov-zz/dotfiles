call plug#begin('~/.config/nvim/plugged')

"Plug 'junegunn/vim-easy-align'
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'morhetz/gruvbox'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }

call plug#end()

colorscheme gruvbox
set number
"set hidden
"set showtabline=2
"set noshowmode
"set laststatus=2

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
set background=dark

let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_server_python_interpreter = '/usr/bin/python3'
