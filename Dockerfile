FROM php:7.4-fpm-alpine

# ติดตั้ง nginx และ bash (เพื่อ debug ได้ง่าย)
RUN apk add --no-cache nginx bash

# ตั้งค่า php-fpm ให้รับบน TCP 127.0.0.1:9000
RUN sed -i 's/^listen = .*/listen = 127.0.0.1:9000/' /usr/local/etc/php-fpm.d/www.conf

# สร้างโฟลเดอร์สำหรับ nginx
RUN mkdir -p /var/log/nginx /run/nginx

# คัดลอกโค้ดเว็บและ config nginx
WORKDIR /var/www/html
COPY src/index.php /var/www/html/
COPY src/default.conf /etc/nginx/http.d/default.conf


# เปิด port 80
EXPOSE 80

# รันทั้ง php-fpm และ nginx พร้อมกัน
CMD ["sh", "-c", "php-fpm -D && nginx -g 'daemon off;'"]
