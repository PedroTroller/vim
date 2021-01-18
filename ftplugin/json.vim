let g:LanguageClient_serverCommands = { 'json': ['yaml-language-server', '--stdio'] }

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
