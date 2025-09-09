FROM n8nio/n8n:1.110.1

# rodar como root para conseguir escrever globalmente
USER root

# nodes customizados
RUN mkdir -p /home/node/.n8n/nodes
WORKDIR /home/node/.n8n/nodes

# limpar possíveis pacotes duplicados
RUN rm -rf /home/node/.n8n/nodes/node_modules/n8n-nodes-evolution-api || true

# instalar o pacote globalmente
RUN npm install -g n8n-nodes-evolution-api

# voltar para usuário padrão
USER node

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

# configuração para proxy
ENV N8N_TRUSTED_PROXIES=0.0.0.0/0
ENV N8N_PROTOCOL=https
ENV N8N_PORT=5678

CMD ["n8n", "start"]
