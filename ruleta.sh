#!/bin/bash

# Author: briancgx
figlet -w 80 "By:  briancgx"

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


function ctrl_c () {
    echo -e "\n\n${redColour}[!] Leaving...${endColour}\n"
    tput cnorm; exit 1
}


# Ctrl+C
trap ctrl_c INT

function helpPanel () {
    echo -e "\n${yellowColour}[!]${endColour}${grayColour} Usage:${endColour}${purpleColour} $0 ${endColour} $greenColour-m <money> -t <technique>${endColour}"
    echo -e "\t${yellowColour}-m${endColour}${grayColour}:${endColour}${purpleColour} Amount of money to bet.${endColour}"
    echo -e "\t${yellowColour}-t${endColour}${grayColour}:${endColour}${purpleColour} Technique to use.${endColour}"
    echo -e "\n\t${yellowColour}Techniques:${endColour}"
    echo -e "\t\t${yellowColour}1${endColour}${grayColour}:${endColour}${purpleColour} martingala${endColour}"
    echo -e "\t\t${yellowColour}2${endColour}${grayColour}:${endColour}${purpleColour} inverseLabrouchere${endColour}"
    exit 1
}

function martingala () {
    echo -e "\n${purpleColour}[+]${endColour} ${greenColour}Martingala${endColour}"
    echo -e "${purpleColour}[+]${endColour} ${greenColour}Current money:${endColour} ${yellowColour}$money\$ ${endColour}"
    echo -ne "${purpleColour}[+]${endColour} ${greenColour}How much money do you plan to bet? -> ${endColour}" && read initial_bet
    echo -ne "${purpleColour}[+]${endColour} ${greenColour}What do you want to continuosly bet on? (par/impar) -> ${endColour}" && read par_impar
    
    #    echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Let's play with a initial bet of ${endColour}${blueColour}$initial_bet\$ ${endColour} ${yellowColour}on${endColour} ${blueColour}$par_impar${endColour}"
    
    backup_bet=$initial_bet
    
    gameCounter=1
    maxMoney=0
    badGames=""
    maxMoney=$initial_bet
    
    
    tput civis
    while true; do
        money=$(($money-$initial_bet))
        #        echo -e "\n${purpleColour}[+]${endColour} ${greenColour}You just bet${endColour} ${yellowColour}$initial_bet\$${endColour} ${greenColour}and now you have${endColour} ${yellowColour}$money\$${endColour} ${greenColour}left${endColour}"
        random_number="$(( $RANDOM % 37 ))"
        #        echo -e "${purpleColour}[+]${endColour} ${greenColour}The number is${endColour} ${yellowColour}$random_number${endColour}"
        if [ $money -gt $maxMoney ]; then
            maxMoney=$money
        fi
        if [ ! "$money" -lt 0 ]; then
            if [ "$par_impar" == "par" ]; then
                if [ "$(($random_number % 2))" -eq 0 ]; then
                    if [ "$random_number" -eq 0 ]; then
                        echo -e "${purpleColour}[+]${endColour} ${redColour}The number is 0, you lose ${endColour}"
                        initial_bet=$(($initial_bet*2))
                        badGames+="$random_number "
                        if [ $money -gt $maxMoney ]; then
                            maxMoney=$money
                        fi
                        #                        echo -e "${purpleColour}[+]${endColour} ${grayColour}Right now you're left with ${endColour}${yellowColour}$money\$${endColour} ${grayColour}and you're going to bet${endColour} ${yellowColour}$initial_bet\$${endColour}"
                    else
                        #                        echo -e "${purpleColour}[+]${endColour} ${greenColour}The number is even, you win!${endColour}"
                        reward=$(($initial_bet*2))
                        #                        echo -e "${purpleColour}[+]${endColour} ${greenColour}You just won${endColour} ${yellowColour}$reward\$${endColour}"
                        money=$(($money+$reward))
                        #                        echo -e "${purpleColour}[+]${endColour} ${grayColour}Now you have${endColour} ${yellowColour}$money\$${endColour}"
                        initial_bet=$backup_bet
                        
                        badGames=""
                        if [ $money -gt $maxMoney ]; then
                            maxMoney=$money
                        fi
                    fi
                else
                    #                    echo -e "${purpleColour}[+]${endColour} ${redColour}The number is odd, you lose ${endColour}"
                    initial_bet=$(($initial_bet*2))
                    badGames+="$random_number "
                    if [ $money -gt $maxMoney ]; then
                        maxMoney=$money
                    fi
                    #                    echo -e "${purpleColour}[+]${endColour} ${grayColour}Right now you're left with ${endColour}${yellowColour}$money\$${endColour} ${grayColour}and you're going to bet${endColour} ${yellowColour}$initial_bet\$${endColour}"
                fi
            else
                if [ "$par_impar" == "impar" ]; then
                    if [ "$(($random_number % 2))" -eq 1 ]; then
                        if [ "$random_number" -eq 0 ]; then
                            #                            echo -e "${purpleColour}[+]${endColour} ${redColour}The number is 0, you lose ${endColour}"
                            initial_bet=$(($initial_bet*2))
                            #                            echo -e "${purpleColour}[+]${endColour} ${grayColour}Right now you're left with ${endColour}${yellowColour}$money\$${endColour} ${grayColour}and you're going to bet${endColour} ${yellowColour}$initial_bet\$${endColour}"
                            badGames+="$random_number "
                            if [ $money -gt $maxMoney ]; then
                                maxMoney=$money
                            fi
                        else
                            #                            echo -e "${purpleColour}[+]${endColour} ${greenColour}The number is odd, you win!${endColour}"
                            reward=$(($initial_bet*2))
                            money=$(($money+$reward))
                            initial_bet=$backup_bet
                            #                            echo -e "${purpleColour}[+]${endColour} ${grayColour}Now you have${endColour} ${yellowColour}$money\$${endColour}"
                            badGames=""
                            if [ $money -gt $maxMoney ]; then
                                maxMoney=$money
                            fi
                        fi
                    else
                        #                        echo -e "${purpleColour}[+]${endColour} ${redColour}The number is even, you lose ${endColour}"
                        initial_bet=$(($initial_bet*2))
                        #                        echo -e "${purpleColour}[+]${endColour} ${grayColour}Right now you're left with ${endColour}${yellowColour}$money\$${endColour} ${grayColour}and you're going to bet${endColour} ${yellowColour}$initial_bet\$${endColour}"
                        badGames+="$random_number "
                        if [ $money -gt $maxMoney ]; then
                            maxMoney=$money
                        fi
                    fi
                    
                fi
            fi
        else
            # No money left
            echo -e "\n${redColour}[!] You don't have any money left${endColour}\n"
            echo -e "${purpleColour}[+]${endColour} ${greenColour}You played${endColour} ${yellowColour}$(($gameCounter-1))${endColour} ${greenColour}games${endColour}"
            echo -e "${purpleColour}[+]${endColour} ${greenColour}You lost in the following games:${endColour} ${redColour}[ $badGames]${endColour}\n"
            echo -e "${purpleColour}[+]${endColour} ${greenColour}The most money you had was${endColour} ${yellowColour}$maxMoney\$${endColour}\n"
            tput cnorm; exit 0
        fi
        
        let gameCounter+=1
        
    done
    
    tput cnorm
}

