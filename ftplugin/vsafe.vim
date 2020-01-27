"===============================================================================
" FILE: vsafe.vim
" AUTHOR: Antenore <antenore@simbiosi.org>
" Last Modified: 1/22/2020
" License: GPLv3 License {{{1===== License: GPLv3 License ======================
" This file is part of VimSafe.
"
" VimSafe is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" VimSafe is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with VimSafe.  If not, see <http://www.gnu.org/licenses/>.
" }}}1
"===============================================================================
"{{{1 ==== TODO: ===============================================================
"{{{2 ==== 1. Copy and Paste using the clipboard ===============================
"    Implemented using Yankitude (git@github.com:someboddy/vim-yankitute.git)
"    You need also +xterm_clipboard and in some cases clipboard=unnamedplus
"}}}2
"}}}1
" {{{1 ==== Initialization =====================================================
if exists('b:did_ftplugin')
    finish
else
    let b:did_ftplugin = 1
endif

let s:cpo_save = &cpoptions
set cpoptions&vim
" }}}1
" {{{1 ==== VSafe Filetype settings ============================================
setlocal viminfo=
setlocal cryptmethod=blowfish2
setlocal noswapfile
setlocal nobackup
setlocal nowritebackup
setlocal bufhidden=wipe
setlocal textwidth=0
setlocal foldmethod=indent
setlocal noundofile
"setlocal fdm=expr
"setlocal foldexpr=VFold(v:lnum)
setlocal foldclose=all
setlocal colorcolumn=0
setlocal foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
setlocal clipboard=unnamedplus
" Concealing password
setlocal conceallevel=2
setlocal concealcursor=""
" }}}1
" {{{1 ==== Functions Definitions ==============================================
" {{{2 ==== s:NewVSafeEntry ====================================================
function! s:NewVSafeEntry()
    " TODO: Replace with dictionary or list and loop
    let line=line('.')
    call inputsave()
    let grname = input('Enter a GROUPNAME.SUBGROUPNAME: ')
    call inputrestore()
    call append(line, grname . '::')
    call append(line+1,'	User: "{USER}"')
    call append(line+2,'	Password: "{PASSWORD}"')
    call append(line+3,'	Url: ""')
    call append(line+4,'	Note ""')
endfunction " }}}2 ==== end of function s:NewVSafeEntry ========================
" {{{2 ==== s:PlaceCursor ======================================================
function! s:PlaceCursor(pat)
    let [pline, pcol] = searchpos(a:pat, 'cw')
    let curr_line = getline(pline)
    let replacement = substitute(curr_line, a:pat, '', '')
    call setline('.', replacement)
    call setpos('.', [0, pline, pcol+1, ''])
    :foldopen
    :startinsert
endfunction " }}}2 ==== end of function s:PlaceCursor ==========================
" {{{2 ==== AddVSafeEntry ======================================================
function! AddVSafeEntry()
    call s:NewVSafeEntry()
    call s:PlaceCursor('{USER}')
endfunction " }}}2 ==== end of function s:AddVSafeEntry ========================
" {{{2 ==== VSafeNextField =====================================================
function! VSafeNextField (back)
    if a:back !=# 'bck'
        let bckflag = ''
    else
        let bckflag = 'b'
    endif
    call search('^\s\(\w*:\)\s".', bckflag. 'ew')
    if foldclosed('.') >= 1
        :foldopen
    endif
    :insert
endfunction  " }}}2 ==== end of function VSafeNextField ========================
" {{{2 ==== VFold ==============================================================
function! VFold (lnum)
    if getline(a:lnum) =~? '^\w.*::'
        let vfoldlevel = 1
    elseif getline(a:lnum) =~? '^\t\w*:\s'
        let vfoldlevel = 2
    else
        let vfoldlevel = 0
    endif
    return vfoldlevel
endfunction " }}}2 ==== end of function VFold ==================================
" {{{2 ==== VSRandom ===========================================================
" Accept 0 or more args ( the number of chars )
function! VSRandom (...)
    let l:bufsize = 0
    let l:strchars = '[^[:alnum:][!$?#@.,;:]'
    " Default value for strsize (the random string size) is 15
    if a:0 > 0
        let l:size = a:1
    else
        let l:size = 15
    endif
    " The while loop ends as soon as I have a string of l:size
    while l:bufsize == 0
        for l:line in readfile('/dev/urandom', '', 1)
            let l:rndstring = strpart(substitute(l:line, l:strchars, '' , 'g'), 0, l:size)
            let l:sizeofrnd = strdisplaywidth(l:rndstring)
            if l:sizeofrnd >= l:size
                let l:bufsize = 1
            endif
        endfor
    endwhile
    return l:rndstring
endfunction
" }}}2 end of VSRandom
" {{{2 ==== VPWGen =============================================================
function! VPWGen()
    if filereadable('/dev/urandom')
        "let l:pwcmd = VSRandom(15)
        let l:pw = substitute(VSRandom(15), '[\]\|[[:cntrl:]]', '', 'g')
        echomsg l:pw
    elseif filereadable('/bin/pwgen')
        let l:pwcmd = '/bin/pwgen -cnyB 16 1'
        let l:pw = substitute(system(pwcmd), '[\]\|[[:cntrl:]]', '', 'g')
    else
        echomsg 'ERR: neither /dev/urandom or pwgen have beed found'
    endif
    redir @p>
    echomsg l:pw
    redir END
endfunction
" }}}2 end of function VPWGEN ==================================================
" }}}1
" {{{1 ==== Mappings ===========================================================
" Motion
nnoremap <silent><buffer> <Tab> :call VSafeNextField('fwd')<CR>
inoremap <silent><buffer> <Tab> <Esc>:call VSafeNextField('fwd')<CR>
nnoremap <silent><buffer> <S-Tab> :call VSafeNextField('bck')<CR>
inoremap <buffer> <CR> <Esc>
" Copy into the system clipboard the old way
"map <silent> <buffer> <F1> :/^\(\sUser:\s"\zs[^"]\+\ze"\n\)\{0}/y+<CR>
"map <silent> <buffer> <F2> :/^\(\sPassword:\s"\zs[^"]\+\ze"\n\)\{0}/y+<CR>
""map <silent> <buffer> <F2> :/^\sPassword:\s"\(\zs.\{-}\ze\)"$/y p<CR>let @+ = @p<CR>
" Copy to clipboard using Yankitude
nnoremap <silent><buffer> <F1> 0:Yankitute+/User:\s"\(\zs.\{-}\ze\)"<CR>
nnoremap <silent><buffer> <F2> 0:Yankitute+/Password:\s"\(\zs.\{-}\ze\)"<CR>
" Add new entry
nnoremap <silent><buffer> <F4> <Esc>:call AddVSafeEntry()<CR>
" Password: call VPWGen and pasting back it's content; clean again the register
nnoremap <F8> :call VPWGen()<CR>"ppJxqpq
" This is to sort the headers leaving untouched the content
nnoremap <silent><buffer> <F5> :%s/\(\n\t\)/\2!<CR>:sor i<CR>jddGp:%s/!/\r\t/g<CR>
" }}}1
" {{{1 ==== Restore settings ===================================================
if exists('b:undo_ftplugin')
    let b:undo_ftplugin .= '|setl noswapfile< nobackup< nowritebackup< bufhidden< tw< fdm< foldclose< colorcolumn<'
else
    let b:undo_ftplugin = 'setl noswapfile< nobackup< nowritebackup< bufhidden< tw< fdm< foldclose< colorcolumn<'
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save
" }}}1
