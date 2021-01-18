map <buffer> bns :call PhpExpandClass()<CR>

" Get it bundled for pathogen: https://github.com/avakhov/vim-yaml

if exists("b:did_indent")
    finish
endif
"runtime! indent/ruby.vim
"unlet! b:did_indent
let b:did_indent = 1

setlocal autoindent sw=4 et
setlocal indentexpr=GetYamlIndent()
setlocal indentkeys=o,O,*<Return>,!^F

function! GetYamlIndent()
    let lnum = v:lnum - 1
    if lnum == 0
        return 0
    endif
    let line = substitute(getline(lnum),'\s\+$','','')
    let indent = indent(lnum)
    let increase = indent + &sw
    if line =~ ':$'
        return increase
    else
        return indent
    endif
endfunction

let g:ale_linters = { 'yaml': ['yamllint'] }

let g:LanguageClient_serverCommands = { 'yaml': ['yaml-language-server', '--stdio'] }

let settings = json_decode('
\{
\    "yaml": {
\        "completion": true,
\        "hover": true,
\        "validate": true,
\        "schemas": {
\            "Kubernetes": "/*"
\        },
\        "format": {
\            "enable": true
\        }
\    },
\    "http": {
\        "proxyStrictSSL": true
\    }
\}')
augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted call LanguageClient#Notify(
        \ 'workspace/didChangeConfiguration', {'settings': settings})
augroup END

autocmd FileType php setlocal omnifunc=LanguageClient#complete

" vim:set sw=2:
