"=============================================================================
" FILE: vsafe.vim
" AUTHOR: Antenore <antenore@simbiosi.org>
" Last Modified: 21 Dec 2013
" License: GPLv3 License {{{
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
" }}}
"=============================================================================
if exists("b:did_ftplugin")
     finish
 endif
let b:did_ftplugin = 1

autocmd Filetype vsafe call SetVSafeOptions()
function! SetVSafeOptions()
    set      viminfo=
    setlocal cm=blowfish
    setlocal noswapfile
    setlocal nobackup
    setlocal nowritebackup
    setlocal bufhidden=wipe
    setlocal tw=0
    setlocal fdm=indent
    setlocal foldclose=all
    setlocal colorcolumn=0
endfunction
