FROM n8nio/n8n:latest

USER node
WORKDIR ~/.n8n/nodes && npm i n8n-nodes-chatwoot
WORKDIR ~/.n8n/nodes && npm i n8n-nodes-text-manipulation

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


ARG ENCRYPTION_KEY

ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY

CMD ["n8n start"]
