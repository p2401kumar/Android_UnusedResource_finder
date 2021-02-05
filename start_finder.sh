chmod +x list/enlist_resources.sh

chmod +x list/color_collector.sh
chmod +x list/string_collector.sh
chmod +x list/layout_collector.sh
chmod +x list/value_collector.sh
chmod +x list/drawable_collector.sh
chmod +x usages/nonXML_usages_listing.sh
chmod +x usages/XML_usages_listing.sh

chmod +x cleanup.sh
chmod +x prerequisite_installer.sh

if [ -z $1 ]
  then
    echo "Error: Provide Project Absolute path as parameter" >&2
    exit 0
fi
`./cleanup.sh`

PROJECT_FOLDER=$1
W=`echo $PROJECT_FOLDER | rev | cut -f1 -d '/'`

if [ ! -z $W ]; then
	PROJECT_FOLDER="$PROJECT_FOLDER/"
fi

./prerequisite_installer.sh
ALL_RESOURCES=`./list/enlist_resources.sh $PROJECT_FOLDER`

./usages/XML_usages_listing.sh $PROJECT_FOLDER
./usages/nonXML_usages_listing.sh $PROJECT_FOLDER
#echo $ALL_RESOURCES
