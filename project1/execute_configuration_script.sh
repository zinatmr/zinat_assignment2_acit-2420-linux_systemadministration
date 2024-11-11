#!/bin/bash

# Title      : Execute Package Installer and Symbolic Link Scripts
# Author     : Mst Zinat Rehana
# Date       : Nov 10 2024
# Version    : 1.0
# Description: This Script is to run package_installer.sh and create_symbolic_link.sh as required.
# Options    : -s specifies the script to run, -f to point to list of package file, -d for directory to be used as symbolic link, -v specifies verbose mode, and -h spec		   ifies help.


# Default variables
script=""            
package_file=""      
directory_sym_link=""         
verbose_mode=""          

# Read options with getopts
while getopts "s:f:d:vh" opt; do
    case "${opt}" in
        s)
            script="${OPTARG}"   # To set the chosen script ("install" or "link")
            ;;
        f)
            package_file="${OPTARG}"   # To set the package file name if specified
            ;;
        d)
            directory_sym_link="${OPTARG}"      # To set the directory for symbolic links if specified
            ;;
        v)
            verbose_mode="-v"               # To enable verbose mode for detailed output
            ;;
        h)
            # To display options and usage information
            echo "Usage: $0 -s <script> [-f <file>] [-d <directory>] [-v] [-h]"
            echo ""
            echo "Options description :"
            echo "  -s <script>       Specify the script to run: 'install' for package_installer.sh, 'link' for create_symbolic_link.sh."
            echo "  -f <file>         File with package list "
            echo "  -d <directory>    Directory for cloned repository (only for create_symbolic_link.sh)."
            echo "  -v                Verbose mode (only for package_installer.sh)."
            echo "  -h                Display this help message."
            echo ""
            echo "Example:"
            echo "  ./execute_configuration_script.sh -s install -f custom_packages.sh -v"
            echo "  ./execute_configuration_script.sh -s link -d /custom/repo/path"
            exit 1                      
            ;;
        *)
            echo "Invalid option: -${OPTARG}"   
            echo "Use -h for help."           
            exit 1
            ;;
    esac
done

# Run the selected script
case "${script}" in
    install)
	# Runs package_installer.sh with the specified options
        if [[ -n "${package_file}" ]]; then
            ./package_installer.sh -f "${package_file}" ${verbose_mode}
        else
            ./package_installer.sh ${verbose_mode}    # installs the packages from the default file
        fi
        ;;
    link)
        # Run create_symbolic_link.sh with the specified options
        if [[ -n "${directory_sym_link}" ]]; then
            ./create_symbolic_link.sh -d "${directory_sym_link}"
        else
            ./create_symbolic_link.sh            # create symbolic link to the default directory
        fi
        ;;
    *)
        # Error message for unspecified or invalid options
        echo "Error: Invalid script specified. Use 'install' or 'link'."
        echo "Use -h for help."                 # Points to help if invalid option
        exit 1
        ;;
esac

