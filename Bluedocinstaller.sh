#|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
#|*    This code was written by    *|
#|*           BluedocTeam          *|
#|*  BlueDoc Text Editor was made  *|
#|*    for use in note taking      *|
#|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
#!/bin/bash
#version 2020.05.16
varcount=0
unset varfile
until [ $varfile = "n" ] 2>/dev/null; do
	echo "install bluedoc? y/n"
	unset varfile
	read varfile
	if [ $varfile = "y" ]; then	
		sudo mkdir /bluedoceditor
		sudo mv bluedoc /bluedoceditor
		sudo chmod +x /bluedoceditor/bluedoc
		echo "bluedoc installed"
		varcount=$((varcount + 1))
		varfile="n"

	elif [ $varfile != "y" ]; then
		echo "y/n only!"
	fi
done

unset varfile
until [ $varfile = "n" ] 2>/dev/null
do
	echo "would you like to use BlueOpen? y/n"
	read varfile
	if [ $varfile = "y" ]; then
		unset varfile
		sudo touch /bluedoceditor/BlueOpen.sh
		sudo echo '#|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
#|*    This code was written by    *|
#|*           BluedocTeam          *|
#|*  BlueDoc Text Editor was made  *|
#|*    for use in note taking      *|
#|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~| 
#!/bin/bash
#version 2020.06.28

clear && echo "BlueDoc editor -- version 20.06"
until [ $varfile = "q" ] 2>/dev/null
do
	if [ "$1" != "" ]; then
		/bluedoceditor/bluedoc $1 $$ clear
		exit
	fi
	echo "File name, cd, ls, or q:"; 	
	read -e varfile #ask which operation to do
    if [ $varfile = "ls" ]; then #ls
    	clear
	echo "you are here $(pwd)"
    	echo "     0  Exit" #adds top exit line
        ls -1pc | egrep -v / | cat -n #output only files, in a numbered list
       
        	echo "Select a value"
        	read -e varfile #ask which file to open; 
 				if [ $varfile = "0" ]; then #exit if 0
					clear && exit
				fi
        			varfile=$(ls -1pc | egrep -v / | head -$varfile | tail -1) #set varfile to selected file
        			/bluedoceditor/bluedoc $varfile #open selected file with bluedoc
    elif [ $varfile = "cd" ]; then #cd
    	clear
	echo "you are here $(pwd)"
    	echo "     0  Exit" #adds top exit line
    	ls -1cd */ | cat -n #output only directories, as a numbered list
    	    	
        	echo "Choose new location:";
    		read -e varfile #ask which directory to open
    		clear
    		if [ $varfile = "0" ]; then #exit if 0
					exit
			fi
    		varfile=$(ls -1cd */ | head -$varfile | tail -1) #set varfile to selected directory
    		cd $varfile #go to selected directory
	elif [ $varfile != "ls" ] && [ $varfile != "cd" ] && [ $varfile != "q" ]; then #check if text entered not operation
        /bluedoceditor/bluedoc $varfile #go to file entered    
    fi
clear
done
' >> /bluedoceditor/BlueOpen.sh 
		sudo chmod +x /bluedoceditor/BlueOpen.sh
		varcount=$((varcount + 1))
		echo "would you like to set up alias?"
		read varfile
	    if [ $varfile = "y" ]; then
			unset varfile 
			varfile=.bash_aliases
			if [ -f "$varfile" ]; then
    			sudo echo '
    			alias bluedoc=/bluedoceditor/BlueOpen.sh' >> .bash_aliases
    			echo "alias made in.bash_aliases"
    			varcount=$((varcount + 1))
    		else
    			sudo echo '
    			alias bluedoc=/bluedoceditor/BlueOpen.sh' >> .bashrc
    			echo "alias made in .bashrc"
    			varcount=$((varcount + 1))
    		fi
    	elif [ $varfile = "n" ]; then
    		echo ":("
		fi
		echo "blue open has been installed"
		varfile="n"
	elif [ $varfile != "y" ] && [ $varfile != "n" ]; then
		echo "y/n only!"
	fi
sudo rm Bluedocinstaller.sh
sudo rm README
done
echo "Install Complete $varcount actions preformed!" && exit
