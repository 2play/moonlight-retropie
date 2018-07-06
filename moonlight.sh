#!/bin/bash
# Based on Jessie Moonlight Script by TechWizTime.
# New Script Revamped by 2Play!
# Stretch OS Install Supported

echo -e "\n****************************************************************"
echo -e "   Moonlight Installer (Steam) Script for RetroPie v07.18.2P!"
echo -e "****************************************************************\n"
echo -e "Select an option:"
echo -e " * 1: Step.1: Fresh Install Moonlight & ES System Menu - Stretch OS"
echo -e " * 2: Step.1: Fresh Install Moonlight & ES System Menu - Jessie OS"
echo -e " * 3: Step.2: Pair Moonlight with a PC"
echo -e " * 4: Step.3: Install 750p & 1080p Steam Launch Scripts"
echo -e " * 5: Remove Steam Launch Scripts"
echo -e " * 6: Install 480p Steam Launch Scripts"
echo -e " * 7: Moonlight Script Update"
echo -e " * 8: Exit"

read NUM
case $NUM in
	1)
		echo -e "\n  Installing Moonlight - Stretch OS   "
		echo -e "*****************************************\n"
		
		if grep -q "deb http://archive.itimmer.nl/raspbian/moonlight stretch main" /etc/apt/sources.list; then
			echo -e "NOTE: Moonlight Source Exists - Skipping"
		else
			echo -e "Adding Moonlight to Sources List"
			echo "deb http://archive.itimmer.nl/raspbian/moonlight stretch main" >> /etc/apt/sources.list
		fi

		echo -e "\n        Install the GPG key           "
		echo -e "****************************************\n"
		
		if [ -f /home/pi/code/moonlight/itimmer.gpg ]
		then	
			echo -e "NOTE: GPG Key Exists - Skipping"
		else		
			mkdir code && cd code && mkdir moonlight && cd ~/code/moonlight
			wget http://archive.itimmer.nl/itimmer.gpg
			chown pi:pi /home/pi/itimmer.gpg
			apt-key add itimmer.gpg		
		fi

		echo -e "\n  System Update & Moonlight Install   "
		echo -e "****************************************\n"
		apt-get update -y
		apt-get install moonlight-embedded -y
		
		
		echo -e "\n     Create STEAM ES System Menu      "
		echo -e "****************************************\n"
		
		if grep -q "<platform>steam</platform>" /etc/emulationstation/es_systems.cfg; then
			echo -e "NOTE: Steam Entry Exists - Skipping"
		else
			echo -e "Adding Steam to Systems"
			sudo sed -i -e 's|</systemList>|  <system>\n    <name>steam</name>\n    <fullname>Steam</fullname>\n    <path>~/RetroPie/roms/moonlight</path>\n    <extension>.sh .SH</extension>\n    <command>bash %ROM%</command>\n    <platform>steam</platform>\n    <theme>steam</theme>\n  </system>\n</systemList>|g' /etc/emulationstation/es_systems.cfg
		fi

		chown -R pi:pi /home/pi/RetroPie/roms/steam/

		echo -e "Installation Completed."
		echo -e "We need to perform a reboot now."
		read -p "Reboot Now (y/n)?" choice
		case "$choice" in 
		  y|Y ) sudo reboot;;
		  n|N ) cd /home/pi/RetroPie/retropiemenu
		  ./moonlight.sh
		  ;;
		  * ) echo "invalid";;
		esac
	;;

	2)
		echo -e "\n   Installing Moonlight - Jessie OS    "
		echo -e "*****************************************\n"
		
		if grep -q "deb http://archive.itimmer.nl/raspbian/moonlight stretch main" /etc/apt/sources.list; then
			echo -e "NOTE: Moonlight Source Exists - Skipping"
		else
			echo -e "Adding Moonlight to Sources List"
			echo "deb http://archive.itimmer.nl/raspbian/moonlight stretch main" >> /etc/apt/sources.list
		fi

		echo -e "\n        Install the GPG key           "
		echo -e "****************************************\n"
		
		if [ -f /home/pi/code/moonlight/itimmer.gpg ]
		then	
			echo -e "NOTE: GPG Key Exists - Skipping"
		else		
			mkdir code && cd code && mkdir moonlight && cd ~/code/moonlight
			wget http://archive.itimmer.nl/itimmer.gpg
			chown pi:pi /home/pi/itimmer.gpg
			apt-key add itimmer.gpg		
		fi

		echo -e "\n  System Update & Moonlight Install   "
		echo -e "****************************************\n"
		apt-get update -y
		apt-get install moonlight-embedded -y
		
		
		echo -e "\n     Create STEAM ES System Menu      "
		echo -e "****************************************\n"
		
		if grep -q "<platform>steam</platform>" /etc/emulationstation/es_systems.cfg; then
			echo -e "NOTE: Steam Entry Exists - Skipping"
		else
			echo -e "Adding Steam to Systems"
			sudo sed -i -e 's|</systemList>|  <system>\n    <name>steam</name>\n    <fullname>Steam</fullname>\n    <path>~/RetroPie/roms/moonlight</path>\n    <extension>.sh .SH</extension>\n    <command>bash %ROM%</command>\n    <platform>steam</platform>\n    <theme>steam</theme>\n  </system>\n</systemList>|g' /etc/emulationstation/es_systems.cfg
		fi

		chown -R pi:pi /home/pi/RetroPie/roms/steam/

		echo -e "Installation Completed."
		echo -e "We need to perform a reboot now."
		read -p "Reboot Now (y/n)?" choice
		case "$choice" in 
		  y|Y ) sudo reboot;;
		  n|N ) cd /home/pi/RetroPie/retropiemenu
		  ./moonlight.sh
		  ;;
		  * ) echo "invalid";;
		esac
	;;

	3) 
		echo -e "\n  Pair Moonlight With A PC    "
		echo -e "********************************\n"
		
		echo -e "Once IP inserted of your STEAM PC, you will be given a PIN"
		echo -e "Input this on the STEAM PC to pair with Moonlight. \n"
		read -p "Input STEAM PC's IP Address here :`echo $'\n> '`" ip
		sudo -u pi moonlight pair $ip
		
		echo -e "\n*** Pairing Complete! ***"
		cd /home/pi/RetroPie/retropiemenu
		./moonlight.sh
	;;

	4)
		echo -e "\n Create 720p + 1080p Steam Launch Scripts   "
		echo -e "**********************************************\n"
		
		echo -e "Create Script Folder"
		mkdir -p /home/pi/RetroPie/roms/steam
		cd /home/pi/RetroPie/roms/steam
		
		echo -e "Creating 720p & 1080p Scripts"
		if [ -f /home/pi/RetroPie/roms/steam/720p30fps.sh ]; then
			echo -e "NOTE: 720p30fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 720p30fps.sh
			echo "moonlight stream -720 -fps 30 "$ip"" >>  720p30fps.sh
		fi
		
		if [ -f /home/pi/RetroPie/roms/steam/720p60fps.sh ]; then
			echo -e "NOTE: 720p60fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 720p60fps.sh
			echo "moonlight stream -720 -fps 60 "$ip"" >>  720p60fps.sh
		fi
		
		if [ -f /home/pi/RetroPie/roms/steam/1080p30fps.sh ]; then
			echo -e "NOTE: 1080p30fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 1080p30fps.sh
			echo "moonlight stream -1080 -fps 30 "$ip"" >>  1080p30fps.sh
		fi
		
		if [ -f /home/pi/RetroPie/roms/steam/1080p60fps.sh ]; then
			echo -e "NOTE: 1080p60fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 1080p60fps.sh
			echo "moonlight stream -1080 -fps 60 "$ip"" >>  1080p60fps.sh
		fi
		
		echo -e "Make Scripts Executable"
		chmod +x 720p30fps.sh
		chmod +x 720p60fps.sh
		chmod +x 1080p30fps.sh
		chmod +x 1080p60fps.sh
		
		echo -e "\n*** 720p + 1080p Steam Launch Scripts Creation Completed! ***"
		cd cd /home/pi/RetroPie/retropiemenu
		./moonlight.sh
	;;

	5)
		echo -e "\n Remove All Steam Launch Scripts   "
		echo -e "*************************************\n"
		cd /home/pi/RetroPie/roms/steam
		rm *
		echo -e "\n*** Removal Completed! ***"
		cd /home/pi/RetroPie/retropiemenu
		./moonlight.sh
	;;

	6)  
		echo -e "\n Create 480p Steam Launch Scripts   "
		echo -e "**************************************\n"
		
		echo -e "Create Script Folder"
		mkdir -p /home/pi/RetroPie/roms/steam
		cd /home/pi/RetroPie/roms/steam
		
		echo -e "Creating 480p Scripts"
		
		if [ -f /home/pi/RetroPie/roms/steam/480p30fps.sh ]; then
			echo -e "NOTE: 480p30fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 480p30fps.sh
			echo "moonlight stream -width 640 -height 480 -fps 30 "$ip"" >>  480p30fps.sh
		fi
				
		if [ -f /home/pi/RetroPie/roms/steam/480p60fps.sh ]; then
			echo -e "NOTE: 480p60fps Exists - Skipping"
		else
			echo "#!/bin/bash" > 480p60fps.sh
			echo "moonlight stream -width 640 -height 480 -fps 60 "$ip"" >>  480p60fps.sh
		fi
		
		echo -e "Make 480p Scripts Executable"
		chmod +x 480p30fps.sh
		chmod +x 480p60fps.sh
		
		echo -e "\n*** 480p Steam Launch Scripts Completed! ***"
		cd /home/pi/RetroPie/retropiemenu
		./moonlight.sh
	;;

	7) 
		echo -e "\n  Update This Script    "
		echo -e "**************************\n"
		
		if [ -f /home/pi/RetroPie/retropiemenu/moonlight.sh ]
		then	
			rm /home/pi/RetroPie/retropiemenu/moonlight.sh
		fi
		cd /home/pi/RetroPie/retropiemenu		
		wget https://raw.githubusercontent.com/2play/moonlight-steam-script-retropie/master/moonlight.sh
		chown pi:pi ./moonlight.sh
		chmod +x moonlight.sh
		./moonlight.sh
	;;

	8)  exit 1;;
		
	*) echo "INVALID NUMBER!" ;;
esac
