#!/bin/bash

ME=`basename $0`
OS=`uname`
if [ "$OS" = "Darwin" ] ; then
    MYFULL="$0"
else
    MYFULL=`readlink -sm $0`
fi
MYDIR=`dirname $MYFULL`
MYDIR=$MYDIR
cd $MYDIR

if [ "$1" == "" ]; then
    inputFile="raw-data"
else
    inputFile=$1
fi

if [ "$2" == "" ]; then
    outputFile="output-data.json"
else
    outputFile=$2
fi

tmpFile="tmp-data.json"

echo ""
echo "Script for formatting DynamoDB dump to JSON"
echo "-------------------------------------------"
echo " -> Raw dump file: $inputFile"
echo " -> Intermediate file : $tmpFile"
echo " -> Formatted JSON file: $outputFile"
echo ""
echo "How it works:"
echo " -- Step 1: With a 'sed' command, raw dump data from '$inputFile' file will be cleaned up from unicode characters;"
echo " -- Step 2: With a 'sed' command, raw dump data from '$inputFile' file will be formatted to the JSON objects;"
echo " -- Step 3: JSON objects will be formatted to the proper representation (correct JSON values), stored at intermediate file '$tmpFile';"
echo " -- Step 4: Array of the JSON objects will be created and written to the '$outputFile' file."
echo ""
echo "Lets start:"
echo ""

sed -e 's/$/}/' -e $'s/\x02/,"/g' -e $'s/\x03/":/g' -e 's/^/{"/' $inputFile > $tmpFile
echo "[" > $outputFile
node format-data.js $tmpFile $outputFile
echo "]" >> $outputFile
rm $tmpFile

echo ""
echo "Data from '$inputFile' was successfully formatted and stored at '$outputFile'"
exit 0
