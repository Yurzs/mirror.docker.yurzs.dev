# Docker mirror

This is a simple docker compose project to create a mirror of the docker hub registry. 

## This registry mirror

This mirror is available under the domain `mirror.docker.yurzs.dev`

### To use this mirror

1. Add the following to your `/etc/docker/daemon.json`:

```json
{
  "registry-mirrors": ["https://mirror.docker.yurzs.dev"]
}
```

### To log in to the mirror

```bash
docker login mirror.docker.yurzs.dev
```

## Usage

You can spin up your own mirror by following these steps:

### Pre-requisites:
- Docker
- DNS records pointing to your server (`auth.<MIRROR_DOMAIN>` and `<MIRROR_DOMAIN>`)
- `80` and `443` ports open on your server

### Quickstart

1. Clone repository `git clone git clone https://github.com/Yurzs/mirror.docker.yurzs.dev.git`
2. Change directory `cd mirror.docker.yurzs.dev`
3. Run `make quickstart MIRROR_DOMAIN=<MIRROR_DOMAIN> EMAIL=<EMAIL>`

Where `<MIRROR_DOMAIN>` is the domain you want to use for the mirror and `<EMAIL>` is the email you want to use for the SSL certificate.

## Client Configuration

To configure docker to use this proxy you can add the following to your `/etc/docker/daemon.json`:

```json
{
  "registry-mirrors": ["https://<MIRROR_DOMAIN>"]
}
```

Location of docker config:

- Linux: `/etc/docker/daemon.json`
- Windows: `C:\ProgramData\Docker\config\daemon.json`
- MacOS: `~/.docker/daemon.json`

If you need to login to the registry you can use the following command:

```bash
docker login <MIRROR_DOMAIN>
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
