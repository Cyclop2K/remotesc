```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```

# remotesc is a script for REMOTE CONTROL using bash


Anonymously(using NIPE) and Automatically Connect and Execute Commands on the Remote Server via SSH


input any IP/DNS address to scan and check the Whois of the given address after connecting to remote server via SSH 




log file and nmap+whois files will be saved on machine

example of the script running >






![anonymous](https://github.com/Cyclop2K/remotesc/assets/137298756/c0dcba7a-5a14-4c45-b6a0-0140cbd8eebf)


to run this script please use >

chmod +x remotesc.sh

./remotesc.sh

**** make sure you have NIPE installed on your machine ****


if your not from israel and from other country make sure to change this section in the script to your country >>>>


is_israeli_ip=false
if [[ $(curl -sSf "http://ip-api.com/json/$public_ip" | awk -F'"' '/country/{print $8}') == "<span style="color: green"> COUNTRY </span>
" ]]; then
    is_israeli_ip=true
fi
