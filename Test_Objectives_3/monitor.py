import configparser
import json
import logging
import os
import subprocess
import time
from urllib.request import urlopen, URLError

def check_mysql():
    """
    檢查 MySQL 連線狀態
    """
    try:
        conn = pymysql.connect(host='localhost', user='root', password='********', db='dns_database')
        conn.close()
        return 'OK'
    except pymysql.MySQLError as e:
        return str(e)

def check_php_mysql():
    """
    檢查 PHP 與 MySQL 連線狀態
    """
    try:
        response = urlopen('http://127.0.0.1/home/healthcheck/healthy.php', timeout=10)
        result = json.loads(response.read().decode('utf-8'))
        if result['mysql_status'] == 'OK':
            return 'OK'
        else:
            return 'ERROR'
    except URLError as e:
        return str(e)

def run_monitor():
    # 載入設定檔
    config = configparser.ConfigParser()
    config.read('config.ini')

    # 設定 logger
    logger = logging.getLogger('monitor')
    logger.setLevel(logging.DEBUG if config.getboolean('system', 'logger') else logging.INFO)
    fh = logging.FileHandler(os.path.join(config.get('system', 'log_path'), 'monitor.log'))
    formatter = logging.Formatter('[%(asctime)s] %(levelname)s:PID:%(process)d, %(message)s')
    fh.setFormatter(formatter)
    logger.addHandler(fh)

    # 檢查 PHP 與 MySQL 連線狀態
    status = check_php_mysql()
    if status == 'OK':
        logger.info('response: {"mysql_status":"OK"}')
    else:
        logger.error('response: {"mysql_status":"%s"}', status)

    # 檢查 MySQL 連線狀態
    status = check_mysql()
    if status == 'OK':
        logger.info('MySQL connection OK')
    else:
        logger.error('MySQL connection error: %s', status)

if __name__ == '__main__':
    run_monitor()
