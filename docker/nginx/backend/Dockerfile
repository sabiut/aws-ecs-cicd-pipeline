FROM nginx:alpine

# Copy nginx configuration
COPY docker/nginx/backend/nginx.conf /etc/nginx/nginx.conf

# Create directory for nginx cache
RUN mkdir -p /var/cache/nginx

# Set proper permissions
RUN chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health/ || exit 1

# Expose port
EXPOSE 8080

# Run nginx
CMD ["nginx", "-g", "daemon off;"]