*VimSafe - A VIM Password Safe (Vault) like tool*

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Installation](#installation)
  * [Vim 8+ packages](#vim-8--packages)
  * [Pathogen](#pathogen)
  * [Vundle](#vundle)
  * [VimPlug](#vimplug)
  * [apt-vim](#apt-vim)
- [Functionalities](#functionalities)
- [Usage](#usage)
- [Commands](#commands)
- [Mapping](#mapping)
- [Version and licence](#version-and-licence)

## Introduction

VimSafe is a password keeper (password vault, password safe, ...) based on Vim.

VimSafe uses the VIM builtin encryption capabilities (blowfish2).

If you want to help (and/or teach me your Vim wizardry), you are more than
welcome.

## Requirements

  * Vim 7.4.401 or later is needed to use blowfish2.
  * Yankitute
    *Author*:  Idan Arye <https://github.com/someboddy/>
  * pwgen (optional).

## Installation

Below are just some of the methods for installing VimSafe Do not follow all of these instructions; just pick your favorite one. Other plugin managers exist, and VimSafe should install just fine with any of them.

### Vim 8+ packages

If you are using VIM version 8 or higher you can use its built-in package management; see `:help packages` for more information. Just run these commands in your terminal:

```bash
git clone https://gitlab.com/antenore/vim-safe.git ~/.vim/pack/vendor/start/vim-safe
vim -u NONE -c "helptags ~/.vim/pack/vendor/start/vim-safe/doc" -c q
```

Otherwise, these are some of the several 3rd-party plugin managers you can choose from. Be sure you read the instructions for your chosen plugin, as there typically are additional steps you nee d to take.

### Pathogen

[pathogen.vim](https://github.com/tpope/vim-pathogen)

In the terminal,
```bash
git clone https://gitlab.com/antenore/vim-safe.git ~/.vim/bundle/vim-safe
```
In your vimrc,
```vim
call pathogen#infect()
syntax on
filetype plugin indent on
```

Then reload vim, run `:helptags ~/.vim/bundle/vim-safe/doc/` or `:Helptags`.

### Vundle

[Vundle.vim](https://github.com/VundleVim/Vundle.vim)

```vim
call vundle#begin()
Plugin 'antenore/vim-safe'
call vundle#end()
```

### VimPlug

[vim-plug](https://github.com/junegunn/vim-plug)

```vim
call plug#begin()
Plug 'antenore/vim-safe'
call plug#end()
```

### apt-vim

[apt-vim](https://github.com/egalpin/apt-vim)

```bash
apt-vim install -y https://gitlab.com/antenore/vim-safe.git
```

## Functionalities

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

## Usage

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

## Commands

| Shortcut | Command / Description |
|:---------|:----------------------|
| `<F4>`   |  *AddVSafeEntry*
|          | To add a new entry (at the moment only manual position)

`<Tab>`,
`<S-Tab>` *VSafeNextField*
To move back and forward between each field

`<F8>`	*VPWGen*
It generates a random password in the p register

## Mapping

 * `<F1>` (WIP) Copy UserName into the system clipboard (require +xterm_clipboard)
 * `<F2>` (WIP) Copy Password into the system clipboard (require +xterm_clipboard)
 * `<F4>` To add a new entry (at the moment only manual position)
 * `<F5>` To sort the whole file
 * `<F8>` Random password in the register p
 * `<Tab>` To move forward to the next field
 * `<S-Tab>` To move backwards to the previous field
 * `<CR>` To exit from insert mode

## Version and licence

 * *Version* : 8.0
 * *Author*  : Antenore `<antenore AT simbiosi dot org>`
 * *License* : GPLv3

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
