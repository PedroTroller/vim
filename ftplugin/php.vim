set ts=4 sts=4 et
set expandtab
set shiftwidth=4
set softtabstop=4

set keywordprg=pman

map <buffer> bns :call PhpExpandClass()<CR>
let g:php_namespace_sort_after_insert = 1

let &tags = "tags"
" let &tags = join(split(glob("php.*.tags"), "\n"), ",")

" map <leader>sp :execute ":! echo ".@%." && php -l ".@%." && XDEBUG_MODE=coverage vendor/bin/phpspec run ".@%." -fpretty --no-coverage -vv"<CR>
map <leader>sp :execute ":! echo ".@%." && php -l ".@%." && XDEBUG_MODE=coverage vendor/bin/phpspec run ".@%." -fpretty -vv"<CR>

let g:ale_linters = { 'php': ['php', 'phpstan', 'lsp'] }
let g:ale_php_phpstan_level = 8
let g:ale_lint_on_enter=0
let g:ale_sign_warning = '!>'
let g:ale_sign_info = '!>'
let g:ale_sign_style_warning = '!>'

let g:limelight_paragraph_span = 0
let g:limelight_bop = 'function'
let g:limelight_eop = '^    }\n'

autocmd FileType php setlocal omnifunc=phpactor#Complete

map <buffer> ns :call phpactor#UseAdd()<CR>
map <C-l> :call phpactor#GotoDefinition()<CR>
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
