#!/bin/bash
#: Title       : Creating a clone from a Gitlab repository
#: Date        : Nov 09 2024
#: Author      : Mst Zinat Rehana
#: Version     : 1.0
#: Description : It creates a local repository by cloning the remote repository
#: Options     : None

# Function to handle errors
err() {
	echo "$1" # Print the error message as an argument
	exit 1
}

# Define the Gitlab repository URL in a variable named REPOSITORY_URL
REPOSITORY_URL="https://gitlab.com/cit2420/2420-as2-starting-files.git"
CLONED_DIRECTORY_PATH="/home/$SUDO_USER/cloned_repository"

# To check if the script is run as root
if [[ $EUID -ne 0 ]]; then
	echo "Please run this script as root."
	exit 1
fi


# To check if the directory exists
if [[ -d "$CLONED_DIRECTORY_PATH" ]]; then
	echo "Directory $ClONED_DIRECTORY_PATH already exists."
else	
	echo "Directory $CLONED_DIRECTORY_PATH does not exist. Creating it now."
  mkdir -p "$CLONED_DIRECTORY_PATH"  # To create the directory
  echo "Directory $CLONED_DIRECTORY_PATH created successfully."
fi

# If git isn't installed then install git and then clone the repository else clone the repository directly. 
if ! command -v git; then
	echo "Git is not installed. Installing git now."
	pacman -Syu 
	pacman -S git
	git clone "$REPOSITORY_URL" "$CLONED_DIRECTORY_PATH"
	echo "Repository cloned successfully to $CLONED_DIRECTORY_PATH."

else
	git clone "$REPOSITORY_URL" "$CLONED_DIRECTORY_PATH"
	echo "Repository cloned successfully to $CLONED_DIRECTORY_PATH."
fi
echo "createclone.sh is successfully completed."

