<?php
$host = 'localhost';
$username = 'username';
$password = 'password';
$dbname = 'dbname';

// 建立與 MySQL 的連線
$conn = new mysqli($host, $username, $password, $dbname);

// 檢查連線是否正常
if ($conn->connect_error) {
    // 回傳連線錯誤訊息
    header('Content-Type: application/json');
    echo json_encode(array('mysql_status' => 'ERROR'));
} else {
    // 回傳連線正常訊息
    header('Content-Type: application/json');
    echo json_encode(array('mysql_status' => 'OK'));
}

// 關閉 MySQL 連線
$conn->close();
?>
