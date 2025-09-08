FROM n8nio/n8n:1.109.2

# Criar pasta para nodes e definir diretório de trabalho
RUN mkdir -p ~/.n8n/nodes
WORKDIR ~/.n8n/nodes

# Instalar nodes adicionais
RUN npm i n8n-nodes-chatwoot
RUN npm i n8n-nodes-text-manipulation

# Definir argumentos para o PostgreSQL
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

# Configurar variáveis de ambiente do PostgreSQL
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD

# Chave de criptografia do n8n
ARG ENCRYPTION_KEY
ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY

# Instalar wait-for-it para aguardar dependências
RUN apt-get update && apt-get install -y wget \
    && wget -O /wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh \
    && chmod +x /wait-for-it.sh

# CMD para aguardar PostgreSQL e Redis antes de iniciar
CMD /wait-for-it.sh $DB_POSTGRESDB_HOST:$DB_POSTGRESDB_PORT -- \
    /wait-for-it.sh $QUEUE_BULL_REDIS_HOST:$QUEUE_BULL_REDIS_PORT -- \
    n8n start
