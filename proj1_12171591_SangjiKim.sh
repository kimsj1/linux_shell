#! /bin/bash
CH=0
agr=n
old=a
new=b
if [ $# -ne 1 ]
then
	echo "Usage: $0 filename"
	exit 1
fi
echo "[Source code]"
cat $1
echo "---------------------------------------------"
echo "User Name: Sangji Kim" ; echo "Student Number: 12171591"
echo "[ MENU ]"
echo -e '1. Enable/disable empty line removal\n2. Enable/disable comment removal\n3. Enable/disable duplicate whitespaces among words\n4. Add the line number\n5. Change the variable name\n6. Remove ${} in arithmathic expansion\n7. Export new file\n8. Exit\n---------------------------------------------'
while (( CH != 8 ))
do	
	read -p "Enter your choice [ 1-8 ] " CH
	if (( CH == 1 )); then
		read -p "Do you want to remove all blank line?(y/n): " agr
		if [ "$agr" == "y" ]; then
			cat $1 | sed '/^$/d'
		fi
	elif (( CH == 2 )); then
		read -p "Do you want to remove all comment?(y/n): " agr
		if [ "$agr" == "y" ]; then
			cat $1 | sed '/# /d'
		fi
	elif (( CH == 3 )); then
		read -p "Do you want to remove duplicate whitespaces?(y/n): " agr
		if [ "$agr" == "y" ]; then
			cat $1 | sed -E 's/([a-z0-9])[\t ]{2,4}/\1 /g'
		fi	
	elif (( CH == 4 )); then
		read -p "Where you want to add whether the start or the end of the lin. (s/e): " agr
		if [ "$agr" == "s" ]; then
			cat $1 | awk '{print "#",NR,$0}'
		else
			cat $1 | awk '{print $0,"#",NR}'
		fi	
	elif (( CH == 5 )); then
		read -p "Do you want to change a variable name?(y/n): " agr
		if [ "$agr" == "y" ]; then
			read -p "Variable name to be changed: " old
			read -p "New variable name: " new
			cat $1 | sed "s/$old/$new/g"
		fi	
	elif (( CH == 6 )); then
		read -p 'Do you want to remove ${} ?(y/n): ' agr
		if [ "$agr" == "y" ]; then
			cat $1 | sed -E 's/\$\{([^}]*)\}/\1/g'
		fi
	elif (( CH == 7 )); then
		read -p "Do you want to apply all settings and create a new file?(y/n): " agr
		if [ "$agr" == "y" ]; then
		cat $1 | sed '/^$/d' | sed '/# /d' | sed -E 's/([a-z0-9])[\t ]{2,4}/\1 /g' | sed -E 's/\$\{([^}]*)\}/\1/g' > new_testing.sh
		read -p "Where you want to add whether the start or the end of the lin. (s/e): " agr				
		read -p "Variable name to be changed: " old
		read -p "New variable name: " new
		cat new_testing.sh | sed "s/$old/$new/g" > new_testing.sh
		if [ "$agr" == "s" ]; then
			cat new_testing.sh | awk '{print "#",NR,$0}' > new_save_file.sh
		else
			cat new_testing.sh | awk '{print $0,"#",NR}' > new_save_file.sh
		fi
		rm new_testing.sh
		cat new_save_file.sh
		echo "new file name : new_save_file.sh  is created!"
		fi	
	elif (( CH == 8 )); then
		echo "Bye!"
	else
		echo 'You should enter number 1-8'	
	fi
done
exit 0
