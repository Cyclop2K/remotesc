#!/bin/bash
###############################################################
#Name: Michael White     lecturer's name: Anatoly             #
#Magen773619:s5:NetworkResearch                               #
#                                                             #  
#sites used >                                                 #
#https://chat.openai.com                                      #     
#https://ansi.gabebanks.net/                                  #
#https://gabebanks.net/                                       #
#https://ipapi.co/                                            #
#https://www.baeldung.com/linux/run-shell-script-remote-ssh   #
###############################################################
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
default='\033[39;49;0m'
redbold='\033[31;40;1m'
greenbold='\033[32;40;1m'
cyanbold='\033[36;1m'
# check if an application is installed
is_installed() {
    command -v "$1" >/dev/null 2>&1
}

# applications to be installed
applications=("curl" "whois" "nmap")

# Iterate through the applications and install if not already installed
for app in "${applications[@]}"; do
    if ! is_installed "$app"; then
        echo "Installing $app..."
        # Add installation command for each application
        case "$app" in
            "application1")
                # Installation command for application1
                sudo apt-get install -y application1
                ;;
            "application2")
                # Installation command for application2
                sudo apt-get install -y application2
                ;;
            "application3")
                # Installation command for application3
                sudo apt-get install -y application3
                ;;
            *)
                echo "Unknown application: $app"
                ;;
        esac
    else
        echo "[#]$app is already installed."
    fi
done
# Running Nipe COMMANDS to ensure ANONYMOUS Connection 
cd /home/kali/nipe ; sudo perl nipe.pl start
cd /home/kali/nipe ; sudo perl nipe.pl restart
echo -e "${red}####################################################${default}"
# Retrieve public IP address using an external API service
public_ip=$(curl -sSf "https://api.ipify.org")
# Check if the public IP address is obtained successfully
if [ -n "$public_ip" ]; then
  echo -e "Your public IP address is: ${green}$public_ip${default}"
else
  echo "Failed to retrieve the public IP address."
fi
echo -e "${red}####################################################${default}"
# Check if the IP address is associated with Israel
is_israeli_ip=false
if [[ $(curl -sSf "http://ip-api.com/json/$public_ip" | awk -F'"' '/country/{print $8}') == "Israel" ]]; then
    is_israeli_ip=true
fi

# Check if the connection is anonymous and display the spoofed country
if [ "$is_israeli_ip" = false ]; then
    spoofed_country=$(curl -sSf "http://ip-api.com/json/$public_ip" | awk -F'"' '/country/{print $8}')
    echo -e "${greenbold}Network connection is anonymous.${default}"
    echo -e "[*]Spoofed country: ${green}$spoofed_country${default}, Your Spoofed IP address: ${green}$public_ip${default}"
else
    echo -e "${redbold}Network connection is not anonymous. Alerting user and exiting...${default}"
    echo "Running nipe commands"
    exit 1
fi
echo -e "${red}####################################################${default}"
# Prompt the user to enter the domain or IP address to scan
read -p "[?]Specify a Domain/IP to scan: " aaddress
#remote server details
remote_server='127.0.0.1'
remote_username='kali'
remote_password='kali'
# Output file paths
log_file='/home/kali/Desktop/data_collection.log'
whois_file='/home/kali/Desktop/whois_data.txt'
nmap_file='/home/kali/Desktop/nmap_data.txt'
# Log function to write entries to the log file
log() {
    echo "$(date): $1" >> "$log_file"
}

# SSH connection and command execution
echo -e "${blue}Connecting to the remote Server.${default}"
sshpass -p "$remote_password" ssh -q -T "$remote_username@$remote_server" > /dev/null 2>&1
    echo "Uptime: $(uptime)"
    echo "IP Address: $aaddress"
    echo "Country: $(curl -sSf "http://ip-api.com/json/$aaddress" | awk -F'"' '/country/{print $8}')"
	echo -e "${red}####################################################${default}"
	##whois
    echo "[*] Whoising Victim's address: $aaddress"
    echo "[@] Data saved into $whois_file"
    whois $aaddress > $whois_file
    ##nmap
    echo "[*] Scanning Victim's address: $aaddress"
    echo "[@] Data saved into $nmap_file"
    nmap -p- $aaddress > $nmap_file
    echo -e "${cyanbold}[!]Data collection completed successfully[!]${default}"
    # Create a log entry for the data collection
	log "Data collection completed for address: $aaddress"
echo -e "${redbold}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${default}"    
	echo -e "Thanks for using My Script :D, bye"
	exit 1
########EOF_SCRIPT##########
