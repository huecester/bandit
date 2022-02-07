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

## bandit6
Find the human-readable, 1033 byte, non-executable file in `inhere` and read it. I used `find`, and there was only one file with exactly 1033 bytes.
```bash
$ cd inhere

$ ls
maybehere00  maybehere03  maybehere06  maybehere09  maybehere12  maybehere15  maybehere18
maybehere01  maybehere04  maybehere07  maybehere10  maybehere13  maybehere16  maybehere19
maybehere02  maybehere05  maybehere08  maybehere11  maybehere14  maybehere17

$ ls -la maybehere00
total 72
drwxr-x---  2 root bandit5 4096 May  7  2020 .
drwxr-x--- 22 root bandit5 4096 May  7  2020 ..
-rwxr-x---  1 root bandit5 1039 May  7  2020 -file1
-rwxr-x---  1 root bandit5  551 May  7  2020 .file1
-rw-r-----  1 root bandit5 9388 May  7  2020 -file2
-rw-r-----  1 root bandit5 7836 May  7  2020 .file2
-rwxr-x---  1 root bandit5 7378 May  7  2020 -file3
-rwxr-x---  1 root bandit5 4802 May  7  2020 .file3
-rwxr-x---  1 root bandit5 6118 May  7  2020 spaces file1
-rw-r-----  1 root bandit5 6850 May  7  2020 spaces file2
-rwxr-x---  1 root bandit5 1915 May  7  2020 spaces file3

$ find . -size 1033c
./maybehere07/.file2

$ cat ./maybehere07/.file2
DXjZPULLxYr17uwoI01bNLQbtFemEgo7
```

## bandit7
Find the file owned by user `bandit7` and group `bandit6`, and is 33 bytes in size.
```bash
$ find / -user bandit7 -group bandit6 -size 33c
/var/lib/dpkg/info/bandit7.password

$ cat /var/lib/dpkg/info/bandit7.password
HKBPTKQnIay4Fw76bEy8PVxKEDQRKTzs
```
