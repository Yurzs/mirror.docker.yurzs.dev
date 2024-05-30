# Docker mirror

This is a simple docker compose project to create a mirror of the docker hub registry. 

## Usage

1. Clone the repository
2. Acquire certificate for your mirror domain using `certbot`.
3. Set `MIRROR_DOMAIN` env variable to your mirror domain. (Or pass it to section 4)
4. Call `docker compose up -d` to start the mirror.

