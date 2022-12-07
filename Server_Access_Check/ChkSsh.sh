#!/usr/bin/env bash
# Define array
declare -a RESULT
declare -a PRESULT
# Color definition
RESET='\033[0m'
CO_BLACK='\033[0;30m'
CO_RED='\033[0;31m'
CO_GREEN='\033[0;32m'
CO_ORANGE='\033[0;33m'
CO_YELLOW='\033[1;33m'
CO_BLUE='\033[0;34m'
CO_LIGHT_BLUE='\033[1;34m'
CO_PURPLE='\033[0;35m'
CO_CYAN='\033[0;36m'
CO_WHITE='\033[0;37m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

# Start main
for SRV in $(cat server.lst)
do
        ping -w1 -c1 ${SRV} >/dev/null 2>&1
  if [[ $? -eq 0 ]]
        then
                ssh -x ${USER}@${SRV} 'ls' 2> /dev/null
                status=$?
                #printf "${SRV}: ${status}\n"
                if [[ ${status} -gt 0 ]]
                then
                        RESULT+=("$SRV")
                        printf "${CO_RED} Server: ${SRV}${RESET}\n"
                else
                        printf "${CO_GREEN}     Ok: ${SRV}${RESET}\n"
                fi
        else
                PRESULT+=("$SRV")
                printf "${CO_YELLOW}No ping: ${SRV}${RESET}\n"
        fi
done

# List summary
printf "\n========== List summary ==========\n"
printf "\nList not successfull connection.\n"
for i in ${!RESULT[*]}
do
        printf "${CO_RED}${RESULT[$i]}${RESET}\n"
done
printf "\nList not available.\n"
for i in ${!PRESULT[*]}
do
        printf "${CO_YELLOW}${PRESULT[$i]}${RESET}\n"
done
