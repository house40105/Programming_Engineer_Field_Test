# Programming_Engineer_Field_Test
Take home test

## File architecture
**1. MySQL Database**

   * dns_records  
   * time_epoch (timestamp)  
   * ip_src (varchar 20)  
   * udp_srcport (int 11)  
   * ip_dst (varchar 20)  
   * udp_dstport (int 11)  
   * dns_qryname (varchar 80)  
  

**2. CSV File**  
 *  dns_sample.csv  

**3. Linux Server**  
  包含了以下的script和command-line tools:  
   * shell script "CLI_menu.sh"  
   * mysqlimport command  
   *  mysql command  
   *  sysbench command  
    
**4. 操作流程**  
1. 使用sysbench進行MySQL壓力測試  
     * 使用以下參數: oltp_read_write, db-driver=mysql, table-size=1000000  
     * 產生壓力測試報告，例如 sysbench_report.txt  
2. 匯入CSV檔案到MySQL database  
     * 使用以下命令：mysqlimport --local --fields-terminated-by=',' --lines-terminated-by='\n' dns_database dns_sample.csv  
     * 如果出現錯誤1045，請使用以下命令來解決：GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;  
3. 使用shell script "CLI_menu.sh" 來搜索database中的dns_records table  
     * 以CLI menu的形式提供3個選項：ip.src、frame.time_epoch、dns.qry.name  
     * 每次搜索只會顯示50條結果，並且有分頁功能  
     * 搜索結果會顯示在一個table中，並且按照time_epoch欄位升序排列  

**5. 系統架構**  
