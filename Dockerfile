# Use the official PHP image as a base image
FROM php:7.4-apache

# Set environment variables
ENV WORDPRESS_VERSION 5.7.2

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Download and extract WordPress
RUN wget -O wordpress.tar.gz https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
    && tar -xzf wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm wordpress.tar.gz

# Set up WordPress permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy custom configurations if any (optional)
# COPY ./my-custom-config.php /var/www/html/wp-config.php

# Expose port 80
EXPOSE 80

# Set the entrypoint to start Apache
ENTRYPOINT ["apache2-foreground"]

