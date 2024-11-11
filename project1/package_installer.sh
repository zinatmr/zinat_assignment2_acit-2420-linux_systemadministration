#!/bin/bash

# Title        : Package Installer Script
# Date         : Nov 09 2024
# Author       : Mst Zinat Rehana
# Version      : 1.1
# Description  : Installs packages listed in a file.
# Options      : -f for specifying file, -v for verbose mode, -h for help.

# Default values
package_file="packagelist.sh"
verbose=""

# Function to handle errors
err() {
    echo "$1" # Print the error message passed as an argument
    exit 1
}

# Parse command-line options
while getopts "f:vh" opt; do
    case "${opt}" in
        f) 
            package_file="${OPTARG}"
            ;;
        v) 
            verbose="true"
            ;;
	h)
    	    echo -e "\nUsage: package_installer.sh [options]\n"
            echo -e "Options:"
            echo -e "  -f <file>      Specify a file that contains a user-defined list of packages."
            echo -e "                 The file should list packages in the following format:\n"
            echo -e "                 { package1\n                   package2\n                   ... }"
            echo -e "\n  -v             Enable verbose mode for additional output during installation."
            echo -e "  -h             Display this help message.\n"
            echo -e "If no file is specified with -f, packages will be installed from the default 'packageList.sh'."
            echo -e "\nExample:\n  sudo ./package_installer.sh -f custom_packages.sh -v\n"
            exit 0
            ;;

        
        *)
            err "Invalid option: -${OPTARG}"
            ;;
    esac
done

# To check if the script is run as root
if [[ $EUID -ne 0 ]]; then
    err "Error: Please run this script as root."
fi

# Load the package list
if [[ -f "./${package_file}" ]]; then
    source "./${package_file}"
    [[ $verbose ]] && echo "Loaded package list from ${package_file}."
else
    err "Error: ${package_file} not found. Please ensure the package list is in the same directory."
fi

# Check if the packages array is loaded from the specified file
if [[ -z "${packages[@]}" ]]; then
    err "Error: No packages found in ${package_file}."
fi

# Loop through each package and install if not already installed
for package in "${packages[@]}"; do
    # Check if the package is installed
    if pacman -Qi "$package" > /tmp/package_check_output; then
        [[ $verbose ]] && echo "${package} is already installed. Skipping."
    else
        [[ $verbose ]] && echo "Installing ${package}..."
        if pacman -S --noconfirm "$package"; then
            [[ $verbose ]] && echo "${package} installed successfully."
        else
            err "Failed to install ${package}."
        fi
    fi
done

echo "Package installation process completed successfully."

