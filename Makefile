start-certbot:
	@echo "Starting certbot"
	@docker compose up -d certbot

stop-certbot:
	@echo "Stopping certbot"
	@docker compose down certbot

combine-certs:
	@test -n "$(MIRROR_DOMAIN)" || (echo "MIRROR_DOMAIN is not set" && exit 1)

	@echo "Starting haproxy"
	@docker compose up -d haproxy

	@echo "Combining registry cert"
	@docker compose exec certbot /etc/letsencrypt/renewal-hooks/post/haproxy

	@echo "Stopping haproxy"
	@docker compose stop haproxy

	@echo "Done!"

generate-certs: start-certbot
	@test -n "$(MIRROR_DOMAIN)" || (echo "MIRROR_DOMAIN is not set" && exit 1)
	@test -n "$(EMAIL)" || (echo "EMAIL is not set" && exit 1)

	@echo "Generating certs"
	@docker compose exec certbot certbot certonly --standalone \
		-d $(MIRROR_DOMAIN) --email $(EMAIL) --agree-tos --no-eff-email

	@make -s combine-certs
	@make -s stop-certbot

	@echo "Done!"

start:
	@test -n "$(MIRROR_DOMAIN)" || (echo "MIRROR_DOMAIN is not set. Add it to command using DOMAIN-NAME=<DOMAIN_NAME>" && exit 1)

	MIRROR_DOMAIN=$(MIRROR_DOMAIN) docker compose up -d --build

stop:
	@docker compose down


quickstart:
	@test -n "$(MIRROR_DOMAIN)" || (echo "MIRROR_DOMAIN is not set. Add it to command using DOMAIN-NAME=<DOMAIN_NAME>" && exit 1)
	@test -n "$(EMAIL)" || (echo "EMAIL is not set. Add it to command using EMAIL=<EMAIL>" && exit 1)

	@echo "Quick starting mirror registry"
	@make -s generate-certs MIRROR_DOMAIN=$(MIRROR_DOMAIN) EMAIL=$(EMAIL)

	@echo "Starting mirror registry"
	@make -s start MIRROR_DOMAIN=$(MIRROR_DOMAIN)
