# Initialization
PROJECT_ROOT=$1
MAIN_USAGE_PATH="app/src/main/java"

FILES=`find "$PROJECT_ROOT$MAIN_USAGE_PATH" -type f -name "*.java" -o -name "*.kt"`

# All usages
FIX_USAGES=""

QQ="((\n)*( )*)*"
REGEX_PREFIX="R$QQ.$QQ"
REGEX_SUFFIX="$QQ.$QQ[a-z_0-9]*"

#ress
LAYOUT="layout"
DRAWABLE="drawable"
STRING="string"
COLOR="color"

USAGE_LIST_FILE_NAME="nonXML_usages_list.pk"

for file in $FILES; do	
	LX_USAGE="$file#"
	
	#layout
	KL_LAYOUT_USAGE=`pcregrep -Mou "$REGEX_PREFIX$LAYOUT$REGEX_SUFFIX" $file|perl -pe 's/(R|layout|\.)/ /g'|tr -s " "`
	for lx in $KL_LAYOUT_USAGE; do
		LX_USAGE="$LX_USAGE@layout/$lx "
	done

	KL_DRAWABLE_USAGE=`pcregrep -Mou "$REGEX_PREFIX$DRAWABLE$REGEX_SUFFIX" $file | perl -pe "s/(R|drawable|\.)/ /g" | tr -s " "`
	for lx in $KL_DRAWABLE_USAGE; do
		LX_USAGE="$LX_USAGE@drawable/$lx "
	done
	
	KL_STRING_USAGE=`pcregrep -Mou "$REGEX_PREFIX$DRAWABLE$REGEX_SUFFIX" $file | perl -pe "s/(R|string|\.)/ /g" | tr -s " "`
	for lx in $KL_STRING_USAGE; do
		LX_USAGE="$LX_USAGE@string/$lx "
	done
	
	KL_COLOR_USAGE=`pcregrep -Mou "$REGEX_PREFIX$COLOR$REGEX_SUFFIX" $file | perl -pe "s/(R|color|\.)/ /g" | tr -s " "`
	for lx in $KL_COLOR_USAGE; do
		LX_USAGE="$LX_USAGE@color/$lx "
	done
	
	echo $LX_USAGE >> $USAGE_LIST_FILE_NAME
done


