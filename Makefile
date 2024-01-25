include .env
export

all: run

run: stop
	docker run -d \
		--name=wg-easy \
		-e LANG=en \
		-e WG_HOST=${CL_SERVER_DOMAIN} \
		-e PASSWORD= \
		-e WG_DEFAULT_DNS=8.8.8.8,8.8.4.4 \
		-v ~/.wg-easy:/etc/wireguard \
		-p 51820:51820/udp \
		-p ${CL_UI_PORT}:51821/tcp \
		--cap-add=NET_ADMIN \
		--cap-add=SYS_MODULE \
		--sysctl="net.ipv4.conf.all.src_valid_mark=1" \
		--sysctl="net.ipv4.ip_forward=1" \
		--restart unless-stopped \
		ghcr.io/wg-easy/wg-easy
	@echo
	@echo "Access server UI at: https://localhost:${CL_UI_PORT}"
	@echo

debug: FORCE
	docker exec -it --workdir=/etc/wireguard wg-easy \
		bash -l

stop: FORCE
	docker stop wg-easy || :
	docker rm wg-easy || :

update: stop
	docker pull ghcr.io/wg-easy/wg-easy

clean: stop

Makefile: ;

FORCE:
