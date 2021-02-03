COLOR_FILE=$1

echo `xmlstarlet sel -t -v '//resources/color/@name' -nl $COLOR_FILE`
