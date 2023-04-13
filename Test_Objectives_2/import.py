import csv
import mysql.connector

#Database Connection Settings
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="*******",
  database="dns_database"
)

#read CSV file
with open('dns_sample.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        #Parse CSV rows
        time_epoch = row['frame.time_epoch']
        ip_src = row['ip.src']
        udp_srcport = row['udp.srcport']
        ip_dst = row['ip.dst']
        udp_dstport = row['udp.dstport']
        dns_qryname = row['dns.qry.name']

        #Insert into database table
        mycursor = mydb.cursor()
        sql = "INSERT INTO dns_records (time_epoch, ip_src, udp_srcport, ip_dst, udp_dstport, dns_qryname) VALUES (%s, %s, %s, %s, %s, %s)"
        val = (time_epoch, ip_src, udp_srcport, ip_dst, udp_dstport, dns_qryname)
        mycursor.execute(sql, val)
        mydb.commit()
