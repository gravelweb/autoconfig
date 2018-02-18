" Save on build
set autowrite

" Use goimports instead of gofmt
let g:go_fmt_command="goimports"

" All error lists as quickfix
let g:go_list_type="quickfix"

" Quickfix navigate
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

" Quick build
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
nmap <leader>r <Plug>(go-run)
nmap <leader>t <Plug>(go-test)
nmap <leader>c <Plug>(go-coverage-toggle)

" Look and feel
let g:go_highlight_types=1
let g:go_highlight_build_constraints=1
