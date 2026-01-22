FROM n8nio/n8n:1.123.11

# user folder
ENV N8N_USER_FOLDER=/n8n

# proxy
ENV N8N_TRUST_PROXY=true
ENV N8N_PROTOCOL=https
ENV N8N_PORT=5678

# IMPORTANTE: continuar como root
USER root

CMD ["n8n", "start"]
