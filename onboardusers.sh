#! /usr/bin/bash

# Automation of User creation
USERS=names.csv

# Ensure current user is root user
if [ $(id -u) -eq 0 ]
then

	# Check if group exists
	if [ $(getent group developers) ]
	then

		while read -r NAME
			do
				# Set the name as the default password
				PASSWORD=$NAME
				echo $NAME

				# Check if user exists
				if id "$user" &>/dev/null
				then
					echo "User $NAME exists"
				else
					# Create user and add to group
					useradd -m -d /home/$NAME -s /bin/bash -g developers $NAME

					# Create .ssh dir
					su - -c "mkdir ~/.ssh" $NAME

					# .ssh user permission
					su - -c "chmod 700 ~/.ssh" $NAME
					
					# Create authorized key file
					su - -c "touch ~/.ssh/authorized_keys" $NAME
					
					# Set permission for authorized key file
					su - -c "chmod 600 ~/.ssh/authorized_keys" $user
					
					# Create and set public key for the user
					cp -R "/home/ubuntu/Shell/id_rsa.pub" "/home/$NAME/.ssh/authorized_keys"
					
					# Generate password
					sudo echo -e "$PASSWORD\n$PASSWORD" | sudo passwd "${NAME}"
					sudo passwd -x 10 $NAME

					echo "User $NAME created successfully"
				fi
		done < $USERS
	else
		echo "Group does not exist"
	fi
else
	echo "Inadequate permissions"
fi