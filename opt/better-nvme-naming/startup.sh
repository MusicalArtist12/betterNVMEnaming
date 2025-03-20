#!/bin/bash
# Julia Abdel-Monem 2025
# Juliaviolet.dev

# clean up from last boot as needed
for file in $(ls /dev/ | grep -E ^nd); do
    rm -f /dev/$file
    # echo /dev/$file
done

alphabet=({a..z})

counter0="0"
counter1="0"

letter0=""
letter1="${alphabet[$counter]}"

lastnamespace=""
lastdrive=""

for file in $(ls -v /dev/ | grep -E ^nvme); do
    
    descriptor=${file:4}
    # echo $descriptor
    drive=${descriptor:0:1}
    namespaceIndex=`expr index "$descriptor" n`
    namespaceChunk=${descriptor:$namespaceIndex}

    namespace=${namespaceChunk%p*}
    partition=${namespaceChunk#*p}
    
    # echo $drive - $namespace - $partition

    if [[ "$namespace" == "0" ]]; then
        # echo "continuing $file"
        lastdrive="$drive"
        continue
    fi

    if [ "$lastnamespace" != "$namespace" ] || [ "$lastdrive" != "$drive" ]; then
        # echo incrementing $counter1 $counter0
        
        if [[ "$letter1" == "z" ]]; then
            counter0=$(($counter0 + 1))
            letter0="${alphabet[$counter0 - 1]}"
            counter1="1"
            letter1="${alphabet[$counter1 - 1]}"
        else
            counter1=$(($counter1 + 1))
            letter1="${alphabet[$counter1 - 1]}"
        fi
    fi

    # echo $namespace - $partition

    if grep -q "p" <<< "$namespaceChunk"; then
        echo $file - nd$letter0$letter1$partition
        ln /dev/$file /dev/nd$letter0$letter1$partition
    else
        echo $file - nd$letter0$letter1
        ln /dev/$file /dev/nd$letter0$letter1
    fi

    lastnamespace="$namespace"
    lastdrive="$drive"
    
done
