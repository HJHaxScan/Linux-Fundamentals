#! /bin/bash

#! Create automation to display the Linux operating system information.
#! 1. Display the Linux version.
#! 2. Display the private IP address, public IP address, and the default gateway.
#! 3. Display the hard disk size; free and used space.
#! 4. Display the top five (5) directories and their size.
#! 5. Display the CPU usage; refresh every 10 seconds.


#! 1. Display the Linux version.

echo -e

name=$(sudo cat /etc/os-release | grep -w NAME | awk -F= '{print $2}')
version=$(sudo cat /etc/os-release | grep -w VERSION | awk -F= '{print $2}')
echo "This is your Linux Name:	$name"
echo "This is your Linux Version :	$version"

echo -e

#! 2. Display the private IP address, public IP address, and the default gateway.

int1=$(ifconfig | grep inet | awk 'FNR == 1 {print}' | awk '{print $2}')
int2=$(ifconfig | grep broadcast | awk '{print $(NF)}')
ext=$(curl -s ipinfo.io/ip)
DG=$(ip route | grep default | awk '{print $3}')

echo "These are your Internal IP Addresses"
echo "INet Internal IP : $int1"
echo "Broadcast Internal IP : $int2"
echo -e
echo "This is your External IP Address: $ext"
echo "This is your Default Gateway: $DG"
echo -e

#! 3. Display the hard disk size; free and used space.

TotalSize=$(df --total -h | awk 'FNR == 8 {print}' | awk '{print $2}')
UsedSize=$(df --total -h | awk 'FNR == 8 {print}' | awk '{print $3}')
FreeSize=$(df --total -h | awk 'FNR == 8 {print}' | awk '{print $4}')

echo "Your total hard disk space is: $TotalSize"
echo "Your used space is: $UsedSize"
echo "Your available space for use is: $FreeSize"
echo -e

#! 4. Display the top five (5) directories and their size.

echo "The computer is scanning for your top 5 directories, please wait for a moment..."
echo -e

TopName=$(sudo du / -h 2>/dev/null | sort -n | tail -n 5 | awk '{print $2}')
TopSize=$(sudo du / -h 2>/dev/null | sort -n | tail -n 5 | awk '{print $1}')

echo -e "Your 5 largest directory are: \n$TopName"
echo -e
echo -e "The directories size are in their respective order: \n$TopSize"
echo -e

#! 5. Display the CPU usage; refresh every 10 seconds.

echo "Please wait while the computer calculate the CPU Usage, this will refresh with the interval of every 10 seconds."
echo -e
echo "To end script, enter Ctrl+C"
echo -e

for repeatask in {1..1000}

do

	echo "CPU Usage: "$[100-$(vmstat 1 1 | tail -n1 | awk '{print $15}')]"%"; date "+%T"; sleep 10;


done
