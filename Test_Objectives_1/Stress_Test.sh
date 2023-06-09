//To run a stress test on a MySQL database using sysbench

//Install MySQL and sysbench on system if it is not already installed
//if not

root@localhost ~]# rpm -qa | grep mysql
[root@localhost ~]# sudo yum install wget
[root@localhost ~]# wget -P /temp/ https://dev.mysql.com/get/mysql80-community-release-el7-4.noarch.rpm


//complete check 
[root@localhost ~]# cd /temp
[root@localhost ~]# ls -la | grep mysql

[root@localhost ~]# rpm -vih /temp/mysql80-community-release-el7-4.noarch.rpm
[root@localhost ~]# yum repolist enabled | grep mysql

//install mysql
[root@localhost ~]#rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
[root@localhost ~]# yum install mysql-community-server

//To verify after installation
[root@localhost ~]# service mysqld start
[root@localhost ~]# service mysqld status


//Set password for root to log in mysql
[root@localhost ~]# cat /var/log/mysqld.log | grep 'temporary password'
[root@localhost ~]# mysql -uroot -p'********'


//Create a test database and a test user with appropriate permissions to access the database
//Create a MySQL database with a table of the desired size. For this example, we will create a table with 1 million rows.
//Use the following command to create a database named sbtest
CREATE DATABASE sbtest;
USE sbtest;

CREATE TABLE sbtest (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    k INT UNSIGNED NOT NULL DEFAULT 0,
    c CHAR(120) NOT NULL DEFAULT '',
    pad CHAR(60) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    KEY k_1 (k)
) ENGINE=InnoDB;


//To change password authentication caching_sha2_password to mysql_native_password due to MySQL 8.0 version
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '********';



//Load the table with data using the following command
sysbench --db-driver=mysql --mysql-user=root --mysql-password=Happy8.0 \
--mysql-db=sbtest --table-size=1000000 /usr/share/sysbench/oltp_read_write.lua \
prepare


//Run the stress test using the following command
//we are running the oltp_read_write benchmark with 64 threads for a duration of 300 seconds, and the report interval is set to 10 seconds
sysbench --db-driver=mysql --mysql-user=root --mysql-password=Happy8.0 \
--mysql-db=sbtest --table-size=1000000 /usr/share/sysbench/oltp_read_write.lua \
--threads=64 --time=300 --report-interval=10 run

//Once the test is completed, sysbench will generate a report showing various metrics such as transactions per second, latency, and CPU usage. An example report is shown below
//This report shows the number of queries performed, transactions, and latency. It also includes the total time taken to complete the test and the thread fairness of the benchmark. You can use this report to identify any bottlenecks or performance issues in your MySQL database


//save the output to a file called report.txt for analysis and interpretation
sysbench --db-driver=mysql --mysql-user=root --mysql-password=Happy8.0 \
--mysql-db=sbtest --table-size=1000000 /usr/share/sysbench/oltp_read_write.lua \
--threads=64 --time=300 --report-interval=10 run> report.txt




//Clean up the test data by running the following command
sysbench --db-driver=mysql --mysql-user=root --mysql-password=Happy8.0 \
--mysql-db=sbtest --table-size=1000000 /usr/share/sysbench/oltp_read_write.lua \
cleanup