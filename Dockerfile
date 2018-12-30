# Especifica a imagem base de container sobre a qual
# nossa imagem será construída
FROM python:3.7-alpine

# Cria um novo usuário que será usado ao invés do root
RUN adduser -D umluizlima

# Configura o diretório no qual a aplicação será instalada
# e os próximos comandos executados
WORKDIR /home/umluizlima

# Copia arquivos e diretórios do sistema de arquivos do
# host para o do container
COPY requirements.txt requirements.txt
COPY app app
COPY boot.sh ./
# Garante que o arquivo boot.sh seja um executável
RUN chmod +x boot.sh

# Executa os comandos para criar um ambiente virtual e instalar
# as dependências do projeto dentro do container
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt

# Configura uma variável de ambiente no container
ENV FLASK_APP app

# Define o dono de todos diretórios e arquivos armazenados
# sob /home/umluizlima como o usuário umluizlima
RUN chown -R umluizlima:umluizlima ./

# Define o usuário padrão para todas as instruções
# subsequentes
USER umluizlima

# Configura a porta que será exposta pelo container
# para o host
EXPOSE 5000

# Define o comando padrão que deve ser executado ao
# iniciar o container
ENTRYPOINT ["./boot.sh"]
