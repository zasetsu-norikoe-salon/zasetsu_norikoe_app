FROM --platform=linux/amd64 nginx:1.21
RUN apt-get update && apt-get install -y curl
# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*
# Nginxの設定ファイルをコンテナにコピー
ADD nginx.conf /etc/nginx/conf.d/default.conf
# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
EXPOSE 80
