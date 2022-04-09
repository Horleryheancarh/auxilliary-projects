# SHELL SCRIPTING

## The objective is to automate user creation

### STEP 1 - Create a folder named Shell and move into it
```bash
mkdir Shell

cd Shell
```
### STEP 2 - Create a csv file named names.csv
```bash
touch names.csv

vim names.csv
```
#### Content of names.csv
```
Darkoovibes
Wizkid
Buju
Fireboy
FreshL
Shaybo
Prettyboy
Kofi
Jamar
JoeyB
Moliy
Mellissa
Teezee
Enny
Victony
Amaarae
Zamir
Davido
Eazi
Obongjayar
```
### STEP 3 - Create a usergroup called developers
```bash
sudo group developers
```
### STEP 4 - Create key files for public and private keys
```bash
vim id_rsa.pub

vim id_rsa
```
#### Content of id_rsa.pub
```
```
#### Content of id_rsa
```
```
### STEP 5 - Create a script file to create users
```bash
vim onboardusers.sh
```
#### Content of the script file
```bash
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
```

![All](Project%201/copcon.png)
![creating](Project%201/create.png)
![list](Project%201/list.png)
![test](Project%201/test1.png)
![test](Project%201/test2.png)