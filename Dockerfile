FROM nginx:1.21.4

ENV REST_API_READ_HOSTNAME=host.docker.internal
ENV REST_API_READ_PORT=8081
ENV REST_API_WRITE_HOSTNAME=host.docker.internal
ENV REST_API_WRITE_PORT=8082

COPY upstream.location.template /etc/nginx/
COPY --chmod=0777 entrypoint/*.sh /docker-entrypoint.d/

RUN perl -0pe 's/root\s+\/usr\/share\/nginx\/html;\s+index\s+index\.html\s+index\.htm;/proxy_pass http:\/\/\$rest_api_host;/igs' /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf.part \
    && echo "include /etc/nginx/upstream.location;" | cat - /etc/nginx/conf.d/default.conf.part > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
