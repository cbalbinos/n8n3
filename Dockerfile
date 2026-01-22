FROM n8nio/n8n:1.123.11

USER root

# garantir que o volume exista e seja gravável
RUN mkdir -p /n8n && chown -R node:node /n8n

# user folder oficial
ENV N8N_USER_FOLDER=/n8n

# proxy / railway
ENV N8N_TRUST_PROXY=true
ENV N8N_PROTOCOL=https
ENV N8N_PORT=5678

# voltar para node (mais seguro)
USER node

CMD ["n8n", "start"]
