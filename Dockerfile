FROM nginx

ENV REST_API_READ_HOSTNAME=localhost
ENV REST_API_READ_PORT=8081
ENV REST_API_WRITE_HOSTNAME=localhost
ENV REST_API_WRITE_PORT=8082

COPY upstream.location.template /etc/nginx/

RUN perl -0pe 's/root\s+\/usr\/share\/nginx\/html;\s+index\s+index\.html\s+index\.htm;/proxy_pass http:\/\/\$rest_api_host;/igs' /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf.part && \
    echo "include /etc/nginx/upstream.location;" | cat - /etc/nginx/conf.d/default.conf.part > /etc/nginx/conf.d/default.conf

RUN echo "envsubst '\$REST_API_READ_HOSTNAME,\$REST_API_READ_PORT,\$REST_API_WRITE_HOSTNAME,\$REST_API_WRITE_PORT' < /etc/nginx/upstream.location.template > /etc/nginx/upstream.location && cat /etc/nginx/upstream.location" > /docker-entrypoint.d/40-envsubst-upstream-location.sh && \
    chmod a+x /docker-entrypoint.d/40-envsubst-upstream-location.sh

CMD ["nginx", "-g", "daemon off;"]
