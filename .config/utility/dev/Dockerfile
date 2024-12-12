FROM debian:bullseye-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    sudo \
    git \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy the entire T5Server project into the container
COPY . /opt/T5Server

WORKDIR /opt/T5Server

# Debug: Listez le contenu du répertoire pour vérifier l'emplacement du script
RUN ls -la .config/utility/dev/

# Copiez explicitement le script
COPY .config/utility/dev/testsValidation.sh /opt/T5Server/testsValidation.sh

# Make sure scripts are executable
RUN chmod +x /opt/T5Server/testsValidation.sh

# Utilisez bash pour exécuter le script
CMD ["/bin/bash", "./testsValidation.sh"]