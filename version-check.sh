#!/bin/bash
#simple script to list the version numbers of critical dev. tools.
 #version of bash
bash --version | head -n1 | cut -d" " -f2-4
 #Is /bin/sh pointing bash?
MYSH=$(readlink -f /bin/sh)
echo "/bin/sh -> $MYSH"
echo $MYSH | grep -q bash || echo "ERROR: /bin/sh doesn't point to bash"
unset MYSH
 
 echo -n "Binutils: "; ld --version | head -n1 | cut -d" " -f3-
 #bison v2.3 must be installed on U16.04
bison --version | head -n1

if [ -h /usr/bin/yacc ]; then
  echo "/usr/bin/yacc -> `readlink -f /usr/bin/yacc`";
elif [ -x /usr/bin/yacc ]; then
  echo yacc is `/usr/bin/yacc --version | head -nq`
else 
  echo "yacc not found"
fi
 #version of bzip2
bzip2 --version 2>&1</dev/null | head -n1 | cut -d" " -f1,6-
echo -n "Coreutils:" ;chown --version | head -n1 | cut -d")" -f2
diff --version | head -n1
find --version | head -n1
gawk --version | head -n1

#for more understanding http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
if [ -h /usr/bin/awk ]; then
  echo "/usr/bin/awk -> `readlink -f /usr/bin/awk`";
elif [ -x /usr/bin/awk ];then 
  echo "awk is `/usr/bin/awk --version | head -n1`";
else
echo "awk not found"
fi

gcc --version | head -n1
g++ --version | head -n1
ldd --version | head -n1
grep --version | head -n1
gzip --version | head -n1
cat /proc/version
m4 --version | head -n1
make --version | head -n1
patch --version | head -n1
echo "Perl `perl -V:version`"
sed --version | head -n1
tar --version | head -n1
makeinfo --version | head -n1
xz --version | head -n1

#test a c program
echo "int main(){}" > dummy.c && g++ -o dummy dummy.c
if [ -x dummy ]
 then echo "g++ compilation OK"
else echo "g++ compilation failed" ; fi
rm -f dummy dummy.c
