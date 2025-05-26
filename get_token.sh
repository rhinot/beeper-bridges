#!/bin/bash
# get_token.sh by github.com/rhinot
# Gets matrix token for use in self-hosted bridges
#
# Script intro
echo "Matrix token generator & extractor for Beeper"
echo -e "by github.com/rhinot\n"

# Prompt the user for input
read -p "Do you need to generate a new token? (yes/NO): " answer

# Check the user's answer
if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
# Find all executable files in the current directory starting with "bbctl"
  find . -maxdepth 1 -executable -type f -name "bbctl*" -exec bash -c ' 
    file="$1"
    if [[ -z "$file" ]]; then
       echo "[ERROR] Please place this script in the same directory as your bbctl executable and re-run." >&2
       exit 1
    else
      # Execute each file found
      echo "Executing: $file"
      "$file" login # Use quotes to handle filenames with spaces
      # Check the exit status of the command
      if [ $? -ne 0 ]; then
        echo "[ERROR] Command \"$file\" login failed." >&2
        exit 1 # Exit the inner bash script if command failed
      fi
    fi
    ' _ {} \;
  # The ' _ {} +' passes the found files as arguments to the sh -c command.
  # The ' _ ' is a placeholder for $0 in the sh -c command, then {} expands to the found files.
fi

# Command to execute after token generation, regardless of success/failure of generation
echo "Extracting token..."
jq '.environments.prod.access_token' ~/.config/bbctl/config.json
exit 0

