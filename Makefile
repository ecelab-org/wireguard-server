include .env
export

all: run fix-permissions

run: FORCE
	docker compose up --detach --wait
	@echo
	@echo "Initializing containers..."
	@echo
	@sleep 4
	docker compose logs

debug: FORCE
	docker exec -it --workdir=/etc/wireguard wireguard-ui \
		bash -l

fix-permissions: FORCE
	@echo
	@echo "Fixing permissions of local './data'."
	@docker run -it --rm -v ./data:/tmp/data \
		--entrypoint /bin/bash \
		ngoduykhanh/wireguard-ui \
		-c '\
		chown :$(shell id -g $(whoami)) /tmp/data -R; \
		find /tmp/data -type d -exec chmod g+wrx,o-wrx {} \; ; \
		find /tmp/data -type f -exec chmod g+wr,o-wrx {} \; ; \
		'
	@echo "Permissions fixed."
	@echo

stop: FORCE
	docker compose down

clean: stop fix-permissions
	rm -rf data/

Makefile: ;

FORCE:
