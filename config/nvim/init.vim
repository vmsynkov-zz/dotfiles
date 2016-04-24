call plug#begin('~/.config/nvim/plugged')

Plug 'terryma/vim-multiple-cursors'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
" " Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
" " On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
"
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
"
call plug#end()

"" Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set showtabline=2

"" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme gruvbox
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
set background=dark
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_inactive_collapse=1

"" EasyAlign
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" \o small terminal window at bottom
nnoremap <leader>o :below 10sp term://$SHELL<cr>i

" ^N toggle NERDTree
map <leader>n :NERDTreeToggle<CR>

" Autostart NERDTree if opened without arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim automatically if NERDTree is the only tab opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "  ",
    \ "Staged"    : "  ",
    \ "Untracked" : "  ",
    \ "Renamed"   : "  ",
    \ "Unmerged"  : "  ",
    \ "Deleted"   : "  ",
    \ "Dirty"     : "  ",
    \ "Clean"     : "  ",
    \ "Unknown"   : "  "
    \ }

"" TEMP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>] :source %<CR>:AirlineRefresh<CR>

" super-fancy macro to end semicolon at the end of the line
let @a='$a; '
nnoremap <leader>; @a

"nnoremap <space> <leader>
map <space> <leader>

set clipboard+=unnamedplus

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers = ['jshint']
