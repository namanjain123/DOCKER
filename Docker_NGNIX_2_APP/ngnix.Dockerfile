FROM nginx:latest
# Remove the default configuration file
RUN rm /etc/nginx/conf.d/default.conf
COPY ngnix.conf /etc/nginx/nginx.conf
EXPOSE 80




