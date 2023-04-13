#!/bin/bash

#Connect to MySQL database
mysql -u username -p password -h hostname -D database_name <<EOF

# Function to display search menu
function search_menu {
  echo "Please select a search option:"
  echo "1. Search by Source IP"
  echo "2. Search by Time Range"
  echo "3. Search by DNS Query Name"
  echo "4. Quit"
  read -p "Enter your choice: " choice
}

# Function to search by Source IP
function search_by_ip {
  read -p "Enter Source IP: " ip
  mysql -u username -p password -D dns_database -e "SELECT time_epoch, ip_src, udp_srcport, ip_dst, udp_dstport, dns_qryname FROM dns_table WHERE ip_src='$ip' ORDER BY time_epoch ASC LIMIT 50;"
}

# Function to search by Time Range
function search_by_time {
  read -p "Enter Start Time (yyyy-mm-dd HH:MM:SS): " start_time
  read -p "Enter End Time (yyyy-mm-dd HH:MM:SS): " end_time
  mysql -u username -p password -D dns_database -e "SELECT time_epoch, ip_src, udp_srcport, ip_dst, udp_dstport, dns_qryname FROM dns_table WHERE time_epoch BETWEEN UNIX_TIMESTAMP('$start_time') AND UNIX_TIMESTAMP('$end_time') ORDER BY time_epoch ASC LIMIT 50;"
}

# Function to search by DNS Query Name
function search_by_query {
  read -p "Enter DNS Query Name: " query
  mysql -u username -p password -D dns_database -e "SELECT time_epoch, ip_src, udp_srcport, ip_dst, udp_dstport, dns_qryname FROM dns_table WHERE dns_qryname='$query' ORDER BY time_epoch ASC LIMIT 50;"
}

# Main loop for search menu
while true
do
  search_menu
  case $choice in
    1) search_by_ip ;;
    2) search_by_time ;;
    3) search_by_query ;;
    4) exit ;;
    *) echo "Invalid choice. Please try again." ;;
  esac
done
