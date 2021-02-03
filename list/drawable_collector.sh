DRAWABLE_FOLDER=$1

# find all files with 
# PNG, png, JPG, JPEG, jpg, jpeg, xml, webp
# in this folder and return

RESOURCES=""
FILES=`find $DRAWABLE_FOLDER -type f -name "*.JPG" -o -name "*.JPEG" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.PNG" -o -name "*.xml" -o -name "*.webp"`

for file in $FILES; do
	NAME=`echo $file | rev | cut -f1 -d '/' | rev | cut -f1 -d '.'`
	RESOURCES="$RESOURCES$NAME "
done

echo $RESOURCES
#echo $FILES
