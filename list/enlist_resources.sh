# Initialization
PROJECT_ROOT=$1
MAIN_RES_PATH="app/src/main/res/"

# Paths
RES_PATH="$PROJECT_ROOT$MAIN_RES_PATH"

# List 
RES_LIST=""
FOLDERS=`ls -d $RES_PATH*`
for dir in $FOLDERS; do
	HLS_NAME=`echo $dir | rev | cut -f1 -d '/' | rev`
	
	if [ `echo $HLS_NAME | grep -E 'drawable|mipmap' -c` -gt 0 ]; then
		HLS_RES_LIST=`./list/drawable_collector.sh $dir`
		# Drawable collection
		for X in $HLS_RES_LIST; do
			if [ `echo $RES_LIST | grep -E "@drawable/$X" -c` -eq 0 ]; then
				RES_LIST="$RES_LIST @drawable/$X"
			fi
		done
	elif [ `echo $HLS_NAME | grep -E 'layout' -c` -gt 0 ]; then
		HLS_RES_LIST=`./list/layout_collector.sh $dir`
		# Layout collection
		for X in $HLS_RES_LIST; do
			if [ `echo $RES_LIST | grep -E "@layout/$X" -c` -eq 0 ]; then
				RES_LIST="$RES_LIST @layout/$X"
			fi
		done
	elif [ `echo $HLS_NAME | grep -E 'values' -c` -gt 0 ]; then
		HLS_RES_LIST=`./list/value_collector.sh $dir`
		
		# Value Collection
		for X in $HLS_RES_LIST; do
			RES_LIST="$RES_LIST $X"
		done
	fi
	

done

echo $RES_LIST
