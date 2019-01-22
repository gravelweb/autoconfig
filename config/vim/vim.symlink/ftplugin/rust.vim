" (rust.vim) autofmt rust code on save
let g:rustfmt_autosave = 1

" (vim-racer) goto definition keys
nmap gd <Plug>(rust-def)
nmap gs <Plug>(rust-def-split)
nmap gx <Plug>(rust-def-vertical)
nmap K <Plug>(rust-doc)

" (ALE) linter config
let g:ale_linters = {'rust': ['rls']}
let g:ale_rust_rls_toolchain = 'stable'
