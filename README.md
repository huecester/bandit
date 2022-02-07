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

## bandit5
Find the human-readable file in `inhere` and read it. I used `find` and `grep` to find the only file with ASCII characters.
```bash
$ cd inhere

$ ls
-file00  -file01  -file02  -file03  -file04  -file05  -file06  -file07  -file08  -file09

$ find . -exec grep -qie "^[a-z0-9]\+$" {} 2>/dev/null \; -print
koReBOKuIDDepwhWk7jZC0RTdopnAYKh
./-file07
```
`find` finds all files matching the conditions given.
	`-exec` executes the given command for each file, inserting the filename at `{}` and ending the command at `\;`.
		`grep` looks for a pattern in a given file.
			The flag `-q` makes `grep` not print anything.
			The flag `-i` makes the search case insensitive.
			The flag `-e` takes a regex as input.
		`2>/dev/null` redirects stderr to /dev/null, basically hiding the errors.
	The flag `-print` prints the filename to stdout.
