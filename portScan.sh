#!/bin/bash
#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n ${redColour}[!] Saliendo ... ${endColour}\n"
  tput cnorm; exit 1
}

#Ctrl C 
trap ctrl_c INT
tput cnorm 

#tput civis # Ocultar el cursor
#for port in $(seq 1 65535); do 
# (echo '' > /dev/tcp/192.168.15.103/$port) 2>/dev/null && echo "[+] $port - Open" &
#done; wait

# Recuperamos el cursor
tput cnorm 

function helpPanel(){
  echo -e "\n ${yellowColour}[*] Herramienta para realizar un escaneo de puertos en una ip específica${endColour}\n\n${blueColour} ----> Uso ${endColour}" 
  echo -e "\n\t${redColour}   -i Con este parámetro se especifica a que ip se le quiere hacer el escaneo${endColour}"
  echo -e "\n\t${greenColour}   -h Mostrar este panel de ayuda${endColour}"
}

function portScan(){
  ip_to_scan="$1"
  echo -e "${yellowColour}[*] ${endColour}${grayColour}Se hara el escaneo de ${endColour}${blueColour}65535${endColour}${grayColour} puertos en la ip${endColour} ${blueColour}$ip_to_scan${endColour}"
  
 for port in $(seq 1 65535); do
    (echo -e'' > /dev/tcp/${ip_to_scan}/$port) 2>/dev/null && echo -e "${yellowColour}[P]${endColour} ${blueColour}$port${endColour}${grayColour} ---> ${endColour}${greenColour}Abierto!${endColour}" &
 done; wait 

}


#Indicadores 
declare -i parameter_counter=0

while getopts "i:h" arg; do 
  case $arg in 
    i) ip_to_scan=$OPTARG; let parameter_counter+=1;;
    h) helpPanel=$OPTARG; let parameter_counter+=2;;
  esac
done

if [ $parameter_counter -eq 1 ]; then 
  portScan "$ip_to_scan"
else 
  helpPanel
fi
