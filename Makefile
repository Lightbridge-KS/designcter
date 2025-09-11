# Help target - lists available commands
help:
	@echo "Available commands:"
	@echo "  make icons    - Generate app launcher icons using flutter_launcher_icons"

# Generate app launcher icons
icons:
	dart run flutter_launcher_icons

build-web-local:
	flutter build web --no-web-resources-cdn --release

# Default target (runs when you just type 'make')
.DEFAULT_GOAL := help