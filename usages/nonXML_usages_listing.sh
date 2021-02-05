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
USAGE_TSORT_COMBINED=$2

for file in $FILES; do	
	LX_USAGE="$file#"
	
	#layout
	KL_LAYOUT_USAGE=`cat $file | perl -0pe 's|//.*?\n|\n|g; s#/\*(.|\n)*?\*/##g;' | pcregrep -Mou "$REGEX_PREFIX$LAYOUT$REGEX_SUFFIX" $file|perl -pe 's/(R|layout|\.)/ /g'|tr -s " "`
	for lx in $KL_LAYOUT_USAGE; do
		LX_USAGE="$LX_USAGE@layout/$lx "
		echo "$file @layout/$lx" >> $USAGE_TSORT_COMBINED
	done

	KL_DRAWABLE_USAGE=`cat $file | perl -0pe 's|//.*?\n|\n|g; s#/\*(.|\n)*?\*/##g;' | pcregrep -Mou "$REGEX_PREFIX$DRAWABLE$REGEX_SUFFIX" $file | perl -pe "s/(R|drawable|\.)/ /g" | tr -s " "`
	for lx in $KL_DRAWABLE_USAGE; do
		LX_USAGE="$LX_USAGE@drawable/$lx "
		echo "$file @drawable/$lx" >> $USAGE_TSORT_COMBINED
	done
	
	KL_STRING_USAGE=`cat $file | perl -0pe 's|//.*?\n|\n|g; s#/\*(.|\n)*?\*/##g;' | pcregrep -Mou "$REGEX_PREFIX$DRAWABLE$REGEX_SUFFIX" $file | perl -pe "s/(R|string|\.)/ /g" | tr -s " "`
	for lx in $KL_STRING_USAGE; do
		LX_USAGE="$LX_USAGE@string/$lx "
		echo "$file @string/$lx" >> $USAGE_TSORT_COMBINED
	done
	
	KL_COLOR_USAGE=`cat $file | perl -0pe 's|//.*?\n|\n|g; s#/\*(.|\n)*?\*/##g;' | pcregrep -Mou "$REGEX_PREFIX$COLOR$REGEX_SUFFIX" $file | perl -pe "s/(R|color|\.)/ /g" | tr -s " "`
	for lx in $KL_COLOR_USAGE; do
		LX_USAGE="$LX_USAGE@color/$lx "
		echo "$file @color/$lx" >> $USAGE_TSORT_COMBINED
	done
	
	echo $LX_USAGE >> $USAGE_LIST_FILE_NAME
done