function inverseLabrouchere () {
    echo -e "\n${purpleColour}[+]${endColour} ${greenColour}Inverse Labouchere${endColour}"
    echo -e "${purpleColour}[+]${endColour} ${greenColour}Current money:${endColour} ${yellowColour}$money\$ ${endColour}"
    echo -ne "${purpleColour}[+]${endColour} ${greenColour}What do you want to continuosly bet on? (par/impar) -> ${endColour}" && read par_impar
    declare -a my_sequence=(1 2 3 4)
    
    echo -e "\n${turquoiseColour}[+]${endColour} ${yellowColour}Start with a sequence of numbers${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
    
    bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
    
    totalGames=0
    betRenew=$(($money+50)) # 50 is the minimum amount of money to renew the sequence
    maxMoney=$money # Maximum amount of money
    echo -e "${purpleColour}[+]${endColour} ${greenColour}The sequence will be renewed when you have${endColour} ${yellowColour}$betRenew\$${endColour}"
    
    tput civis
    
    while true; do
        let totalGames+=1
        random_number=$(( $RANDOM % 37 ))
        money=$(($money-$bet))
        if [ $money -gt $maxMoney ]; then
            maxMoney=$money
        fi
        
        if [ ! "$money" -lt 0 ]; then
            
            echo -e "\n${turquoiseColour}[+]${endColour} ${yellowColour}We invest $bet\$${endColour}"
            echo -e "${purpleColour}[+]${endColour} ${greenColour}Current money:${endColour} ${yellowColour}$money\$ ${endColour}"
            
            echo -e "${purpleColour}[+]${endColour} ${greenColour}The number is${endColour} ${yellowColour}$random_number${endColour}"
            
            if [ "$par_impar" == "par" ]; then
                if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
                    echo -e "${purpleColour}[+]${endColour} ${greenColour}The number is even, you win!${endColour}"
                    reward=$(($bet*2))
                    money=$(($money+$reward))
                    echo -e "${purpleColour}[+]${endColour} ${greenColour}You just won${endColour} ${yellowColour}$reward\$${endColour}"
                    echo -e "${purpleColour}[+]${endColour} ${greenColour}Now you have${endColour} ${yellowColour}$money\$${endColour}"
                    if [ "$money" -gt "$maxMoney" ]; then
                        maxMoney=$money
                    fi
                    if [ $money -gt $betRenew ]; then
                        echo -e "\n${purpleColour}[+]${endColour} ${yellowColour}It has exceeded the limit of $betRenew\$ to renew the sequence${endColour}"
                        betRenew=$(($betRenew+50))
                        echo -e "${purpleColour}[+]${endColour} ${greenColour}The limit is now${endColour} ${yellowColour}$betRenew\$${endColour}"
                        my_sequence=(1 2 3 4)
                        bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                        echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Restarting sequence${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                    else
                        my_sequence+=($bet)
                        my_sequence=(${my_sequence[@]})
                        
                        echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}The sequence is now${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                        if [ "${#my_sequence[@]}" -ne 1 ]; then
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                            elif [ "${#my_sequence[@]}" -eq 1 ]; then
                            bet=${my_sequence[0]}
                        else
                            echo -e "${redColour}[!] The sequence is empty${endColour}"
                            my_sequence=(1 2 3 4)
                            echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Restarting sequence${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                        fi
                    fi
                    
                    elif [ "$((random_number % 2))" -eq 1 ] || [ $random_number -eq 0 ]; then
                    if [ "$((random_number % 2))" -eq 1 ]; then
                        echo -e "${purpleColour}[+]${endColour} ${redColour}The number is odd, you lose ${endColour}"
                    else
                        echo -e "${purpleColour}[+]${endColour} ${redColour}The number is 0, you lose ${endColour}"
                    fi
                    
                    if [ $money -lt $(($betRenew-100)) ]; then
                        echo -e "\n${purpleColour}[+]${endColour} ${yellowColour}We have reached a critical number; the limit will be reduced${endColour}"
                        betRenew=$(($betRenew-50))
                        echo -e "${purpleColour}[+]${endColour} ${greenColour}The limit is now${endColour} ${yellowColour}$betRenew\$${endColour}"
                        
                        unset my_sequence[0]
                        unset my_sequence[-1] 2> /dev/null
                        
                        my_sequence=(${my_sequence[@]})
                        
                        echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}The sequence is now${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                        if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
                            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                            elif [ "${#my_sequence[@]}" -eq 1 ]; then
                            bet=${my_sequence[0]}
                        else
                            echo -e "${redColour}[!] The sequence is empty${endColour}"
                            my_sequence=(1 2 3 4)
                            echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Restarting sequence${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                        fi
                    else
                        unset my_sequence[0]
                        unset my_sequence[-1] 2> /dev/null
                        
                        my_sequence=(${my_sequence[@]})
                        
                        echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}The sequence is now${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                        if [ "${#my_sequence[@]}" -ne 1 ]  && [ "${#my_sequence[@]}" -ne 0 ]; then
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                            elif [ "${#my_sequence[@]}" -eq 1 ]; then
                            bet=${my_sequence[0]}
                        else
                            echo -e "${redColour}[!] The sequence is empty${endColour}"
                            my_sequence=(1 2 3 4)
                            echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Restarting sequence${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                        fi
                    fi
                fi
                
                elif [ "$par_impar" == "impar" ]; then
                if [ "$(($random_number % 2))" -eq 1 ]; then
                    echo -e "${purpleColour}[+]${endColour} ${greenColour}The number is odd, you win!${endColour}"
                    reward=$(($bet*2))
                    money=$(($money+$reward))
                    echo -e "${purpleColour}[+]${endColour} ${greenColour}You just won${endColour} ${yellowColour}$reward\$${endColour}"
                    echo -e "${purpleColour}[+]${endColour} ${greenColour}Now you have${endColour} ${yellowColour}$money\$${endColour}"
                    if [ "$money" -gt "$maxMoney" ]; then
                        maxMoney=$money
                    fi
                    if [ $money -gt $betRenew ]; then
                        echo -e "\n${purpleColour}[+]${endColour} ${yellowColour}It has exceeded the limit of $betRenew\$ to renew the sequence${endColour}"
                        betRenew=$(($betRenew+50))
                        echo -e "${purpleColour}[+]${endColour} ${greenColour}The limit is now${endColour} ${yellowColour}$betRenew\$${endColour}"
                        my_sequence=(1 2 3 4)
                        bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                        echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Restarting sequence${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                    else
                        my_sequence+=($bet)
                        my_sequence=(${my_sequence[@]})
                        
                        echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}The sequence is now${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                        if [ "${#my_sequence[@]}" -ne 1 ]; then
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                            elif [ "${#my_sequence[@]}" -eq 1 ]; then
                            bet=${my_sequence[0]}
                        else
                            echo -e "${redColour}[!] The sequence is empty${endColour}"
                            my_sequence=(1 2 3 4)
                            echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Restarting sequence${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                        fi
                    fi
                    elif [ "$(($random_number % 2))" -eq 0 ]; then
                    echo -e "${purpleColour}[+]${endColour} ${redColour}The number is even, you lose ${endColour}"
                    
                    if [ $money -lt $(($betRenew-100)) ]; then
                        echo -e "\n${purpleColour}[+]${endColour} ${yellowColour}We have reached a critical number; the limit will be reduced${endColour}"
                        betRenew=$(($betRenew-50))
                        echo -e "${purpleColour}[+]${endColour} ${greenColour}The limit is now${endColour} ${yellowColour}$betRenew\$${endColour}"
                        
                        unset my_sequence[0]
                        unset my_sequence[-1] 2> /dev/null
                        
                        my_sequence=(${my_sequence[@]})
                        
                        echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}The sequence is now${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                        if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
                            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
                            elif [ "${#my_sequence[@]}" -eq 1 ]; then
                            bet=${my_sequence[0]}
                        else
                            echo -e "${redColour}[!] The sequence is empty${endColour}"
                            my_sequence=(1 2 3 4)
                            echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Restarting sequence${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                        fi
                    else
                        unset my_sequence[0]
                        unset my_sequence[-1] 2> /dev/null
                        
                        my_sequence=(${my_sequence[@]})
                        
                        echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}The sequence is now${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                        if [ "${#my_sequence[@]}" -ne 1 ]  && [ "${#my_sequence[@]}" -ne 0 ]; then
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                            elif [ "${#my_sequence[@]}" -eq 1 ]; then
                            bet=${my_sequence[0]}
                        else
                            echo -e "${redColour}[!] The sequence is empty${endColour}"
                            my_sequence=(1 2 3 4)
                            echo -e "${turquoiseColour}[+]${endColour} ${yellowColour}Restarting sequence${endColour} ${blueColour}[${my_sequence[*]}]${endColour}"
                            bet=$(( ${my_sequence[0]} + ${my_sequence[-1]} ))
                        fi
                    fi
                fi
            fi
        else
            echo -e "\n${redColour}[!] You don't have any money left${endColour}"
            echo -e "${purpleColour}[+]${endColour} ${greenColour}You played${endColour} ${yellowColour}$totalGames${endColour} ${greenColour}games${endColour}\n"
            echo -e "${purpleColour}[+]${endColour} ${greenColour}The most money you had was${endColour} ${yellowColour}$maxMoney\$${endColour}\n"
            tput cnorm; exit 1
        fi
        
        #        sleep 0.7
    done
    
    tput cnorm
}

while getopts "m:t:h" arg; do
    case $arg in
        m) money=$OPTARG;;
        t) technique=$OPTARG;;
        h) helpPanel;;
    esac
done

if [ $money ] && [ $technique ]; then
    if [ $technique == "martingala" ]; then
        martingala
        elif [ "$technique" == "inverseLabrouchere" ]; then
        inverseLabrouchere
    else
        echo -e "\n${redColour}[!] Invalid technique${endColour}"
        helpPanel
    fi
else
    helpPanel
fi