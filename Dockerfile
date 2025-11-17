FROM php:7.4-fpm-alpine

# ติดตั้ง nginx
RUN apk add --no-cache nginx

# ตั้งค่า php-fpm ให้รับบน TCP 127.0.0.1:9000
RUN sed -i 's/^listen = .*$/listen = 127.0.0.1:9000/' /usr/local/etc/php-fpm.d/www.conf

WORKDIR /var/www/html

# คัดลอกโค้ดเว็บ
COPY src/ /var/www/html/

# สร้างโฟลเดอร์ log/run
RUN mkdir -p /var/log/nginx /run/nginx

# ตั้งค่า nginx ให้ log ไปที่ console
RUN echo 'error_log /dev/stderr;' >> /etc/nginx/nginx.conf && \
    echo 'access_log /dev/stdout;' >> /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]