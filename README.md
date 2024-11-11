# zinat_assignment2_acit-2420-linux_systemadministration

## Project Directories
This project has two project ditectories
1. Project1
2. Project2

## Project1 contents
Project1 contians the scripts to create new confifuration.It contains the following scripts:

1. createclone.sh
    This script clones the given repository with example configuration files.

2. packagelist.sh
    This files contains default list of packages.

3. package_installer.sh
    This script installs all the packages in the packalish.sh or a user define list pof package file. Can be run stand alone. Type in the code below to see the usage.

    ```bash
        package_installer.sh -h
    ```
4. create_symbolic_link.sh 
    This script creates the symbolic link between the user local files and the cloned configuration files. It has a default defined for symbolic links. Can be run stand alone. Type in the code below to see the usage

    ```bash
        create_symbolic_ling.sh -h
    ```
5. execute_configuration_script.sh
    This script can invoke "package_installer.sh" or "create_symbolic_link.sh". Type in the code below to see the usage
    
    ```bash
        execurte_configuration_script.sh
    ```

## Project2 contents
Project2 contains the script to create new user. It conatins the following script:

1. create_new_user.sh
    This file will create new user. Type in the code below to see the usage:

    ```bash
        create_new_user.sh -h
    ```



