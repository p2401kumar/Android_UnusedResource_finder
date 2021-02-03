# Initialization
PROJECT_ROOT=$1
MAIN_USAGE_PATH="app/src/main/java"
RES_USAGE_PATH="app/src/main/res"

FILES=`find "$PROJECT_ROOT$MAIN_USAGE_PATH" -type f -name "*.java" -o -name "*.xml" -o -name "*.kt"`

# All usages
USAGES_ALL=""

STATIC_FIELD="(layout|drawable|string|color)"

for file in $FILES; do	
	EMS_USAGE=`pcregrep -M -o "R(( )*.(\n)*( )*|( )*(\n)*( )*.( )*)$STATIC_FIELD(( )*.(\n)*( )*|( )*(\n)*( )*.( )*)[a-z_0-9]*" $file`
	
	USAGES_ALL="$USAGES_ALL $EMS_USAGE"
done

echo $USAGES_ALL
