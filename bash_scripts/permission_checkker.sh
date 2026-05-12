#!/bin/bash
DIR="/opt/121225-wde"
echo "До"
ls -la $DIR
for file in $DIR/*.sh;do
if [ -f "$file" ];then
chmod +x "$file"
fi
done
echo "После"
ls -la $DIR
