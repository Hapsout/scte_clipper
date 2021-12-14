#!/bin/bash
file=$1

#Collection of the first and last PTS
firstPTS=$(ffprobe -v quiet -print_format json=compact=1 -show_entries packet=pts $file | jq -r '.[] | first(.[] | .pts)')
firstPTS=$(echo "scale=6;$firstPTS/90000" | bc)
lastPTS=$(ffprobe -v quiet -print_format json=compact=1 -show_entries packet=pts $file | jq -r '.[] | last(.[] | .pts)')
lastPTS=$(echo "scale=6;$lastPTS/90000" | bc)

#Collection of pts_time of all deduplicated time_signal type markers
allUniquePTSTime=$(python3 -c "import threefive; threefive.decode('${file}')" | jq --raw-output '.command | select(.command_type==6) | .pts_time' | jq -s 'unique | .[]')

#Build Array with all TimeCode
#first item
allTimeCode[${#allTimeCode[@]}]=$firstPTS

#Other items
for t in ${allUniquePTSTime[@]}; do
    if (( $(echo "$t < $lastPTS" |bc -l) )); then
        allTimeCode[${#allTimeCode[@]}]=$t
    fi
done

#last item
allTimeCode[${#allTimeCode[@]}]=$lastPTS

for ((i=0;i<=(${#allTimeCode[@]}-2);i++)); do
    echo $i
    echo $(ffmpeg -v quiet -y -ss $(echo "scale=3;${allTimeCode[$i]} - ${allTimeCode[0]}" | bc) -i $1 -t $(echo "scale=3;${allTimeCode[$i+1]} - ${allTimeCode[$i]}" | bc) -f wav -bitexact -acodec pcm_s16le -ar 48000 -ac 2 clip_$i.wav)
done

echo "$i clip built"
