IMAGE ?= squidfunk/mkdocs-material:latest
PORT  ?= 8000

.PHONY: pull serve build clean free-port

pull:
	docker pull $(IMAGE)

serve:
	# Image entrypoint is already 'mkdocs'; pass subcommand only
	docker run --rm -it -p $(PORT):8000 -v $(PWD):/docs $(IMAGE) serve -a 0.0.0.0:8000

build:
	# Build static site to ./site
	docker run --rm -v $(PWD):/docs $(IMAGE) build

clean:
	rm -rf site

free-port:
	@echo "Attempting to free host port $(PORT)..."
	@ids=$$(docker ps --filter "publish=$(PORT)" -q 2>/dev/null); \
	if [ -n "$$ids" ]; then \
	  echo "Stopping Docker containers publishing $(PORT): $$ids"; \
	  docker stop $$ids >/dev/null || true; \
	else \
	  echo "No Docker containers found publishing $(PORT)"; \
	fi
	@if command -v fuser >/dev/null 2>&1; then \
	  echo "Killing processes with fuser on tcp:$(PORT) (if any)"; \
	  fuser -k -n tcp $(PORT) >/dev/null 2>&1 || true; \
	else \
	  echo "fuser not found; skipping"; \
	fi
	@if command -v lsof >/dev/null 2>&1; then \
	  pids=$$(lsof -t -i TCP:$(PORT) 2>/dev/null | sort -u); \
	  if [ -n "$$pids" ]; then \
	    echo "Killing PIDs via lsof: $$pids"; \
	    kill $$pids || true; \
	  else \
	    echo "No processes found via lsof for port $(PORT)"; \
	  fi; \
	else \
	  echo "lsof not found; skipping"; \
	fi
	@echo "Done. To verify, run: ss -ltnp | rg ':$(PORT)' || lsof -i :$(PORT)'"
