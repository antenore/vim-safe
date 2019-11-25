***VimSafe - A VIM Password Safe (Vault) like tool***

<a name="vim-safe-contents"/>
## CONTENTS

1. [Introduction](#vim-safe-intro)
    1. [Requirements](#vim-safe-requirements)
    2. [Functionalities](#vim-safe-functionalities)
    3. [Usage example](#vim-safe-example)
2. [Commands](#vim-safe-commands)
3. [Mappings](#vim-safe-mappings)

<a name="vim-safe-intro"/>
## INTRODUCTION

VimSafe is a password keeper (password vault, password safe, ...) based on Vim.

VimSafe uses the VIM builtin encryption capabilities (blowfish2).

If you want to help (and/or teach me your Vim wizardry), you are more than
welcome.

<a name="vim-safe-requirements"/>
## REQUIREMENTS

  * Vim 7.4.401 or later is needed to use blowfish2.
  * Yankitute
    *Author*:  Idan Arye <https://github.com/someboddy/>


<a name="vim-safe-functionalities"/>
## FUNCTIONALITIES

* Encryption using internal blowfish2 Vim implementation
* Auto open/close folded elements
* Motion
  - Move with **`<Tab> <S-Tab>`**
  - Exit from insert mode with **`<CR>`**
* Insert new Item
  - Place at the right place
  - Hit **`<F4>`**
  - TODO: Add by Group/SubGroup/Entry in the right place automagically
* Sort entries
* Copy User/Password into the system clipboard
  - Works only with +xterm_clipboard ( **`<F1>`** **`<F2>`** )
  - TODO: Add external clipboard tool support (i.e. xclip)
*   Automatic password generation with
  - Internal VSRandom function using /dev/urandom (this is literally amazing)
  - external command pwgen

<a name="vim-safe-example"/>
## USAGE-EXAMPLE

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

<a name="vim-safe-commands"/>
## COMMANDS						 

| Shortcut | Command / Description |
|:---------|:----------------------|
| `<F4>`   |  *AddVSafeEntry*
|          | To add a new entry (at the moment only manual position)

`<Tab>`,
`<S-Tab>` *VSafeNextField*
To move back and forward between each field

`<F8>`	*VPWGen*
It generates a random password in the p register

<a name="vim-safe-mappings"/>
## MAPPING

 * `<F1>` (WIP) Copy UserName into the system clipboard (require +xterm_clipboard)
 * `<F2>` (WIP) Copy Password into the system clipboard (require +xterm_clipboard)
 * `<F4>` To add a new entry (at the moment only manual position)
 * `<F5>` To sort the whole file
 * `<F8>` Random password in the register p
 * `<Tab>` To move forward to the next field
 * `<S-Tab>` To move backwards to the previous field
 * `<CR>` To exit from insert mode

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
