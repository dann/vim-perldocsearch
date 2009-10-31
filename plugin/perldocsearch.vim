" perldocsearch.vim
"
" Author: Takatoshi Kitano
" Version: 0.01 for Vim 7.1
" Last Change:  2009/10/31
" Licence: MIT Licence
"
" Description:
"   How to Use
"     :PerldocSearch coerce -G Moose

if exists("g:loaded_perldocsearch")
    finish
endif
let g:loaded_perldocsearch = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('PerldocSearch_Cmd')
    let g:PerldocSearch_Cmd = 1
end

if !exists('PerldocSearch_OpenQuickfixWindow')
    let g:PerldocSearch_OpenQuickfixWindow = 1
end

if !exists('PerldocSearch_Cmd')
    if executable('podsearch')
        let PerldocSearch_Cmd = 'podsearch'
    else
        echomsg 'podsearch is not found in PATH. Plugin is not loaded.'
        " Skip loading the plugin
        let loaded_perldocsearch = 0
        let &cpo = s:save_cpo
        unlet s:save_cpo
        finish
    endif
endif

function! s:PerldocSearch(...)
    let args = [ g:PerldocSearch_Cmd ]
    let args += a:000
    let cmd_output =  system(join(args, ' '))

    let tmpfile = tempname()
    exe "redir! > " . tmpfile
    silent echon cmd_output
    redir END
    let old_efm = &efm

    setlocal efm=%f:%m
    if exists(":cgetfile")
        execute "silent! cgetfile " . tmpfile
    else
        execute "silent! cfile " . tmpfile
    endif

    let &efm = old_efm

    if g:PerldocSearch_OpenQuickfixWindow == 1
        botright copen
    endif

    call delete(tmpfile)

endfunction

command! -nargs=* -complete=file PerldocSearch :call s:PerldocSearch(<f-args>)

"restore cpo
let &cpo = s:save_cpo
unlet s:save_cpo

" vim: ft=vim
