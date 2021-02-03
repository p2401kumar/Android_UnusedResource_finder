LAYOUT_FOLDER=$1

# find all files with 
# xml
# in this folder and return

RESOURCES=""
FILES=`find $LAYOUT_FOLDER -type f -name "*.xml"`

for file in $FILES; do
	NAME=`echo $file | rev | cut -f1 -d '/' | rev | cut -f1 -d '.'`
	RESOURCES="$RESOURCES$NAME "
done

echo $RESOURCES
#echo $FILES
