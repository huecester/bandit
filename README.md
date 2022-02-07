 Bandit
Personal repo for the (Bandit level on OverTheWire)[https://overthewire.org/wargames/bandit/bandit0.html]

## bandit0
Enter with given password `bandit0`.

## bandit1
Read the `readme` file.
```bash
$ cat readme
boJ9jbbUNNfktd78OOpsqOltutMc3MY1
```

## bandit2
Read the `-` file. Trying to `cat` the file `-` will make `cat` read from stdin.
```bash
$ cat ./-
CV1DtqXWVFXTvM2F0k09SHz0YwRINYA9
```

## bandit3
Read the `spaces in this filename` file. Use backslashes to escape the spaces or use quotes.
```bash
$ cat spaces\ in\ this\ filename
UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK

$ cat 'spaces in this filename'
UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK
```

## bandit4
Read the `.hidden` file in the `inhere` directory. Use `ls -a` to list hidden files (files beginning with a `.`).
```bash
$ cd inhere

$ ls
$ ls -a
. .. .hidden

$ cat .hidden
pIwrPrtPN36QITSp3EQaw936yaFoFgAB
```
