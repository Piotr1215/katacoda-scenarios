#!/usr/bin/env bash
set -eo pipefail

# Setup remote debugging for Killercoda scenarios
# Configures SSH and installs cloudflared tunnel for remote access

# Configure SSH for password authentication
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Restart SSH service
systemctl restart ssh || service ssh restart

# Set root password
echo "root:test123" | chpasswd

# Install cloudflared
if ! command -v cloudflared &> /dev/null; then
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O /tmp/cloudflared-linux-amd64
    chmod +x /tmp/cloudflared-linux-amd64
    mv /tmp/cloudflared-linux-amd64 /usr/local/bin/cloudflared
fi

# Create startup script for tunnel
cat > /usr/local/bin/start_remote_debug << 'SCRIPT'
#!/usr/bin/env bash
cloudflared tunnel --url ssh://localhost:22
SCRIPT

chmod +x /usr/local/bin/start_remote_debug

echo "Remote access setup complete. Run 'start_remote_debug' to start the tunnel."