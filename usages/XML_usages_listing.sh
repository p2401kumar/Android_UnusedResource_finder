# this script searched for each resource file which depends on other resources
# for exmaple, there can be case that a layout file cantains some drawable
# we prepare an ouput file which contains result in the form
# @RESOURCE_NAME#{dependees...}

# Initialization
PROJECT_ROOT=$1
RES_USAGE_PATH="app/src/main/res"

USAGE_LIST_FILE_NAME="XML_usages_list.pk"

#layout 
LAYOUT_FILES=`find "$PROJECT_ROOT$RES_USAGE_PATH" -type f -name "*.xml" | grep -E 'res/layout|res/drawable'`
for file in $LAYOUT_FILES; do
	#preprocess file to id
	T_FILENAME=`echo $file | rev | cut -f1 -d '/' | rev | cut -f1 -d '.'`
	#echo $T_FILENAME

	LX_USAGE=""
	if [ `echo $file | grep '/drawable' -c` -gt 0 ]; then
		LX_USAGE="@drawable/$T_FILENAME#"
	else
		LX_USAGE="@layout/$T_FILENAME#"
	fi

	KL_LAYOUT_USAGE=`pcregrep -Mou "@layout/[a-z_0-9]*" $file`
	for lx in $KL_LAYOUT_USAGE; do
		LX_USAGE="$LX_USAGE$lx "
	done

	KL_DRAWABLE_USAGE=`pcregrep -Mou "@drawable/[a-z_0-9]*" $file`
	for lx in $KL_DRAWABLE_USAGE; do
		LX_USAGE="$LX_USAGE$lx "
	done
	
	KL_STRING_USAGE=`pcregrep -Mou "@string/[a-z_0-9]*" $file`
	for lx in $KL_STRING_USAGE; do
		LX_USAGE="$LX_USAGE$lx "
	done
	
	KL_COLOR_USAGE=`pcregrep -Mou "@color/[a-z_0-9]*" $file`
	for lx in $KL_COLOR_USAGE; do
		LX_USAGE="$LX_USAGE$lx "
	done
	
	echo $LX_USAGE >> $USAGE_LIST_FILE_NAME
done


