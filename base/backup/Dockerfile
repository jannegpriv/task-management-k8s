FROM postgres:15

# Install Python and pip (needed for b2-cli)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install b2-cli
RUN pip3 install b2

# Copy backup script
COPY backup-script.sh /backup-script.sh
RUN chmod +x /backup-script.sh

CMD ["/backup-script.sh"]
