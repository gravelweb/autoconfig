if getcwd() != $HOME."/Documents/Journal"
  finish
endif

autocmd BufEnter * call SetUp()
function! SetUp()
    set linebreak
    "colorscheme pencil
    " execute `Goyo` if it's not already active
    if !exists('#goyo')
        Goyo
    endif
    cnoremap q :qa

endfunction
