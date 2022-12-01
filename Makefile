.PHONY: install-docker
install-docker:
	bash ./install-docker.bash

.PHONY: deploy-chain
deploy-chain:
	rm -rf ./genesis.json
	cp /tmp/config.json config.json
	envsubst < config.json > tmp_config.json
	docker run --rm -v ${PWD}/tmp_config.json:/config.json -t taher1307/create-genesis:latest /config.json > ./genesis.json
	rm -f tmp_config.json
	docker-compose up -d

.PHONY: deploy-validator
deploy-validator:
	docker-compose -f ./validator/docker-compose.yaml --env-file ./.env up -d
