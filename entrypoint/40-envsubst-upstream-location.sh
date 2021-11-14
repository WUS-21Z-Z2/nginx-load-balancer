envsubst '$REST_API_READ_HOSTNAME,$REST_API_READ_PORT,$REST_API_WRITE_HOSTNAME,$REST_API_WRITE_PORT' < /etc/nginx/upstream.location.template > /etc/nginx/upstream.location
cat /etc/nginx/upstream.location
