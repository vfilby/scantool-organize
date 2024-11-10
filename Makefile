UID=3005
GID=3005

docker: Dockerfile
	docker build -t scantool-organize:development .

runtime-config: clean
	mkdir -p $(shell pwd)/runtime/to-sort
	mkdir -p $(shell pwd)/runtime/sorted
	cp -R $(shell pwd)/test-files/ $(shell pwd)/runtime/to-sort
	chown -R $(UID):$(GID) $(shell pwd)/runtime

docker-run: docker runtime-config
	docker run --rm -it \
	  -v $(shell pwd)/runtime/to-sort:/mnt/to-sort \
		-v $(shell pwd)/runtime/sorted:/mnt/sorted \
		-v $(shell pwd)/organize-rules.yaml:/app/organize-rules.yaml:ro \
		-v $(shell pwd)/test-script.sh:/app/test-script.sh:ro \
		--user "$(UID):$(GID)" \
		scantool-organize:development organize run --config /app/organize-rules.yaml

docker-dryrun: docker runtime-config
	docker run --rm -it \
	  -v $(shell pwd)/runtime/to-sort:/mnt/to-sort \
		-v $(shell pwd)/runtime/sorted:/mnt/sorted \
		-v $(shell pwd)/organize-rules.yaml:/app/organize-rules.yaml:ro \
		-v $(shell pwd)/test-script.sh:/app/test-script.sh:ro \
		--user "$(UID):$(GID)" \
		scantool-organize:development organize sim /app/organize-rules.yaml

docker-shell: docker runtime-config
	docker run --rm -it \
	  -v $(shell pwd)/runtime/to-sort:/mnt/to-sort \
		-v $(shell pwd)/runtime/sorted:/mnt/sorted \
		-v $(shell pwd)/organize-rules.yaml:/app/organize-rules.yaml \
		-v $(shell pwd)/test-script.sh:/app/test-script.sh \
		--user "$(UID):$(GID)" \
		scantool-organize:development bash

docker-runner: docker runtime-config
	docker run --rm -it \
	  -v $(shell pwd)/runtime/to-sort:/mnt/to-sort \
		-v $(shell pwd)/runtime/sorted:/mnt/sorted \
		-v $(shell pwd)/organize-rules.yaml:/app/organize-rules.yaml:ro \
		-v $(shell pwd)/test-script.sh:/app/test-script.sh:ro \
		-e ORGANIZE_INTERVAL=10 \
		--user "$(UID):$(GID)" \
		scantool-organize:development

clean:
	rm -rf $(shell pwd)/runtime
