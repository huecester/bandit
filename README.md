# Bandit
Personal repo for the [Bandit level on OverTheWire](https://overthewire.org/wargames/bandit/bandit0.html).

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
$ ls -l /etc/cron.d
total 24
-rw-r--r-- 1 root root  62 May 14  2020 cronjob_bandit15_root
-rw-r--r-- 1 root root  62 Jul 11  2020 cronjob_bandit17_root
-rw-r--r-- 1 root root 120 May  7  2020 cronjob_bandit22
-rw-r--r-- 1 root root 122 May  7  2020 cronjob_bandit23
-rw-r--r-- 1 root root 120 May 14  2020 cronjob_bandit24
-rw-r--r-- 1 root root  62 May 14  2020 cronjob_bandit25_root

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

## bandit23
Find the cronjob running for bandit23.
```bash
$ ls -l /etc/cron.d
total 24
-rw-r--r-- 1 root root  62 May 14  2020 cronjob_bandit15_root
-rw-r--r-- 1 root root  62 Jul 11  2020 cronjob_bandit17_root
-rw-r--r-- 1 root root 120 May  7  2020 cronjob_bandit22
-rw-r--r-- 1 root root 122 May  7  2020 cronjob_bandit23
-rw-r--r-- 1 root root 120 May 14  2020 cronjob_bandit24
-rw-r--r-- 1 root root  62 May 14  2020 cronjob_bandit25_root

$ cat /etc/cron.d/cronjob_bandit23
@reboot bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null
* * * * * bandit23 /usr/bin/cronjob_bandit23.sh  &> /dev/null

$ cat /usr/bin/cronjob_bandit23.sh
#!/bin/bash

myname=$(whoami)
mytarget=$(echo I am user $myname | md5sum | cut -d ' ' -f 1)

echo "Copying passwordfile /etc/bandit_pass/$myname to /tmp/$mytarget"

cat /etc/bandit_pass/$myname > /tmp/$mytarget
```
This shell script copies the password of the user executing the script to a file.
If bandit23 were to run the file, bandit23's password would be copied to the file with a name equivalent to the MD5 hash of "I am user bandit23".
The `cut -d ' ' -f 1` extracts the pure MD5 hash from the command's output, which includes the filename to the right of the hash.

```bash
$ echo I am user bandit23 | md5sum | cut -d ' ' -f 1
8ca319486bfbbc3663ea0fbe81326349

$ cat /tmp/8ca319486bfbbc3663ea0fbe81326349
jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n
```

## bandit24
Find the cronjob running for bandit24.
```bash
$ ls -l /etc/cron.d
total 24
-rw-r--r-- 1 root root  62 May 14  2020 cronjob_bandit15_root
-rw-r--r-- 1 root root  62 Jul 11  2020 cronjob_bandit17_root
-rw-r--r-- 1 root root 120 May  7  2020 cronjob_bandit22
-rw-r--r-- 1 root root 122 May  7  2020 cronjob_bandit23
-rw-r--r-- 1 root root 120 May 14  2020 cronjob_bandit24
-rw-r--r-- 1 root root  62 May 14  2020 cronjob_bandit25_root

$ cat /etc/cron.d/cronjob_bandit24
@reboot bandit24 /usr/bin/cronjob_bandit24.sh  &> /dev/null
* * * * * bandit24 /usr/bin/cronjob_bandit24.sh  &> /dev/null

$ cat /usr/bin/cronjob_bandit24.sh
#!/bin/bash

myname=$(whoami)

cd /var/spool/$myname
echo "Executing and deleting all scripts in /var/spool/$myname:"
for i in * .*;
do
    if [ "$i" != "." -a "$i" != ".." ];
    then
        echo "Handling $i"
        owner="$(stat --format "%U" ./$i)"
        if [ "${owner}" = "bandit23" ]; then
            timeout -s 9 60 ./$i
        fi
        rm -f ./$i
    fi
done
```
If executed by bandit24, this bash script `cd`s to `/var/spool/bandit24` and executes all scripts owned by bandit23 inside using `timeout`. The easiest way to get the password is to `cat` it out to a file in `/tmp`.

```bash
# /var/spool/bandit24/script.sh
#!/bin/bash
cat /etc/bandit_pass/bandit24 > /tmp/bazinga/password.txt
```
Now, read the new file.

```bash
$ cat /tmp/bazinga/password.txt
UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ
```

## bandit25
Brute force the passcode to the process on port 30002.
```bash
$ nc localhost 30002
I am the pincode checker for user bandit25. Please enter the password for user bandit24 and the secret pincode on a single line, separated by a space.
0 0 0 0
Wrong! Please enter the correct current password. Try again.
```
Use a script to generate the codes.

```bash
#!/bin/bash
for i in {0..9999}; do
	echo $(cat /etc/bandit_pass/bandit24) $(printf "%04d" $i)
done

$ ./script.sh > codes.txt
```

Use pipe redirection to send the codes to `nc`.
```bash
$ cat codes.txt | nc localhost 30002
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
Wrong! Please enter the correct pincode. Try again.
...
Correct!
The password of user bandit25 is uNG9O58gUE7snukf3bvZ0rxhtnjzSGzG

Exiting.
```

## bandit26
Use the provided sshkey to login to bandit26 and break out of the custom shell. When logging into bandit26, custom text is shown, and we are immediately kicked out. One way to find the shell of a user is to `cat /etc/passwd`.
```bash
$ cat /etc/passwd
...
bandit26:x:11026:11026:bandit level 26:/home/bandit26:/usr/bin/showtext
...

$ cat /usr/bin/showtext
#!/bin/sh

export TERM=linux

more ~/text.txt
exit 0
```
To break out of `more`, we can shrink the terminal to keep `more` from exiting, then start `vi`. After starting `vi`, we can set the shell and start `bash` to get the password.
```vim
:set shell=bash
:shell
```

```bash
$ cat /etc/bandit_pass/bandit26
5czgV9L3Xx8JPOyRbXh6lQbmIOWvPT6Z
```

## bandit27
Use the setuid binary. Same solution as bandit20.
```bash
$ ls
bandit27-do  text.txt

$ ./bandit27-do cat /etc/bandit_pass/bandit27
3ba3118a22e93127a4ed485be72ef5ea
```

## bandit28
Clone the git repo and find the password.
```bash
$ git clone bandit27-git@localhost:~/repo
...

$ cd repo

$ ls
README

$ cat README
The password to the next level is: 0ef186ac70e04ea33b4c1853d2526fa2
```

## bandit29
Clone the git repo and find the password.
```bash
$ git clone bandit28-git@localhost:~/repo
...

$ cd repo

$ ls
README.md

$ cat README.md
# Bandit Notes
Some notes for level29 of bandit.

## credentials

- username: bandit29
- password: xxxxxxxxxx
```
The password seems to have been edited out. We can check the git logs to see edits.

```bash
$ git log
commit edd935d60906b33f0619605abd1689808ccdd5ee
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

    fix info leak

commit c086d11a00c0648d095d04c089786efef5e01264
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

    add missing data

commit de2ebe2d5fd1598cd547f4d56247e053be3fdc38
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

    initial commit of README.md

$ git show c086d11a00c0648d095d04c089786efef5e01264
commit c086d11a00c0648d095d04c089786efef5e01264
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:49 2020 +0200

    add missing data

diff --git a/README.md b/README.md
index 7ba2d2f..3f7cee8 100644
--- a/README.md
+++ b/README.md
@@ -4,5 +4,5 @@ Some notes for level29 of bandit.
 ## credentials

 - username: bandit29
-- password: <TBD>
+- password: bbc96594b4e001778eee9975372716b2
```

## bandit30
Clone the git repo and find the password.
```bash
$ git clone bandit-29@localhost:~/repo
...

$ cd repo

$ ls
README.md

$ cat README.md
# Bandit Notes
Some notes for bandit30 of bandit.

## credentials

- username: bandit30
- password: <no passwords in production!>

$ git log
commit 208f463b5b3992906eabf23c562eda3277fea912
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:51 2020 +0200

    fix username

commit 18a6fd6d5ef7f0874bbdda2fa0d77b3b81fd63f7
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:51 2020 +0200

    initial commit of README.md
```
Looking through the commits doesn't show anything of use. However, the `<no passwords in production!>` hints about another branch.

```bash
$ git checkout dev
Branch dev set up to track remote branch dev from origin.
Switched to a new branch 'dev'

$ git log
commit bc833286fca18a3948aec989f7025e23ffc16c07
Author: Morla Porla <morla@overthewire.org>
Date:   Thu May 7 20:14:52 2020 +0200

    add data needed for development

commit 8e6c203f885bd4cd77602f8b9a9ea479929ffa57
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:51 2020 +0200

    add gif2ascii

commit 208f463b5b3992906eabf23c562eda3277fea912
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:51 2020 +0200

    fix username

commit 18a6fd6d5ef7f0874bbdda2fa0d77b3b81fd63f7
Author: Ben Dover <noone@overthewire.org>
Date:   Thu May 7 20:14:51 2020 +0200

    initial commit of README.md

$ ls
code  README.md

$ cat README.md
# Bandit Notes
Some notes for bandit30 of bandit.

## credentials

- username: bandit30
- password: 5b90576bedb2cc04c86a9e924ce42faf
```

## bandit30
Clone the repo and find the password.
```bash
$ git clone bandit30-git@localhost:~/repo
...

$ cd repo

$ ls
README.md

$ cat README.md
just an epmty file... muahaha
```
The log doesn't show any other commits, and there aren't any branches. Another thing we can try is showing tags.

```bash
$ git tag
secret

$ git show secret
47e603bb428404d265f59c42920d81e5
```

## bandit31
Clone the repo and find the password.
```bash
$ git clone bandit31-git@localhost:~/repo
...

$ cd repo

$ ls
README.md

$ cat README.md
This time your task is to push a file to the remote repository.

Details:
    File name: key.txt
    Content: 'May I come in?'
    Branch: master
```
First, delete the .gitignore file preventing any `.txt` files from being added, then push `key.txt`.

```bash
$ rm .gitignore

$ echo 'May I come in?' > key.txt

$ git add . && git commit -m 'bazinga' && git push
...
remote: ### Attempting to validate files... ####
remote:
remote: .oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.
remote:
remote: Well done! Here is the password for the next level:
remote: 56a9bf19c63d650ce78e6ec0354ee45e
remote:
remote: .oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.oOo.
...
```

## bandit33
Break out of the UPPERCASE SHELL. Use the environment variable `$0` to execute the `sh` shell.
```bash
>> $0
$ whoami
bandit33

$ cat /etc/bandit_pass/bandit33
c9c3199ddf4121b10cf581a98d51caee
```
