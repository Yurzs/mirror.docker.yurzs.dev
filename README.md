# Docker mirror

This is a simple docker compose project to create a mirror of the docker hub registry. 

## This registry mirror

This mirror is available under the domain `mirror.docker.yurzs.dev`

## Usage

1. Clone the repository
2. Acquire certificate for your mirror domain using `certbot`.
3. Set `MIRROR_DOMAIN` env variable to your mirror domain. (Or pass it to section 4)
4. Call `docker compose up -d` to start the mirror.

## Configuration

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
