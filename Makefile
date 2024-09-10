.PHONY: run
run:
	flutter run --wasm -d chrome

.PHONY: build
build:
	flutter build web --wasm

.PHONY: serve
serve:
	python3 -m http.server 8000 -d build/web
