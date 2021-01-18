```bash
docker run -it -v "/var/run/docker.sock:/var/run/docker.sock" -v "$(pwd):/code" -u "$(id -u)" pedrotroller/vim
```
