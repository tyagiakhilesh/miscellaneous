#!/bin/sh

#NON_DIRECTORY_ENTIRES=`find ./ -exec file {} \; | grep -v directory`;
NON_DIRECTORY_ENTIRES=`find $1 -type f`;
TARGET_DIR=$2;
echo "Target dir is $TARGET_DIR";

for entry in $NON_DIRECTORY_ENTIRES
do
    echo "entry is " $entry;
    newName=`echo $entry | sed 's|\.|_|g' | sed 's|/|_|g'`
    echo "newName is $newName"
    #uncomment below line for RENAME ONLY Functionality and comment the next line out
    #newValue="${entry}_${newName}.eml";
    #move and rename to target directory
    newValue="${TARGET_DIR}/${newName}.eml";
    echo "newValue is $newValue"
    echo "Renaming $entry to $newValue";
    mv $entry $newValue;
done
