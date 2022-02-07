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

## bandit8
Find the password next to the word `millionth` in `data.txt`. Use `grep` to find the line with the word `millionth`.
```bash
$ ls
data.txt

$ cat data.txt | grep millionth
millionth       cvX2JJa4CFALtqS87jk27qwqGhBM9plV
```

## bandit9
Find the line in `data.txt` that occurs only once. Use `uniq` and `sort`.
```bash
$ ls
data.txt

$ cat data.txt | sort | uniq -u
UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR
```
`sort` sorts all lines alphabetically as `uniq` requires to remove duplicate lines.
`uniq -u` takes the input and deletes all repeated lines, printing only unique lines.

## bandit10
Find the human-readable line preceded by multiple `=` signs in `data.txt`. Use `strings` to find human-readable lines.
```bash
$ ls
data.txt

$ strings data.txt | grep '==='
========== the*2i"4
========== password
Z)========== is
&========== truKLdjsbJ5g7yyJ2X2R0o3a5HQJFuLk
```

## bandit11
Decode the base64 in `data.txt`.
```bash
$ ls
data.txt

$ cat data.txt
VGhlIHBhc3N3b3JkIGlzIElGdWt3S0dzRlc4TU9xM0lSRnFyeEUxaHhUTkViVVBSCg==

$ base64 -d data.txt
The password is IFukwKGsFW8MOq3IRFqrxE1hxTNEbUPR
```

## bandit12
Decode the ROT13 ciphertext in `data.txt`. I used `tr`, but you can also use a website like [dcode.fr](https://www.dcode.fr/rot-13-cipher).
```bash
$ ls
data.txt

$ cat data.txt
Gur cnffjbeq vf 5Gr8L4qetPEsPk8htqjhRK8XSP6x2RHh

$ cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
The password is 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu
```

## bandit13
Reverse the hexdump in `data.txt` and decompress the file. As OverTheWire suggests, it's best to create a directory in `/tmp` and copy the file over.
```bash
$ ls
data.txt

$ mkdir /tmp/bazinga
$ cd /tmp/bazinga
$ cp ~/data.txt .

$ xxd -r data.txt data.gz
```
At this point, continuously decompress the file using `gunzip [file]`, `bunzip2 [file]`, or `tar -xf [file]`. Note that to use `gunzip`, the file must end in `.gz`.
```bash
$ cat data8
The password is 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL
```

## bandit14
Use the private ssh key to login to bandit14 and read the password in `/etc/bandit_pass/bandit14`. You can either ssh directly from the server, or you can copy the private key to your machine using `scp`.
```bash
$ ls
sshkey.private

$ ssh -i sshkey.private bandit14@localhost

$ cat /etc/bandit_pass/bandit14
4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e
```
