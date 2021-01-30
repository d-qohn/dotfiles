"
set backspace=indent,eol,start                          " sensible backspacing
set emoji
set encoding=utf-8                                      " text encoding
set expandtab smarttab                                  " tab key actions
set fillchars+=vert:\▏                                  " requires a patched nerd font (try FiraCode)
set history=5000
set mouse=a
set number
set nocursorline
set relativenumber 
set showtabline=2                                       " always show tabline
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set title                                               " tab title as file name
set tw=90                                               " auto wrap lines that are longer than that
set undofile                                            " enable persistent undo
set undodir=/tmp                                        " undo temp file directory
set wrap breakindent                                    " wrap long lines to the width set by tw

" colorscheme
let g:gruvbox_italic=1
colorscheme gruvbox 
" colorscheme tender 

let mapleader=","
nnoremap ; :

" terminal mode
" tnoremap <Esc> <C-\><C-n>

" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>

" trim white spaces
nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" NERDTree
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>
nmap <Leader>tr :NERDTreeFocus<cr>R<c-w><c-p>

" markdown preview
au FileType markdown nmap <leader>m :MarkdownPreview<CR>

" fzf
nnoremap <silent> <leader>f :Files<CR>

" indentLine
let g:indentLine_char_list = ['▏', '¦', '┆', '┊']
let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0  

" airline
let g:airline_skip_empty_sections = 1
let g:airline_section_warning = ''
let g:airline_section_x=''
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2   " show tabline only if there is more than 1 buffer
let g:airline#extensions#tabline#fnamemod = ':t'        " show only file name on tabs
let airline#extensions#coc#error_symbol = '✘:'
let airline#extensions#coc#warning_symbol = '⚠:'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.dirty= '✗'
