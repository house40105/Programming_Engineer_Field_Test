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
     * 使用以下命令：**mysqlimport --local --fields-terminated-by=',' --lines-terminated-by='\n' dns_database dns_sample.csv**  
     * 如果出現錯誤1045，請使用以下命令來解決：**GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;**  
3. 使用shell script "CLI_menu.sh" 來搜索database中的dns_records table  
     * 以CLI menu的形式提供3個選項：ip.src、frame.time_epoch、dns.qry.name  
     * 每次搜索只會顯示50條結果，並且有分頁功能  
     * 搜索結果會顯示在一個table中，並且按照time_epoch欄位升序排列  

**5. 系統架構**  
  ![image](https://github.com/house40105/Programming_Engineer_Field_Test/blob/main/file%20architecture.jpg "File Architecture")  
  **1. CLI_menu.sh:** 執行 shell script 來執行查詢功能，使用者可以透過此 shell script 與資料庫進行互動，並透過輸入查詢條件查詢資料庫。  
  **2. dns_database.sql:** 資料庫建立檔案，包含 dns_table 資料表的建立和資料庫使用者的權限設置等。  
  **3. dns_sample.csv:** 包含 DNS 記錄的 CSV 檔案。  
  **4. import.py:** 匯入 CSV 檔案至資料庫的 Python 執行檔，可以透過此來將 CSV 檔案中的資料匯入到 MySQL 資料庫中。  
    
  在這個應用程式的架構中，我們可以透過執行 **CLI_menu.sh** 來開始查詢。使用者可以透過輸入要查詢的 IP 位址、時間範圍和 DNS 查詢名稱來搜尋 DNS 記錄。這些查詢條件將透過 SQL 語句在**dns_table** 資料表中進行查詢，並將結果以表格形式顯示在終端機上。每次查詢僅顯示 50 筆資料，使用者可以透過翻頁功能來查看更多的結果。  
    
  在開始查詢之前，使用者必須先匯入 **dns_sample.csv** 檔案至 **dns_table** 資料表中，這可以透過執行 **import.py** 來完成。在匯入資料之前，使用者必須確保已在 MySQL 中建立了一個名為 **dns_database** 的資料庫。
