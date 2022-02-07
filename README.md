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

## bandit15
Enter bandit14's password to the process binded to port 30000 using netcat.
```bash
$ nc localhost 30000
bazinga
Wrong! Please enter the correct current password

$ nc localhost 30000
4wcYUJFw0k0XLShlDzztnTBHiqxU3b3e
Correct!
BfMYroe26WYalil77FoDi9qh59eK5xNr
```

## bandit16
Enter bandit15's password to port 30001 with SSL. Use `openssl`'s `s_client` tool.
```bash
$ openssl s_client -connect localhost:30001
CONNECTED(00000003)
depth=0 CN = localhost
verify error:num=18:self signed certificate
verify return:1
depth=0 CN = localhost
verify return:1
...
BfMYroe26WYalil77FoDi9qh59eK5xNr
Correct!
cluFn7wTiGryunymYOu4RcffSxQluehd

closed
```

## bandit17
Find the listening port using SSL that returns credentials. Use `nmap` to find listening ports.
```bash
$ nmap localhost -p31000-32000

Starting Nmap 7.40 ( https://nmap.org ) at 2022-02-07 07:17 CET
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00029s latency).
Not shown: 996 closed ports
PORT      STATE SERVICE
31046/tcp open  unknown
31518/tcp open  unknown
31691/tcp open  unknown
31790/tcp open  unknown
31960/tcp open  unknown

Nmap done: 1 IP address (1 host up) scanned in 0.09 seconds

$ openssl s_client -connect localhost:31790
...
cluFn7wTiGryunymYOu4RcffSxQluehd
Correct!
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----

closed
```
`ssh` into bandit17 and `cat /etc/bandit_pass/bandit17`.

```bash
$ cat /etc/bandit_pass/bandit17
xLYVMN9WE5zQ5vHacb0sZEVqbrp7nBTn
```

## bandit18
Find the one different line between `passwords.old` and `passwords.new`. Use `diff`.
```bash
$ diff passwords.old passwords.new
42c42
< w0Yfolrc5bwjS4qw5mq1nnQi6mF03bii
---
> kfBf3eYk5BPBRzwjqutbbfE887SVc5Yd
```

## bandit19
Bypass the exit command in `.bashrc` and read the password in the `readme` file. Pass a command to `ssh` to run the command before `.bashrc` is sourced.
```bash
$ ssh -p 2220 bandit18@bandit.labs.overthewire.org cat readme
...
IueksS7Ubh8G3DCwVzrTd8rAVOwq3M5x
```

## bandit20
Use the setuid binary `bandit20-do` to read bandit20's password.
```bash
$ ./bandit20-do
Run a command as another user.
  Example: ./bandit20-do id

$ ./bandit20-do cat /etc/bandit_pass/bandit20
GbKksEFF4yrVs6il55v6gwY5aVje5f0j
```

## bandit21
Use `suconnect` along with a TCP server using `nc` to get the next password.
```bash
$ ls
suconnect

$ ./suconnect
Usage: ./suconnect <portnumber>
This program will connect to the given port on localhost using TCP. If it receives the correct password from the other side, the next password is transmitted back.

# Connection 1
$ nc -lvp 3030
GbKksEFF4yrVs6il55v6gwY5aVje5f0j
gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr

# Connection 2
$ ./suconnect 3030
Read: GbKksEFF4yrVs6il55v6gwY5aVje5f0j
Password matches, sending next password
```

## bandit22
Find the cronjob running for bandit22.
```bash
$ cat /etc/cron.d/cronjob_bandit22
@reboot bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
* * * * * bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
```
The most important part of this file is the command, `/usr/bin/cronjob_bandit22.sh`, which the group `bandit21` can read, and our current user is a part of that group.

```bash
$ ls -l /usr/bin/cronjob_bandit22.sh
-rwxr-x--- 1 bandit22 bandit21 130 May  7  2020 /usr/bin/cronjob_bandit22.sh

$ cat /usr/bin/cronjob_bandit22.sh
#!/bin/bash
chmod 644 /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
cat /etc/bandit_pass/bandit22 > /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
```
This file shows bandit22's password being put into the file at `/tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv`.

```bash
$ cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI
```
