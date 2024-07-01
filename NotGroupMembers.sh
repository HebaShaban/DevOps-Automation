#!/usr/bin/bash
for user in $(cut -d: -f1 /etc/passwd)
do
if [[ $(id -nG $user | grep  -w "deployG") == "" ]]
then
echo $user
fi
done
