"===============================================================================
" FILE: vsafe.vim
" AUTHOR: Antenore <antenore@simbiosi.org>
" Last Modified: 21 Dec 2013
" License: GPLv3 License {{{1===== License: GPLv3 License =====================
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
<<<<<<< HEAD
"{{{2 ==== Copy and Paste using the clipboard
" - Commands
"   quq                                        " Clean reg u
"   :/^\sUser:\s"\(\zs.\{-}\ze\)"$/y u        |" Yank Username in registry u
"   let @+ = @u                                " Put reg u in Clipboard (reg +)
"   qpq                                        " Clean reg p
"   :/^\sPassword:\s"\(\zs.\{-}\ze\)"$/y p    |" Yank Password in registry p
"   let @+ = @p                                " Put reg p in Clipboard (reg +)
"
"   WARNING: This does not work if vim it's not compiled with +xterm_clipboard
"   WARNING: yank copy the whole line, looking for alternative
=======
"{{{2 ==== 1. Copy and Paste using the clipboard ===============================
"    Implemented using Yankitude (git@github.com:someboddy/vim-yankitute.git)
"    You need also +xterm_clipboard and in some cases clipboard=unnamedplus
>>>>>>> 5fcd199d9a63b1c782ac96743b2d6f194235e3c8
"}}}2
"}}}1
" {{{1 ==== Initialization =====================================================
if exists('b:did_ftplugin')
  finish
else
  let b:did_ftplugin = 1
endif

let s:cpo_save = &cpo
set cpo&vim
" }}}1
" {{{1 ==== VSafe Filetype settings ============================================
setlocal viminfo=
setlocal cm=blowfish
setlocal noswapfile
setlocal nobackup
setlocal nowritebackup
setlocal bufhidden=wipe
setlocal tw=0
setlocal fdm=indent
"setlocal fdm=expr
"setlocal foldexpr=VFold(v:lnum)
setlocal foldclose=all
setlocal colorcolumn=0
setlocal foldtext=v:folddashes.substitute(getline(v:foldstart),'/\\*\\\|\\*/\\\|{{{\\d\\=','','g')
setlocal clipboard=unnamedplus
" }}}1
" {{{1 ==== Functions Definitions ==============================================
" {{{2 ==== s:NewVsafeEntry ====================================================
function! s:NewVsafeEntry()
    " TODO: Replace with distionary or list and loop
    let line=line(".")
    call inputsave()
    let grname = input('Enter a GROUPNAME.SUBGROUPNAME: ')
    call inputrestore()
    call append(line, grname . '::')
    call append(line+1,'	User: "{USER}"')
    call append(line+2,'	Password: "{PASSWORD}"')
    call append(line+3,'	Url: ""')
    call append(line+4,'	Note ""')
endfunction " }}}2 ==== end of function s:NewVsafeEntry ========================
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
" {{{2 ==== AddVsafeEntry ======================================================
function! AddVsafeEntry()
    call s:NewVsafeEntry()
    call s:PlaceCursor('{USER}')
endfunction " }}}2 ==== end of function s:AddVsafeEntry ========================
" {{{2 ==== NextField ==========================================================
function! NextField (back)
    if a:back != 'bck'
        let bckflag = ''
    else
        let bckflag = 'b'
    endif
    call search('^\s\(\w*:\)\s".', bckflag. 'ew')
    if foldclosed('.') >= 1
        :foldopen
    endif
endfunction  " }}}2 ==== end of function NextField =============================
" {{{2 ==== VFold ==============================================================
function! VFold (lnum)
    if getline(a:lnum) =~ '^\w.*::'
        let vfoldlevel = 1
    elseif getline(a:lnum) =~ '^\t\w*:\s'
        let vfoldlevel = 2
    else
        let vfoldlevel = 0
    endif
    return vfoldlevel
endfunction " }}}2 ==== end of function VFold =================================
" }}}1
" {{{1 ==== Mappings ===========================================================
" Copy into the system clipboard
map <silent> <buffer> <F1> :/^\(\sUser:\s"\zs[^"]\+\ze"\n\)\{0}/y+<CR>
map <silent> <buffer> <F2> :/^\(\sPassword:\s"\zs[^"]\+\ze"\n\)\{0}/y+<CR>
"map <silent> <buffer> <F2> :/^\sPassword:\s"\(\zs.\{-}\ze\)"$/y p<CR>let @+ = @p<CR>
" Add new entry
map <silent> <buffer> <F4> <Esc>:call AddVsafeEntry()<CR>
<<<<<<< HEAD
=======
map <silent> <buffer> <Tab> :call NextField('fwd')<CR>
map <silent> <buffer> <S-Tab> :call NextField('bck')<CR>
map <silent> <buffer> <F1> 0:Yankitute+/User:\s"\(\zs.\{-}\ze\)"<CR>
map <silent> <buffer> <F2> 0:Yankitute+/Password:\s"\(\zs.\{-}\ze\)"<CR>
>>>>>>> 5fcd199d9a63b1c782ac96743b2d6f194235e3c8
" This is to sort the headers leaving untouched the content
map <silent> <buffer> <F5> :%s/\(\n\t\)/\2!<CR>:sor i<CR>jddGp:%s/!/\r\t/g<CR>
" Motion
map <silent> <buffer> <Tab> :call NextField('fwd')<CR>
map <silent> <buffer> <S-Tab> :call NextField('bck')<CR>
imap <buffer> <CR> <Esc>
" }}}1
" {{{1 ==== Restore settings ===================================================
if exists('b:undo_ftplugin')
  let b:undo_ftplugin .= "|setl noswapfile< nobackup< nowritebackup< bufhidden< tw< fdm< foldclose< colorcolumn<"
else
  let b:undo_ftplugin = "setl noswapfile< nobackup< nowritebackup< bufhidden< tw< fdm< foldclose< colorcolumn<"
endif

let &cpo = s:cpo_save
unlet s:cpo_save
" }}}1
