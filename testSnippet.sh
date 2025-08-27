#! /bin/bash

##Parsing the current path as the script root folder to avoid any bugs. 
if [ ! -f ritornello.ly ]; then echo -e "\nChange directory to the snippet folder!\nExiting...\n" && exit ; else echo -e "\nStarting test..."; fi
rootIsHere=$(echo "$(dirname $(readlink -f ritornello.ly))/")
cd $rootIsHere
cd ./test/
rm *.pdf
##
echo -e "\n$(ls -l | grep .ly)"
echo -e "\nNumber of files to be tested: $(echo "$(ls -l | grep .ly)" | grep -c ".*")!"
##
for arquivo in *.ly; do 
	echo -e "\nTesting file: $arquivo\n"
	lilypond $arquivo ; done
##
echo -e "\n$(ls -l | grep .pdf)"
echo -e "\nNumber of files that were generated: $(echo "$(ls -l | grep .pdf)" | grep -c ".*")!"
##
cd "$rootIsHere"
echo -e "\n"
exit