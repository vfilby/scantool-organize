docker:
	docker build -t scanman-organizetool:development .

runtime-config: clean
	mkdir -p $(shell pwd)/runtime/to-sort
	mkdir -p $(shell pwd)/runtime/sorted
	cp -R $(shell pwd)/test-files/ $(shell pwd)/runtime/to-sort

docker-run: docker runtime-config
	docker run --rm -it \
	  -v $(shell pwd)/runtime/to-sort:/mnt/to-sort \
		-v $(shell pwd)/runtime/sorted:/mnt/sorted \
		-v $(shell pwd)/organize-rules.yaml:/organizetool/organize-rules.yaml:ro \
		-v $(shell pwd)/test-script.sh:/organizetool/test-script.sh:ro \
		scanman-organizetool:development organize run --config /organizetool/organize-rules.yaml

docker-dryrun: docker runtime-config
	docker run --rm -it \
	  -v $(shell pwd)/runtime/to-sort:/mnt/to-sort \
		-v $(shell pwd)/runtime/sorted:/mnt/sorted \
		-v $(shell pwd)/organize-rules.yaml:/organizetool/organize-rules.yaml:ro \
		-v $(shell pwd)/test-script.sh:/organizetool/test-script.sh:ro \
		-e PUID=3005 \
		-e PGID=3005 \
		scanman-organizetool:development organize sim /organizetool/organize-rules.yaml

docker-shell: docker runtime-config
	docker run --rm -it \
	  -v $(shell pwd)/runtime/to-sort:/mnt/to-sort \
		-v $(shell pwd)/runtime/sorted:/mnt/sorted \
		-v $(shell pwd)/organize-rules.yaml:/organizetool/organize-rules.yaml \
		-v $(shell pwd)/test-script.sh:/organizetool/test-script.sh \
		-e PUID=3005 \
		-e PGID=3005 \
		scanman-organizetool:development bash

docker-runner: docker runtime-config
	docker run --rm -it \
	  -v $(shell pwd)/runtime/to-sort:/mnt/to-sort \
		-v $(shell pwd)/runtime/sorted:/mnt/sorted \
		-v $(shell pwd)/organize-rules.yaml:/organizetool/organize-rules.yaml:ro \
		-v $(shell pwd)/test-script.sh:/organizetool/test-script.sh:ro \
		-e ORGANIZE_INTERVAL=10 \
		-e PUID=3005 \
		-e PGID=3005 \
		scanman-organizetool:development

clean:
	rm -rf $(shell pwd)/runtime
