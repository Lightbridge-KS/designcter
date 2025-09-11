# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

DesignCTER is a cross-platform Flutter application for generating CT protocol templates in emergency departments. This is a migration from a previous Python/Flet application with enhanced UI and functionality.

## Architecture

The application follows a modular Flutter architecture:

### Core Structure
- **Main App**: `lib/main.dart` - Entry point with theme management and navigation
- **Servers**: Business logic modules
  - `lib/servers/calculator/` - Medical calculators (mean, spine, volume)
  - `lib/servers/designcter/` - Protocol design with Mustache templates
- **Widgets**: UI components organized by feature
  - `lib/widgets/calculator/` - Calculator UI pages
  - `lib/widgets/design/` - Protocol design interfaces
  - `lib/widgets/components/` - Reusable UI components

### Key Components
- **Template System**: Uses Mustache templating (`lib/servers/designcter/template/`)
- **Cross-platform**: Desktop-focused with web support
- **Window Management**: Conditional imports for desktop window management
- **Theme System**: Dynamic theme switching with brown/green/blue options
- **Offline Fonts**: Local Roboto font family configured for hospital intranet deployment

## GitHub Actions Workflows

Automated build and release workflows:
- **macOS Build** (`.github/workflows/macos-build.yml`): Creates macOS app releases
- **Web Build** (`.github/workflows/web-build.yml`): Creates web deployment packages
- Both workflows trigger on push to main/dev branches and version tags
- Artifacts: `macos-build` and `web-build` for respective platforms

## Offline Deployment

Configured for hospital environments with no internet access:
- **Local Fonts**: Complete Roboto font family (fonts/Roboto/) embedded in builds
- **No CDN Dependencies**: Web build uses `--no-web-resources-cdn` flag  
- **Intranet Ready**: All resources bundled locally for isolated network deployment

## Development Commands

### Essential Commands
```bash
# Install dependencies
flutter pub get

# Run in development mode
flutter run

# Run tests
flutter test

# Build for production
flutter build macos    # macOS
flutter build windows  # Windows
flutter build web --release --no-web-resources-cdn  # Web (offline-ready)

# Generate app icons
make icons
# or
dart run flutter_launcher_icons

# Check code quality
flutter analyze
```

### Testing
- Unit tests: `test/calculator_test.dart`, `test/designer_test.dart`
- Run specific test: `flutter test test/calculator_test.dart`

## Platform Support

Primary targets: macOS and Windows desktop applications
Secondary: **Web** - Full offline deployment ready for hospital environments

## Dependencies

Key packages:
- `mustachex` - Template rendering
- `window_manager` - Desktop window management
- `intl` - Internationalization
- `flutter_lints` - Code quality

## Important Notes

- ID mapping changes documented in `.github/copilot-instructions.md`
- Templates stored in `lib/servers/designcter/template/`
- Assets configuration in `pubspec.yaml` includes template directory
- Window management uses conditional imports for web compatibility