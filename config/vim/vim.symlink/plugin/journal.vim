if getcwd() != $HOME."/Documents/Journal"
  finish
endif

autocmd BufEnter * call SetUp()
function! SetUp()
    " don't chop words in half
    set linebreak
    " don't chop words in half
    set spell spelllang=en_ca
    " make navigation more amenable to the long wrapping lines.
    noremap <buffer> k gk
    noremap <buffer> j gj
    noremap <buffer> <Up> gk
    noremap <buffer> <Down> gj
    noremap <buffer> 0 g0
    noremap <buffer> ^ g^
    noremap <buffer> $ g$
    noremap <buffer> D dg$
    noremap <buffer> C cg$
    noremap <buffer> A g$a
    " utf-8 should be set if not already done globally
    setlocal fileencoding=utf-8
    " execute `Goyo` if it's not already active
    if !exists('#goyo')
        Goyo
    endif
    cnoremap q :qa

endfunction
