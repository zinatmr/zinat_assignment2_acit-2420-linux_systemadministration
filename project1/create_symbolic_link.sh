#!/bin/bash
#: Title       : Creating symbolic link
#: Date        : Nov 09 2024
#: Author      : Mst Zinat Rehana
#: Version     : 1.0
#: Description : This script creates symbolic links for local configuration files, allowing them to be managed and synchronized with the remote repository.
#: Options     : -d is to specify a custom path for the cloned repository and -h to                 display the help message.


# The default path for the CLONED_DIRECTORY_PATH
CLONED_DIRECTORY_PATH="/home/$SUDO_USER/cloned_repository"
# To handle options 
while getopts "d:h" opt; do
    case "${opt}" in
        d)
            CLONED_DIRECTORY_PATH="${OPTARG}"
            ;;
        h)
            echo -e "\nUsage: $0 [-d <directory>] [-h]"
            echo -e "\nOptions:"
            echo -e "  -d <directory>    Specify a custom directory for the cloned repository. If -d is not used then ~/cloned_repository will be used"
            echo -e "  -h                Display this help message.\n"
            exit 0
            ;;
        *)
            echo "Invalid option: -${OPTARG}" >&2
            echo -e "Use -h for help.\n" >&2
            exit 1
            ;;
    esac
done
# To check if the script is run as root
if [[ $EUID -ne 0 ]]; then
	echo "Please run this script as root."
	exit 1
fi

# To define paths for symbolic links
SYM_LINK_BIN="/home/$SUDO_USER/"
SYM_LINK_CONFIG="/home/$SUDO_USER/.config"
SYM_LINK_BASHRC="/home/$SUDO_USER/.bashrc"

# To create symbolic links 
ln -s "$CLONED_DIRECTORY_PATH/bin" "$SYM_LINK_BIN"
ln -s "$CLONED_DIRECTORY_PATH/config" "$SYM_LINK_CONFIG"
ln -s "$CLONED_DIRECTORY_PATH/home/bashrc" "$SYM_LINK_BASHRC"

echo "Symbolic links script processed."
