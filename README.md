# Homebrew Tap for jenkinpan

This is a custom Homebrew tap for installing my Rust CLI tools.

## Installation

First, tap this repository:

```bash
brew tap jenkinpan/tap https://github.com/jenkinpan/homebrew-tap
```

## Available Formulae

### devtool

A CLI tool for development to update rustup toolchain, mise maintained tools and homebrew packages.

**Install:**
```bash
brew install jenkinpan/tap/devtool
```

**Repository:** [devtool-rs](https://github.com/jenkinpan/devtool-rs)

### pkg-checker

A Rust tool for checking and updating globally installed Cargo packages with interactive mode and smart prerelease detection.

**Install:**
```bash
brew install jenkinpan/tap/pkg-checker
```

**Repository:** [pkg-checker-rs](https://github.com/jenkinpan/pkg-checker-rs)

## Automatic Updates

This tap is automatically updated when new releases are published to the respective GitHub repositories. The formulae are updated via GitHub Actions workflows.

## How It Works

1. When a new release is created in `devtool-rs` or `pkg-checker-rs`, their CI/CD pipelines trigger a repository dispatch event to this tap
2. The tap's GitHub Actions workflow receives the event with version and SHA256 checksums
3. The formula is automatically updated with the new version and checksums
4. Changes are committed and pushed to the tap repository

## Manual Update

If you need to manually update a formula, you can trigger the workflow dispatch with the required parameters:

1. Go to the Actions tab in this repository
2. Select the appropriate workflow (Update devtool Formula or Update pkg-checker Formula)
3. Click "Run workflow"
4. Fill in the version and SHA256 checksums for all platforms
5. Click "Run workflow"

## Development

To add a new formula to this tap:

1. Create a new `.rb` file in the `Formula/` directory
2. Follow the Homebrew formula guidelines
3. Create a corresponding GitHub Actions workflow in `.github/workflows/` for automatic updates

## License

This tap follows the licenses of individual formulae:
- **devtool**: MIT OR Apache-2.0
- **pkg-checker**: MIT