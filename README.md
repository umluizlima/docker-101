# Docker 101
> Uma jornada introdutória ao Docker

Dúvidas sobre os comandos no Dockerfile? Consulte a documentação [aqui](https://docs.docker.com/engine/reference/builder/).


## Passo-a-passo
Para criar a imagem de container deste projeto a partir do Dockerfile e colocar
um container para rodar:

### 1. Clone
```sh
$ git clone https://github.com/umluizlima/docker-101
$ cd docker-101
```

### 2. Monte
```sh
$ docker build -t sua-imagem:sua-tag .
```

### 3. Verifique
```sh
$ docker images
```

### 4. Inicie
```sh
$ docker run --name seu-container -d -p 8080:5000 --rm sua-imagem:sua-tag
```

### 5. Verifique
```sh
$ docker ps
```

### 6. Pare
```sh
$ docker stop seu-container
```

### 7. Remova
```sh
$ docker image rm sua-imagem
```

## Problemas
Durante o desenvolvimento deste estudo enfrentei alguns problemas. Apesar de ter encontrado suas soluções com facilidade no Google, é conveniente deixá-los registrados aqui para quem vier depois.


- Na primeira vez em que tentei dar build na imagem ocorreu um erro `...driver failed programming external connectivity on endpoint...` cuja solução foi reiniciar o docker no Windows clicando no seu ícone na barra de ferramentas ([Fonte](https://stackoverflow.com/questions/44414130/docker-on-windows-10-driver-failed-programming-external-connectivity-on-endpoin)).

- Ao tentar rodar um container a partir da minha imagem encontrei um erro `standard_init_linux.go:190: exec user process caused "no such file or directory"` causado pelo padrão de quebra de linha CRLF no arquivo `boot.sh`. A solução foi alterar para padrão LF no editor de texto, e alterar a configuração do Git na minha máquina para não converter os padrões durante push ([Fonte](https://stackoverflow.com/questions/51508150/standard-init-linux-go190-exec-user-process-caused-no-such-file-or-directory))
```sh
$ git config core.autocrlf false
```

- Ao rodar o container não consegui acessar a aplicação pelo navegador. Isso se deu pois a aplicação deve ser servida publicamente no container, e ao acessar deve-se atentar para a porta do host escolhida no comando `docker run` ([Fonte](https://stackoverflow.com/questions/30323224/deploying-a-minimal-flask-app-in-docker-server-connection-issues)). Para acessar sua aplicação no endereço `127.0.0.1:8000` no navegador:
  - No arquivo `boot.sh`:
  ```sh
  exec flask run --host=0.0.0.0
  ```
  - No comando `docker run`:
  ```sh
  docker run --name seu-container -d -p 8080:5000 --rm sua-imagem:sua-tag
  ```

- A medida em que criava novas versões da imagem percebi um acúmulo de imagens `<none>` listadas sob o comando `docker images`. O comando `docker system prune` resolve isso removendo todas as imagens residuais, containeres parados e volumes e redes não utilizadas ([Fonte](https://forums.docker.com/t/how-to-remove-none-images-after-building/7050/14)).
```sh
$ docker system prune
```

## Referências
- Miguel Grinberg:
  - [The Flask Mega-Tutorial Part XIX: Deployment on Docker Containers](https://blog.miguelgrinberg.com/post/the-flask-mega-tutorial-part-xix-deployment-on-docker-containers)
- Alexander Ryabtsev:
  - [What is Docker and How to Use it With Python (Tutorial)](https://djangostars.com/blog/what-is-docker-and-how-to-use-it-with-python/)
