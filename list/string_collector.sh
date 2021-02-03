STRING_FILE=$1

echo `xmlstarlet sel -t -v '//resources/string/@name' -nl $STRING_FILE`
