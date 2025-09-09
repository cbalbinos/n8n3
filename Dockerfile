FROM n8nio/n8n:1.110.1

# Rodar como root para instalar o pacote globalmente
USER root

# Limpar possíveis pacotes duplicados
RUN rm -rf /home/node/.n8n/nodes/node_modules/n8n-nodes-evolution-api || true

# Instalar o pacote community node globalmente
RUN npm install -g n8n-nodes-evolution-api

# Voltar para o usuário padrão
USER node

# Diretório para nodes customizados
RUN mkdir -p /home/node/.n8n/nodes
WORKDIR /home/node/.n8n/nodes

# Configuração default para proxy (pode ser sobrescrita pelas variáveis do Railway)
ENV N8N_TRUSTED_PROXIES=0.0.0.0/0

CMD ["n8n", "start"]
