" Vim syntax file
" Language: vsafe, vim password vault files
" Maintainer: Antenore Gatta
" Latest Revision: 20 Dec 2013
" {{{ -=# General Options ======================================================
if exists("b:current_syntax")
    finish
endif

syntax clear

syn keyword vsafeTodo                         contained TODO FIXME XXX NOTE
syn match   vsafeComment  /#.*$/              contains=vsafeTodo
" }}} ==========================================================================
" {{{ -=# Pattern Matching =====================================================
syn match   vsafeHead     /^\(\w\+\)\(.*\)$/
syn match   vsafeUserKey  /User:/             nextgroup=vsafeUser skipwhite
syn match   vsafeUser     /"\(.*\)"/          contained
syn match   vsafePwdKey   /Password:/         nextgroup=vsafePwd skipwhite
syn match   vsafePwd      /"\(.*\)"/          contained conceal cchar=*
syn match   vsafeUrlKey   /Url:/              nextgroup=vsafeUrl skipwhite
syn match   vsafeUrl      /"\(.*\)"/          contained
syn match   vsafeURL      '\<\(\(https\{0,1}\|ftp\)://\|\(www[23]\{0,1}\.\|ftp\.\)\)[A-Za-z0-9._/~:,#-]\+\>'
syn match   vsafeURLMacro '\<\(\(https\{0,1}\|ftp\)://\|\(www[23]\{0,1}\.\|ftp\.\)\)[A-Za-z0-9._/~:,#%{}-]\+\>'
syn match   vsafeNotesKey /Notes:/            nextgroup=vsafeNotes skipwhite
syn match   vsafeNotes    /"\(.*\)"/          contained
" }}} ==========================================================================
" {{{ -=# Keywords==============================================================
"syn keyword vsafeUrlKey   Url
"syn match vsafePasswd '\(Password: .*\)\@<=".*"' conceal cchar=*
"syn match vsafeNotes '\(Notes: .*\)\@<=".*"'
"syn match vsafeString '\(Notes: .*\)\@<=".*"'
" }}} ==========================================================================
" {{{ -=# Highlight ============================================================
" General keywords
hi def link vsafeComment                      Comment
hi def link vsafeDesc                         PreProc
hi def link vsafeTodo                         Todo
" vsafe specific
hi def link vsafeHead                         Identifier
hi def link vsafeUserKey                      Keyword
hi def link vsafeUser                         String
hi def link vsafePwdKey                       Keyword
hi def link vsafePwd                          Special
hi def link vsafeUrlKey                       Keyword
hi def link vsafeUrl                          String
hi def link vsafeURL                          Underlined
hi def link vsafeURLMacro                     Underlined
hi def link vsafeNotesKey                     Keyword
hi def link vsafeNotes                        String

"hi          vsafeURL                          term=underline,bold cterm=underline,bold
"hi          vsafeURLMacro                     term=underline,bold cterm=underline,bold
" }}} ==========================================================================
