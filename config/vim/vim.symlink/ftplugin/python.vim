setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" pylint disable
let g:syntastic_python_pylint_quiet_messages = { "regex": "missing-docstring" }
