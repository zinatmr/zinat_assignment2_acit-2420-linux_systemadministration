# zinat_assignment2_acit-2420-linux_systemadministration
*Note use roo privelege or sudo to run the scripts.

## Project Directories
This project has two project ditectories
1. Project1
2. Project2

## Project1 contents
Project1 contians the scripts to create new confifuration. It contains the following scripts:

1. createclone.sh
    - This script clones the given repository with example configuration files.

2. packagelist.sh
    - This files contains default list of packages.

3. package_installer.sh
    - This script installs all the packages in the packagelist.sh or a user define list of package file. Can be run stand alone. Type in the code below to see the usage:

    ```bash
        sudo package_installer.sh -h
    ```
4. create_symbolic_link.sh 
    - This script creates the symbolic link between the user files and the cloned configuration files. It has a default path defined for the cloned repostiory. User can also have the cloned repository elesewehere and use the new path for symbolic links. Can be run stand alone. Type in the code below to see the usage:

    ```bash
        sudo create_symbolic_ling.sh -h
    ```
5. execute_configuration_script.sh
    - This script can invoke "package_installer.sh" or "create_symbolic_link.sh" depending on the usage. Created as part of the assignment ask. Type in the code below to see the usage:
    
    ```bash
        sudo execurte_configuration_script.sh -h
    ```

## Project2 contents
Project2 contains the script to create new users, user groups, and passwords. It conatins the following script:

1. create_new_user.sh
    - This file will create new user. Type in the code below to see the usage:

    ```bash
        sudo create_new_user.sh -h
    ```



