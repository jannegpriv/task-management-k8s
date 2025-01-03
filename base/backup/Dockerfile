FROM postgres:15

# Install required packages
RUN apt-get update && apt-get install -y \
    python3-full \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Create and activate virtual environment, install b2
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install b2

# Copy backup script
COPY backup-script.sh /backup-script.sh
RUN chmod +x /backup-script.sh

CMD ["/backup-script.sh"]
