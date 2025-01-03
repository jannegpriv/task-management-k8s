FROM postgres:15

# Install required packages
RUN apt-get update && apt-get install -y \
    python3-full \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip install --user pipx \
    && python3 -m pipx ensurepath \
    && python3 -m pipx install b2

# Copy backup script
COPY backup-script.sh /backup-script.sh
RUN chmod +x /backup-script.sh

CMD ["/backup-script.sh"]
