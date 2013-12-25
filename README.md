VimSafe - A VIM Password Safe (Vault) like tool
===============================================

***MPORTANT***: VimSafe has been not netested enough and I'm still working hard to improve it.

***WARNING***: An encrypted text file, were some of the fields are well known, it's easily breakable.

If you want to help (and/or teach me your Vim wizardry), you are more than welcome.

What is VimSafe?
----

VimSafe is a password keeper (password vault, password safe, ...) based on Vim.

In this early stage, VimSafe uses the VIM builtin encryption cababilities (blowfish). As highlighted, this solution it's not  safe.

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
  7 Group.xxx::
  8 +--  4 lines: User: "picasso"-------------------------------
  9 +--  4 lines: User: "merlin"--------------------------------
  ```

