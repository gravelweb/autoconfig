" BEHAVIOURAL SETTINGS
" --------------------
" Open file in existing nvim session rather than a nested one
if executable('nvr')
  let $VISUAL="nvr --remote-tab-wait +'set bufhidden=wipe'"
endif
" more intuitive splits
set splitbelow
set splitright
" disable esc in favour of jk, enable in terminal
inoremap jk <esc>
inoremap <esc> <nop>
vnoremap jk <esc>
vnoremap <esc> <nop>
tnoremap jk <c-\><c-n>
" file tab completion tweaks
set wildmode=list:longest,full wildmenu smartcase

" SHORTCUTS
" ---------
" quick macro mapping
nnoremap Q @q
" remap leader key
let mapleader=","
" movement keys
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
vnoremap <c-h> <c-w>h
vnoremap <c-j> <c-w>j
vnoremap <c-k> <c-w>k
vnoremap <c-l> <c-w>l
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
" zoom keys (make 'b'ig)
nnoremap <c-b> <c-w>s<c-w>T
" fuzzy finder
nnoremap <c-p> :<c-u>FZF<CR>

" AESTHETICS
" ----------
" color theme
colorscheme solarized
set background=dark
" artificial max line length of 79 columns
set colorcolumn=80
" number lines relative to current line
set number relativenumber
" always show status bar
set laststatus=2
" clearly display non-space whitespace
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list
