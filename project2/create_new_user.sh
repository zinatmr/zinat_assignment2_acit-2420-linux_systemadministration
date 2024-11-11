#!/bin/bash
# Title      : Manual User Creation Script
# Author     : Mst Zinat Rehana
# Version    : 1.0
# Date       : Nov 10, 2024
# Description: Script to create a new user directly without using any utility.
# Options    : -u for new username, -s to specify shell, -d specify home directory, -g for additional groups for users, -h for help.

# Default values
username=""
shell="/bin/bash"           # Default shell
home_dir=""
additional_groups=""



# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    err "Please run this script as root."
fi

# Get options with getopts from command line
while getopts "u:s:d:g:h" opt; do
    case "${opt}" in
        u)
            username="${OPTARG}"
            ;;
        s)
            shell="${OPTARG}"
            ;;
        d)
            home_dir="${OPTARG}"
            ;;
        g)
            additional_groups="${OPTARG}"
            ;;
        h)
            # Display help for the script
            echo "Usage: $0 -u <username> -s <shell> -d <home_directory> -g <additional_groups> -h"
            echo ""
            echo "Options:"
            echo "  -u <username>         Specify the username for the new user. Will not run if new user is not specified"
            echo "  -s <shell>            Specify the shell for the new user (default: /bin/bash)."
	    echo "  -d <home_directory>    Specify the home directory for the new user (default is /home/username)."
            echo "  -g <additional_groups> Specify additional groups (comma-separated) to add the user to (example group1,group2,..."
            echo "  -h                    Display help message."
            exit 0
            ;;
        *)
            echo "Invalid option: -${OPTARG}" >&2
            echo "Use -h for help."
            exit 1
            ;;
    esac
done

# Check if username is provided
if [[ -z "$username" ]]; then
    echo "Error: Username is required."
    echo "use -h to see help"
    exit 1
fi

# Set home directory if not provided
if [[ -z "$home_dir" ]]; then
    home_dir="/home/$username"
fi

# Create user ID and group ID
userID=$(($(awk -F: '{if ($3 >= 1000 && $3 < 65534) max = $3} END {print max+1}' /etc/passwd)))
groupID=$userID

# Add an entry in /etc/passwd for the new user
echo "$username:x:$userID:$groupID::$home_dir:$shell" | tee -a /etc/passwd > /tmp/some_output

# Create an entry in /etc/group with the same name as the username
echo "$username:x:$groupID:" | tee -a /etc/group > /tmp/some_output

# Add the user to additional groups if specified
if [[ -n "$additional_groups" ]]; then
    IFS=',' read -ra groups <<< "$additional_groups"
    for group in "${groups[@]}"; do
        if ! grep -q "^$group:" /etc/group; then
            # Create the group if it doesn't exist
            group_id=$(($(awk -F: '{if ($3 >= 1000 && $3 < 65534) max = $3} END {print max+1}' /etc/group)))
            echo "$group:x:$group_id:" | tee -a /etc/group > /tmp/some_output
        fi
        # Add the user to the existing group
        sudo sed -i "/^${group}:/ s/$/,$username/" /etc/group
    done
fi

# Create the home directory and copy /etc/skel contents
mkdir -p "$home_dir"
cp -r /etc/skel/. "$home_dir"
chown -R "$username:$username" "$home_dir"

# Set the password for the new user
echo "Set the password for $username:"
passwd "$username"

echo "User $username created successfully."

