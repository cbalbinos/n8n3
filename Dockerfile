FROM n8nio/n8n:1.109.2

# Diretório para nodes customizados
RUN mkdir -p /home/node/.n8n/nodes
WORKDIR /home/node/.n8n/nodes

# --- Variáveis do Postgres ---
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

# --- Chave de criptografia ---
ARG ENCRYPTION_KEY
ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY

# --- Comando para iniciar ---
# Garantindo que escute em 0.0.0.0 e funcione em modo queue
CMD ["n8n", "start", "--host", "0.0.0.0"]
