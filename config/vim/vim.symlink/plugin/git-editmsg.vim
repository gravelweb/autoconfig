if @% !~ "\.git/COMMIT_EDITMSG$"
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
