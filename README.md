VimSafe - A VIM Password Safe (Vault) like tool
===============================================

***IMPORTANT***: VimSafe has been not netested enough and I'm still working hard to improve it.

***WARNING***: The Vim Encryption, even the one using blowfish, it's easily breakable. I'm planning to use GPG or OpenSSL as soon the plugin will be "production ready".

If you want to help (and/or teach me your Vim wizardry), you are more than welcome.

## What is VimSafe? ##

VimSafe is a password keeper (password vault, password safe, ...) based on Vim.

In this early stage, VimSafe uses the VIM builtin encryption cababilities (blowfish). As highlighted, this solution it's not  safe.

### Functionalities ###

*   WIP: Encryption using internal blowfish (CBC like) Vim implementation
    
    > TODO: Allow external backend like GPG and OpenSSL

*   Auto open/close folded elements
*   Motion

    > Move with **`<Tab> <S-Tab>`**

    > Exit from insert mode with **`<CR>`**

*   WIP: Insert new Item

    > Place at the right place
    
    > Hit **`<F4>`**
    
    > TODO: Add by Group/SubGroup/Entry in the right place automagically
    
*   Sort entries
*   WIP: Copy User/Password into the system clipboard

    > Works only with +xterm_clipboard
    
    > TODO: Add external clipboard tool support (i.e. xclip)


### Overview ###

The text in the vsafe file has to be formatted in this way:

``` vsafe
# -=# VimSafe #=-
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

When you open a vsafe file all the elements, except the Groups/Subgroups, are folded and the passwords are all concealed with a *

``` vim
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

## Mappings ##

 * **`<F1>`** (WIP) Copy UserName into the system clipboard (you need +xterm_clipboard)
 * **`<F2>`** (WIP) Copy Password into the system clipboard (you need +xterm_clipboard)
 * **`<F4>`** To add a new entry (at the moment only manual position)
 * **`<F5>`** To sort the whole file
 * **`<Tab>`** To move forward to the next field
 * **`<S-Tab>`** To move backwards to the previous field
 * **`<CR>`** To exit from insert mode
