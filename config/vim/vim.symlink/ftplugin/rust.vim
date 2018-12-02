" autofmt rust code
let g:rustfmt_autosave = 1

" racer hotkeys
nmap gd <Plug>(rust-def)
nmap gs <Plug>(rust-def-split)
nmap gx <Plug>(rust-def-vertical)
nmap K <Plug>(rust-doc)

" ale config
let g:ale_linters = {'rust': ['rls']}
let g:ale_rust_rls_toolchain = 'stable'

" racer config
let g:racer_experimental_completer = 1
