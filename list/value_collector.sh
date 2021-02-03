VALUES_FOLDER=$1

# find all files with 
# strings
# in this folder and return

RES_LIST=""
for file in `ls -f $VALUES_FOLDER`; do
	if [ `echo $file | grep "string" -c` -gt 0 ]; then
		HLS_RES_LIST=`./list/string_collector.sh $VALUES_FOLDER/$file`
		for X in $HLS_RES_LIST; do
			if [ `echo $RES_LIST | grep -E "@string/$X" -c` -eq 0 ]; then
				RES_LIST="$RES_LIST @string/$X"
			fi
		done
	elif [ `echo $file | grep "color" -c` -gt 0 ]; then
		HLS_RES_LIST=`./list/color_collector.sh $VALUES_FOLDER/$file`
		for X in $HLS_RES_LIST; do
			if [ `echo $RES_LIST | grep -E "@color/$X" -c` -eq 0 ]; then
				RES_LIST="$RES_LIST @color/$X"
			fi
		done
	fi
done

echo $RES_LIST
