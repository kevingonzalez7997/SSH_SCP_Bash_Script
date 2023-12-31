#!/bin/bash
#Kevin Gonzalez
#2023-09-06

# First we have to create our functions for our 2 options

# Creating a function for ssh, we will call it later
ssh_choice() {
    echo "You have picked ssh"
    # Ask for remote IP and username and use -p to store it in a variable
    read -p "Please enter the remote IP address of the computer you would like to connect to: " remoteIP
    read -p "Please enter the remote username of the computer user you are connecting to: " remoteUser
    # Run the ssh command to connect, use $ to insert variables in strings
    ssh "$remoteUser@$remoteIP"
}

# Creating a function for SCP
scp_choice() {
    echo "You have picked scp, you will have to options, lets start by collecting some information"
    # Ask for remote IP and username and store them in variables
    read -p "Please enter the remote IP address of the computer you will be sending data to: " remoteIP
    read -p "Please enter the remote username of the computer you will be sending data to : " remoteUser

    # Ask which path the user wants to use for the file transfer (A or B)
    # Ask for the path to the source and destination files
    # Store all three answers in variables
    echo "Would you like to: "
    echo "a: send from remote computer to local"
    echo "b: send from local to remote computer"
    read -p "Please pick 'a' or 'b': " ab
    read -p "Please enter the path to the file you would like to send: " srcFile
    read -p "Please enter the path to the file that will be sent: " desFile

    # Create an if-else statement for the user's choice of path
    if [ "$ab" == 'a' ]; then
        # scp condition for remote to local
        scp "$remoteUser@$remoteIP":"$srcFile" "$desFile"
    elif [ "$ab" == 'b' ]; then
        # scp condition for local to remote
        scp "$srcFile" "$remoteUser@$remoteIP":"$desFile"
    else
        # Catch in case anything else is entered
        echo "Please enter 'a' or 'b'"
    fi

    echo "File is transferring"
    echo "Transfer complete"
}


# Now that we have two functions (one for ssh and one for scp), we can ask the user what they want
# We start a while loop
while true; do
    # Ask the user to pick a valid option
    read -p "Please enter one of the following options (ssh, scp, exit): " options

    # Here we will give an action depending on what the user picks
    # Case is nested inside as we have three different options with different actions
    case "$options" in
    "ssh")
        # Here we call the function we created earlier
        ssh_choice
        ;;
    "scp")
        # Here we call the function we created earlier
        scp_choice
        ;;
    "exit")
        # If exit is selected it will break out
        break
        ;;
    *)
        # * is to catch if any input beside the given option is entered
        echo "Not a valid option. Please pick 'ssh', 'scp', or 'exit'."
        ;;
    esac
done
