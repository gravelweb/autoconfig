setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" (ALE) linter/fixer config
let g:ale_python_pylint_executable = $HOME.'/.local/bin/pylint'
let g:ale_fixers = {'python': ['black']}
let g:ale_python_black_executable = $HOME.'/.local/bin/black'
