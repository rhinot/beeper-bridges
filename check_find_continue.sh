#!/bin/bash
# Check if find failure stops the script

touch fail_script
chmod +x fail_script
echo 'exit 1' > fail_script

find . -maxdepth 1 -name "fail_script" -exec bash -c 'exit 1' \;

echo "Main script continued"
rm fail_script
