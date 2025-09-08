FROM n8nio/n8n:1.109.2

# nodes customizados
RUN mkdir -p /home/node/.n8n/nodes
WORKDIR /home/node/.n8n/nodes

# limpar possíveis pacotes duplicados ao iniciar
RUN rm -rf /home/node/.n8n/nodes/node_modules/n8n-nodes-evolution-api || true

# variáveis do banco
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD

# encryption key
ARG ENCRYPTION_KEY
ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY

# rodar como root para conseguir escrever no volume do Railway
USER root

# configuração para proxy
ENV N8N_TRUSTED_PROXIES="0.0.0.0/0"
ENV N8N_PROTOCOL="https"
ENV N8N_PORT="5678"

CMD ["n8n", "start"]
