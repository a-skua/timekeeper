.PHONY: run
run:
	flutter run --wasm -d chrome

.PHONY: build
build:
	flutter build web --wasm --release

.PHONY: serve
serve:
	python3 -m http.server 8000 -d build/web

.PHONY: serve-wasm
serve-wasm:
	cd build/web \
		&& dhttpd -p 8000 '--headers=Cross-Origin-Embedder-Policy=credentialless;Cross-Origin-Opener-Policy=same-origin'
