***VimSafe - A VIM Password Safe (Vault) like tool***

*Version*: 8.0
*Author* : Antenore `<antenore AT simbiosi dot org>`
*License*: GPLv3

>   VimSafe an encrypted, text-only, password keeper
>   Copyright (C) 2014 Antenore Gatta
>
>   This program is free software: you can redistribute it and/or modify
>   it under the terms of the GNU General Public License as published by
>   the Free Software Foundation, either version 3 of the License, or
>   (at your option) any later version.
>
>   This program is distributed in the hope that it will be useful,
>   but WITHOUT ANY WARRANTY; without even the implied warranty of
>   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   GNU General Public License for more details.
>
>   You should have received a copy of the GNU General Public License
>   along with this program.  If not, see <http://www.gnu.org/licenses/>.


## CONTENTS                                 <a name="vim-safe-contents"/>

1. [Introduction](#vim-safe-intro)
    1. [Overview](#vim-safe-overview)
    2. [Requirements](#vim-safe-requirements)
    3. [Functionalities](#vim-safe-functionalities)
    4. [Usage example](#vim-safe-example)
2. [Commands](#vim-safe-commands)
3. [Mappings](#vim-safe-mappings)


## INTRODUCTION                             <a name="vim-safe-intro"/>

**IMPORTANT**: VimSafe has been not tetested enough and I'm still working hard to
           improve it.

**WARNING**: The Vim Encryption, even the one using blowfish, it's easily breakable.
         I'm planning to use GPG or OpenSSL as soon the plugin will be
         "production ready".

If you want to help (and/or teach me your Vim wizardry), you are more than
welcome.

### OVERVIEW                                 <a name="vim-safe-overview"/>

VimSafe is a password keeper (password vault, password safe, ...) based on Vim.

In this early stage, VimSafe uses the VIM builtin encryption cababilities
(blowfish). As highlighted, this solution it's not  safe.

<a name="vim-safe-requirements"/>
### REQUIREMENTS

  * Yankitute
    *Author*:  Idan Arye <https://github.com/someboddy/>


<a name=""/>
FUNCTIONALITIES					     <a name="vim-safe-functionalities"/>

* WIP: Encryption using internal blowfish (CBC like) Vim implementation
  - TODO: Allow external backend like GPG and OpenSSL
* Auto open/close folded elements
* Motion
  - Move with **`<Tab> <S-Tab>`**
  - Exit from insert mode with **`<CR>`**
* WIP: Insert new Item
  - Place at the right place
  - Hit **`<F4>`**
  - TODO: Add by Group/SubGroup/Entry in the right place automagically
* Sort entries
* WIP: Copy User/Password into the system clipboard
  - Works only with +xterm_clipboard ( **`<F1>`** **`<F2>`** )
  - TODO: Add external clipboard tool support (i.e. xclip)
*   Automatic password generation with
  - Internal VSRandom function using /dev/urandom (this is literally amazing)
  - external command pwgen

<a name=""/>
USAGE-EXAMPLE						 <a name="vim-safe-example"/>

The text in the vsafe file has to be formatted in this way:
```yml
   # -=# VimSafe #=->
   Group.SubGroup.SubSubGroup::
       User: "Raffaello"
       Password: "123456789"
       Url: "http://www.wtf-ftw.zz/"
       Notes: ""
   Group.xxx:
       User:
       Password:
       Url:
       Notes:
   Group.xxx.yyy.zzz:
       User:
       Password:
       Url:
       Notes:
```

When you open a vsafe file all the elements, except the Groups/Subgroups, are
folded and the passwords are all concealed with a *

```vim
  1 # -=# VimSafe #=-
  2 Group.SubGroup.SubSubGroup::
  3 ›   User: "raffaello"
  4 ›   Password: *
  5 ›   Url: "http://www.aabbccddeeff.it/what/if/local?user"
  6 ›   Notes: "Do you need this note?"
  7 Group.ASubGroup::
  8 +--  User: "picasso"-------------------------------
  9 +--  User: "merlin"--------------------------------
 10 +--  User: "obama"---------------------------------
```

COMMANDS						 <a name="vim-safe-commands"/>

| Shortcut | Command / Description |
|:---------|:----------------------|
| `<F4>`   |  *AddVSafeEntry*
|          | To add a new entry (at the moment only manual position)

`<Tab>`,
`<S-Tab>` *VSafeNextField*  
To move back and forward between each field

`<F8>`	*VPWGen*  
It generates a random password in the p register

MAPPING							 <a name="vim-safe-mappings"/>

 * `<F1>` (WIP) Copy UserName into the system clipboard (require +xterm_clipboard)
 * `<F2>` (WIP) Copy Password into the system clipboard (require +xterm_clipboard)
 * `<F4>` To add a new entry (at the moment only manual position)
 * `<F5>` To sort the whole file
 * `<F8>` Random password in the register p
 * `<Tab>` To move forward to the next field
 * `<S-Tab>` To move backwards to the previous field
 * `<CR>` To exit from insert mode

